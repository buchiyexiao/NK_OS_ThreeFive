# 操作系统——lab2

> lab2实验练习代码不是很多，但是需要拓展的知识很多，实验外的一些知识还是很有必要搞明白的（不然代码也写不出来），所以前面先写了拓展类知识。

### 程序执行顺序

结合lab1和lab2,总结出ucore目前为止的执行顺序：

```
1. boot/bootasm.S  | bootasm.asm

a. 开启A20   16位地址线 实现 20位地址访问  芯片版本兼容    通过写 键盘控制器8042  的 64h端口 与 60h端口。

b.物理内存探测  通过 BIOS 中断获取内存布局

c.加载GDT全局描述符 lgdt gdtdesc

d.使能和进入保护模式 置位 cr0寄存器的 PE位 (内存分段访问) PE+PG（分页机制）

movl %cr0, %eax     

orl $CR0_PE_ON, %eax  或操作，置位 PE位     

movl %eax, %cr0

2. boot/bootmain.c -> bootmain 函数

a. 调用readseg函数从ELFHDR处读取8个扇区大小的 os 数据。 

b. 将输入读入 到 内存中以 进程(程序)块 proghdr 的方式存储 

c. 跳到ucore操作系统在内存中的入口位置（kern/init.c中的kern_init函数的起始地址）

3. kern/init.c

a. 初始化终端 cons_init(); init the console   kernel/driver/consore.c

 显示器初始化       cga_init();         

串口初始化         serial_init();      

keyboard键盘初始化 kbd_init();

b. 打印内核信息 & 欢迎信息     

print_kerninfo();          //  内核信息  kernel/debug/kdebug.c    

cprintf("%s\n\n", message);//　欢迎信息 const char *message = “qwert”
c. 显示堆栈中的多层函数调用关系 切换到保护模式，启用分段机制
    grade_backtrace();

d. 初始化物理内存管理
    pmm_init();        // init physical memory management   kernel/mm/ppm.c
    --->gdt_init();    // 初始化默认的全局描述符表
    ---> page_init();// 内存管理等函数
e. 初始化中断控制器，
    pic_init();        // 初始化 8259A 中断控制器   kernel/driver/picirq.c

f. 设置中断描述符表
    idt_init();        // kernel/trap/trap.c 
    // __vectors[] 来对应中断描述符表中的256个中断符  tools/vector.c中

g. 初始化时钟中断，使能整个系统的中断机制  8253定时器 
    clock_init();      // 10ms 时钟中断(1s中断100次)   kernel/driver/clock.c
    ----> pic_enable(IRQ_TIMER);// 使能定时器中断 

h. 使能整个系统的中断机制 enable irq interrupt
    intr_enable();     // kernel/driver/intr.c
    // sti();          // set interrupt // x86.h
    
i. lab1_switch_test();// 用户切换函数 会 触发中断用户切换中断

4. kernel/trap/trap.c 
   trap中断(陷阱)处理函数
    trap() ---> trap_dispatch()   // kernel/trap/trap.c 

    a. 10ms 时钟中断处理 case IRQ_TIMER：
       if((ticks++)%100==0) print_ticks();//向终端打印时间信息（1s打印一次）

    b. 串口1 中断    case IRQ_COM1: 
       获取串口字符后打印

    c. 键盘中断      case IRQ_KBD: 
       获取键盘字符后打印

    d. 用户切换中断

```

### 系统内存的探测

#### INT 15h中断与E820参数

​		在分配物理内存空间前，必须要获取物理内存空间信息。本实验通过向INT 15h中断传入e820h参数来探测物理内存空间的信息。以下是ucore中物理内存空间信息实例：

```c++
  memory: 0009fc00, [00000000, 0009fbff], type = 1.
  memory: 00000400, [0009fc00, 0009ffff], type = 2.
  memory: 00010000, [000f0000, 000fffff], type = 2.
  memory: 07ee0000, [00100000, 07fdffff], type = 1.
  memory: 00020000, [07fe0000, 07ffffff], type = 2.
  memory: 00040000, [fffc0000, ffffffff], type = 2.
```

​		type是物理内存空间的类型，1是可以使用的物理内存空间， 2是不能使用的物理内存空间。注意， 2中的"不能使用"指的是这些地址不能映射到物理内存上， 但它们可以映射到ROM或者映射到其他设备，比如各种外设等。

#### 实现过程

​		要实现这种方法来探测物理内存空间，必须将系统置于实模式下，所以在bootloader中添加物理内存空间探测的功能，将获取的物理内存空间的信息用内存映射地址描述符（Address Range Descriptor)来表示，一个内存映射地址描述符占20B，定义如下：

```C
00h    8字节   base address            #系统内存块基地址
08h    8字节   length in bytes         #系统内存大小
10h    4字节   type of address range   #内存类型
```

​		没探测到一块物理内存空间，其对应的内存映射地址描述符会被写入指定的内存空间。完成物理空间内存的探测后，我们可以通过这块物理空间中的内存映射地址描述符了解物理内存空间的分布情况。通过中断获取的一个一个内存块的信息会存入一个缓冲区中 e820map结构体。

```c
/* memlayout.h */
struct e820map {
    int nr_map;
    struct {
        long long addr;
        long long size;
        long type;
   } map[E820MAX];
};
```

​		e820h的调用参数：

```
	eax：子功能编号，这里我们填入0xe820
    edx：534D4150h(ascii字符”SMAP”)，签名，约定填”SMAP”
    ebx：每调用一次int $0x15，ebx会加1。当ebx为0表示所有内存块检测完毕。（重要！看后面的案例会明白如何使用）
    ecx：存放地址范围描述符的内存大小，至少要设置为20。
    es:di：告诉BIOS要把地址描述符写到这个地址。
    中断的返回值如下：

    CF标志位：若中断执行失败，则置为1。
    eax：     值是534D4150h(“SMAP”)
    es:di：   中断不改变该值，值与参数传入的值一致
    ebx：     下一个中断描述符的计数值（见后面的案例）
    ecx：     返回BIOS写到cs:di处的地址描述符的大小
    ah：      若发生错误，表示错误码
```

boot/bootasm.S   b.物理内存探测 通过 BIOS 中断获取内存布局 

```assembly
 .set SMAP,                  0x534d4150    # 设置变量(即4个ASCII字符“SMAP”)

# 第一步： 设置一个存放内存映射地址描述符的物理地址(这里是0x8000)
probe_memory:
    # 约定在bootloader中将内存探测结果放到0x8000地址处。
    # 在0x8000处存放struct e820map, 并清除 e820map 中的 nr_map 记录了内存块的个数
    movl $0, 0x8000 # 对0x8000处的32位单元清零,即给位于0x8000处的struct e820map的成员变量 nr_map 清零
    xorl %ebx, %ebx # 清理 %ebx, 异或,相同为0，不同为1
    
    # 0x8004 处将用于存放第一个内存映射地址描述符 
    movw $0x8004, %di # 表示设置调用INT 15h BIOS中断后，BIOS返回的映射地址描述符的起始地址
    # 中断前需要传递的参数， es:di：告诉BIOS要把地址描述符写到这个地址。
    
    # 第二步： 将e820作为参数传递给INT 15h中断
start_probe:
  # 传入0xe820 作为INT 15h中断的参数 
    movl $0xE820, %eax  #  INT 15的中断调用参数 eax：子功能编号，这里我们填入0xe820
  # 内存映射地址描述符的大小 
    movl $20, %ecx      # 设置地址范围描述符的大小为20字节，其大小等于struct e820map的成员变量map的大小
                        # 存放地址范围描述符的内存大小，至少要设置为20
    movl $SMAP, %edx    # 设置edx为534D4150h (即4个ASCII字符“SMAP”)，这是一个约定
  # 调用INT 15h中断 
    int $0x15 # 中断参数0xe820，要求BIOS返回一个用地址范围描述符表示的内存段信息
    
# 通过检测 eflags 的CF位来判断探测是否结束。
# 如果没有结束， 设置存放下一个内存映射地址描述符的物理地址，然后跳到步骤2；如果结束，则程序结束
    # 如果eflags的CF位为0，则表示还有内存段需要探测 
    jnc cont # 如果发生错误，CF位为1。那么可以尝试使用其它子功能进行探测，或者就直接关机（连内存容量都没探测肯定无法启动OS了）
    movw $12345, 0x8000 # 在ucore中表示出错，与BIOS无关
    jmp finish_probe
cont:
  # 继续探测 设置下一个内存映射地址描述符的起始地址 
    addw $20, %di   # 设置下一个BIOS返回的映射地址描述符的起始地址
                    # 控制BIOS该将“地址描述符”写到哪里
  # e820map中的nr_map加1 
    incl 0x8000     # 递增struct e820map的成员变量nr_map # nr_map成员自增1，该变量与BIOS无关
  # 如果还有内存段需要探测则继续探测, 否则结束探测 
    cmpl $0, %ebx   # 每调用一次int $0x15，ebx会加1。当ebx为0表示所有内存块检测完毕。
    jnz start_probe
finish_probe:
```

### 物理内存空间管理的初始化

当我们在bootloader中完成对物理内存空间的探测后， 我们就可以根据得到的信息来对可用的内存空间进行管理。在ucore中， 我们将物理内存空间按照页的大小(4KB)进行管理， 页的信息用Page这个结构体来保存。

```c
 // kern/mm/memlayout.h
struct Page {
    int ref;                        // 映射此 物理页的 虚拟页个数，表示该 物理页 被 页表 的引用记数 page frame's reference counter
                    // 一旦某页表中有一个页表项设置了虚拟页到这个Page管理的物理页的映射关系，就会把Page的ref加一。
                    // 反之，若是解除，那就减一。
    uint32_t flags;                 // 描述 物理页 属性的标志flags数组
      // 表示此物理页的状态标记，有两个标志位，第一个表示是否被保留，如果被保留了则设为1（比如内核代码占用的空间）。
      // 第二个表示此页是否是free的。
      // 如果设置为1，表示这页是free的，可以被分配；
      // 如果设置为0，表示这页已经被分配出去了，不能被再二次分配。
    
    unsigned int property;           // 用来记录某连续内存空闲块的大小，
                           			 // 这里需要注意的是用到此成员变量的这个Page一定是连续内存块的开始地址（第一页的地址）。
    list_entry_t page_link;         // 双向链接 各个Page结构的 page_link 双向链表
    // list_entry_t 是便于把多个连续内存空闲块链接在一起的 双向链表指针，
    // 连续内存空闲块利用这个页的 成员变量 page_link 来链接比它地址小和大的其他连续内存空闲块.
};

typedef struct {// kern/mm/memlayout.h
    list_entry_t free_list;         //  是一个list_entry结构的双向链表指针 the list header
    unsigned int nr_free;           //  记录当前空闲页的个数, of free pages in this free list
} free_area_t;
```

#### 物理内存空间管理的初始化的过程

1. 根据物理内存空间探测的结果， 找到最后一个可用空间的结束地址(或者Kernel的结束地址，选一个小的) 根据这个结束地址计算出整个可用的物理内存空间一共有多少个页。
2. 找到Kernel的结束地址(end)，这个地址是在kernel.ld中定义的， 我们从这个地址所在的下一个页开始(pages)写入系统页的信息(将所有的Page写入这个地址)
3. 从pages开始，将所有页的信息的flag都设置为reserved(不可用)
4. 找到free页的开始地址， 并初始化所有free页的信息(free页就是除了kernel和页信息外的可用空间，初始化的过程会reset flag中的reserved位)

![物理内存空间的分布图](img\295946239-592131eae426e_articlex.png)

由该图可以很清晰的知道物理内存空间如何分布，以及初始化的。pages就是BSS结束处至空闲内存空间的起始地址。free页是从空闲内存空间的起始地址至实际物理内存空间结束地址。

##### pages的地址：

```c
pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
```

##### free页的起始地址：

```c
uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
```

##### 初始化free页的信息

```c
init_memmap(pa2page(begin), (end - begin) / PGSIZE);
```

在本lab中， 获取页的信息是由 `pa2page()` 来完成的。

在初始化free页的信息时， 我们只将连续多个free页中第一个页的信息连入free_list中， 并且只将这个页的property设置为连续多个free页的个数。 其他所有页的信息我们只是简单的设置为0。

### 内存段页式管理

在这种模式下，逻辑地址先通过段机制转化成线性地址， 然后通过两种页表(页目录和页表)来实现线性地址到物理地址的转换。 

![段页式内存管理](img\4190879442-592131eaad948_articlex.png)



在 页目录 和 页表中 存放的地址都是 物理地址。

在X86系统中，页目录表 的起始物理地址存放在 cr3 寄存器中,这个地址必须是一个 页对齐 的地址，也就是低 12 位必须为0。 在ucore 用boot_cr3（mm/pmm.c）记录这个值。 在ucore中，线性地址的的高10位作为页目录表的索引，之后的10位作为页表的的索引， 所以页目录表和页表中各有1024个项，每个项占4B，所以页目录表和页表刚好可以用一个物理的页来存放。

### 练习1：实现 first-fit 连续物理内存分配算法（需要编程）

这个练习是实现first-fit连续物理内存分配算法。在实现first fit 内存分配算法的回收函数时，要考虑地址连续的空闲块之间的合并操作。

`default_init()`不需要改变。建立空的双向链表，并设置空块总量为0。

```c
static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
}
```

`default_init_memmap`，为方便，按地址从小到大构建链表，即每次将新的块插入后面。

```
/**
 * 初始化时使用。
 * 探测到一个基址为base，大小为n 的空间，将它加入list（开始时做一点检查）
 */
static void
default_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);
    nr_free += n;
    // 按地址序，依次往后排列。因为是双向链表，所以头指针前一个就是最后一个。
    // 只改了这一句。
    list_add_before(&free_list, &(base->page_link)); 
}
```

### `alloc`

就是找到第一个足够大的页，然后分配它。主要是`free`时，没有保证顺序，所以分配时也是乱序的。这一段只需要改：拆分时小块的插入位置，就插在拆分前处，而不是在list最后即可。

```c
// 可以发现，现在的分配方法中list是无序的，就是根据释放时序。
// 取的时候，直接去找第一个可行的。
static struct Page *
default_alloc_pages(size_t n) {
    assert(n > 0);
    // 要的页数比剩余free的页数都多，return null
    if (n > nr_free) {
        return NULL;
    }
    struct Page *page = NULL;
    list_entry_t *le = &free_list;
    // 找了一圈后退出 TODO: list有空的头结点吗？有吧。
    while ((le = list_next(le)) != &free_list) {
        // 找到这个节点所在的基于Page的变量
        // 这里的page_link就是成员变量的名字，之后会变成宏。。看起来像是一个变量一样，其实不是。
        // ((type *)((char *)(ptr) - offsetof(type, member)))
        // #define offsetof(type, member)
        // ((size_t)(&((type *)0)->member))
        // le2page, 找到这个le所在page结构体的头指针，其中这个le是page变量的page_link成员变量
        struct Page *p = le2page(le, page_link);
        // 找到了一个满足的，就把这个空间（的首页）拿出来
        if (p->property >= n) {
            page = p;
            break;
        }
    }
    //如果找到了可行区域
    if (page != NULL) {
        // 这个可行区域的空间大于需求空间，拆分，将剩下的一段放到list中【free+list的后面一个】
        if (page->property > n) {
            struct Page *p = page + n;
            p->property = page->property - n;
            SetPageProperty(p);
            // 加入后来的，p
            list_add_after(&(page->page_link), &(p->page_link));
            // list_add(&free_list, &(p->page_link));
        }
        // 删除原来的
        list_del(&(page->page_link));
        // 更新空余空间的状态
        nr_free -= n;
        //page被使用了，所以把它的属性clear掉
        ClearPageProperty(page);
    }
    // 返回page
    return page;
}
```

### `free`

未修改前，可以发现算法是，从头找到尾部，找到是否有被free的块紧邻的块。而first fit算法是有序的，只需找到它的前后即可，然后合并放入对应位置。

```c
static void
default_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    // 先更改被释放的这几页的标记位
    for (; p != base + n; p ++) {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    // 将这几块视为一个连续的内存空间
    base->property = n;
    SetPageProperty(base);

    list_entry_t *next_entry = list_next(&free_list);
    // 找到base的前一块空块的后一块
    while (next_entry != &free_list && le2page(next_entry, page_link) < base)
        next_entry = list_next(next_entry);
    // 找到前面那块
    list_entry_t *prev_entry = list_prev(next_entry);
    // 找到insert的位置
    list_entry_t *insert_entry = prev_entry;
    // 如果和前一块挨在一起，就和前一块合并
    if (prev_entry != &free_list) {
        p = le2page(prev_entry, page_link);
        if (p + p->property == base) {
            p->property += base->property;
            ClearPageProperty(base);
            base = p;
            insert_entry = list_prev(prev_entry);
            list_del(prev_entry);
        }
    }
	// 后一块
    if (next_entry != &free_list) {
        p = le2page(next_entry, page_link);
        if (base + base->property == p) {
            base->property += p->property;
            ClearPageProperty(p);
            list_del(next_entry);
        }
    }
    // 加一下
    nr_free += n;
    list_add(insert_entry, &(base->page_link));
}
```

## 练习二

pde_t 全称为page directory entry，也就是一级页表的表项
pte_t 全称为page table entry，表示二级页表的表项。
uintptr_t 表示为线性地址，由于段式管理只做直接映射，所以它也是逻辑地址。
PTE_U: 位3，表示用户态的软件可以读取对应地址的物理内存页内容
PTE_W: 位2，表示物理内存页内容可写
PTE_P: 位1，表示物理内存页存在

寻找页表项步骤：

1. 在一级页表（页目录）中找到它的对应项，如果存在，直接返回。
2. 如果不存在，不要求创建，返回NULL。
3. 如果不存在，要求创建，alloc空间失败，返回NULL
4. 成功拿到一个page，将它清空，并设置它的引用次数为1（在pages数组中）。
5. 并在一级页表中建立该项。最后返回。

## 练习三

步骤：
判断页表中该表项是否存在
判断是否只被引用了一次
如果只被引用了一次，那么可以释放掉此页
如果被多次引用，则不能释放此页，只用释放二级页表的表项
更新页表

Q1：有关系。页目录项保存的物理页面地址（即某个页表）以及页表项保存的物理页面地址都对应于Page数组中的某一页。

Q2：将物理地址和虚地址之前的偏移量即映射关系改为0就可以实现。
