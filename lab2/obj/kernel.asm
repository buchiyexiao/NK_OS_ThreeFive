
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

c0100000 <kern_entry>:

.text
.globl kern_entry
kern_entry:
    # load pa of boot pgdir
    movl $REALLOC(__boot_pgdir), %eax
c0100000:	b8 00 a0 11 00       	mov    $0x11a000,%eax
    movl %eax, %cr3
c0100005:	0f 22 d8             	mov    %eax,%cr3

    # enable paging
    movl %cr0, %eax
c0100008:	0f 20 c0             	mov    %cr0,%eax
    orl $(CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP), %eax
c010000b:	0d 2f 00 05 80       	or     $0x8005002f,%eax
    andl $~(CR0_TS | CR0_EM), %eax
c0100010:	83 e0 f3             	and    $0xfffffff3,%eax
    movl %eax, %cr0
c0100013:	0f 22 c0             	mov    %eax,%cr0

    # update eip
    # now, eip = 0x1.....
    leal next, %eax
c0100016:	8d 05 1e 00 10 c0    	lea    0xc010001e,%eax
    # set eip = KERNBASE + 0x1.....
    jmp *%eax
c010001c:	ff e0                	jmp    *%eax

c010001e <next>:
next:

    # unmap va 0 ~ 4M, it's temporary mapping
    xorl %eax, %eax
c010001e:	31 c0                	xor    %eax,%eax
    movl %eax, __boot_pgdir
c0100020:	a3 00 a0 11 c0       	mov    %eax,0xc011a000

    # set ebp, esp
    movl $0x0, %ebp
c0100025:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
c010002a:	bc 00 90 11 c0       	mov    $0xc0119000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
c010002f:	e8 02 00 00 00       	call   c0100036 <kern_init>

c0100034 <spin>:

# should never get here
spin:
    jmp spin
c0100034:	eb fe                	jmp    c0100034 <spin>

c0100036 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
c0100036:	f3 0f 1e fb          	endbr32 
c010003a:	55                   	push   %ebp
c010003b:	89 e5                	mov    %esp,%ebp
c010003d:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
c0100040:	b8 28 cf 11 c0       	mov    $0xc011cf28,%eax
c0100045:	2d 00 c0 11 c0       	sub    $0xc011c000,%eax
c010004a:	83 ec 04             	sub    $0x4,%esp
c010004d:	50                   	push   %eax
c010004e:	6a 00                	push   $0x0
c0100050:	68 00 c0 11 c0       	push   $0xc011c000
c0100055:	e8 02 55 00 00       	call   c010555c <memset>
c010005a:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
c010005d:	e8 40 16 00 00       	call   c01016a2 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
c0100062:	c7 45 f4 20 5d 10 c0 	movl   $0xc0105d20,-0xc(%ebp)
    cprintf("%s\n\n", message);
c0100069:	83 ec 08             	sub    $0x8,%esp
c010006c:	ff 75 f4             	pushl  -0xc(%ebp)
c010006f:	68 3c 5d 10 c0       	push   $0xc0105d3c
c0100074:	e8 2b 02 00 00       	call   c01002a4 <cprintf>
c0100079:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
c010007c:	e8 df 08 00 00       	call   c0100960 <print_kerninfo>

    grade_backtrace();
c0100081:	e8 85 00 00 00       	call   c010010b <grade_backtrace>

    pmm_init();                 // init physical memory management
c0100086:	e8 bd 33 00 00       	call   c0103448 <pmm_init>

    pic_init();                 // init interrupt controller
c010008b:	e8 9a 17 00 00       	call   c010182a <pic_init>
    idt_init();                 // init interrupt descriptor table
c0100090:	e8 3c 19 00 00       	call   c01019d1 <idt_init>

    clock_init();               // init clock interrupt
c0100095:	e8 4f 0d 00 00       	call   c0100de9 <clock_init>
    intr_enable();              // enable irq interrupt
c010009a:	e8 da 18 00 00       	call   c0101979 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
c010009f:	e8 65 01 00 00       	call   c0100209 <lab1_switch_test>

    /* do nothing */
    while (1);
c01000a4:	eb fe                	jmp    c01000a4 <kern_init+0x6e>

c01000a6 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
c01000a6:	f3 0f 1e fb          	endbr32 
c01000aa:	55                   	push   %ebp
c01000ab:	89 e5                	mov    %esp,%ebp
c01000ad:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
c01000b0:	83 ec 04             	sub    $0x4,%esp
c01000b3:	6a 00                	push   $0x0
c01000b5:	6a 00                	push   $0x0
c01000b7:	6a 00                	push   $0x0
c01000b9:	e8 15 0d 00 00       	call   c0100dd3 <mon_backtrace>
c01000be:	83 c4 10             	add    $0x10,%esp
}
c01000c1:	90                   	nop
c01000c2:	c9                   	leave  
c01000c3:	c3                   	ret    

c01000c4 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
c01000c4:	f3 0f 1e fb          	endbr32 
c01000c8:	55                   	push   %ebp
c01000c9:	89 e5                	mov    %esp,%ebp
c01000cb:	53                   	push   %ebx
c01000cc:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
c01000cf:	8d 4d 0c             	lea    0xc(%ebp),%ecx
c01000d2:	8b 55 0c             	mov    0xc(%ebp),%edx
c01000d5:	8d 5d 08             	lea    0x8(%ebp),%ebx
c01000d8:	8b 45 08             	mov    0x8(%ebp),%eax
c01000db:	51                   	push   %ecx
c01000dc:	52                   	push   %edx
c01000dd:	53                   	push   %ebx
c01000de:	50                   	push   %eax
c01000df:	e8 c2 ff ff ff       	call   c01000a6 <grade_backtrace2>
c01000e4:	83 c4 10             	add    $0x10,%esp
}
c01000e7:	90                   	nop
c01000e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
c01000eb:	c9                   	leave  
c01000ec:	c3                   	ret    

c01000ed <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
c01000ed:	f3 0f 1e fb          	endbr32 
c01000f1:	55                   	push   %ebp
c01000f2:	89 e5                	mov    %esp,%ebp
c01000f4:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
c01000f7:	83 ec 08             	sub    $0x8,%esp
c01000fa:	ff 75 10             	pushl  0x10(%ebp)
c01000fd:	ff 75 08             	pushl  0x8(%ebp)
c0100100:	e8 bf ff ff ff       	call   c01000c4 <grade_backtrace1>
c0100105:	83 c4 10             	add    $0x10,%esp
}
c0100108:	90                   	nop
c0100109:	c9                   	leave  
c010010a:	c3                   	ret    

c010010b <grade_backtrace>:

void
grade_backtrace(void) {
c010010b:	f3 0f 1e fb          	endbr32 
c010010f:	55                   	push   %ebp
c0100110:	89 e5                	mov    %esp,%ebp
c0100112:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
c0100115:	b8 36 00 10 c0       	mov    $0xc0100036,%eax
c010011a:	83 ec 04             	sub    $0x4,%esp
c010011d:	68 00 00 ff ff       	push   $0xffff0000
c0100122:	50                   	push   %eax
c0100123:	6a 00                	push   $0x0
c0100125:	e8 c3 ff ff ff       	call   c01000ed <grade_backtrace0>
c010012a:	83 c4 10             	add    $0x10,%esp
}
c010012d:	90                   	nop
c010012e:	c9                   	leave  
c010012f:	c3                   	ret    

c0100130 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
c0100130:	f3 0f 1e fb          	endbr32 
c0100134:	55                   	push   %ebp
c0100135:	89 e5                	mov    %esp,%ebp
c0100137:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
c010013a:	8c 4d f6             	mov    %cs,-0xa(%ebp)
c010013d:	8c 5d f4             	mov    %ds,-0xc(%ebp)
c0100140:	8c 45 f2             	mov    %es,-0xe(%ebp)
c0100143:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
c0100146:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c010014a:	0f b7 c0             	movzwl %ax,%eax
c010014d:	83 e0 03             	and    $0x3,%eax
c0100150:	89 c2                	mov    %eax,%edx
c0100152:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c0100157:	83 ec 04             	sub    $0x4,%esp
c010015a:	52                   	push   %edx
c010015b:	50                   	push   %eax
c010015c:	68 41 5d 10 c0       	push   $0xc0105d41
c0100161:	e8 3e 01 00 00       	call   c01002a4 <cprintf>
c0100166:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
c0100169:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c010016d:	0f b7 d0             	movzwl %ax,%edx
c0100170:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c0100175:	83 ec 04             	sub    $0x4,%esp
c0100178:	52                   	push   %edx
c0100179:	50                   	push   %eax
c010017a:	68 4f 5d 10 c0       	push   $0xc0105d4f
c010017f:	e8 20 01 00 00       	call   c01002a4 <cprintf>
c0100184:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
c0100187:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c010018b:	0f b7 d0             	movzwl %ax,%edx
c010018e:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c0100193:	83 ec 04             	sub    $0x4,%esp
c0100196:	52                   	push   %edx
c0100197:	50                   	push   %eax
c0100198:	68 5d 5d 10 c0       	push   $0xc0105d5d
c010019d:	e8 02 01 00 00       	call   c01002a4 <cprintf>
c01001a2:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
c01001a5:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c01001a9:	0f b7 d0             	movzwl %ax,%edx
c01001ac:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c01001b1:	83 ec 04             	sub    $0x4,%esp
c01001b4:	52                   	push   %edx
c01001b5:	50                   	push   %eax
c01001b6:	68 6b 5d 10 c0       	push   $0xc0105d6b
c01001bb:	e8 e4 00 00 00       	call   c01002a4 <cprintf>
c01001c0:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
c01001c3:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01001c7:	0f b7 d0             	movzwl %ax,%edx
c01001ca:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c01001cf:	83 ec 04             	sub    $0x4,%esp
c01001d2:	52                   	push   %edx
c01001d3:	50                   	push   %eax
c01001d4:	68 79 5d 10 c0       	push   $0xc0105d79
c01001d9:	e8 c6 00 00 00       	call   c01002a4 <cprintf>
c01001de:	83 c4 10             	add    $0x10,%esp
    round ++;
c01001e1:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c01001e6:	83 c0 01             	add    $0x1,%eax
c01001e9:	a3 00 c0 11 c0       	mov    %eax,0xc011c000
}
c01001ee:	90                   	nop
c01001ef:	c9                   	leave  
c01001f0:	c3                   	ret    

c01001f1 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
c01001f1:	f3 0f 1e fb          	endbr32 
c01001f5:	55                   	push   %ebp
c01001f6:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    asm volatile (
c01001f8:	cd 78                	int    $0x78
	    "int %0 \n" //%0 为 T_SWITCH_TOU 参数
	    :
	    : "i"(T_SWITCH_TOU)
	);
}
c01001fa:	90                   	nop
c01001fb:	5d                   	pop    %ebp
c01001fc:	c3                   	ret    

c01001fd <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
c01001fd:	f3 0f 1e fb          	endbr32 
c0100201:	55                   	push   %ebp
c0100202:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    //引发对应的中断（T_SWITCH_TOK）
    asm volatile (
c0100204:	cd 79                	int    $0x79
        "int %0 \n"
        :
        : "i"(T_SWITCH_TOK)
    );
}
c0100206:	90                   	nop
c0100207:	5d                   	pop    %ebp
c0100208:	c3                   	ret    

c0100209 <lab1_switch_test>:

static void
lab1_switch_test(void) {
c0100209:	f3 0f 1e fb          	endbr32 
c010020d:	55                   	push   %ebp
c010020e:	89 e5                	mov    %esp,%ebp
c0100210:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
c0100213:	e8 18 ff ff ff       	call   c0100130 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
c0100218:	83 ec 0c             	sub    $0xc,%esp
c010021b:	68 88 5d 10 c0       	push   $0xc0105d88
c0100220:	e8 7f 00 00 00       	call   c01002a4 <cprintf>
c0100225:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
c0100228:	e8 c4 ff ff ff       	call   c01001f1 <lab1_switch_to_user>
    lab1_print_cur_status();
c010022d:	e8 fe fe ff ff       	call   c0100130 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
c0100232:	83 ec 0c             	sub    $0xc,%esp
c0100235:	68 a8 5d 10 c0       	push   $0xc0105da8
c010023a:	e8 65 00 00 00       	call   c01002a4 <cprintf>
c010023f:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
c0100242:	e8 b6 ff ff ff       	call   c01001fd <lab1_switch_to_kernel>
    lab1_print_cur_status();
c0100247:	e8 e4 fe ff ff       	call   c0100130 <lab1_print_cur_status>
}
c010024c:	90                   	nop
c010024d:	c9                   	leave  
c010024e:	c3                   	ret    

c010024f <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
c010024f:	f3 0f 1e fb          	endbr32 
c0100253:	55                   	push   %ebp
c0100254:	89 e5                	mov    %esp,%ebp
c0100256:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
c0100259:	83 ec 0c             	sub    $0xc,%esp
c010025c:	ff 75 08             	pushl  0x8(%ebp)
c010025f:	e8 73 14 00 00       	call   c01016d7 <cons_putc>
c0100264:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
c0100267:	8b 45 0c             	mov    0xc(%ebp),%eax
c010026a:	8b 00                	mov    (%eax),%eax
c010026c:	8d 50 01             	lea    0x1(%eax),%edx
c010026f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100272:	89 10                	mov    %edx,(%eax)
}
c0100274:	90                   	nop
c0100275:	c9                   	leave  
c0100276:	c3                   	ret    

c0100277 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
c0100277:	f3 0f 1e fb          	endbr32 
c010027b:	55                   	push   %ebp
c010027c:	89 e5                	mov    %esp,%ebp
c010027e:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
c0100281:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
c0100288:	ff 75 0c             	pushl  0xc(%ebp)
c010028b:	ff 75 08             	pushl  0x8(%ebp)
c010028e:	8d 45 f4             	lea    -0xc(%ebp),%eax
c0100291:	50                   	push   %eax
c0100292:	68 4f 02 10 c0       	push   $0xc010024f
c0100297:	e8 0f 56 00 00       	call   c01058ab <vprintfmt>
c010029c:	83 c4 10             	add    $0x10,%esp
    return cnt;
c010029f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01002a2:	c9                   	leave  
c01002a3:	c3                   	ret    

c01002a4 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
c01002a4:	f3 0f 1e fb          	endbr32 
c01002a8:	55                   	push   %ebp
c01002a9:	89 e5                	mov    %esp,%ebp
c01002ab:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c01002ae:	8d 45 0c             	lea    0xc(%ebp),%eax
c01002b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
c01002b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01002b7:	83 ec 08             	sub    $0x8,%esp
c01002ba:	50                   	push   %eax
c01002bb:	ff 75 08             	pushl  0x8(%ebp)
c01002be:	e8 b4 ff ff ff       	call   c0100277 <vcprintf>
c01002c3:	83 c4 10             	add    $0x10,%esp
c01002c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c01002c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01002cc:	c9                   	leave  
c01002cd:	c3                   	ret    

c01002ce <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
c01002ce:	f3 0f 1e fb          	endbr32 
c01002d2:	55                   	push   %ebp
c01002d3:	89 e5                	mov    %esp,%ebp
c01002d5:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
c01002d8:	83 ec 0c             	sub    $0xc,%esp
c01002db:	ff 75 08             	pushl  0x8(%ebp)
c01002de:	e8 f4 13 00 00       	call   c01016d7 <cons_putc>
c01002e3:	83 c4 10             	add    $0x10,%esp
}
c01002e6:	90                   	nop
c01002e7:	c9                   	leave  
c01002e8:	c3                   	ret    

c01002e9 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
c01002e9:	f3 0f 1e fb          	endbr32 
c01002ed:	55                   	push   %ebp
c01002ee:	89 e5                	mov    %esp,%ebp
c01002f0:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
c01002f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
c01002fa:	eb 14                	jmp    c0100310 <cputs+0x27>
        cputch(c, &cnt);
c01002fc:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0100300:	83 ec 08             	sub    $0x8,%esp
c0100303:	8d 55 f0             	lea    -0x10(%ebp),%edx
c0100306:	52                   	push   %edx
c0100307:	50                   	push   %eax
c0100308:	e8 42 ff ff ff       	call   c010024f <cputch>
c010030d:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
c0100310:	8b 45 08             	mov    0x8(%ebp),%eax
c0100313:	8d 50 01             	lea    0x1(%eax),%edx
c0100316:	89 55 08             	mov    %edx,0x8(%ebp)
c0100319:	0f b6 00             	movzbl (%eax),%eax
c010031c:	88 45 f7             	mov    %al,-0x9(%ebp)
c010031f:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
c0100323:	75 d7                	jne    c01002fc <cputs+0x13>
    }
    cputch('\n', &cnt);
c0100325:	83 ec 08             	sub    $0x8,%esp
c0100328:	8d 45 f0             	lea    -0x10(%ebp),%eax
c010032b:	50                   	push   %eax
c010032c:	6a 0a                	push   $0xa
c010032e:	e8 1c ff ff ff       	call   c010024f <cputch>
c0100333:	83 c4 10             	add    $0x10,%esp
    return cnt;
c0100336:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0100339:	c9                   	leave  
c010033a:	c3                   	ret    

c010033b <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
c010033b:	f3 0f 1e fb          	endbr32 
c010033f:	55                   	push   %ebp
c0100340:	89 e5                	mov    %esp,%ebp
c0100342:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
c0100345:	90                   	nop
c0100346:	e8 d9 13 00 00       	call   c0101724 <cons_getc>
c010034b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010034e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100352:	74 f2                	je     c0100346 <getchar+0xb>
        /* do nothing */;
    return c;
c0100354:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100357:	c9                   	leave  
c0100358:	c3                   	ret    

c0100359 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
c0100359:	f3 0f 1e fb          	endbr32 
c010035d:	55                   	push   %ebp
c010035e:	89 e5                	mov    %esp,%ebp
c0100360:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
c0100363:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100367:	74 13                	je     c010037c <readline+0x23>
        cprintf("%s", prompt);
c0100369:	83 ec 08             	sub    $0x8,%esp
c010036c:	ff 75 08             	pushl  0x8(%ebp)
c010036f:	68 c7 5d 10 c0       	push   $0xc0105dc7
c0100374:	e8 2b ff ff ff       	call   c01002a4 <cprintf>
c0100379:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
c010037c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
c0100383:	e8 b3 ff ff ff       	call   c010033b <getchar>
c0100388:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
c010038b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010038f:	79 0a                	jns    c010039b <readline+0x42>
            return NULL;
c0100391:	b8 00 00 00 00       	mov    $0x0,%eax
c0100396:	e9 82 00 00 00       	jmp    c010041d <readline+0xc4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
c010039b:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
c010039f:	7e 2b                	jle    c01003cc <readline+0x73>
c01003a1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
c01003a8:	7f 22                	jg     c01003cc <readline+0x73>
            cputchar(c);
c01003aa:	83 ec 0c             	sub    $0xc,%esp
c01003ad:	ff 75 f0             	pushl  -0x10(%ebp)
c01003b0:	e8 19 ff ff ff       	call   c01002ce <cputchar>
c01003b5:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
c01003b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01003bb:	8d 50 01             	lea    0x1(%eax),%edx
c01003be:	89 55 f4             	mov    %edx,-0xc(%ebp)
c01003c1:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01003c4:	88 90 20 c0 11 c0    	mov    %dl,-0x3fee3fe0(%eax)
c01003ca:	eb 4c                	jmp    c0100418 <readline+0xbf>
        }
        else if (c == '\b' && i > 0) {
c01003cc:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
c01003d0:	75 1a                	jne    c01003ec <readline+0x93>
c01003d2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01003d6:	7e 14                	jle    c01003ec <readline+0x93>
            cputchar(c);
c01003d8:	83 ec 0c             	sub    $0xc,%esp
c01003db:	ff 75 f0             	pushl  -0x10(%ebp)
c01003de:	e8 eb fe ff ff       	call   c01002ce <cputchar>
c01003e3:	83 c4 10             	add    $0x10,%esp
            i --;
c01003e6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01003ea:	eb 2c                	jmp    c0100418 <readline+0xbf>
        }
        else if (c == '\n' || c == '\r') {
c01003ec:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
c01003f0:	74 06                	je     c01003f8 <readline+0x9f>
c01003f2:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
c01003f6:	75 8b                	jne    c0100383 <readline+0x2a>
            cputchar(c);
c01003f8:	83 ec 0c             	sub    $0xc,%esp
c01003fb:	ff 75 f0             	pushl  -0x10(%ebp)
c01003fe:	e8 cb fe ff ff       	call   c01002ce <cputchar>
c0100403:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
c0100406:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100409:	05 20 c0 11 c0       	add    $0xc011c020,%eax
c010040e:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
c0100411:	b8 20 c0 11 c0       	mov    $0xc011c020,%eax
c0100416:	eb 05                	jmp    c010041d <readline+0xc4>
        c = getchar();
c0100418:	e9 66 ff ff ff       	jmp    c0100383 <readline+0x2a>
        }
    }
}
c010041d:	c9                   	leave  
c010041e:	c3                   	ret    

c010041f <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
c010041f:	f3 0f 1e fb          	endbr32 
c0100423:	55                   	push   %ebp
c0100424:	89 e5                	mov    %esp,%ebp
c0100426:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
c0100429:	a1 20 c4 11 c0       	mov    0xc011c420,%eax
c010042e:	85 c0                	test   %eax,%eax
c0100430:	75 5f                	jne    c0100491 <__panic+0x72>
        goto panic_dead;
    }
    is_panic = 1;
c0100432:	c7 05 20 c4 11 c0 01 	movl   $0x1,0xc011c420
c0100439:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
c010043c:	8d 45 14             	lea    0x14(%ebp),%eax
c010043f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
c0100442:	83 ec 04             	sub    $0x4,%esp
c0100445:	ff 75 0c             	pushl  0xc(%ebp)
c0100448:	ff 75 08             	pushl  0x8(%ebp)
c010044b:	68 ca 5d 10 c0       	push   $0xc0105dca
c0100450:	e8 4f fe ff ff       	call   c01002a4 <cprintf>
c0100455:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
c0100458:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010045b:	83 ec 08             	sub    $0x8,%esp
c010045e:	50                   	push   %eax
c010045f:	ff 75 10             	pushl  0x10(%ebp)
c0100462:	e8 10 fe ff ff       	call   c0100277 <vcprintf>
c0100467:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
c010046a:	83 ec 0c             	sub    $0xc,%esp
c010046d:	68 e6 5d 10 c0       	push   $0xc0105de6
c0100472:	e8 2d fe ff ff       	call   c01002a4 <cprintf>
c0100477:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
c010047a:	83 ec 0c             	sub    $0xc,%esp
c010047d:	68 e8 5d 10 c0       	push   $0xc0105de8
c0100482:	e8 1d fe ff ff       	call   c01002a4 <cprintf>
c0100487:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
c010048a:	e8 25 06 00 00       	call   c0100ab4 <print_stackframe>
c010048f:	eb 01                	jmp    c0100492 <__panic+0x73>
        goto panic_dead;
c0100491:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
c0100492:	e8 ee 14 00 00       	call   c0101985 <intr_disable>
    while (1) {
        kmonitor(NULL);
c0100497:	83 ec 0c             	sub    $0xc,%esp
c010049a:	6a 00                	push   $0x0
c010049c:	e8 4c 08 00 00       	call   c0100ced <kmonitor>
c01004a1:	83 c4 10             	add    $0x10,%esp
c01004a4:	eb f1                	jmp    c0100497 <__panic+0x78>

c01004a6 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
c01004a6:	f3 0f 1e fb          	endbr32 
c01004aa:	55                   	push   %ebp
c01004ab:	89 e5                	mov    %esp,%ebp
c01004ad:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
c01004b0:	8d 45 14             	lea    0x14(%ebp),%eax
c01004b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
c01004b6:	83 ec 04             	sub    $0x4,%esp
c01004b9:	ff 75 0c             	pushl  0xc(%ebp)
c01004bc:	ff 75 08             	pushl  0x8(%ebp)
c01004bf:	68 fa 5d 10 c0       	push   $0xc0105dfa
c01004c4:	e8 db fd ff ff       	call   c01002a4 <cprintf>
c01004c9:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
c01004cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01004cf:	83 ec 08             	sub    $0x8,%esp
c01004d2:	50                   	push   %eax
c01004d3:	ff 75 10             	pushl  0x10(%ebp)
c01004d6:	e8 9c fd ff ff       	call   c0100277 <vcprintf>
c01004db:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
c01004de:	83 ec 0c             	sub    $0xc,%esp
c01004e1:	68 e6 5d 10 c0       	push   $0xc0105de6
c01004e6:	e8 b9 fd ff ff       	call   c01002a4 <cprintf>
c01004eb:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
c01004ee:	90                   	nop
c01004ef:	c9                   	leave  
c01004f0:	c3                   	ret    

c01004f1 <is_kernel_panic>:

bool
is_kernel_panic(void) {
c01004f1:	f3 0f 1e fb          	endbr32 
c01004f5:	55                   	push   %ebp
c01004f6:	89 e5                	mov    %esp,%ebp
    return is_panic;
c01004f8:	a1 20 c4 11 c0       	mov    0xc011c420,%eax
}
c01004fd:	5d                   	pop    %ebp
c01004fe:	c3                   	ret    

c01004ff <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
c01004ff:	f3 0f 1e fb          	endbr32 
c0100503:	55                   	push   %ebp
c0100504:	89 e5                	mov    %esp,%ebp
c0100506:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
c0100509:	8b 45 0c             	mov    0xc(%ebp),%eax
c010050c:	8b 00                	mov    (%eax),%eax
c010050e:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0100511:	8b 45 10             	mov    0x10(%ebp),%eax
c0100514:	8b 00                	mov    (%eax),%eax
c0100516:	89 45 f8             	mov    %eax,-0x8(%ebp)
c0100519:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
c0100520:	e9 d2 00 00 00       	jmp    c01005f7 <stab_binsearch+0xf8>
        int true_m = (l + r) / 2, m = true_m;
c0100525:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0100528:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010052b:	01 d0                	add    %edx,%eax
c010052d:	89 c2                	mov    %eax,%edx
c010052f:	c1 ea 1f             	shr    $0x1f,%edx
c0100532:	01 d0                	add    %edx,%eax
c0100534:	d1 f8                	sar    %eax
c0100536:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0100539:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010053c:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
c010053f:	eb 04                	jmp    c0100545 <stab_binsearch+0x46>
            m --;
c0100541:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
c0100545:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100548:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c010054b:	7c 1f                	jl     c010056c <stab_binsearch+0x6d>
c010054d:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100550:	89 d0                	mov    %edx,%eax
c0100552:	01 c0                	add    %eax,%eax
c0100554:	01 d0                	add    %edx,%eax
c0100556:	c1 e0 02             	shl    $0x2,%eax
c0100559:	89 c2                	mov    %eax,%edx
c010055b:	8b 45 08             	mov    0x8(%ebp),%eax
c010055e:	01 d0                	add    %edx,%eax
c0100560:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100564:	0f b6 c0             	movzbl %al,%eax
c0100567:	39 45 14             	cmp    %eax,0x14(%ebp)
c010056a:	75 d5                	jne    c0100541 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
c010056c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010056f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c0100572:	7d 0b                	jge    c010057f <stab_binsearch+0x80>
            l = true_m + 1;
c0100574:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100577:	83 c0 01             	add    $0x1,%eax
c010057a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
c010057d:	eb 78                	jmp    c01005f7 <stab_binsearch+0xf8>
        }

        // actual binary search
        any_matches = 1;
c010057f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
c0100586:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100589:	89 d0                	mov    %edx,%eax
c010058b:	01 c0                	add    %eax,%eax
c010058d:	01 d0                	add    %edx,%eax
c010058f:	c1 e0 02             	shl    $0x2,%eax
c0100592:	89 c2                	mov    %eax,%edx
c0100594:	8b 45 08             	mov    0x8(%ebp),%eax
c0100597:	01 d0                	add    %edx,%eax
c0100599:	8b 40 08             	mov    0x8(%eax),%eax
c010059c:	39 45 18             	cmp    %eax,0x18(%ebp)
c010059f:	76 13                	jbe    c01005b4 <stab_binsearch+0xb5>
            *region_left = m;
c01005a1:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005a4:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005a7:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
c01005a9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01005ac:	83 c0 01             	add    $0x1,%eax
c01005af:	89 45 fc             	mov    %eax,-0x4(%ebp)
c01005b2:	eb 43                	jmp    c01005f7 <stab_binsearch+0xf8>
        } else if (stabs[m].n_value > addr) {
c01005b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005b7:	89 d0                	mov    %edx,%eax
c01005b9:	01 c0                	add    %eax,%eax
c01005bb:	01 d0                	add    %edx,%eax
c01005bd:	c1 e0 02             	shl    $0x2,%eax
c01005c0:	89 c2                	mov    %eax,%edx
c01005c2:	8b 45 08             	mov    0x8(%ebp),%eax
c01005c5:	01 d0                	add    %edx,%eax
c01005c7:	8b 40 08             	mov    0x8(%eax),%eax
c01005ca:	39 45 18             	cmp    %eax,0x18(%ebp)
c01005cd:	73 16                	jae    c01005e5 <stab_binsearch+0xe6>
            *region_right = m - 1;
c01005cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005d2:	8d 50 ff             	lea    -0x1(%eax),%edx
c01005d5:	8b 45 10             	mov    0x10(%ebp),%eax
c01005d8:	89 10                	mov    %edx,(%eax)
            r = m - 1;
c01005da:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005dd:	83 e8 01             	sub    $0x1,%eax
c01005e0:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01005e3:	eb 12                	jmp    c01005f7 <stab_binsearch+0xf8>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
c01005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005e8:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005eb:	89 10                	mov    %edx,(%eax)
            l = m;
c01005ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
c01005f3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
c01005f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01005fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
c01005fd:	0f 8e 22 ff ff ff    	jle    c0100525 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
c0100603:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100607:	75 0f                	jne    c0100618 <stab_binsearch+0x119>
        *region_right = *region_left - 1;
c0100609:	8b 45 0c             	mov    0xc(%ebp),%eax
c010060c:	8b 00                	mov    (%eax),%eax
c010060e:	8d 50 ff             	lea    -0x1(%eax),%edx
c0100611:	8b 45 10             	mov    0x10(%ebp),%eax
c0100614:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
c0100616:	eb 3f                	jmp    c0100657 <stab_binsearch+0x158>
        l = *region_right;
c0100618:	8b 45 10             	mov    0x10(%ebp),%eax
c010061b:	8b 00                	mov    (%eax),%eax
c010061d:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
c0100620:	eb 04                	jmp    c0100626 <stab_binsearch+0x127>
c0100622:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
c0100626:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100629:	8b 00                	mov    (%eax),%eax
c010062b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
c010062e:	7e 1f                	jle    c010064f <stab_binsearch+0x150>
c0100630:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0100633:	89 d0                	mov    %edx,%eax
c0100635:	01 c0                	add    %eax,%eax
c0100637:	01 d0                	add    %edx,%eax
c0100639:	c1 e0 02             	shl    $0x2,%eax
c010063c:	89 c2                	mov    %eax,%edx
c010063e:	8b 45 08             	mov    0x8(%ebp),%eax
c0100641:	01 d0                	add    %edx,%eax
c0100643:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100647:	0f b6 c0             	movzbl %al,%eax
c010064a:	39 45 14             	cmp    %eax,0x14(%ebp)
c010064d:	75 d3                	jne    c0100622 <stab_binsearch+0x123>
        *region_left = l;
c010064f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100652:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0100655:	89 10                	mov    %edx,(%eax)
}
c0100657:	90                   	nop
c0100658:	c9                   	leave  
c0100659:	c3                   	ret    

c010065a <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
c010065a:	f3 0f 1e fb          	endbr32 
c010065e:	55                   	push   %ebp
c010065f:	89 e5                	mov    %esp,%ebp
c0100661:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
c0100664:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100667:	c7 00 18 5e 10 c0    	movl   $0xc0105e18,(%eax)
    info->eip_line = 0;
c010066d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100670:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
c0100677:	8b 45 0c             	mov    0xc(%ebp),%eax
c010067a:	c7 40 08 18 5e 10 c0 	movl   $0xc0105e18,0x8(%eax)
    info->eip_fn_namelen = 9;
c0100681:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100684:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
c010068b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010068e:	8b 55 08             	mov    0x8(%ebp),%edx
c0100691:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
c0100694:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100697:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
c010069e:	c7 45 f4 40 70 10 c0 	movl   $0xc0107040,-0xc(%ebp)
    stab_end = __STAB_END__;
c01006a5:	c7 45 f0 48 3a 11 c0 	movl   $0xc0113a48,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
c01006ac:	c7 45 ec 49 3a 11 c0 	movl   $0xc0113a49,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
c01006b3:	c7 45 e8 a6 65 11 c0 	movl   $0xc01165a6,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
c01006ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01006bd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c01006c0:	76 0d                	jbe    c01006cf <debuginfo_eip+0x75>
c01006c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01006c5:	83 e8 01             	sub    $0x1,%eax
c01006c8:	0f b6 00             	movzbl (%eax),%eax
c01006cb:	84 c0                	test   %al,%al
c01006cd:	74 0a                	je     c01006d9 <debuginfo_eip+0x7f>
        return -1;
c01006cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01006d4:	e9 85 02 00 00       	jmp    c010095e <debuginfo_eip+0x304>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
c01006d9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c01006e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01006e3:	2b 45 f4             	sub    -0xc(%ebp),%eax
c01006e6:	c1 f8 02             	sar    $0x2,%eax
c01006e9:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
c01006ef:	83 e8 01             	sub    $0x1,%eax
c01006f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
c01006f5:	ff 75 08             	pushl  0x8(%ebp)
c01006f8:	6a 64                	push   $0x64
c01006fa:	8d 45 e0             	lea    -0x20(%ebp),%eax
c01006fd:	50                   	push   %eax
c01006fe:	8d 45 e4             	lea    -0x1c(%ebp),%eax
c0100701:	50                   	push   %eax
c0100702:	ff 75 f4             	pushl  -0xc(%ebp)
c0100705:	e8 f5 fd ff ff       	call   c01004ff <stab_binsearch>
c010070a:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
c010070d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100710:	85 c0                	test   %eax,%eax
c0100712:	75 0a                	jne    c010071e <debuginfo_eip+0xc4>
        return -1;
c0100714:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0100719:	e9 40 02 00 00       	jmp    c010095e <debuginfo_eip+0x304>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
c010071e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100721:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0100724:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0100727:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
c010072a:	ff 75 08             	pushl  0x8(%ebp)
c010072d:	6a 24                	push   $0x24
c010072f:	8d 45 d8             	lea    -0x28(%ebp),%eax
c0100732:	50                   	push   %eax
c0100733:	8d 45 dc             	lea    -0x24(%ebp),%eax
c0100736:	50                   	push   %eax
c0100737:	ff 75 f4             	pushl  -0xc(%ebp)
c010073a:	e8 c0 fd ff ff       	call   c01004ff <stab_binsearch>
c010073f:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
c0100742:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0100745:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0100748:	39 c2                	cmp    %eax,%edx
c010074a:	7f 78                	jg     c01007c4 <debuginfo_eip+0x16a>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
c010074c:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010074f:	89 c2                	mov    %eax,%edx
c0100751:	89 d0                	mov    %edx,%eax
c0100753:	01 c0                	add    %eax,%eax
c0100755:	01 d0                	add    %edx,%eax
c0100757:	c1 e0 02             	shl    $0x2,%eax
c010075a:	89 c2                	mov    %eax,%edx
c010075c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010075f:	01 d0                	add    %edx,%eax
c0100761:	8b 10                	mov    (%eax),%edx
c0100763:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100766:	2b 45 ec             	sub    -0x14(%ebp),%eax
c0100769:	39 c2                	cmp    %eax,%edx
c010076b:	73 22                	jae    c010078f <debuginfo_eip+0x135>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
c010076d:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100770:	89 c2                	mov    %eax,%edx
c0100772:	89 d0                	mov    %edx,%eax
c0100774:	01 c0                	add    %eax,%eax
c0100776:	01 d0                	add    %edx,%eax
c0100778:	c1 e0 02             	shl    $0x2,%eax
c010077b:	89 c2                	mov    %eax,%edx
c010077d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100780:	01 d0                	add    %edx,%eax
c0100782:	8b 10                	mov    (%eax),%edx
c0100784:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100787:	01 c2                	add    %eax,%edx
c0100789:	8b 45 0c             	mov    0xc(%ebp),%eax
c010078c:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
c010078f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100792:	89 c2                	mov    %eax,%edx
c0100794:	89 d0                	mov    %edx,%eax
c0100796:	01 c0                	add    %eax,%eax
c0100798:	01 d0                	add    %edx,%eax
c010079a:	c1 e0 02             	shl    $0x2,%eax
c010079d:	89 c2                	mov    %eax,%edx
c010079f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007a2:	01 d0                	add    %edx,%eax
c01007a4:	8b 50 08             	mov    0x8(%eax),%edx
c01007a7:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007aa:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
c01007ad:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007b0:	8b 40 10             	mov    0x10(%eax),%eax
c01007b3:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
c01007b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01007b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
c01007bc:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01007bf:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01007c2:	eb 15                	jmp    c01007d9 <debuginfo_eip+0x17f>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
c01007c4:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007c7:	8b 55 08             	mov    0x8(%ebp),%edx
c01007ca:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
c01007cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01007d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
c01007d3:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01007d6:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
c01007d9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007dc:	8b 40 08             	mov    0x8(%eax),%eax
c01007df:	83 ec 08             	sub    $0x8,%esp
c01007e2:	6a 3a                	push   $0x3a
c01007e4:	50                   	push   %eax
c01007e5:	e8 de 4b 00 00       	call   c01053c8 <strfind>
c01007ea:	83 c4 10             	add    $0x10,%esp
c01007ed:	8b 55 0c             	mov    0xc(%ebp),%edx
c01007f0:	8b 52 08             	mov    0x8(%edx),%edx
c01007f3:	29 d0                	sub    %edx,%eax
c01007f5:	89 c2                	mov    %eax,%edx
c01007f7:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007fa:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
c01007fd:	83 ec 0c             	sub    $0xc,%esp
c0100800:	ff 75 08             	pushl  0x8(%ebp)
c0100803:	6a 44                	push   $0x44
c0100805:	8d 45 d0             	lea    -0x30(%ebp),%eax
c0100808:	50                   	push   %eax
c0100809:	8d 45 d4             	lea    -0x2c(%ebp),%eax
c010080c:	50                   	push   %eax
c010080d:	ff 75 f4             	pushl  -0xc(%ebp)
c0100810:	e8 ea fc ff ff       	call   c01004ff <stab_binsearch>
c0100815:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
c0100818:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010081b:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010081e:	39 c2                	cmp    %eax,%edx
c0100820:	7f 24                	jg     c0100846 <debuginfo_eip+0x1ec>
        info->eip_line = stabs[rline].n_desc;
c0100822:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0100825:	89 c2                	mov    %eax,%edx
c0100827:	89 d0                	mov    %edx,%eax
c0100829:	01 c0                	add    %eax,%eax
c010082b:	01 d0                	add    %edx,%eax
c010082d:	c1 e0 02             	shl    $0x2,%eax
c0100830:	89 c2                	mov    %eax,%edx
c0100832:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100835:	01 d0                	add    %edx,%eax
c0100837:	0f b7 40 06          	movzwl 0x6(%eax),%eax
c010083b:	0f b7 d0             	movzwl %ax,%edx
c010083e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100841:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
c0100844:	eb 13                	jmp    c0100859 <debuginfo_eip+0x1ff>
        return -1;
c0100846:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c010084b:	e9 0e 01 00 00       	jmp    c010095e <debuginfo_eip+0x304>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
c0100850:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100853:	83 e8 01             	sub    $0x1,%eax
c0100856:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
c0100859:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010085c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010085f:	39 c2                	cmp    %eax,%edx
c0100861:	7c 56                	jl     c01008b9 <debuginfo_eip+0x25f>
           && stabs[lline].n_type != N_SOL
c0100863:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100866:	89 c2                	mov    %eax,%edx
c0100868:	89 d0                	mov    %edx,%eax
c010086a:	01 c0                	add    %eax,%eax
c010086c:	01 d0                	add    %edx,%eax
c010086e:	c1 e0 02             	shl    $0x2,%eax
c0100871:	89 c2                	mov    %eax,%edx
c0100873:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100876:	01 d0                	add    %edx,%eax
c0100878:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010087c:	3c 84                	cmp    $0x84,%al
c010087e:	74 39                	je     c01008b9 <debuginfo_eip+0x25f>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
c0100880:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100883:	89 c2                	mov    %eax,%edx
c0100885:	89 d0                	mov    %edx,%eax
c0100887:	01 c0                	add    %eax,%eax
c0100889:	01 d0                	add    %edx,%eax
c010088b:	c1 e0 02             	shl    $0x2,%eax
c010088e:	89 c2                	mov    %eax,%edx
c0100890:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100893:	01 d0                	add    %edx,%eax
c0100895:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100899:	3c 64                	cmp    $0x64,%al
c010089b:	75 b3                	jne    c0100850 <debuginfo_eip+0x1f6>
c010089d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008a0:	89 c2                	mov    %eax,%edx
c01008a2:	89 d0                	mov    %edx,%eax
c01008a4:	01 c0                	add    %eax,%eax
c01008a6:	01 d0                	add    %edx,%eax
c01008a8:	c1 e0 02             	shl    $0x2,%eax
c01008ab:	89 c2                	mov    %eax,%edx
c01008ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008b0:	01 d0                	add    %edx,%eax
c01008b2:	8b 40 08             	mov    0x8(%eax),%eax
c01008b5:	85 c0                	test   %eax,%eax
c01008b7:	74 97                	je     c0100850 <debuginfo_eip+0x1f6>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
c01008b9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01008bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01008bf:	39 c2                	cmp    %eax,%edx
c01008c1:	7c 42                	jl     c0100905 <debuginfo_eip+0x2ab>
c01008c3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008c6:	89 c2                	mov    %eax,%edx
c01008c8:	89 d0                	mov    %edx,%eax
c01008ca:	01 c0                	add    %eax,%eax
c01008cc:	01 d0                	add    %edx,%eax
c01008ce:	c1 e0 02             	shl    $0x2,%eax
c01008d1:	89 c2                	mov    %eax,%edx
c01008d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008d6:	01 d0                	add    %edx,%eax
c01008d8:	8b 10                	mov    (%eax),%edx
c01008da:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01008dd:	2b 45 ec             	sub    -0x14(%ebp),%eax
c01008e0:	39 c2                	cmp    %eax,%edx
c01008e2:	73 21                	jae    c0100905 <debuginfo_eip+0x2ab>
        info->eip_file = stabstr + stabs[lline].n_strx;
c01008e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008e7:	89 c2                	mov    %eax,%edx
c01008e9:	89 d0                	mov    %edx,%eax
c01008eb:	01 c0                	add    %eax,%eax
c01008ed:	01 d0                	add    %edx,%eax
c01008ef:	c1 e0 02             	shl    $0x2,%eax
c01008f2:	89 c2                	mov    %eax,%edx
c01008f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008f7:	01 d0                	add    %edx,%eax
c01008f9:	8b 10                	mov    (%eax),%edx
c01008fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01008fe:	01 c2                	add    %eax,%edx
c0100900:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100903:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
c0100905:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0100908:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010090b:	39 c2                	cmp    %eax,%edx
c010090d:	7d 4a                	jge    c0100959 <debuginfo_eip+0x2ff>
        for (lline = lfun + 1;
c010090f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100912:	83 c0 01             	add    $0x1,%eax
c0100915:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c0100918:	eb 18                	jmp    c0100932 <debuginfo_eip+0x2d8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
c010091a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010091d:	8b 40 14             	mov    0x14(%eax),%eax
c0100920:	8d 50 01             	lea    0x1(%eax),%edx
c0100923:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100926:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
c0100929:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010092c:	83 c0 01             	add    $0x1,%eax
c010092f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
c0100932:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100935:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
c0100938:	39 c2                	cmp    %eax,%edx
c010093a:	7d 1d                	jge    c0100959 <debuginfo_eip+0x2ff>
             lline < rfun && stabs[lline].n_type == N_PSYM;
c010093c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010093f:	89 c2                	mov    %eax,%edx
c0100941:	89 d0                	mov    %edx,%eax
c0100943:	01 c0                	add    %eax,%eax
c0100945:	01 d0                	add    %edx,%eax
c0100947:	c1 e0 02             	shl    $0x2,%eax
c010094a:	89 c2                	mov    %eax,%edx
c010094c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010094f:	01 d0                	add    %edx,%eax
c0100951:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100955:	3c a0                	cmp    $0xa0,%al
c0100957:	74 c1                	je     c010091a <debuginfo_eip+0x2c0>
        }
    }
    return 0;
c0100959:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010095e:	c9                   	leave  
c010095f:	c3                   	ret    

c0100960 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
c0100960:	f3 0f 1e fb          	endbr32 
c0100964:	55                   	push   %ebp
c0100965:	89 e5                	mov    %esp,%ebp
c0100967:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
c010096a:	83 ec 0c             	sub    $0xc,%esp
c010096d:	68 22 5e 10 c0       	push   $0xc0105e22
c0100972:	e8 2d f9 ff ff       	call   c01002a4 <cprintf>
c0100977:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
c010097a:	83 ec 08             	sub    $0x8,%esp
c010097d:	68 36 00 10 c0       	push   $0xc0100036
c0100982:	68 3b 5e 10 c0       	push   $0xc0105e3b
c0100987:	e8 18 f9 ff ff       	call   c01002a4 <cprintf>
c010098c:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
c010098f:	83 ec 08             	sub    $0x8,%esp
c0100992:	68 1d 5d 10 c0       	push   $0xc0105d1d
c0100997:	68 53 5e 10 c0       	push   $0xc0105e53
c010099c:	e8 03 f9 ff ff       	call   c01002a4 <cprintf>
c01009a1:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
c01009a4:	83 ec 08             	sub    $0x8,%esp
c01009a7:	68 00 c0 11 c0       	push   $0xc011c000
c01009ac:	68 6b 5e 10 c0       	push   $0xc0105e6b
c01009b1:	e8 ee f8 ff ff       	call   c01002a4 <cprintf>
c01009b6:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
c01009b9:	83 ec 08             	sub    $0x8,%esp
c01009bc:	68 28 cf 11 c0       	push   $0xc011cf28
c01009c1:	68 83 5e 10 c0       	push   $0xc0105e83
c01009c6:	e8 d9 f8 ff ff       	call   c01002a4 <cprintf>
c01009cb:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
c01009ce:	b8 28 cf 11 c0       	mov    $0xc011cf28,%eax
c01009d3:	2d 36 00 10 c0       	sub    $0xc0100036,%eax
c01009d8:	05 ff 03 00 00       	add    $0x3ff,%eax
c01009dd:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
c01009e3:	85 c0                	test   %eax,%eax
c01009e5:	0f 48 c2             	cmovs  %edx,%eax
c01009e8:	c1 f8 0a             	sar    $0xa,%eax
c01009eb:	83 ec 08             	sub    $0x8,%esp
c01009ee:	50                   	push   %eax
c01009ef:	68 9c 5e 10 c0       	push   $0xc0105e9c
c01009f4:	e8 ab f8 ff ff       	call   c01002a4 <cprintf>
c01009f9:	83 c4 10             	add    $0x10,%esp
}
c01009fc:	90                   	nop
c01009fd:	c9                   	leave  
c01009fe:	c3                   	ret    

c01009ff <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
c01009ff:	f3 0f 1e fb          	endbr32 
c0100a03:	55                   	push   %ebp
c0100a04:	89 e5                	mov    %esp,%ebp
c0100a06:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
c0100a0c:	83 ec 08             	sub    $0x8,%esp
c0100a0f:	8d 45 dc             	lea    -0x24(%ebp),%eax
c0100a12:	50                   	push   %eax
c0100a13:	ff 75 08             	pushl  0x8(%ebp)
c0100a16:	e8 3f fc ff ff       	call   c010065a <debuginfo_eip>
c0100a1b:	83 c4 10             	add    $0x10,%esp
c0100a1e:	85 c0                	test   %eax,%eax
c0100a20:	74 15                	je     c0100a37 <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
c0100a22:	83 ec 08             	sub    $0x8,%esp
c0100a25:	ff 75 08             	pushl  0x8(%ebp)
c0100a28:	68 c6 5e 10 c0       	push   $0xc0105ec6
c0100a2d:	e8 72 f8 ff ff       	call   c01002a4 <cprintf>
c0100a32:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
c0100a35:	eb 65                	jmp    c0100a9c <print_debuginfo+0x9d>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a37:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100a3e:	eb 1c                	jmp    c0100a5c <print_debuginfo+0x5d>
            fnname[j] = info.eip_fn_name[j];
c0100a40:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0100a43:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a46:	01 d0                	add    %edx,%eax
c0100a48:	0f b6 00             	movzbl (%eax),%eax
c0100a4b:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100a51:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100a54:	01 ca                	add    %ecx,%edx
c0100a56:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a58:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100a5c:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100a5f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0100a62:	7c dc                	jl     c0100a40 <print_debuginfo+0x41>
        fnname[j] = '\0';
c0100a64:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
c0100a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a6d:	01 d0                	add    %edx,%eax
c0100a6f:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
c0100a72:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
c0100a75:	8b 55 08             	mov    0x8(%ebp),%edx
c0100a78:	89 d1                	mov    %edx,%ecx
c0100a7a:	29 c1                	sub    %eax,%ecx
c0100a7c:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0100a7f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100a82:	83 ec 0c             	sub    $0xc,%esp
c0100a85:	51                   	push   %ecx
c0100a86:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100a8c:	51                   	push   %ecx
c0100a8d:	52                   	push   %edx
c0100a8e:	50                   	push   %eax
c0100a8f:	68 e2 5e 10 c0       	push   $0xc0105ee2
c0100a94:	e8 0b f8 ff ff       	call   c01002a4 <cprintf>
c0100a99:	83 c4 20             	add    $0x20,%esp
}
c0100a9c:	90                   	nop
c0100a9d:	c9                   	leave  
c0100a9e:	c3                   	ret    

c0100a9f <read_eip>:

static __noinline uint32_t
read_eip(void) {
c0100a9f:	f3 0f 1e fb          	endbr32 
c0100aa3:	55                   	push   %ebp
c0100aa4:	89 e5                	mov    %esp,%ebp
c0100aa6:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
c0100aa9:	8b 45 04             	mov    0x4(%ebp),%eax
c0100aac:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
c0100aaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0100ab2:	c9                   	leave  
c0100ab3:	c3                   	ret    

c0100ab4 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
c0100ab4:	f3 0f 1e fb          	endbr32 
c0100ab8:	55                   	push   %ebp
c0100ab9:	89 e5                	mov    %esp,%ebp
c0100abb:	83 ec 28             	sub    $0x28,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
c0100abe:	89 e8                	mov    %ebp,%eax
c0100ac0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
c0100ac3:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();
c0100ac6:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100ac9:	e8 d1 ff ff ff       	call   c0100a9f <read_eip>
c0100ace:	89 45 f0             	mov    %eax,-0x10(%ebp)

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
c0100ad1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0100ad8:	e9 8d 00 00 00       	jmp    c0100b6a <print_stackframe+0xb6>
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
c0100add:	83 ec 04             	sub    $0x4,%esp
c0100ae0:	ff 75 f0             	pushl  -0x10(%ebp)
c0100ae3:	ff 75 f4             	pushl  -0xc(%ebp)
c0100ae6:	68 f4 5e 10 c0       	push   $0xc0105ef4
c0100aeb:	e8 b4 f7 ff ff       	call   c01002a4 <cprintf>
c0100af0:	83 c4 10             	add    $0x10,%esp
        uint32_t *args = (uint32_t *)ebp + 2;
c0100af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100af6:	83 c0 08             	add    $0x8,%eax
c0100af9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < 4; j ++) {
c0100afc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
c0100b03:	eb 26                	jmp    c0100b2b <print_stackframe+0x77>
            cprintf("0x%08x ", args[j]);
c0100b05:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100b08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100b0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100b12:	01 d0                	add    %edx,%eax
c0100b14:	8b 00                	mov    (%eax),%eax
c0100b16:	83 ec 08             	sub    $0x8,%esp
c0100b19:	50                   	push   %eax
c0100b1a:	68 10 5f 10 c0       	push   $0xc0105f10
c0100b1f:	e8 80 f7 ff ff       	call   c01002a4 <cprintf>
c0100b24:	83 c4 10             	add    $0x10,%esp
        for (j = 0; j < 4; j ++) {
c0100b27:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
c0100b2b:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
c0100b2f:	7e d4                	jle    c0100b05 <print_stackframe+0x51>
        }
        cprintf("\n");
c0100b31:	83 ec 0c             	sub    $0xc,%esp
c0100b34:	68 18 5f 10 c0       	push   $0xc0105f18
c0100b39:	e8 66 f7 ff ff       	call   c01002a4 <cprintf>
c0100b3e:	83 c4 10             	add    $0x10,%esp
        print_debuginfo(eip - 1);
c0100b41:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100b44:	83 e8 01             	sub    $0x1,%eax
c0100b47:	83 ec 0c             	sub    $0xc,%esp
c0100b4a:	50                   	push   %eax
c0100b4b:	e8 af fe ff ff       	call   c01009ff <print_debuginfo>
c0100b50:	83 c4 10             	add    $0x10,%esp
        eip = ((uint32_t *)ebp)[1];
c0100b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b56:	83 c0 04             	add    $0x4,%eax
c0100b59:	8b 00                	mov    (%eax),%eax
c0100b5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = ((uint32_t *)ebp)[0];
c0100b5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b61:	8b 00                	mov    (%eax),%eax
c0100b63:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
c0100b66:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
c0100b6a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100b6e:	74 0a                	je     c0100b7a <print_stackframe+0xc6>
c0100b70:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
c0100b74:	0f 8e 63 ff ff ff    	jle    c0100add <print_stackframe+0x29>
    }
}
c0100b7a:	90                   	nop
c0100b7b:	c9                   	leave  
c0100b7c:	c3                   	ret    

c0100b7d <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
c0100b7d:	f3 0f 1e fb          	endbr32 
c0100b81:	55                   	push   %ebp
c0100b82:	89 e5                	mov    %esp,%ebp
c0100b84:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
c0100b87:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b8e:	eb 0c                	jmp    c0100b9c <parse+0x1f>
            *buf ++ = '\0';
c0100b90:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b93:	8d 50 01             	lea    0x1(%eax),%edx
c0100b96:	89 55 08             	mov    %edx,0x8(%ebp)
c0100b99:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b9c:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b9f:	0f b6 00             	movzbl (%eax),%eax
c0100ba2:	84 c0                	test   %al,%al
c0100ba4:	74 1e                	je     c0100bc4 <parse+0x47>
c0100ba6:	8b 45 08             	mov    0x8(%ebp),%eax
c0100ba9:	0f b6 00             	movzbl (%eax),%eax
c0100bac:	0f be c0             	movsbl %al,%eax
c0100baf:	83 ec 08             	sub    $0x8,%esp
c0100bb2:	50                   	push   %eax
c0100bb3:	68 9c 5f 10 c0       	push   $0xc0105f9c
c0100bb8:	e8 d4 47 00 00       	call   c0105391 <strchr>
c0100bbd:	83 c4 10             	add    $0x10,%esp
c0100bc0:	85 c0                	test   %eax,%eax
c0100bc2:	75 cc                	jne    c0100b90 <parse+0x13>
        }
        if (*buf == '\0') {
c0100bc4:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bc7:	0f b6 00             	movzbl (%eax),%eax
c0100bca:	84 c0                	test   %al,%al
c0100bcc:	74 65                	je     c0100c33 <parse+0xb6>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
c0100bce:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
c0100bd2:	75 12                	jne    c0100be6 <parse+0x69>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
c0100bd4:	83 ec 08             	sub    $0x8,%esp
c0100bd7:	6a 10                	push   $0x10
c0100bd9:	68 a1 5f 10 c0       	push   $0xc0105fa1
c0100bde:	e8 c1 f6 ff ff       	call   c01002a4 <cprintf>
c0100be3:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
c0100be6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100be9:	8d 50 01             	lea    0x1(%eax),%edx
c0100bec:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0100bef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100bf9:	01 c2                	add    %eax,%edx
c0100bfb:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bfe:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100c00:	eb 04                	jmp    c0100c06 <parse+0x89>
            buf ++;
c0100c02:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100c06:	8b 45 08             	mov    0x8(%ebp),%eax
c0100c09:	0f b6 00             	movzbl (%eax),%eax
c0100c0c:	84 c0                	test   %al,%al
c0100c0e:	74 8c                	je     c0100b9c <parse+0x1f>
c0100c10:	8b 45 08             	mov    0x8(%ebp),%eax
c0100c13:	0f b6 00             	movzbl (%eax),%eax
c0100c16:	0f be c0             	movsbl %al,%eax
c0100c19:	83 ec 08             	sub    $0x8,%esp
c0100c1c:	50                   	push   %eax
c0100c1d:	68 9c 5f 10 c0       	push   $0xc0105f9c
c0100c22:	e8 6a 47 00 00       	call   c0105391 <strchr>
c0100c27:	83 c4 10             	add    $0x10,%esp
c0100c2a:	85 c0                	test   %eax,%eax
c0100c2c:	74 d4                	je     c0100c02 <parse+0x85>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100c2e:	e9 69 ff ff ff       	jmp    c0100b9c <parse+0x1f>
            break;
c0100c33:	90                   	nop
        }
    }
    return argc;
c0100c34:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100c37:	c9                   	leave  
c0100c38:	c3                   	ret    

c0100c39 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
c0100c39:	f3 0f 1e fb          	endbr32 
c0100c3d:	55                   	push   %ebp
c0100c3e:	89 e5                	mov    %esp,%ebp
c0100c40:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
c0100c43:	83 ec 08             	sub    $0x8,%esp
c0100c46:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100c49:	50                   	push   %eax
c0100c4a:	ff 75 08             	pushl  0x8(%ebp)
c0100c4d:	e8 2b ff ff ff       	call   c0100b7d <parse>
c0100c52:	83 c4 10             	add    $0x10,%esp
c0100c55:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
c0100c58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100c5c:	75 0a                	jne    c0100c68 <runcmd+0x2f>
        return 0;
c0100c5e:	b8 00 00 00 00       	mov    $0x0,%eax
c0100c63:	e9 83 00 00 00       	jmp    c0100ceb <runcmd+0xb2>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100c6f:	eb 59                	jmp    c0100cca <runcmd+0x91>
        if (strcmp(commands[i].name, argv[0]) == 0) {
c0100c71:	8b 4d b0             	mov    -0x50(%ebp),%ecx
c0100c74:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c77:	89 d0                	mov    %edx,%eax
c0100c79:	01 c0                	add    %eax,%eax
c0100c7b:	01 d0                	add    %edx,%eax
c0100c7d:	c1 e0 02             	shl    $0x2,%eax
c0100c80:	05 00 90 11 c0       	add    $0xc0119000,%eax
c0100c85:	8b 00                	mov    (%eax),%eax
c0100c87:	83 ec 08             	sub    $0x8,%esp
c0100c8a:	51                   	push   %ecx
c0100c8b:	50                   	push   %eax
c0100c8c:	e8 59 46 00 00       	call   c01052ea <strcmp>
c0100c91:	83 c4 10             	add    $0x10,%esp
c0100c94:	85 c0                	test   %eax,%eax
c0100c96:	75 2e                	jne    c0100cc6 <runcmd+0x8d>
            return commands[i].func(argc - 1, argv + 1, tf);
c0100c98:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c9b:	89 d0                	mov    %edx,%eax
c0100c9d:	01 c0                	add    %eax,%eax
c0100c9f:	01 d0                	add    %edx,%eax
c0100ca1:	c1 e0 02             	shl    $0x2,%eax
c0100ca4:	05 08 90 11 c0       	add    $0xc0119008,%eax
c0100ca9:	8b 10                	mov    (%eax),%edx
c0100cab:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100cae:	83 c0 04             	add    $0x4,%eax
c0100cb1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0100cb4:	83 e9 01             	sub    $0x1,%ecx
c0100cb7:	83 ec 04             	sub    $0x4,%esp
c0100cba:	ff 75 0c             	pushl  0xc(%ebp)
c0100cbd:	50                   	push   %eax
c0100cbe:	51                   	push   %ecx
c0100cbf:	ff d2                	call   *%edx
c0100cc1:	83 c4 10             	add    $0x10,%esp
c0100cc4:	eb 25                	jmp    c0100ceb <runcmd+0xb2>
    for (i = 0; i < NCOMMANDS; i ++) {
c0100cc6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100ccd:	83 f8 02             	cmp    $0x2,%eax
c0100cd0:	76 9f                	jbe    c0100c71 <runcmd+0x38>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
c0100cd2:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0100cd5:	83 ec 08             	sub    $0x8,%esp
c0100cd8:	50                   	push   %eax
c0100cd9:	68 bf 5f 10 c0       	push   $0xc0105fbf
c0100cde:	e8 c1 f5 ff ff       	call   c01002a4 <cprintf>
c0100ce3:	83 c4 10             	add    $0x10,%esp
    return 0;
c0100ce6:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100ceb:	c9                   	leave  
c0100cec:	c3                   	ret    

c0100ced <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
c0100ced:	f3 0f 1e fb          	endbr32 
c0100cf1:	55                   	push   %ebp
c0100cf2:	89 e5                	mov    %esp,%ebp
c0100cf4:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
c0100cf7:	83 ec 0c             	sub    $0xc,%esp
c0100cfa:	68 d8 5f 10 c0       	push   $0xc0105fd8
c0100cff:	e8 a0 f5 ff ff       	call   c01002a4 <cprintf>
c0100d04:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
c0100d07:	83 ec 0c             	sub    $0xc,%esp
c0100d0a:	68 00 60 10 c0       	push   $0xc0106000
c0100d0f:	e8 90 f5 ff ff       	call   c01002a4 <cprintf>
c0100d14:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
c0100d17:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100d1b:	74 0e                	je     c0100d2b <kmonitor+0x3e>
        print_trapframe(tf);
c0100d1d:	83 ec 0c             	sub    $0xc,%esp
c0100d20:	ff 75 08             	pushl  0x8(%ebp)
c0100d23:	e8 74 0e 00 00       	call   c0101b9c <print_trapframe>
c0100d28:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
c0100d2b:	83 ec 0c             	sub    $0xc,%esp
c0100d2e:	68 25 60 10 c0       	push   $0xc0106025
c0100d33:	e8 21 f6 ff ff       	call   c0100359 <readline>
c0100d38:	83 c4 10             	add    $0x10,%esp
c0100d3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100d3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100d42:	74 e7                	je     c0100d2b <kmonitor+0x3e>
            if (runcmd(buf, tf) < 0) {
c0100d44:	83 ec 08             	sub    $0x8,%esp
c0100d47:	ff 75 08             	pushl  0x8(%ebp)
c0100d4a:	ff 75 f4             	pushl  -0xc(%ebp)
c0100d4d:	e8 e7 fe ff ff       	call   c0100c39 <runcmd>
c0100d52:	83 c4 10             	add    $0x10,%esp
c0100d55:	85 c0                	test   %eax,%eax
c0100d57:	78 02                	js     c0100d5b <kmonitor+0x6e>
        if ((buf = readline("K> ")) != NULL) {
c0100d59:	eb d0                	jmp    c0100d2b <kmonitor+0x3e>
                break;
c0100d5b:	90                   	nop
            }
        }
    }
}
c0100d5c:	90                   	nop
c0100d5d:	c9                   	leave  
c0100d5e:	c3                   	ret    

c0100d5f <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
c0100d5f:	f3 0f 1e fb          	endbr32 
c0100d63:	55                   	push   %ebp
c0100d64:	89 e5                	mov    %esp,%ebp
c0100d66:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100d69:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100d70:	eb 3c                	jmp    c0100dae <mon_help+0x4f>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
c0100d72:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100d75:	89 d0                	mov    %edx,%eax
c0100d77:	01 c0                	add    %eax,%eax
c0100d79:	01 d0                	add    %edx,%eax
c0100d7b:	c1 e0 02             	shl    $0x2,%eax
c0100d7e:	05 04 90 11 c0       	add    $0xc0119004,%eax
c0100d83:	8b 08                	mov    (%eax),%ecx
c0100d85:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100d88:	89 d0                	mov    %edx,%eax
c0100d8a:	01 c0                	add    %eax,%eax
c0100d8c:	01 d0                	add    %edx,%eax
c0100d8e:	c1 e0 02             	shl    $0x2,%eax
c0100d91:	05 00 90 11 c0       	add    $0xc0119000,%eax
c0100d96:	8b 00                	mov    (%eax),%eax
c0100d98:	83 ec 04             	sub    $0x4,%esp
c0100d9b:	51                   	push   %ecx
c0100d9c:	50                   	push   %eax
c0100d9d:	68 29 60 10 c0       	push   $0xc0106029
c0100da2:	e8 fd f4 ff ff       	call   c01002a4 <cprintf>
c0100da7:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
c0100daa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0100dae:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100db1:	83 f8 02             	cmp    $0x2,%eax
c0100db4:	76 bc                	jbe    c0100d72 <mon_help+0x13>
    }
    return 0;
c0100db6:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100dbb:	c9                   	leave  
c0100dbc:	c3                   	ret    

c0100dbd <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
c0100dbd:	f3 0f 1e fb          	endbr32 
c0100dc1:	55                   	push   %ebp
c0100dc2:	89 e5                	mov    %esp,%ebp
c0100dc4:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
c0100dc7:	e8 94 fb ff ff       	call   c0100960 <print_kerninfo>
    return 0;
c0100dcc:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100dd1:	c9                   	leave  
c0100dd2:	c3                   	ret    

c0100dd3 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
c0100dd3:	f3 0f 1e fb          	endbr32 
c0100dd7:	55                   	push   %ebp
c0100dd8:	89 e5                	mov    %esp,%ebp
c0100dda:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
c0100ddd:	e8 d2 fc ff ff       	call   c0100ab4 <print_stackframe>
    return 0;
c0100de2:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100de7:	c9                   	leave  
c0100de8:	c3                   	ret    

c0100de9 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
c0100de9:	f3 0f 1e fb          	endbr32 
c0100ded:	55                   	push   %ebp
c0100dee:	89 e5                	mov    %esp,%ebp
c0100df0:	83 ec 18             	sub    $0x18,%esp
c0100df3:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
c0100df9:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100dfd:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100e01:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100e05:	ee                   	out    %al,(%dx)
}
c0100e06:	90                   	nop
c0100e07:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
c0100e0d:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100e11:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100e15:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100e19:	ee                   	out    %al,(%dx)
}
c0100e1a:	90                   	nop
c0100e1b:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
c0100e21:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100e25:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0100e29:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0100e2d:	ee                   	out    %al,(%dx)
}
c0100e2e:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
c0100e2f:	c7 05 0c cf 11 c0 00 	movl   $0x0,0xc011cf0c
c0100e36:	00 00 00 

    cprintf("++ setup timer interrupts\n");
c0100e39:	83 ec 0c             	sub    $0xc,%esp
c0100e3c:	68 32 60 10 c0       	push   $0xc0106032
c0100e41:	e8 5e f4 ff ff       	call   c01002a4 <cprintf>
c0100e46:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
c0100e49:	83 ec 0c             	sub    $0xc,%esp
c0100e4c:	6a 00                	push   $0x0
c0100e4e:	e8 a6 09 00 00       	call   c01017f9 <pic_enable>
c0100e53:	83 c4 10             	add    $0x10,%esp
}
c0100e56:	90                   	nop
c0100e57:	c9                   	leave  
c0100e58:	c3                   	ret    

c0100e59 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
c0100e59:	55                   	push   %ebp
c0100e5a:	89 e5                	mov    %esp,%ebp
c0100e5c:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0100e5f:	9c                   	pushf  
c0100e60:	58                   	pop    %eax
c0100e61:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0100e64:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0100e67:	25 00 02 00 00       	and    $0x200,%eax
c0100e6c:	85 c0                	test   %eax,%eax
c0100e6e:	74 0c                	je     c0100e7c <__intr_save+0x23>
        intr_disable();
c0100e70:	e8 10 0b 00 00       	call   c0101985 <intr_disable>
        return 1;
c0100e75:	b8 01 00 00 00       	mov    $0x1,%eax
c0100e7a:	eb 05                	jmp    c0100e81 <__intr_save+0x28>
    }
    return 0;
c0100e7c:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100e81:	c9                   	leave  
c0100e82:	c3                   	ret    

c0100e83 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
c0100e83:	55                   	push   %ebp
c0100e84:	89 e5                	mov    %esp,%ebp
c0100e86:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0100e89:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100e8d:	74 05                	je     c0100e94 <__intr_restore+0x11>
        intr_enable();
c0100e8f:	e8 e5 0a 00 00       	call   c0101979 <intr_enable>
    }
}
c0100e94:	90                   	nop
c0100e95:	c9                   	leave  
c0100e96:	c3                   	ret    

c0100e97 <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
c0100e97:	f3 0f 1e fb          	endbr32 
c0100e9b:	55                   	push   %ebp
c0100e9c:	89 e5                	mov    %esp,%ebp
c0100e9e:	83 ec 10             	sub    $0x10,%esp
c0100ea1:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100ea7:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100eab:	89 c2                	mov    %eax,%edx
c0100ead:	ec                   	in     (%dx),%al
c0100eae:	88 45 f1             	mov    %al,-0xf(%ebp)
c0100eb1:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
c0100eb7:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100ebb:	89 c2                	mov    %eax,%edx
c0100ebd:	ec                   	in     (%dx),%al
c0100ebe:	88 45 f5             	mov    %al,-0xb(%ebp)
c0100ec1:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
c0100ec7:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0100ecb:	89 c2                	mov    %eax,%edx
c0100ecd:	ec                   	in     (%dx),%al
c0100ece:	88 45 f9             	mov    %al,-0x7(%ebp)
c0100ed1:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
c0100ed7:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0100edb:	89 c2                	mov    %eax,%edx
c0100edd:	ec                   	in     (%dx),%al
c0100ede:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
c0100ee1:	90                   	nop
c0100ee2:	c9                   	leave  
c0100ee3:	c3                   	ret    

c0100ee4 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
c0100ee4:	f3 0f 1e fb          	endbr32 
c0100ee8:	55                   	push   %ebp
c0100ee9:	89 e5                	mov    %esp,%ebp
c0100eeb:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
c0100eee:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
c0100ef5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100ef8:	0f b7 00             	movzwl (%eax),%eax
c0100efb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
c0100eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f02:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
c0100f07:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f0a:	0f b7 00             	movzwl (%eax),%eax
c0100f0d:	66 3d 5a a5          	cmp    $0xa55a,%ax
c0100f11:	74 12                	je     c0100f25 <cga_init+0x41>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
c0100f13:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
c0100f1a:	66 c7 05 46 c4 11 c0 	movw   $0x3b4,0xc011c446
c0100f21:	b4 03 
c0100f23:	eb 13                	jmp    c0100f38 <cga_init+0x54>
    } else {
        *cp = was;
c0100f25:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f28:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0100f2c:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
c0100f2f:	66 c7 05 46 c4 11 c0 	movw   $0x3d4,0xc011c446
c0100f36:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
c0100f38:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100f3f:	0f b7 c0             	movzwl %ax,%eax
c0100f42:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c0100f46:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f4a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100f4e:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0100f52:	ee                   	out    %al,(%dx)
}
c0100f53:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;
c0100f54:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100f5b:	83 c0 01             	add    $0x1,%eax
c0100f5e:	0f b7 c0             	movzwl %ax,%eax
c0100f61:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f65:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
c0100f69:	89 c2                	mov    %eax,%edx
c0100f6b:	ec                   	in     (%dx),%al
c0100f6c:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
c0100f6f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100f73:	0f b6 c0             	movzbl %al,%eax
c0100f76:	c1 e0 08             	shl    $0x8,%eax
c0100f79:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
c0100f7c:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100f83:	0f b7 c0             	movzwl %ax,%eax
c0100f86:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0100f8a:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f8e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100f92:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100f96:	ee                   	out    %al,(%dx)
}
c0100f97:	90                   	nop
    pos |= inb(addr_6845 + 1);
c0100f98:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100f9f:	83 c0 01             	add    $0x1,%eax
c0100fa2:	0f b7 c0             	movzwl %ax,%eax
c0100fa5:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100fa9:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100fad:	89 c2                	mov    %eax,%edx
c0100faf:	ec                   	in     (%dx),%al
c0100fb0:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
c0100fb3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100fb7:	0f b6 c0             	movzbl %al,%eax
c0100fba:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
c0100fbd:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100fc0:	a3 40 c4 11 c0       	mov    %eax,0xc011c440
    crt_pos = pos;
c0100fc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100fc8:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
}
c0100fce:	90                   	nop
c0100fcf:	c9                   	leave  
c0100fd0:	c3                   	ret    

c0100fd1 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
c0100fd1:	f3 0f 1e fb          	endbr32 
c0100fd5:	55                   	push   %ebp
c0100fd6:	89 e5                	mov    %esp,%ebp
c0100fd8:	83 ec 38             	sub    $0x38,%esp
c0100fdb:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
c0100fe1:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100fe5:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0100fe9:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c0100fed:	ee                   	out    %al,(%dx)
}
c0100fee:	90                   	nop
c0100fef:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
c0100ff5:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100ff9:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c0100ffd:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c0101001:	ee                   	out    %al,(%dx)
}
c0101002:	90                   	nop
c0101003:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
c0101009:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010100d:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c0101011:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c0101015:	ee                   	out    %al,(%dx)
}
c0101016:	90                   	nop
c0101017:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
c010101d:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101021:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c0101025:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c0101029:	ee                   	out    %al,(%dx)
}
c010102a:	90                   	nop
c010102b:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
c0101031:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101035:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c0101039:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c010103d:	ee                   	out    %al,(%dx)
}
c010103e:	90                   	nop
c010103f:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
c0101045:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101049:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c010104d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101051:	ee                   	out    %al,(%dx)
}
c0101052:	90                   	nop
c0101053:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
c0101059:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010105d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0101061:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0101065:	ee                   	out    %al,(%dx)
}
c0101066:	90                   	nop
c0101067:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010106d:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
c0101071:	89 c2                	mov    %eax,%edx
c0101073:	ec                   	in     (%dx),%al
c0101074:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
c0101077:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
c010107b:	3c ff                	cmp    $0xff,%al
c010107d:	0f 95 c0             	setne  %al
c0101080:	0f b6 c0             	movzbl %al,%eax
c0101083:	a3 48 c4 11 c0       	mov    %eax,0xc011c448
c0101088:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010108e:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0101092:	89 c2                	mov    %eax,%edx
c0101094:	ec                   	in     (%dx),%al
c0101095:	88 45 f1             	mov    %al,-0xf(%ebp)
c0101098:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c010109e:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c01010a2:	89 c2                	mov    %eax,%edx
c01010a4:	ec                   	in     (%dx),%al
c01010a5:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
c01010a8:	a1 48 c4 11 c0       	mov    0xc011c448,%eax
c01010ad:	85 c0                	test   %eax,%eax
c01010af:	74 0d                	je     c01010be <serial_init+0xed>
        pic_enable(IRQ_COM1);
c01010b1:	83 ec 0c             	sub    $0xc,%esp
c01010b4:	6a 04                	push   $0x4
c01010b6:	e8 3e 07 00 00       	call   c01017f9 <pic_enable>
c01010bb:	83 c4 10             	add    $0x10,%esp
    }
}
c01010be:	90                   	nop
c01010bf:	c9                   	leave  
c01010c0:	c3                   	ret    

c01010c1 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
c01010c1:	f3 0f 1e fb          	endbr32 
c01010c5:	55                   	push   %ebp
c01010c6:	89 e5                	mov    %esp,%ebp
c01010c8:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c01010cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01010d2:	eb 09                	jmp    c01010dd <lpt_putc_sub+0x1c>
        delay();
c01010d4:	e8 be fd ff ff       	call   c0100e97 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c01010d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01010dd:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
c01010e3:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01010e7:	89 c2                	mov    %eax,%edx
c01010e9:	ec                   	in     (%dx),%al
c01010ea:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01010ed:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01010f1:	84 c0                	test   %al,%al
c01010f3:	78 09                	js     c01010fe <lpt_putc_sub+0x3d>
c01010f5:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c01010fc:	7e d6                	jle    c01010d4 <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
c01010fe:	8b 45 08             	mov    0x8(%ebp),%eax
c0101101:	0f b6 c0             	movzbl %al,%eax
c0101104:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
c010110a:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010110d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101111:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0101115:	ee                   	out    %al,(%dx)
}
c0101116:	90                   	nop
c0101117:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
c010111d:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101121:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101125:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101129:	ee                   	out    %al,(%dx)
}
c010112a:	90                   	nop
c010112b:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
c0101131:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101135:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0101139:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c010113d:	ee                   	out    %al,(%dx)
}
c010113e:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
c010113f:	90                   	nop
c0101140:	c9                   	leave  
c0101141:	c3                   	ret    

c0101142 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
c0101142:	f3 0f 1e fb          	endbr32 
c0101146:	55                   	push   %ebp
c0101147:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
c0101149:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c010114d:	74 0d                	je     c010115c <lpt_putc+0x1a>
        lpt_putc_sub(c);
c010114f:	ff 75 08             	pushl  0x8(%ebp)
c0101152:	e8 6a ff ff ff       	call   c01010c1 <lpt_putc_sub>
c0101157:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
c010115a:	eb 1e                	jmp    c010117a <lpt_putc+0x38>
        lpt_putc_sub('\b');
c010115c:	6a 08                	push   $0x8
c010115e:	e8 5e ff ff ff       	call   c01010c1 <lpt_putc_sub>
c0101163:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
c0101166:	6a 20                	push   $0x20
c0101168:	e8 54 ff ff ff       	call   c01010c1 <lpt_putc_sub>
c010116d:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
c0101170:	6a 08                	push   $0x8
c0101172:	e8 4a ff ff ff       	call   c01010c1 <lpt_putc_sub>
c0101177:	83 c4 04             	add    $0x4,%esp
}
c010117a:	90                   	nop
c010117b:	c9                   	leave  
c010117c:	c3                   	ret    

c010117d <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
c010117d:	f3 0f 1e fb          	endbr32 
c0101181:	55                   	push   %ebp
c0101182:	89 e5                	mov    %esp,%ebp
c0101184:	53                   	push   %ebx
c0101185:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
c0101188:	8b 45 08             	mov    0x8(%ebp),%eax
c010118b:	b0 00                	mov    $0x0,%al
c010118d:	85 c0                	test   %eax,%eax
c010118f:	75 07                	jne    c0101198 <cga_putc+0x1b>
        c |= 0x0700;
c0101191:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
c0101198:	8b 45 08             	mov    0x8(%ebp),%eax
c010119b:	0f b6 c0             	movzbl %al,%eax
c010119e:	83 f8 0d             	cmp    $0xd,%eax
c01011a1:	74 6c                	je     c010120f <cga_putc+0x92>
c01011a3:	83 f8 0d             	cmp    $0xd,%eax
c01011a6:	0f 8f 9d 00 00 00    	jg     c0101249 <cga_putc+0xcc>
c01011ac:	83 f8 08             	cmp    $0x8,%eax
c01011af:	74 0a                	je     c01011bb <cga_putc+0x3e>
c01011b1:	83 f8 0a             	cmp    $0xa,%eax
c01011b4:	74 49                	je     c01011ff <cga_putc+0x82>
c01011b6:	e9 8e 00 00 00       	jmp    c0101249 <cga_putc+0xcc>
    case '\b':
        if (crt_pos > 0) {
c01011bb:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01011c2:	66 85 c0             	test   %ax,%ax
c01011c5:	0f 84 a4 00 00 00    	je     c010126f <cga_putc+0xf2>
            crt_pos --;
c01011cb:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01011d2:	83 e8 01             	sub    $0x1,%eax
c01011d5:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
c01011db:	8b 45 08             	mov    0x8(%ebp),%eax
c01011de:	b0 00                	mov    $0x0,%al
c01011e0:	83 c8 20             	or     $0x20,%eax
c01011e3:	89 c1                	mov    %eax,%ecx
c01011e5:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c01011ea:	0f b7 15 44 c4 11 c0 	movzwl 0xc011c444,%edx
c01011f1:	0f b7 d2             	movzwl %dx,%edx
c01011f4:	01 d2                	add    %edx,%edx
c01011f6:	01 d0                	add    %edx,%eax
c01011f8:	89 ca                	mov    %ecx,%edx
c01011fa:	66 89 10             	mov    %dx,(%eax)
        }
        break;
c01011fd:	eb 70                	jmp    c010126f <cga_putc+0xf2>
    case '\n':
        crt_pos += CRT_COLS;
c01011ff:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101206:	83 c0 50             	add    $0x50,%eax
c0101209:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
c010120f:	0f b7 1d 44 c4 11 c0 	movzwl 0xc011c444,%ebx
c0101216:	0f b7 0d 44 c4 11 c0 	movzwl 0xc011c444,%ecx
c010121d:	0f b7 c1             	movzwl %cx,%eax
c0101220:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
c0101226:	c1 e8 10             	shr    $0x10,%eax
c0101229:	89 c2                	mov    %eax,%edx
c010122b:	66 c1 ea 06          	shr    $0x6,%dx
c010122f:	89 d0                	mov    %edx,%eax
c0101231:	c1 e0 02             	shl    $0x2,%eax
c0101234:	01 d0                	add    %edx,%eax
c0101236:	c1 e0 04             	shl    $0x4,%eax
c0101239:	29 c1                	sub    %eax,%ecx
c010123b:	89 ca                	mov    %ecx,%edx
c010123d:	89 d8                	mov    %ebx,%eax
c010123f:	29 d0                	sub    %edx,%eax
c0101241:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
        break;
c0101247:	eb 27                	jmp    c0101270 <cga_putc+0xf3>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
c0101249:	8b 0d 40 c4 11 c0    	mov    0xc011c440,%ecx
c010124f:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101256:	8d 50 01             	lea    0x1(%eax),%edx
c0101259:	66 89 15 44 c4 11 c0 	mov    %dx,0xc011c444
c0101260:	0f b7 c0             	movzwl %ax,%eax
c0101263:	01 c0                	add    %eax,%eax
c0101265:	01 c8                	add    %ecx,%eax
c0101267:	8b 55 08             	mov    0x8(%ebp),%edx
c010126a:	66 89 10             	mov    %dx,(%eax)
        break;
c010126d:	eb 01                	jmp    c0101270 <cga_putc+0xf3>
        break;
c010126f:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
c0101270:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101277:	66 3d cf 07          	cmp    $0x7cf,%ax
c010127b:	76 59                	jbe    c01012d6 <cga_putc+0x159>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
c010127d:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c0101282:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
c0101288:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c010128d:	83 ec 04             	sub    $0x4,%esp
c0101290:	68 00 0f 00 00       	push   $0xf00
c0101295:	52                   	push   %edx
c0101296:	50                   	push   %eax
c0101297:	e8 03 43 00 00       	call   c010559f <memmove>
c010129c:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c010129f:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
c01012a6:	eb 15                	jmp    c01012bd <cga_putc+0x140>
            crt_buf[i] = 0x0700 | ' ';
c01012a8:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c01012ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01012b0:	01 d2                	add    %edx,%edx
c01012b2:	01 d0                	add    %edx,%eax
c01012b4:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c01012b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c01012bd:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
c01012c4:	7e e2                	jle    c01012a8 <cga_putc+0x12b>
        }
        crt_pos -= CRT_COLS;
c01012c6:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01012cd:	83 e8 50             	sub    $0x50,%eax
c01012d0:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
    }

    // move that little blinky thing
    outb(addr_6845, 14);
c01012d6:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c01012dd:	0f b7 c0             	movzwl %ax,%eax
c01012e0:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c01012e4:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01012e8:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c01012ec:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c01012f0:	ee                   	out    %al,(%dx)
}
c01012f1:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
c01012f2:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01012f9:	66 c1 e8 08          	shr    $0x8,%ax
c01012fd:	0f b6 c0             	movzbl %al,%eax
c0101300:	0f b7 15 46 c4 11 c0 	movzwl 0xc011c446,%edx
c0101307:	83 c2 01             	add    $0x1,%edx
c010130a:	0f b7 d2             	movzwl %dx,%edx
c010130d:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
c0101311:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101314:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0101318:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c010131c:	ee                   	out    %al,(%dx)
}
c010131d:	90                   	nop
    outb(addr_6845, 15);
c010131e:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0101325:	0f b7 c0             	movzwl %ax,%eax
c0101328:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c010132c:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101330:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101334:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0101338:	ee                   	out    %al,(%dx)
}
c0101339:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
c010133a:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101341:	0f b6 c0             	movzbl %al,%eax
c0101344:	0f b7 15 46 c4 11 c0 	movzwl 0xc011c446,%edx
c010134b:	83 c2 01             	add    $0x1,%edx
c010134e:	0f b7 d2             	movzwl %dx,%edx
c0101351:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
c0101355:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101358:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c010135c:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101360:	ee                   	out    %al,(%dx)
}
c0101361:	90                   	nop
}
c0101362:	90                   	nop
c0101363:	8b 5d fc             	mov    -0x4(%ebp),%ebx
c0101366:	c9                   	leave  
c0101367:	c3                   	ret    

c0101368 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
c0101368:	f3 0f 1e fb          	endbr32 
c010136c:	55                   	push   %ebp
c010136d:	89 e5                	mov    %esp,%ebp
c010136f:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c0101372:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c0101379:	eb 09                	jmp    c0101384 <serial_putc_sub+0x1c>
        delay();
c010137b:	e8 17 fb ff ff       	call   c0100e97 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c0101380:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c0101384:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010138a:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c010138e:	89 c2                	mov    %eax,%edx
c0101390:	ec                   	in     (%dx),%al
c0101391:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c0101394:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101398:	0f b6 c0             	movzbl %al,%eax
c010139b:	83 e0 20             	and    $0x20,%eax
c010139e:	85 c0                	test   %eax,%eax
c01013a0:	75 09                	jne    c01013ab <serial_putc_sub+0x43>
c01013a2:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c01013a9:	7e d0                	jle    c010137b <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
c01013ab:	8b 45 08             	mov    0x8(%ebp),%eax
c01013ae:	0f b6 c0             	movzbl %al,%eax
c01013b1:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c01013b7:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01013ba:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c01013be:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c01013c2:	ee                   	out    %al,(%dx)
}
c01013c3:	90                   	nop
}
c01013c4:	90                   	nop
c01013c5:	c9                   	leave  
c01013c6:	c3                   	ret    

c01013c7 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
c01013c7:	f3 0f 1e fb          	endbr32 
c01013cb:	55                   	push   %ebp
c01013cc:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
c01013ce:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c01013d2:	74 0d                	je     c01013e1 <serial_putc+0x1a>
        serial_putc_sub(c);
c01013d4:	ff 75 08             	pushl  0x8(%ebp)
c01013d7:	e8 8c ff ff ff       	call   c0101368 <serial_putc_sub>
c01013dc:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
c01013df:	eb 1e                	jmp    c01013ff <serial_putc+0x38>
        serial_putc_sub('\b');
c01013e1:	6a 08                	push   $0x8
c01013e3:	e8 80 ff ff ff       	call   c0101368 <serial_putc_sub>
c01013e8:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
c01013eb:	6a 20                	push   $0x20
c01013ed:	e8 76 ff ff ff       	call   c0101368 <serial_putc_sub>
c01013f2:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
c01013f5:	6a 08                	push   $0x8
c01013f7:	e8 6c ff ff ff       	call   c0101368 <serial_putc_sub>
c01013fc:	83 c4 04             	add    $0x4,%esp
}
c01013ff:	90                   	nop
c0101400:	c9                   	leave  
c0101401:	c3                   	ret    

c0101402 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
c0101402:	f3 0f 1e fb          	endbr32 
c0101406:	55                   	push   %ebp
c0101407:	89 e5                	mov    %esp,%ebp
c0101409:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
c010140c:	eb 33                	jmp    c0101441 <cons_intr+0x3f>
        if (c != 0) {
c010140e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0101412:	74 2d                	je     c0101441 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
c0101414:	a1 64 c6 11 c0       	mov    0xc011c664,%eax
c0101419:	8d 50 01             	lea    0x1(%eax),%edx
c010141c:	89 15 64 c6 11 c0    	mov    %edx,0xc011c664
c0101422:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0101425:	88 90 60 c4 11 c0    	mov    %dl,-0x3fee3ba0(%eax)
            if (cons.wpos == CONSBUFSIZE) {
c010142b:	a1 64 c6 11 c0       	mov    0xc011c664,%eax
c0101430:	3d 00 02 00 00       	cmp    $0x200,%eax
c0101435:	75 0a                	jne    c0101441 <cons_intr+0x3f>
                cons.wpos = 0;
c0101437:	c7 05 64 c6 11 c0 00 	movl   $0x0,0xc011c664
c010143e:	00 00 00 
    while ((c = (*proc)()) != -1) {
c0101441:	8b 45 08             	mov    0x8(%ebp),%eax
c0101444:	ff d0                	call   *%eax
c0101446:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0101449:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
c010144d:	75 bf                	jne    c010140e <cons_intr+0xc>
            }
        }
    }
}
c010144f:	90                   	nop
c0101450:	90                   	nop
c0101451:	c9                   	leave  
c0101452:	c3                   	ret    

c0101453 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
c0101453:	f3 0f 1e fb          	endbr32 
c0101457:	55                   	push   %ebp
c0101458:	89 e5                	mov    %esp,%ebp
c010145a:	83 ec 10             	sub    $0x10,%esp
c010145d:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101463:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0101467:	89 c2                	mov    %eax,%edx
c0101469:	ec                   	in     (%dx),%al
c010146a:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c010146d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
c0101471:	0f b6 c0             	movzbl %al,%eax
c0101474:	83 e0 01             	and    $0x1,%eax
c0101477:	85 c0                	test   %eax,%eax
c0101479:	75 07                	jne    c0101482 <serial_proc_data+0x2f>
        return -1;
c010147b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0101480:	eb 2a                	jmp    c01014ac <serial_proc_data+0x59>
c0101482:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101488:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c010148c:	89 c2                	mov    %eax,%edx
c010148e:	ec                   	in     (%dx),%al
c010148f:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
c0101492:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
c0101496:	0f b6 c0             	movzbl %al,%eax
c0101499:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
c010149c:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
c01014a0:	75 07                	jne    c01014a9 <serial_proc_data+0x56>
        c = '\b';
c01014a2:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
c01014a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c01014ac:	c9                   	leave  
c01014ad:	c3                   	ret    

c01014ae <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
c01014ae:	f3 0f 1e fb          	endbr32 
c01014b2:	55                   	push   %ebp
c01014b3:	89 e5                	mov    %esp,%ebp
c01014b5:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
c01014b8:	a1 48 c4 11 c0       	mov    0xc011c448,%eax
c01014bd:	85 c0                	test   %eax,%eax
c01014bf:	74 10                	je     c01014d1 <serial_intr+0x23>
        cons_intr(serial_proc_data);
c01014c1:	83 ec 0c             	sub    $0xc,%esp
c01014c4:	68 53 14 10 c0       	push   $0xc0101453
c01014c9:	e8 34 ff ff ff       	call   c0101402 <cons_intr>
c01014ce:	83 c4 10             	add    $0x10,%esp
    }
}
c01014d1:	90                   	nop
c01014d2:	c9                   	leave  
c01014d3:	c3                   	ret    

c01014d4 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
c01014d4:	f3 0f 1e fb          	endbr32 
c01014d8:	55                   	push   %ebp
c01014d9:	89 e5                	mov    %esp,%ebp
c01014db:	83 ec 28             	sub    $0x28,%esp
c01014de:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01014e4:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01014e8:	89 c2                	mov    %eax,%edx
c01014ea:	ec                   	in     (%dx),%al
c01014eb:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
c01014ee:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
c01014f2:	0f b6 c0             	movzbl %al,%eax
c01014f5:	83 e0 01             	and    $0x1,%eax
c01014f8:	85 c0                	test   %eax,%eax
c01014fa:	75 0a                	jne    c0101506 <kbd_proc_data+0x32>
        return -1;
c01014fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0101501:	e9 5e 01 00 00       	jmp    c0101664 <kbd_proc_data+0x190>
c0101506:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010150c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c0101510:	89 c2                	mov    %eax,%edx
c0101512:	ec                   	in     (%dx),%al
c0101513:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
c0101516:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
c010151a:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
c010151d:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
c0101521:	75 17                	jne    c010153a <kbd_proc_data+0x66>
        // E0 escape character
        shift |= E0ESC;
c0101523:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101528:	83 c8 40             	or     $0x40,%eax
c010152b:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
        return 0;
c0101530:	b8 00 00 00 00       	mov    $0x0,%eax
c0101535:	e9 2a 01 00 00       	jmp    c0101664 <kbd_proc_data+0x190>
    } else if (data & 0x80) {
c010153a:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c010153e:	84 c0                	test   %al,%al
c0101540:	79 47                	jns    c0101589 <kbd_proc_data+0xb5>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
c0101542:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101547:	83 e0 40             	and    $0x40,%eax
c010154a:	85 c0                	test   %eax,%eax
c010154c:	75 09                	jne    c0101557 <kbd_proc_data+0x83>
c010154e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101552:	83 e0 7f             	and    $0x7f,%eax
c0101555:	eb 04                	jmp    c010155b <kbd_proc_data+0x87>
c0101557:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c010155b:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
c010155e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101562:	0f b6 80 40 90 11 c0 	movzbl -0x3fee6fc0(%eax),%eax
c0101569:	83 c8 40             	or     $0x40,%eax
c010156c:	0f b6 c0             	movzbl %al,%eax
c010156f:	f7 d0                	not    %eax
c0101571:	89 c2                	mov    %eax,%edx
c0101573:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101578:	21 d0                	and    %edx,%eax
c010157a:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
        return 0;
c010157f:	b8 00 00 00 00       	mov    $0x0,%eax
c0101584:	e9 db 00 00 00       	jmp    c0101664 <kbd_proc_data+0x190>
    } else if (shift & E0ESC) {
c0101589:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c010158e:	83 e0 40             	and    $0x40,%eax
c0101591:	85 c0                	test   %eax,%eax
c0101593:	74 11                	je     c01015a6 <kbd_proc_data+0xd2>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
c0101595:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
c0101599:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c010159e:	83 e0 bf             	and    $0xffffffbf,%eax
c01015a1:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
    }

    shift |= shiftcode[data];
c01015a6:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01015aa:	0f b6 80 40 90 11 c0 	movzbl -0x3fee6fc0(%eax),%eax
c01015b1:	0f b6 d0             	movzbl %al,%edx
c01015b4:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01015b9:	09 d0                	or     %edx,%eax
c01015bb:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
    shift ^= togglecode[data];
c01015c0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01015c4:	0f b6 80 40 91 11 c0 	movzbl -0x3fee6ec0(%eax),%eax
c01015cb:	0f b6 d0             	movzbl %al,%edx
c01015ce:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01015d3:	31 d0                	xor    %edx,%eax
c01015d5:	a3 68 c6 11 c0       	mov    %eax,0xc011c668

    c = charcode[shift & (CTL | SHIFT)][data];
c01015da:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01015df:	83 e0 03             	and    $0x3,%eax
c01015e2:	8b 14 85 40 95 11 c0 	mov    -0x3fee6ac0(,%eax,4),%edx
c01015e9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01015ed:	01 d0                	add    %edx,%eax
c01015ef:	0f b6 00             	movzbl (%eax),%eax
c01015f2:	0f b6 c0             	movzbl %al,%eax
c01015f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
c01015f8:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01015fd:	83 e0 08             	and    $0x8,%eax
c0101600:	85 c0                	test   %eax,%eax
c0101602:	74 22                	je     c0101626 <kbd_proc_data+0x152>
        if ('a' <= c && c <= 'z')
c0101604:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
c0101608:	7e 0c                	jle    c0101616 <kbd_proc_data+0x142>
c010160a:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
c010160e:	7f 06                	jg     c0101616 <kbd_proc_data+0x142>
            c += 'A' - 'a';
c0101610:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
c0101614:	eb 10                	jmp    c0101626 <kbd_proc_data+0x152>
        else if ('A' <= c && c <= 'Z')
c0101616:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
c010161a:	7e 0a                	jle    c0101626 <kbd_proc_data+0x152>
c010161c:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
c0101620:	7f 04                	jg     c0101626 <kbd_proc_data+0x152>
            c += 'a' - 'A';
c0101622:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
c0101626:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c010162b:	f7 d0                	not    %eax
c010162d:	83 e0 06             	and    $0x6,%eax
c0101630:	85 c0                	test   %eax,%eax
c0101632:	75 2d                	jne    c0101661 <kbd_proc_data+0x18d>
c0101634:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
c010163b:	75 24                	jne    c0101661 <kbd_proc_data+0x18d>
        cprintf("Rebooting!\n");
c010163d:	83 ec 0c             	sub    $0xc,%esp
c0101640:	68 4d 60 10 c0       	push   $0xc010604d
c0101645:	e8 5a ec ff ff       	call   c01002a4 <cprintf>
c010164a:	83 c4 10             	add    $0x10,%esp
c010164d:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
c0101653:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101657:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
c010165b:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
c010165f:	ee                   	out    %al,(%dx)
}
c0101660:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
c0101661:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0101664:	c9                   	leave  
c0101665:	c3                   	ret    

c0101666 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
c0101666:	f3 0f 1e fb          	endbr32 
c010166a:	55                   	push   %ebp
c010166b:	89 e5                	mov    %esp,%ebp
c010166d:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
c0101670:	83 ec 0c             	sub    $0xc,%esp
c0101673:	68 d4 14 10 c0       	push   $0xc01014d4
c0101678:	e8 85 fd ff ff       	call   c0101402 <cons_intr>
c010167d:	83 c4 10             	add    $0x10,%esp
}
c0101680:	90                   	nop
c0101681:	c9                   	leave  
c0101682:	c3                   	ret    

c0101683 <kbd_init>:

static void
kbd_init(void) {
c0101683:	f3 0f 1e fb          	endbr32 
c0101687:	55                   	push   %ebp
c0101688:	89 e5                	mov    %esp,%ebp
c010168a:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
c010168d:	e8 d4 ff ff ff       	call   c0101666 <kbd_intr>
    pic_enable(IRQ_KBD);
c0101692:	83 ec 0c             	sub    $0xc,%esp
c0101695:	6a 01                	push   $0x1
c0101697:	e8 5d 01 00 00       	call   c01017f9 <pic_enable>
c010169c:	83 c4 10             	add    $0x10,%esp
}
c010169f:	90                   	nop
c01016a0:	c9                   	leave  
c01016a1:	c3                   	ret    

c01016a2 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
c01016a2:	f3 0f 1e fb          	endbr32 
c01016a6:	55                   	push   %ebp
c01016a7:	89 e5                	mov    %esp,%ebp
c01016a9:	83 ec 08             	sub    $0x8,%esp
    cga_init();
c01016ac:	e8 33 f8 ff ff       	call   c0100ee4 <cga_init>
    serial_init();
c01016b1:	e8 1b f9 ff ff       	call   c0100fd1 <serial_init>
    kbd_init();
c01016b6:	e8 c8 ff ff ff       	call   c0101683 <kbd_init>
    if (!serial_exists) {
c01016bb:	a1 48 c4 11 c0       	mov    0xc011c448,%eax
c01016c0:	85 c0                	test   %eax,%eax
c01016c2:	75 10                	jne    c01016d4 <cons_init+0x32>
        cprintf("serial port does not exist!!\n");
c01016c4:	83 ec 0c             	sub    $0xc,%esp
c01016c7:	68 59 60 10 c0       	push   $0xc0106059
c01016cc:	e8 d3 eb ff ff       	call   c01002a4 <cprintf>
c01016d1:	83 c4 10             	add    $0x10,%esp
    }
}
c01016d4:	90                   	nop
c01016d5:	c9                   	leave  
c01016d6:	c3                   	ret    

c01016d7 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
c01016d7:	f3 0f 1e fb          	endbr32 
c01016db:	55                   	push   %ebp
c01016dc:	89 e5                	mov    %esp,%ebp
c01016de:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c01016e1:	e8 73 f7 ff ff       	call   c0100e59 <__intr_save>
c01016e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
c01016e9:	83 ec 0c             	sub    $0xc,%esp
c01016ec:	ff 75 08             	pushl  0x8(%ebp)
c01016ef:	e8 4e fa ff ff       	call   c0101142 <lpt_putc>
c01016f4:	83 c4 10             	add    $0x10,%esp
        cga_putc(c);
c01016f7:	83 ec 0c             	sub    $0xc,%esp
c01016fa:	ff 75 08             	pushl  0x8(%ebp)
c01016fd:	e8 7b fa ff ff       	call   c010117d <cga_putc>
c0101702:	83 c4 10             	add    $0x10,%esp
        serial_putc(c);
c0101705:	83 ec 0c             	sub    $0xc,%esp
c0101708:	ff 75 08             	pushl  0x8(%ebp)
c010170b:	e8 b7 fc ff ff       	call   c01013c7 <serial_putc>
c0101710:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
c0101713:	83 ec 0c             	sub    $0xc,%esp
c0101716:	ff 75 f4             	pushl  -0xc(%ebp)
c0101719:	e8 65 f7 ff ff       	call   c0100e83 <__intr_restore>
c010171e:	83 c4 10             	add    $0x10,%esp
}
c0101721:	90                   	nop
c0101722:	c9                   	leave  
c0101723:	c3                   	ret    

c0101724 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
c0101724:	f3 0f 1e fb          	endbr32 
c0101728:	55                   	push   %ebp
c0101729:	89 e5                	mov    %esp,%ebp
c010172b:	83 ec 18             	sub    $0x18,%esp
    int c = 0;
c010172e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0101735:	e8 1f f7 ff ff       	call   c0100e59 <__intr_save>
c010173a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
c010173d:	e8 6c fd ff ff       	call   c01014ae <serial_intr>
        kbd_intr();
c0101742:	e8 1f ff ff ff       	call   c0101666 <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
c0101747:	8b 15 60 c6 11 c0    	mov    0xc011c660,%edx
c010174d:	a1 64 c6 11 c0       	mov    0xc011c664,%eax
c0101752:	39 c2                	cmp    %eax,%edx
c0101754:	74 31                	je     c0101787 <cons_getc+0x63>
            c = cons.buf[cons.rpos ++];
c0101756:	a1 60 c6 11 c0       	mov    0xc011c660,%eax
c010175b:	8d 50 01             	lea    0x1(%eax),%edx
c010175e:	89 15 60 c6 11 c0    	mov    %edx,0xc011c660
c0101764:	0f b6 80 60 c4 11 c0 	movzbl -0x3fee3ba0(%eax),%eax
c010176b:	0f b6 c0             	movzbl %al,%eax
c010176e:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
c0101771:	a1 60 c6 11 c0       	mov    0xc011c660,%eax
c0101776:	3d 00 02 00 00       	cmp    $0x200,%eax
c010177b:	75 0a                	jne    c0101787 <cons_getc+0x63>
                cons.rpos = 0;
c010177d:	c7 05 60 c6 11 c0 00 	movl   $0x0,0xc011c660
c0101784:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
c0101787:	83 ec 0c             	sub    $0xc,%esp
c010178a:	ff 75 f0             	pushl  -0x10(%ebp)
c010178d:	e8 f1 f6 ff ff       	call   c0100e83 <__intr_restore>
c0101792:	83 c4 10             	add    $0x10,%esp
    return c;
c0101795:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0101798:	c9                   	leave  
c0101799:	c3                   	ret    

c010179a <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
c010179a:	f3 0f 1e fb          	endbr32 
c010179e:	55                   	push   %ebp
c010179f:	89 e5                	mov    %esp,%ebp
c01017a1:	83 ec 14             	sub    $0x14,%esp
c01017a4:	8b 45 08             	mov    0x8(%ebp),%eax
c01017a7:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
c01017ab:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01017af:	66 a3 50 95 11 c0    	mov    %ax,0xc0119550
    if (did_init) {
c01017b5:	a1 6c c6 11 c0       	mov    0xc011c66c,%eax
c01017ba:	85 c0                	test   %eax,%eax
c01017bc:	74 38                	je     c01017f6 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
c01017be:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01017c2:	0f b6 c0             	movzbl %al,%eax
c01017c5:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
c01017cb:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017ce:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c01017d2:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c01017d6:	ee                   	out    %al,(%dx)
}
c01017d7:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
c01017d8:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c01017dc:	66 c1 e8 08          	shr    $0x8,%ax
c01017e0:	0f b6 c0             	movzbl %al,%eax
c01017e3:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
c01017e9:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017ec:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c01017f0:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c01017f4:	ee                   	out    %al,(%dx)
}
c01017f5:	90                   	nop
    }
}
c01017f6:	90                   	nop
c01017f7:	c9                   	leave  
c01017f8:	c3                   	ret    

c01017f9 <pic_enable>:

void
pic_enable(unsigned int irq) {
c01017f9:	f3 0f 1e fb          	endbr32 
c01017fd:	55                   	push   %ebp
c01017fe:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
c0101800:	8b 45 08             	mov    0x8(%ebp),%eax
c0101803:	ba 01 00 00 00       	mov    $0x1,%edx
c0101808:	89 c1                	mov    %eax,%ecx
c010180a:	d3 e2                	shl    %cl,%edx
c010180c:	89 d0                	mov    %edx,%eax
c010180e:	f7 d0                	not    %eax
c0101810:	89 c2                	mov    %eax,%edx
c0101812:	0f b7 05 50 95 11 c0 	movzwl 0xc0119550,%eax
c0101819:	21 d0                	and    %edx,%eax
c010181b:	0f b7 c0             	movzwl %ax,%eax
c010181e:	50                   	push   %eax
c010181f:	e8 76 ff ff ff       	call   c010179a <pic_setmask>
c0101824:	83 c4 04             	add    $0x4,%esp
}
c0101827:	90                   	nop
c0101828:	c9                   	leave  
c0101829:	c3                   	ret    

c010182a <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
c010182a:	f3 0f 1e fb          	endbr32 
c010182e:	55                   	push   %ebp
c010182f:	89 e5                	mov    %esp,%ebp
c0101831:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
c0101834:	c7 05 6c c6 11 c0 01 	movl   $0x1,0xc011c66c
c010183b:	00 00 00 
c010183e:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
c0101844:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101848:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
c010184c:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
c0101850:	ee                   	out    %al,(%dx)
}
c0101851:	90                   	nop
c0101852:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
c0101858:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010185c:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
c0101860:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
c0101864:	ee                   	out    %al,(%dx)
}
c0101865:	90                   	nop
c0101866:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
c010186c:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101870:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0101874:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c0101878:	ee                   	out    %al,(%dx)
}
c0101879:	90                   	nop
c010187a:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
c0101880:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101884:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c0101888:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c010188c:	ee                   	out    %al,(%dx)
}
c010188d:	90                   	nop
c010188e:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
c0101894:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101898:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c010189c:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c01018a0:	ee                   	out    %al,(%dx)
}
c01018a1:	90                   	nop
c01018a2:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
c01018a8:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018ac:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c01018b0:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c01018b4:	ee                   	out    %al,(%dx)
}
c01018b5:	90                   	nop
c01018b6:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
c01018bc:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018c0:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c01018c4:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c01018c8:	ee                   	out    %al,(%dx)
}
c01018c9:	90                   	nop
c01018ca:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
c01018d0:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018d4:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c01018d8:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c01018dc:	ee                   	out    %al,(%dx)
}
c01018dd:	90                   	nop
c01018de:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
c01018e4:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018e8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c01018ec:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c01018f0:	ee                   	out    %al,(%dx)
}
c01018f1:	90                   	nop
c01018f2:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
c01018f8:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018fc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101900:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0101904:	ee                   	out    %al,(%dx)
}
c0101905:	90                   	nop
c0101906:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
c010190c:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101910:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101914:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101918:	ee                   	out    %al,(%dx)
}
c0101919:	90                   	nop
c010191a:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
c0101920:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101924:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0101928:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c010192c:	ee                   	out    %al,(%dx)
}
c010192d:	90                   	nop
c010192e:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
c0101934:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101938:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c010193c:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0101940:	ee                   	out    %al,(%dx)
}
c0101941:	90                   	nop
c0101942:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
c0101948:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010194c:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c0101950:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c0101954:	ee                   	out    %al,(%dx)
}
c0101955:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
c0101956:	0f b7 05 50 95 11 c0 	movzwl 0xc0119550,%eax
c010195d:	66 83 f8 ff          	cmp    $0xffff,%ax
c0101961:	74 13                	je     c0101976 <pic_init+0x14c>
        pic_setmask(irq_mask);
c0101963:	0f b7 05 50 95 11 c0 	movzwl 0xc0119550,%eax
c010196a:	0f b7 c0             	movzwl %ax,%eax
c010196d:	50                   	push   %eax
c010196e:	e8 27 fe ff ff       	call   c010179a <pic_setmask>
c0101973:	83 c4 04             	add    $0x4,%esp
    }
}
c0101976:	90                   	nop
c0101977:	c9                   	leave  
c0101978:	c3                   	ret    

c0101979 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
c0101979:	f3 0f 1e fb          	endbr32 
c010197d:	55                   	push   %ebp
c010197e:	89 e5                	mov    %esp,%ebp
    asm volatile ("sti");
c0101980:	fb                   	sti    
}
c0101981:	90                   	nop
    sti();
}
c0101982:	90                   	nop
c0101983:	5d                   	pop    %ebp
c0101984:	c3                   	ret    

c0101985 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
c0101985:	f3 0f 1e fb          	endbr32 
c0101989:	55                   	push   %ebp
c010198a:	89 e5                	mov    %esp,%ebp
    asm volatile ("cli" ::: "memory");
c010198c:	fa                   	cli    
}
c010198d:	90                   	nop
    cli();
}
c010198e:	90                   	nop
c010198f:	5d                   	pop    %ebp
c0101990:	c3                   	ret    

c0101991 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
c0101991:	f3 0f 1e fb          	endbr32 
c0101995:	55                   	push   %ebp
c0101996:	89 e5                	mov    %esp,%ebp
c0101998:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
c010199b:	83 ec 08             	sub    $0x8,%esp
c010199e:	6a 64                	push   $0x64
c01019a0:	68 80 60 10 c0       	push   $0xc0106080
c01019a5:	e8 fa e8 ff ff       	call   c01002a4 <cprintf>
c01019aa:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
c01019ad:	83 ec 0c             	sub    $0xc,%esp
c01019b0:	68 8a 60 10 c0       	push   $0xc010608a
c01019b5:	e8 ea e8 ff ff       	call   c01002a4 <cprintf>
c01019ba:	83 c4 10             	add    $0x10,%esp
    panic("EOT: kernel seems ok.");
c01019bd:	83 ec 04             	sub    $0x4,%esp
c01019c0:	68 98 60 10 c0       	push   $0xc0106098
c01019c5:	6a 12                	push   $0x12
c01019c7:	68 ae 60 10 c0       	push   $0xc01060ae
c01019cc:	e8 4e ea ff ff       	call   c010041f <__panic>

c01019d1 <idt_init>:
static struct pseudodesc idt_pd = {
    sizeof(idt) - 1, (uintptr_t)idt
};
/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
c01019d1:	f3 0f 1e fb          	endbr32 
c01019d5:	55                   	push   %ebp
c01019d6:	89 e5                	mov    %esp,%ebp
c01019d8:	83 ec 10             	sub    $0x10,%esp
    extern uintptr_t __vectors[]; //_vevtors数组保存在vectors.S中的256个中断处理例程的入口地址

    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
c01019db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01019e2:	e9 c8 00 00 00       	jmp    c0101aaf <idt_init+0xde>
        SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);
c01019e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019ea:	8b 04 85 e0 95 11 c0 	mov    -0x3fee6a20(,%eax,4),%eax
c01019f1:	89 c2                	mov    %eax,%edx
c01019f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019f6:	66 89 14 c5 80 c6 11 	mov    %dx,-0x3fee3980(,%eax,8)
c01019fd:	c0 
c01019fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a01:	66 c7 04 c5 82 c6 11 	movw   $0x8,-0x3fee397e(,%eax,8)
c0101a08:	c0 08 00 
c0101a0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a0e:	0f b6 14 c5 84 c6 11 	movzbl -0x3fee397c(,%eax,8),%edx
c0101a15:	c0 
c0101a16:	83 e2 e0             	and    $0xffffffe0,%edx
c0101a19:	88 14 c5 84 c6 11 c0 	mov    %dl,-0x3fee397c(,%eax,8)
c0101a20:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a23:	0f b6 14 c5 84 c6 11 	movzbl -0x3fee397c(,%eax,8),%edx
c0101a2a:	c0 
c0101a2b:	83 e2 1f             	and    $0x1f,%edx
c0101a2e:	88 14 c5 84 c6 11 c0 	mov    %dl,-0x3fee397c(,%eax,8)
c0101a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a38:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c0101a3f:	c0 
c0101a40:	83 e2 f0             	and    $0xfffffff0,%edx
c0101a43:	83 ca 0e             	or     $0xe,%edx
c0101a46:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c0101a4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a50:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c0101a57:	c0 
c0101a58:	83 e2 ef             	and    $0xffffffef,%edx
c0101a5b:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c0101a62:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a65:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c0101a6c:	c0 
c0101a6d:	83 e2 9f             	and    $0xffffff9f,%edx
c0101a70:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c0101a77:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a7a:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c0101a81:	c0 
c0101a82:	83 ca 80             	or     $0xffffff80,%edx
c0101a85:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c0101a8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a8f:	8b 04 85 e0 95 11 c0 	mov    -0x3fee6a20(,%eax,4),%eax
c0101a96:	c1 e8 10             	shr    $0x10,%eax
c0101a99:	89 c2                	mov    %eax,%edx
c0101a9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a9e:	66 89 14 c5 86 c6 11 	mov    %dx,-0x3fee397a(,%eax,8)
c0101aa5:	c0 
    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
c0101aa6:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101aa9:	83 c0 08             	add    $0x8,%eax
c0101aac:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0101aaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101ab2:	3d ff 07 00 00       	cmp    $0x7ff,%eax
c0101ab7:	0f 86 2a ff ff ff    	jbe    c01019e7 <idt_init+0x16>
 /*循环调用SETGATE函数对中断门idt[i]依次进行初始化
   其中第一个参数为初始化模板idt[i]；第二个参数为0，表示中断门；第三个参数GD_KTEXT为内核代码段的起始地址；第四个参数_vector[i]为中断处理例程的入口地址；第五个参数表示内核权限\*/
    SETGATE(idt[T_SWITCH_TOK],0,GD_KTEXT,__vectors[T_SWITCH_TOK],DPL_USER);
c0101abd:	a1 c4 97 11 c0       	mov    0xc01197c4,%eax
c0101ac2:	66 a3 48 ca 11 c0    	mov    %ax,0xc011ca48
c0101ac8:	66 c7 05 4a ca 11 c0 	movw   $0x8,0xc011ca4a
c0101acf:	08 00 
c0101ad1:	0f b6 05 4c ca 11 c0 	movzbl 0xc011ca4c,%eax
c0101ad8:	83 e0 e0             	and    $0xffffffe0,%eax
c0101adb:	a2 4c ca 11 c0       	mov    %al,0xc011ca4c
c0101ae0:	0f b6 05 4c ca 11 c0 	movzbl 0xc011ca4c,%eax
c0101ae7:	83 e0 1f             	and    $0x1f,%eax
c0101aea:	a2 4c ca 11 c0       	mov    %al,0xc011ca4c
c0101aef:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101af6:	83 e0 f0             	and    $0xfffffff0,%eax
c0101af9:	83 c8 0e             	or     $0xe,%eax
c0101afc:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101b01:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101b08:	83 e0 ef             	and    $0xffffffef,%eax
c0101b0b:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101b10:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101b17:	83 c8 60             	or     $0x60,%eax
c0101b1a:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101b1f:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101b26:	83 c8 80             	or     $0xffffff80,%eax
c0101b29:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101b2e:	a1 c4 97 11 c0       	mov    0xc01197c4,%eax
c0101b33:	c1 e8 10             	shr    $0x10,%eax
c0101b36:	66 a3 4e ca 11 c0    	mov    %ax,0xc011ca4e
c0101b3c:	c7 45 f8 60 95 11 c0 	movl   $0xc0119560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
c0101b43:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0101b46:	0f 01 18             	lidtl  (%eax)
}
c0101b49:	90                   	nop

    lidt(&idt_pd);
//加载idt中断描述符表，并将&idt_pd的首地址加载到IDTR中
}
c0101b4a:	90                   	nop
c0101b4b:	c9                   	leave  
c0101b4c:	c3                   	ret    

c0101b4d <trapname>:

static const char *
trapname(int trapno) {
c0101b4d:	f3 0f 1e fb          	endbr32 
c0101b51:	55                   	push   %ebp
c0101b52:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
c0101b54:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b57:	83 f8 13             	cmp    $0x13,%eax
c0101b5a:	77 0c                	ja     c0101b68 <trapname+0x1b>
        return excnames[trapno];
c0101b5c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b5f:	8b 04 85 00 64 10 c0 	mov    -0x3fef9c00(,%eax,4),%eax
c0101b66:	eb 18                	jmp    c0101b80 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
c0101b68:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
c0101b6c:	7e 0d                	jle    c0101b7b <trapname+0x2e>
c0101b6e:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
c0101b72:	7f 07                	jg     c0101b7b <trapname+0x2e>
        return "Hardware Interrupt";
c0101b74:	b8 bf 60 10 c0       	mov    $0xc01060bf,%eax
c0101b79:	eb 05                	jmp    c0101b80 <trapname+0x33>
    }
    return "(unknown trap)";
c0101b7b:	b8 d2 60 10 c0       	mov    $0xc01060d2,%eax
}
c0101b80:	5d                   	pop    %ebp
c0101b81:	c3                   	ret    

c0101b82 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
c0101b82:	f3 0f 1e fb          	endbr32 
c0101b86:	55                   	push   %ebp
c0101b87:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
c0101b89:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b8c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101b90:	66 83 f8 08          	cmp    $0x8,%ax
c0101b94:	0f 94 c0             	sete   %al
c0101b97:	0f b6 c0             	movzbl %al,%eax
}
c0101b9a:	5d                   	pop    %ebp
c0101b9b:	c3                   	ret    

c0101b9c <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
c0101b9c:	f3 0f 1e fb          	endbr32 
c0101ba0:	55                   	push   %ebp
c0101ba1:	89 e5                	mov    %esp,%ebp
c0101ba3:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
c0101ba6:	83 ec 08             	sub    $0x8,%esp
c0101ba9:	ff 75 08             	pushl  0x8(%ebp)
c0101bac:	68 13 61 10 c0       	push   $0xc0106113
c0101bb1:	e8 ee e6 ff ff       	call   c01002a4 <cprintf>
c0101bb6:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
c0101bb9:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bbc:	83 ec 0c             	sub    $0xc,%esp
c0101bbf:	50                   	push   %eax
c0101bc0:	e8 b4 01 00 00       	call   c0101d79 <print_regs>
c0101bc5:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
c0101bc8:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bcb:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
c0101bcf:	0f b7 c0             	movzwl %ax,%eax
c0101bd2:	83 ec 08             	sub    $0x8,%esp
c0101bd5:	50                   	push   %eax
c0101bd6:	68 24 61 10 c0       	push   $0xc0106124
c0101bdb:	e8 c4 e6 ff ff       	call   c01002a4 <cprintf>
c0101be0:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
c0101be3:	8b 45 08             	mov    0x8(%ebp),%eax
c0101be6:	0f b7 40 28          	movzwl 0x28(%eax),%eax
c0101bea:	0f b7 c0             	movzwl %ax,%eax
c0101bed:	83 ec 08             	sub    $0x8,%esp
c0101bf0:	50                   	push   %eax
c0101bf1:	68 37 61 10 c0       	push   $0xc0106137
c0101bf6:	e8 a9 e6 ff ff       	call   c01002a4 <cprintf>
c0101bfb:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
c0101bfe:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c01:	0f b7 40 24          	movzwl 0x24(%eax),%eax
c0101c05:	0f b7 c0             	movzwl %ax,%eax
c0101c08:	83 ec 08             	sub    $0x8,%esp
c0101c0b:	50                   	push   %eax
c0101c0c:	68 4a 61 10 c0       	push   $0xc010614a
c0101c11:	e8 8e e6 ff ff       	call   c01002a4 <cprintf>
c0101c16:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
c0101c19:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c1c:	0f b7 40 20          	movzwl 0x20(%eax),%eax
c0101c20:	0f b7 c0             	movzwl %ax,%eax
c0101c23:	83 ec 08             	sub    $0x8,%esp
c0101c26:	50                   	push   %eax
c0101c27:	68 5d 61 10 c0       	push   $0xc010615d
c0101c2c:	e8 73 e6 ff ff       	call   c01002a4 <cprintf>
c0101c31:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
c0101c34:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c37:	8b 40 30             	mov    0x30(%eax),%eax
c0101c3a:	83 ec 0c             	sub    $0xc,%esp
c0101c3d:	50                   	push   %eax
c0101c3e:	e8 0a ff ff ff       	call   c0101b4d <trapname>
c0101c43:	83 c4 10             	add    $0x10,%esp
c0101c46:	8b 55 08             	mov    0x8(%ebp),%edx
c0101c49:	8b 52 30             	mov    0x30(%edx),%edx
c0101c4c:	83 ec 04             	sub    $0x4,%esp
c0101c4f:	50                   	push   %eax
c0101c50:	52                   	push   %edx
c0101c51:	68 70 61 10 c0       	push   $0xc0106170
c0101c56:	e8 49 e6 ff ff       	call   c01002a4 <cprintf>
c0101c5b:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
c0101c5e:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c61:	8b 40 34             	mov    0x34(%eax),%eax
c0101c64:	83 ec 08             	sub    $0x8,%esp
c0101c67:	50                   	push   %eax
c0101c68:	68 82 61 10 c0       	push   $0xc0106182
c0101c6d:	e8 32 e6 ff ff       	call   c01002a4 <cprintf>
c0101c72:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
c0101c75:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c78:	8b 40 38             	mov    0x38(%eax),%eax
c0101c7b:	83 ec 08             	sub    $0x8,%esp
c0101c7e:	50                   	push   %eax
c0101c7f:	68 91 61 10 c0       	push   $0xc0106191
c0101c84:	e8 1b e6 ff ff       	call   c01002a4 <cprintf>
c0101c89:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
c0101c8c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c8f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101c93:	0f b7 c0             	movzwl %ax,%eax
c0101c96:	83 ec 08             	sub    $0x8,%esp
c0101c99:	50                   	push   %eax
c0101c9a:	68 a0 61 10 c0       	push   $0xc01061a0
c0101c9f:	e8 00 e6 ff ff       	call   c01002a4 <cprintf>
c0101ca4:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
c0101ca7:	8b 45 08             	mov    0x8(%ebp),%eax
c0101caa:	8b 40 40             	mov    0x40(%eax),%eax
c0101cad:	83 ec 08             	sub    $0x8,%esp
c0101cb0:	50                   	push   %eax
c0101cb1:	68 b3 61 10 c0       	push   $0xc01061b3
c0101cb6:	e8 e9 e5 ff ff       	call   c01002a4 <cprintf>
c0101cbb:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101cbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0101cc5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
c0101ccc:	eb 3f                	jmp    c0101d0d <print_trapframe+0x171>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
c0101cce:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cd1:	8b 50 40             	mov    0x40(%eax),%edx
c0101cd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0101cd7:	21 d0                	and    %edx,%eax
c0101cd9:	85 c0                	test   %eax,%eax
c0101cdb:	74 29                	je     c0101d06 <print_trapframe+0x16a>
c0101cdd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101ce0:	8b 04 85 80 95 11 c0 	mov    -0x3fee6a80(,%eax,4),%eax
c0101ce7:	85 c0                	test   %eax,%eax
c0101ce9:	74 1b                	je     c0101d06 <print_trapframe+0x16a>
            cprintf("%s,", IA32flags[i]);
c0101ceb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101cee:	8b 04 85 80 95 11 c0 	mov    -0x3fee6a80(,%eax,4),%eax
c0101cf5:	83 ec 08             	sub    $0x8,%esp
c0101cf8:	50                   	push   %eax
c0101cf9:	68 c2 61 10 c0       	push   $0xc01061c2
c0101cfe:	e8 a1 e5 ff ff       	call   c01002a4 <cprintf>
c0101d03:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101d06:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0101d0a:	d1 65 f0             	shll   -0x10(%ebp)
c0101d0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101d10:	83 f8 17             	cmp    $0x17,%eax
c0101d13:	76 b9                	jbe    c0101cce <print_trapframe+0x132>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
c0101d15:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d18:	8b 40 40             	mov    0x40(%eax),%eax
c0101d1b:	c1 e8 0c             	shr    $0xc,%eax
c0101d1e:	83 e0 03             	and    $0x3,%eax
c0101d21:	83 ec 08             	sub    $0x8,%esp
c0101d24:	50                   	push   %eax
c0101d25:	68 c6 61 10 c0       	push   $0xc01061c6
c0101d2a:	e8 75 e5 ff ff       	call   c01002a4 <cprintf>
c0101d2f:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
c0101d32:	83 ec 0c             	sub    $0xc,%esp
c0101d35:	ff 75 08             	pushl  0x8(%ebp)
c0101d38:	e8 45 fe ff ff       	call   c0101b82 <trap_in_kernel>
c0101d3d:	83 c4 10             	add    $0x10,%esp
c0101d40:	85 c0                	test   %eax,%eax
c0101d42:	75 32                	jne    c0101d76 <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
c0101d44:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d47:	8b 40 44             	mov    0x44(%eax),%eax
c0101d4a:	83 ec 08             	sub    $0x8,%esp
c0101d4d:	50                   	push   %eax
c0101d4e:	68 cf 61 10 c0       	push   $0xc01061cf
c0101d53:	e8 4c e5 ff ff       	call   c01002a4 <cprintf>
c0101d58:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
c0101d5b:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d5e:	0f b7 40 48          	movzwl 0x48(%eax),%eax
c0101d62:	0f b7 c0             	movzwl %ax,%eax
c0101d65:	83 ec 08             	sub    $0x8,%esp
c0101d68:	50                   	push   %eax
c0101d69:	68 de 61 10 c0       	push   $0xc01061de
c0101d6e:	e8 31 e5 ff ff       	call   c01002a4 <cprintf>
c0101d73:	83 c4 10             	add    $0x10,%esp
    }
}
c0101d76:	90                   	nop
c0101d77:	c9                   	leave  
c0101d78:	c3                   	ret    

c0101d79 <print_regs>:

void
print_regs(struct pushregs *regs) {
c0101d79:	f3 0f 1e fb          	endbr32 
c0101d7d:	55                   	push   %ebp
c0101d7e:	89 e5                	mov    %esp,%ebp
c0101d80:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
c0101d83:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d86:	8b 00                	mov    (%eax),%eax
c0101d88:	83 ec 08             	sub    $0x8,%esp
c0101d8b:	50                   	push   %eax
c0101d8c:	68 f1 61 10 c0       	push   $0xc01061f1
c0101d91:	e8 0e e5 ff ff       	call   c01002a4 <cprintf>
c0101d96:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
c0101d99:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d9c:	8b 40 04             	mov    0x4(%eax),%eax
c0101d9f:	83 ec 08             	sub    $0x8,%esp
c0101da2:	50                   	push   %eax
c0101da3:	68 00 62 10 c0       	push   $0xc0106200
c0101da8:	e8 f7 e4 ff ff       	call   c01002a4 <cprintf>
c0101dad:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
c0101db0:	8b 45 08             	mov    0x8(%ebp),%eax
c0101db3:	8b 40 08             	mov    0x8(%eax),%eax
c0101db6:	83 ec 08             	sub    $0x8,%esp
c0101db9:	50                   	push   %eax
c0101dba:	68 0f 62 10 c0       	push   $0xc010620f
c0101dbf:	e8 e0 e4 ff ff       	call   c01002a4 <cprintf>
c0101dc4:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
c0101dc7:	8b 45 08             	mov    0x8(%ebp),%eax
c0101dca:	8b 40 0c             	mov    0xc(%eax),%eax
c0101dcd:	83 ec 08             	sub    $0x8,%esp
c0101dd0:	50                   	push   %eax
c0101dd1:	68 1e 62 10 c0       	push   $0xc010621e
c0101dd6:	e8 c9 e4 ff ff       	call   c01002a4 <cprintf>
c0101ddb:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
c0101dde:	8b 45 08             	mov    0x8(%ebp),%eax
c0101de1:	8b 40 10             	mov    0x10(%eax),%eax
c0101de4:	83 ec 08             	sub    $0x8,%esp
c0101de7:	50                   	push   %eax
c0101de8:	68 2d 62 10 c0       	push   $0xc010622d
c0101ded:	e8 b2 e4 ff ff       	call   c01002a4 <cprintf>
c0101df2:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
c0101df5:	8b 45 08             	mov    0x8(%ebp),%eax
c0101df8:	8b 40 14             	mov    0x14(%eax),%eax
c0101dfb:	83 ec 08             	sub    $0x8,%esp
c0101dfe:	50                   	push   %eax
c0101dff:	68 3c 62 10 c0       	push   $0xc010623c
c0101e04:	e8 9b e4 ff ff       	call   c01002a4 <cprintf>
c0101e09:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
c0101e0c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e0f:	8b 40 18             	mov    0x18(%eax),%eax
c0101e12:	83 ec 08             	sub    $0x8,%esp
c0101e15:	50                   	push   %eax
c0101e16:	68 4b 62 10 c0       	push   $0xc010624b
c0101e1b:	e8 84 e4 ff ff       	call   c01002a4 <cprintf>
c0101e20:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
c0101e23:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e26:	8b 40 1c             	mov    0x1c(%eax),%eax
c0101e29:	83 ec 08             	sub    $0x8,%esp
c0101e2c:	50                   	push   %eax
c0101e2d:	68 5a 62 10 c0       	push   $0xc010625a
c0101e32:	e8 6d e4 ff ff       	call   c01002a4 <cprintf>
c0101e37:	83 c4 10             	add    $0x10,%esp
}
c0101e3a:	90                   	nop
c0101e3b:	c9                   	leave  
c0101e3c:	c3                   	ret    

c0101e3d <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
c0101e3d:	f3 0f 1e fb          	endbr32 
c0101e41:	55                   	push   %ebp
c0101e42:	89 e5                	mov    %esp,%ebp
c0101e44:	57                   	push   %edi
c0101e45:	56                   	push   %esi
c0101e46:	53                   	push   %ebx
c0101e47:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
    char c;

    switch (tf->tf_trapno) {
c0101e4d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e50:	8b 40 30             	mov    0x30(%eax),%eax
c0101e53:	83 f8 79             	cmp    $0x79,%eax
c0101e56:	0f 84 46 01 00 00    	je     c0101fa2 <trap_dispatch+0x165>
c0101e5c:	83 f8 79             	cmp    $0x79,%eax
c0101e5f:	0f 87 26 02 00 00    	ja     c010208b <trap_dispatch+0x24e>
c0101e65:	83 f8 78             	cmp    $0x78,%eax
c0101e68:	0f 84 ca 00 00 00    	je     c0101f38 <trap_dispatch+0xfb>
c0101e6e:	83 f8 78             	cmp    $0x78,%eax
c0101e71:	0f 87 14 02 00 00    	ja     c010208b <trap_dispatch+0x24e>
c0101e77:	83 f8 2f             	cmp    $0x2f,%eax
c0101e7a:	0f 87 0b 02 00 00    	ja     c010208b <trap_dispatch+0x24e>
c0101e80:	83 f8 2e             	cmp    $0x2e,%eax
c0101e83:	0f 83 38 02 00 00    	jae    c01020c1 <trap_dispatch+0x284>
c0101e89:	83 f8 24             	cmp    $0x24,%eax
c0101e8c:	74 5c                	je     c0101eea <trap_dispatch+0xad>
c0101e8e:	83 f8 24             	cmp    $0x24,%eax
c0101e91:	0f 87 f4 01 00 00    	ja     c010208b <trap_dispatch+0x24e>
c0101e97:	83 f8 20             	cmp    $0x20,%eax
c0101e9a:	74 0a                	je     c0101ea6 <trap_dispatch+0x69>
c0101e9c:	83 f8 21             	cmp    $0x21,%eax
c0101e9f:	74 70                	je     c0101f11 <trap_dispatch+0xd4>
c0101ea1:	e9 e5 01 00 00       	jmp    c010208b <trap_dispatch+0x24e>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
 ticks ++;
c0101ea6:	a1 0c cf 11 c0       	mov    0xc011cf0c,%eax
c0101eab:	83 c0 01             	add    $0x1,%eax
c0101eae:	a3 0c cf 11 c0       	mov    %eax,0xc011cf0c
        if (ticks % TICK_NUM == 0) {
c0101eb3:	8b 0d 0c cf 11 c0    	mov    0xc011cf0c,%ecx
c0101eb9:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
c0101ebe:	89 c8                	mov    %ecx,%eax
c0101ec0:	f7 e2                	mul    %edx
c0101ec2:	89 d0                	mov    %edx,%eax
c0101ec4:	c1 e8 05             	shr    $0x5,%eax
c0101ec7:	6b c0 64             	imul   $0x64,%eax,%eax
c0101eca:	29 c1                	sub    %eax,%ecx
c0101ecc:	89 c8                	mov    %ecx,%eax
c0101ece:	85 c0                	test   %eax,%eax
c0101ed0:	0f 85 ee 01 00 00    	jne    c01020c4 <trap_dispatch+0x287>
            print_ticks();
c0101ed6:	e8 b6 fa ff ff       	call   c0101991 <print_ticks>
ticks=0;
c0101edb:	c7 05 0c cf 11 c0 00 	movl   $0x0,0xc011cf0c
c0101ee2:	00 00 00 
        }
        break;
c0101ee5:	e9 da 01 00 00       	jmp    c01020c4 <trap_dispatch+0x287>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
c0101eea:	e8 35 f8 ff ff       	call   c0101724 <cons_getc>
c0101eef:	88 45 e3             	mov    %al,-0x1d(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
c0101ef2:	0f be 55 e3          	movsbl -0x1d(%ebp),%edx
c0101ef6:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
c0101efa:	83 ec 04             	sub    $0x4,%esp
c0101efd:	52                   	push   %edx
c0101efe:	50                   	push   %eax
c0101eff:	68 69 62 10 c0       	push   $0xc0106269
c0101f04:	e8 9b e3 ff ff       	call   c01002a4 <cprintf>
c0101f09:	83 c4 10             	add    $0x10,%esp
        break;
c0101f0c:	e9 ba 01 00 00       	jmp    c01020cb <trap_dispatch+0x28e>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
c0101f11:	e8 0e f8 ff ff       	call   c0101724 <cons_getc>
c0101f16:	88 45 e3             	mov    %al,-0x1d(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
c0101f19:	0f be 55 e3          	movsbl -0x1d(%ebp),%edx
c0101f1d:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
c0101f21:	83 ec 04             	sub    $0x4,%esp
c0101f24:	52                   	push   %edx
c0101f25:	50                   	push   %eax
c0101f26:	68 7b 62 10 c0       	push   $0xc010627b
c0101f2b:	e8 74 e3 ff ff       	call   c01002a4 <cprintf>
c0101f30:	83 c4 10             	add    $0x10,%esp
        break;
c0101f33:	e9 93 01 00 00       	jmp    c01020cb <trap_dispatch+0x28e>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) { //要保证自己再对应的模式中
c0101f38:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f3b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101f3f:	66 83 f8 1b          	cmp    $0x1b,%ax
c0101f43:	0f 84 7e 01 00 00    	je     c01020c7 <trap_dispatch+0x28a>
            struct trapframe trap_temp = *tf; //临时栈
c0101f49:	8b 55 08             	mov    0x8(%ebp),%edx
c0101f4c:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
c0101f52:	89 d3                	mov    %edx,%ebx
c0101f54:	ba 13 00 00 00       	mov    $0x13,%edx
c0101f59:	89 c7                	mov    %eax,%edi
c0101f5b:	89 de                	mov    %ebx,%esi
c0101f5d:	89 d1                	mov    %edx,%ecx
c0101f5f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            trap_temp.tf_cs=USER_CS;//更改代码段
c0101f61:	66 c7 45 a0 1b 00    	movw   $0x1b,-0x60(%ebp)
            trap_temp.tf_ds=trap_temp.tf_es=trap_temp.tf_ss=USER_DS;//更改数据段
c0101f67:	66 c7 45 ac 23 00    	movw   $0x23,-0x54(%ebp)
c0101f6d:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
c0101f71:	66 89 45 8c          	mov    %ax,-0x74(%ebp)
c0101f75:	0f b7 45 8c          	movzwl -0x74(%ebp),%eax
c0101f79:	66 89 45 90          	mov    %ax,-0x70(%ebp)
            trap_temp.tf_esp=(uint32_t)tf+sizeof(struct trapframe)-8;//更改ESP
c0101f7d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f80:	83 c0 44             	add    $0x44,%eax
c0101f83:	89 45 a8             	mov    %eax,-0x58(%ebp)
            trap_temp.tf_eflags|=FL_IOPL_MASK;//更改EFLAGS,不然在转换时会发生IO权限异常
c0101f86:	8b 45 a4             	mov    -0x5c(%ebp),%eax
c0101f89:	80 cc 30             	or     $0x30,%ah
c0101f8c:	89 45 a4             	mov    %eax,-0x5c(%ebp)
            *((uint32_t*)tf-1)=&trap_temp;//因为从内核栈切换到用户栈,所以修改栈顶地址
c0101f8f:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f92:	8d 50 fc             	lea    -0x4(%eax),%edx
c0101f95:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
c0101f9b:	89 02                	mov    %eax,(%edx)
        }
        break;
c0101f9d:	e9 25 01 00 00       	jmp    c01020c7 <trap_dispatch+0x28a>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
c0101fa2:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fa5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101fa9:	66 83 f8 08          	cmp    $0x8,%ax
c0101fad:	0f 84 17 01 00 00    	je     c01020ca <trap_dispatch+0x28d>
            tf->tf_cs = KERNEL_CS;
c0101fb3:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fb6:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
c0101fbc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fbf:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
c0101fc5:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fc8:	0f b7 50 28          	movzwl 0x28(%eax),%edx
c0101fcc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fcf:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
c0101fd3:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fd6:	8b 40 40             	mov    0x40(%eax),%eax
c0101fd9:	80 e4 cf             	and    $0xcf,%ah
c0101fdc:	89 c2                	mov    %eax,%edx
c0101fde:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fe1:	89 50 40             	mov    %edx,0x40(%eax)
            int offset = tf->tf_esp - (sizeof(struct trapframe)-8); //修改后少了esp和ss需要进行偏移
c0101fe4:	8b 45 08             	mov    0x8(%ebp),%eax
c0101fe7:	8b 40 44             	mov    0x44(%eax),%eax
c0101fea:	83 e8 44             	sub    $0x44,%eax
c0101fed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            __memmove(offset,tf,sizeof(struct trapframe)-8);
c0101ff0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0101ff3:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0101ff6:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ff9:	89 45 d8             	mov    %eax,-0x28(%ebp)
c0101ffc:	c7 45 d4 44 00 00 00 	movl   $0x44,-0x2c(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
c0102003:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0102006:	3b 45 d8             	cmp    -0x28(%ebp),%eax
c0102009:	73 3f                	jae    c010204a <trap_dispatch+0x20d>
c010200b:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010200e:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0102011:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0102014:	89 45 cc             	mov    %eax,-0x34(%ebp)
c0102017:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010201a:	89 45 c8             	mov    %eax,-0x38(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c010201d:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0102020:	c1 e8 02             	shr    $0x2,%eax
c0102023:	89 c1                	mov    %eax,%ecx
    asm volatile (
c0102025:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0102028:	8b 45 cc             	mov    -0x34(%ebp),%eax
c010202b:	89 d7                	mov    %edx,%edi
c010202d:	89 c6                	mov    %eax,%esi
c010202f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0102031:	8b 4d c8             	mov    -0x38(%ebp),%ecx
c0102034:	83 e1 03             	and    $0x3,%ecx
c0102037:	74 02                	je     c010203b <trap_dispatch+0x1fe>
c0102039:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c010203b:	89 f0                	mov    %esi,%eax
c010203d:	89 fa                	mov    %edi,%edx
c010203f:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
c0102042:	89 55 c0             	mov    %edx,-0x40(%ebp)
c0102045:	89 45 bc             	mov    %eax,-0x44(%ebp)
        return __memcpy(dst, src, n);
c0102048:	eb 34                	jmp    c010207e <trap_dispatch+0x241>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
c010204a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010204d:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102050:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0102053:	01 c2                	add    %eax,%edx
c0102055:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0102058:	8d 48 ff             	lea    -0x1(%eax),%ecx
c010205b:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010205e:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
c0102061:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0102064:	89 c1                	mov    %eax,%ecx
c0102066:	89 d8                	mov    %ebx,%eax
c0102068:	89 d6                	mov    %edx,%esi
c010206a:	89 c7                	mov    %eax,%edi
c010206c:	fd                   	std    
c010206d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c010206f:	fc                   	cld    
c0102070:	89 f8                	mov    %edi,%eax
c0102072:	89 f2                	mov    %esi,%edx
c0102074:	89 4d b8             	mov    %ecx,-0x48(%ebp)
c0102077:	89 55 b4             	mov    %edx,-0x4c(%ebp)
c010207a:	89 45 b0             	mov    %eax,-0x50(%ebp)
    return dst;
c010207d:	90                   	nop
            *((uint32_t*)tf-1)=offset; //重新设置栈帧地址
c010207e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102081:	8d 50 fc             	lea    -0x4(%eax),%edx
c0102084:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0102087:	89 02                	mov    %eax,(%edx)
        }
        break;
c0102089:	eb 3f                	jmp    c01020ca <trap_dispatch+0x28d>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
c010208b:	8b 45 08             	mov    0x8(%ebp),%eax
c010208e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0102092:	0f b7 c0             	movzwl %ax,%eax
c0102095:	83 e0 03             	and    $0x3,%eax
c0102098:	85 c0                	test   %eax,%eax
c010209a:	75 2f                	jne    c01020cb <trap_dispatch+0x28e>
            print_trapframe(tf);
c010209c:	83 ec 0c             	sub    $0xc,%esp
c010209f:	ff 75 08             	pushl  0x8(%ebp)
c01020a2:	e8 f5 fa ff ff       	call   c0101b9c <print_trapframe>
c01020a7:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
c01020aa:	83 ec 04             	sub    $0x4,%esp
c01020ad:	68 8a 62 10 c0       	push   $0xc010628a
c01020b2:	68 bf 00 00 00       	push   $0xbf
c01020b7:	68 ae 60 10 c0       	push   $0xc01060ae
c01020bc:	e8 5e e3 ff ff       	call   c010041f <__panic>
        break;
c01020c1:	90                   	nop
c01020c2:	eb 07                	jmp    c01020cb <trap_dispatch+0x28e>
        break;
c01020c4:	90                   	nop
c01020c5:	eb 04                	jmp    c01020cb <trap_dispatch+0x28e>
        break;
c01020c7:	90                   	nop
c01020c8:	eb 01                	jmp    c01020cb <trap_dispatch+0x28e>
        break;
c01020ca:	90                   	nop
        }
    }
}
c01020cb:	90                   	nop
c01020cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
c01020cf:	5b                   	pop    %ebx
c01020d0:	5e                   	pop    %esi
c01020d1:	5f                   	pop    %edi
c01020d2:	5d                   	pop    %ebp
c01020d3:	c3                   	ret    

c01020d4 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
c01020d4:	f3 0f 1e fb          	endbr32 
c01020d8:	55                   	push   %ebp
c01020d9:	89 e5                	mov    %esp,%ebp
c01020db:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
c01020de:	83 ec 0c             	sub    $0xc,%esp
c01020e1:	ff 75 08             	pushl  0x8(%ebp)
c01020e4:	e8 54 fd ff ff       	call   c0101e3d <trap_dispatch>
c01020e9:	83 c4 10             	add    $0x10,%esp
}
c01020ec:	90                   	nop
c01020ed:	c9                   	leave  
c01020ee:	c3                   	ret    

c01020ef <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
c01020ef:	6a 00                	push   $0x0
  pushl $0
c01020f1:	6a 00                	push   $0x0
  jmp __alltraps
c01020f3:	e9 67 0a 00 00       	jmp    c0102b5f <__alltraps>

c01020f8 <vector1>:
.globl vector1
vector1:
  pushl $0
c01020f8:	6a 00                	push   $0x0
  pushl $1
c01020fa:	6a 01                	push   $0x1
  jmp __alltraps
c01020fc:	e9 5e 0a 00 00       	jmp    c0102b5f <__alltraps>

c0102101 <vector2>:
.globl vector2
vector2:
  pushl $0
c0102101:	6a 00                	push   $0x0
  pushl $2
c0102103:	6a 02                	push   $0x2
  jmp __alltraps
c0102105:	e9 55 0a 00 00       	jmp    c0102b5f <__alltraps>

c010210a <vector3>:
.globl vector3
vector3:
  pushl $0
c010210a:	6a 00                	push   $0x0
  pushl $3
c010210c:	6a 03                	push   $0x3
  jmp __alltraps
c010210e:	e9 4c 0a 00 00       	jmp    c0102b5f <__alltraps>

c0102113 <vector4>:
.globl vector4
vector4:
  pushl $0
c0102113:	6a 00                	push   $0x0
  pushl $4
c0102115:	6a 04                	push   $0x4
  jmp __alltraps
c0102117:	e9 43 0a 00 00       	jmp    c0102b5f <__alltraps>

c010211c <vector5>:
.globl vector5
vector5:
  pushl $0
c010211c:	6a 00                	push   $0x0
  pushl $5
c010211e:	6a 05                	push   $0x5
  jmp __alltraps
c0102120:	e9 3a 0a 00 00       	jmp    c0102b5f <__alltraps>

c0102125 <vector6>:
.globl vector6
vector6:
  pushl $0
c0102125:	6a 00                	push   $0x0
  pushl $6
c0102127:	6a 06                	push   $0x6
  jmp __alltraps
c0102129:	e9 31 0a 00 00       	jmp    c0102b5f <__alltraps>

c010212e <vector7>:
.globl vector7
vector7:
  pushl $0
c010212e:	6a 00                	push   $0x0
  pushl $7
c0102130:	6a 07                	push   $0x7
  jmp __alltraps
c0102132:	e9 28 0a 00 00       	jmp    c0102b5f <__alltraps>

c0102137 <vector8>:
.globl vector8
vector8:
  pushl $8
c0102137:	6a 08                	push   $0x8
  jmp __alltraps
c0102139:	e9 21 0a 00 00       	jmp    c0102b5f <__alltraps>

c010213e <vector9>:
.globl vector9
vector9:
  pushl $9
c010213e:	6a 09                	push   $0x9
  jmp __alltraps
c0102140:	e9 1a 0a 00 00       	jmp    c0102b5f <__alltraps>

c0102145 <vector10>:
.globl vector10
vector10:
  pushl $10
c0102145:	6a 0a                	push   $0xa
  jmp __alltraps
c0102147:	e9 13 0a 00 00       	jmp    c0102b5f <__alltraps>

c010214c <vector11>:
.globl vector11
vector11:
  pushl $11
c010214c:	6a 0b                	push   $0xb
  jmp __alltraps
c010214e:	e9 0c 0a 00 00       	jmp    c0102b5f <__alltraps>

c0102153 <vector12>:
.globl vector12
vector12:
  pushl $12
c0102153:	6a 0c                	push   $0xc
  jmp __alltraps
c0102155:	e9 05 0a 00 00       	jmp    c0102b5f <__alltraps>

c010215a <vector13>:
.globl vector13
vector13:
  pushl $13
c010215a:	6a 0d                	push   $0xd
  jmp __alltraps
c010215c:	e9 fe 09 00 00       	jmp    c0102b5f <__alltraps>

c0102161 <vector14>:
.globl vector14
vector14:
  pushl $14
c0102161:	6a 0e                	push   $0xe
  jmp __alltraps
c0102163:	e9 f7 09 00 00       	jmp    c0102b5f <__alltraps>

c0102168 <vector15>:
.globl vector15
vector15:
  pushl $0
c0102168:	6a 00                	push   $0x0
  pushl $15
c010216a:	6a 0f                	push   $0xf
  jmp __alltraps
c010216c:	e9 ee 09 00 00       	jmp    c0102b5f <__alltraps>

c0102171 <vector16>:
.globl vector16
vector16:
  pushl $0
c0102171:	6a 00                	push   $0x0
  pushl $16
c0102173:	6a 10                	push   $0x10
  jmp __alltraps
c0102175:	e9 e5 09 00 00       	jmp    c0102b5f <__alltraps>

c010217a <vector17>:
.globl vector17
vector17:
  pushl $17
c010217a:	6a 11                	push   $0x11
  jmp __alltraps
c010217c:	e9 de 09 00 00       	jmp    c0102b5f <__alltraps>

c0102181 <vector18>:
.globl vector18
vector18:
  pushl $0
c0102181:	6a 00                	push   $0x0
  pushl $18
c0102183:	6a 12                	push   $0x12
  jmp __alltraps
c0102185:	e9 d5 09 00 00       	jmp    c0102b5f <__alltraps>

c010218a <vector19>:
.globl vector19
vector19:
  pushl $0
c010218a:	6a 00                	push   $0x0
  pushl $19
c010218c:	6a 13                	push   $0x13
  jmp __alltraps
c010218e:	e9 cc 09 00 00       	jmp    c0102b5f <__alltraps>

c0102193 <vector20>:
.globl vector20
vector20:
  pushl $0
c0102193:	6a 00                	push   $0x0
  pushl $20
c0102195:	6a 14                	push   $0x14
  jmp __alltraps
c0102197:	e9 c3 09 00 00       	jmp    c0102b5f <__alltraps>

c010219c <vector21>:
.globl vector21
vector21:
  pushl $0
c010219c:	6a 00                	push   $0x0
  pushl $21
c010219e:	6a 15                	push   $0x15
  jmp __alltraps
c01021a0:	e9 ba 09 00 00       	jmp    c0102b5f <__alltraps>

c01021a5 <vector22>:
.globl vector22
vector22:
  pushl $0
c01021a5:	6a 00                	push   $0x0
  pushl $22
c01021a7:	6a 16                	push   $0x16
  jmp __alltraps
c01021a9:	e9 b1 09 00 00       	jmp    c0102b5f <__alltraps>

c01021ae <vector23>:
.globl vector23
vector23:
  pushl $0
c01021ae:	6a 00                	push   $0x0
  pushl $23
c01021b0:	6a 17                	push   $0x17
  jmp __alltraps
c01021b2:	e9 a8 09 00 00       	jmp    c0102b5f <__alltraps>

c01021b7 <vector24>:
.globl vector24
vector24:
  pushl $0
c01021b7:	6a 00                	push   $0x0
  pushl $24
c01021b9:	6a 18                	push   $0x18
  jmp __alltraps
c01021bb:	e9 9f 09 00 00       	jmp    c0102b5f <__alltraps>

c01021c0 <vector25>:
.globl vector25
vector25:
  pushl $0
c01021c0:	6a 00                	push   $0x0
  pushl $25
c01021c2:	6a 19                	push   $0x19
  jmp __alltraps
c01021c4:	e9 96 09 00 00       	jmp    c0102b5f <__alltraps>

c01021c9 <vector26>:
.globl vector26
vector26:
  pushl $0
c01021c9:	6a 00                	push   $0x0
  pushl $26
c01021cb:	6a 1a                	push   $0x1a
  jmp __alltraps
c01021cd:	e9 8d 09 00 00       	jmp    c0102b5f <__alltraps>

c01021d2 <vector27>:
.globl vector27
vector27:
  pushl $0
c01021d2:	6a 00                	push   $0x0
  pushl $27
c01021d4:	6a 1b                	push   $0x1b
  jmp __alltraps
c01021d6:	e9 84 09 00 00       	jmp    c0102b5f <__alltraps>

c01021db <vector28>:
.globl vector28
vector28:
  pushl $0
c01021db:	6a 00                	push   $0x0
  pushl $28
c01021dd:	6a 1c                	push   $0x1c
  jmp __alltraps
c01021df:	e9 7b 09 00 00       	jmp    c0102b5f <__alltraps>

c01021e4 <vector29>:
.globl vector29
vector29:
  pushl $0
c01021e4:	6a 00                	push   $0x0
  pushl $29
c01021e6:	6a 1d                	push   $0x1d
  jmp __alltraps
c01021e8:	e9 72 09 00 00       	jmp    c0102b5f <__alltraps>

c01021ed <vector30>:
.globl vector30
vector30:
  pushl $0
c01021ed:	6a 00                	push   $0x0
  pushl $30
c01021ef:	6a 1e                	push   $0x1e
  jmp __alltraps
c01021f1:	e9 69 09 00 00       	jmp    c0102b5f <__alltraps>

c01021f6 <vector31>:
.globl vector31
vector31:
  pushl $0
c01021f6:	6a 00                	push   $0x0
  pushl $31
c01021f8:	6a 1f                	push   $0x1f
  jmp __alltraps
c01021fa:	e9 60 09 00 00       	jmp    c0102b5f <__alltraps>

c01021ff <vector32>:
.globl vector32
vector32:
  pushl $0
c01021ff:	6a 00                	push   $0x0
  pushl $32
c0102201:	6a 20                	push   $0x20
  jmp __alltraps
c0102203:	e9 57 09 00 00       	jmp    c0102b5f <__alltraps>

c0102208 <vector33>:
.globl vector33
vector33:
  pushl $0
c0102208:	6a 00                	push   $0x0
  pushl $33
c010220a:	6a 21                	push   $0x21
  jmp __alltraps
c010220c:	e9 4e 09 00 00       	jmp    c0102b5f <__alltraps>

c0102211 <vector34>:
.globl vector34
vector34:
  pushl $0
c0102211:	6a 00                	push   $0x0
  pushl $34
c0102213:	6a 22                	push   $0x22
  jmp __alltraps
c0102215:	e9 45 09 00 00       	jmp    c0102b5f <__alltraps>

c010221a <vector35>:
.globl vector35
vector35:
  pushl $0
c010221a:	6a 00                	push   $0x0
  pushl $35
c010221c:	6a 23                	push   $0x23
  jmp __alltraps
c010221e:	e9 3c 09 00 00       	jmp    c0102b5f <__alltraps>

c0102223 <vector36>:
.globl vector36
vector36:
  pushl $0
c0102223:	6a 00                	push   $0x0
  pushl $36
c0102225:	6a 24                	push   $0x24
  jmp __alltraps
c0102227:	e9 33 09 00 00       	jmp    c0102b5f <__alltraps>

c010222c <vector37>:
.globl vector37
vector37:
  pushl $0
c010222c:	6a 00                	push   $0x0
  pushl $37
c010222e:	6a 25                	push   $0x25
  jmp __alltraps
c0102230:	e9 2a 09 00 00       	jmp    c0102b5f <__alltraps>

c0102235 <vector38>:
.globl vector38
vector38:
  pushl $0
c0102235:	6a 00                	push   $0x0
  pushl $38
c0102237:	6a 26                	push   $0x26
  jmp __alltraps
c0102239:	e9 21 09 00 00       	jmp    c0102b5f <__alltraps>

c010223e <vector39>:
.globl vector39
vector39:
  pushl $0
c010223e:	6a 00                	push   $0x0
  pushl $39
c0102240:	6a 27                	push   $0x27
  jmp __alltraps
c0102242:	e9 18 09 00 00       	jmp    c0102b5f <__alltraps>

c0102247 <vector40>:
.globl vector40
vector40:
  pushl $0
c0102247:	6a 00                	push   $0x0
  pushl $40
c0102249:	6a 28                	push   $0x28
  jmp __alltraps
c010224b:	e9 0f 09 00 00       	jmp    c0102b5f <__alltraps>

c0102250 <vector41>:
.globl vector41
vector41:
  pushl $0
c0102250:	6a 00                	push   $0x0
  pushl $41
c0102252:	6a 29                	push   $0x29
  jmp __alltraps
c0102254:	e9 06 09 00 00       	jmp    c0102b5f <__alltraps>

c0102259 <vector42>:
.globl vector42
vector42:
  pushl $0
c0102259:	6a 00                	push   $0x0
  pushl $42
c010225b:	6a 2a                	push   $0x2a
  jmp __alltraps
c010225d:	e9 fd 08 00 00       	jmp    c0102b5f <__alltraps>

c0102262 <vector43>:
.globl vector43
vector43:
  pushl $0
c0102262:	6a 00                	push   $0x0
  pushl $43
c0102264:	6a 2b                	push   $0x2b
  jmp __alltraps
c0102266:	e9 f4 08 00 00       	jmp    c0102b5f <__alltraps>

c010226b <vector44>:
.globl vector44
vector44:
  pushl $0
c010226b:	6a 00                	push   $0x0
  pushl $44
c010226d:	6a 2c                	push   $0x2c
  jmp __alltraps
c010226f:	e9 eb 08 00 00       	jmp    c0102b5f <__alltraps>

c0102274 <vector45>:
.globl vector45
vector45:
  pushl $0
c0102274:	6a 00                	push   $0x0
  pushl $45
c0102276:	6a 2d                	push   $0x2d
  jmp __alltraps
c0102278:	e9 e2 08 00 00       	jmp    c0102b5f <__alltraps>

c010227d <vector46>:
.globl vector46
vector46:
  pushl $0
c010227d:	6a 00                	push   $0x0
  pushl $46
c010227f:	6a 2e                	push   $0x2e
  jmp __alltraps
c0102281:	e9 d9 08 00 00       	jmp    c0102b5f <__alltraps>

c0102286 <vector47>:
.globl vector47
vector47:
  pushl $0
c0102286:	6a 00                	push   $0x0
  pushl $47
c0102288:	6a 2f                	push   $0x2f
  jmp __alltraps
c010228a:	e9 d0 08 00 00       	jmp    c0102b5f <__alltraps>

c010228f <vector48>:
.globl vector48
vector48:
  pushl $0
c010228f:	6a 00                	push   $0x0
  pushl $48
c0102291:	6a 30                	push   $0x30
  jmp __alltraps
c0102293:	e9 c7 08 00 00       	jmp    c0102b5f <__alltraps>

c0102298 <vector49>:
.globl vector49
vector49:
  pushl $0
c0102298:	6a 00                	push   $0x0
  pushl $49
c010229a:	6a 31                	push   $0x31
  jmp __alltraps
c010229c:	e9 be 08 00 00       	jmp    c0102b5f <__alltraps>

c01022a1 <vector50>:
.globl vector50
vector50:
  pushl $0
c01022a1:	6a 00                	push   $0x0
  pushl $50
c01022a3:	6a 32                	push   $0x32
  jmp __alltraps
c01022a5:	e9 b5 08 00 00       	jmp    c0102b5f <__alltraps>

c01022aa <vector51>:
.globl vector51
vector51:
  pushl $0
c01022aa:	6a 00                	push   $0x0
  pushl $51
c01022ac:	6a 33                	push   $0x33
  jmp __alltraps
c01022ae:	e9 ac 08 00 00       	jmp    c0102b5f <__alltraps>

c01022b3 <vector52>:
.globl vector52
vector52:
  pushl $0
c01022b3:	6a 00                	push   $0x0
  pushl $52
c01022b5:	6a 34                	push   $0x34
  jmp __alltraps
c01022b7:	e9 a3 08 00 00       	jmp    c0102b5f <__alltraps>

c01022bc <vector53>:
.globl vector53
vector53:
  pushl $0
c01022bc:	6a 00                	push   $0x0
  pushl $53
c01022be:	6a 35                	push   $0x35
  jmp __alltraps
c01022c0:	e9 9a 08 00 00       	jmp    c0102b5f <__alltraps>

c01022c5 <vector54>:
.globl vector54
vector54:
  pushl $0
c01022c5:	6a 00                	push   $0x0
  pushl $54
c01022c7:	6a 36                	push   $0x36
  jmp __alltraps
c01022c9:	e9 91 08 00 00       	jmp    c0102b5f <__alltraps>

c01022ce <vector55>:
.globl vector55
vector55:
  pushl $0
c01022ce:	6a 00                	push   $0x0
  pushl $55
c01022d0:	6a 37                	push   $0x37
  jmp __alltraps
c01022d2:	e9 88 08 00 00       	jmp    c0102b5f <__alltraps>

c01022d7 <vector56>:
.globl vector56
vector56:
  pushl $0
c01022d7:	6a 00                	push   $0x0
  pushl $56
c01022d9:	6a 38                	push   $0x38
  jmp __alltraps
c01022db:	e9 7f 08 00 00       	jmp    c0102b5f <__alltraps>

c01022e0 <vector57>:
.globl vector57
vector57:
  pushl $0
c01022e0:	6a 00                	push   $0x0
  pushl $57
c01022e2:	6a 39                	push   $0x39
  jmp __alltraps
c01022e4:	e9 76 08 00 00       	jmp    c0102b5f <__alltraps>

c01022e9 <vector58>:
.globl vector58
vector58:
  pushl $0
c01022e9:	6a 00                	push   $0x0
  pushl $58
c01022eb:	6a 3a                	push   $0x3a
  jmp __alltraps
c01022ed:	e9 6d 08 00 00       	jmp    c0102b5f <__alltraps>

c01022f2 <vector59>:
.globl vector59
vector59:
  pushl $0
c01022f2:	6a 00                	push   $0x0
  pushl $59
c01022f4:	6a 3b                	push   $0x3b
  jmp __alltraps
c01022f6:	e9 64 08 00 00       	jmp    c0102b5f <__alltraps>

c01022fb <vector60>:
.globl vector60
vector60:
  pushl $0
c01022fb:	6a 00                	push   $0x0
  pushl $60
c01022fd:	6a 3c                	push   $0x3c
  jmp __alltraps
c01022ff:	e9 5b 08 00 00       	jmp    c0102b5f <__alltraps>

c0102304 <vector61>:
.globl vector61
vector61:
  pushl $0
c0102304:	6a 00                	push   $0x0
  pushl $61
c0102306:	6a 3d                	push   $0x3d
  jmp __alltraps
c0102308:	e9 52 08 00 00       	jmp    c0102b5f <__alltraps>

c010230d <vector62>:
.globl vector62
vector62:
  pushl $0
c010230d:	6a 00                	push   $0x0
  pushl $62
c010230f:	6a 3e                	push   $0x3e
  jmp __alltraps
c0102311:	e9 49 08 00 00       	jmp    c0102b5f <__alltraps>

c0102316 <vector63>:
.globl vector63
vector63:
  pushl $0
c0102316:	6a 00                	push   $0x0
  pushl $63
c0102318:	6a 3f                	push   $0x3f
  jmp __alltraps
c010231a:	e9 40 08 00 00       	jmp    c0102b5f <__alltraps>

c010231f <vector64>:
.globl vector64
vector64:
  pushl $0
c010231f:	6a 00                	push   $0x0
  pushl $64
c0102321:	6a 40                	push   $0x40
  jmp __alltraps
c0102323:	e9 37 08 00 00       	jmp    c0102b5f <__alltraps>

c0102328 <vector65>:
.globl vector65
vector65:
  pushl $0
c0102328:	6a 00                	push   $0x0
  pushl $65
c010232a:	6a 41                	push   $0x41
  jmp __alltraps
c010232c:	e9 2e 08 00 00       	jmp    c0102b5f <__alltraps>

c0102331 <vector66>:
.globl vector66
vector66:
  pushl $0
c0102331:	6a 00                	push   $0x0
  pushl $66
c0102333:	6a 42                	push   $0x42
  jmp __alltraps
c0102335:	e9 25 08 00 00       	jmp    c0102b5f <__alltraps>

c010233a <vector67>:
.globl vector67
vector67:
  pushl $0
c010233a:	6a 00                	push   $0x0
  pushl $67
c010233c:	6a 43                	push   $0x43
  jmp __alltraps
c010233e:	e9 1c 08 00 00       	jmp    c0102b5f <__alltraps>

c0102343 <vector68>:
.globl vector68
vector68:
  pushl $0
c0102343:	6a 00                	push   $0x0
  pushl $68
c0102345:	6a 44                	push   $0x44
  jmp __alltraps
c0102347:	e9 13 08 00 00       	jmp    c0102b5f <__alltraps>

c010234c <vector69>:
.globl vector69
vector69:
  pushl $0
c010234c:	6a 00                	push   $0x0
  pushl $69
c010234e:	6a 45                	push   $0x45
  jmp __alltraps
c0102350:	e9 0a 08 00 00       	jmp    c0102b5f <__alltraps>

c0102355 <vector70>:
.globl vector70
vector70:
  pushl $0
c0102355:	6a 00                	push   $0x0
  pushl $70
c0102357:	6a 46                	push   $0x46
  jmp __alltraps
c0102359:	e9 01 08 00 00       	jmp    c0102b5f <__alltraps>

c010235e <vector71>:
.globl vector71
vector71:
  pushl $0
c010235e:	6a 00                	push   $0x0
  pushl $71
c0102360:	6a 47                	push   $0x47
  jmp __alltraps
c0102362:	e9 f8 07 00 00       	jmp    c0102b5f <__alltraps>

c0102367 <vector72>:
.globl vector72
vector72:
  pushl $0
c0102367:	6a 00                	push   $0x0
  pushl $72
c0102369:	6a 48                	push   $0x48
  jmp __alltraps
c010236b:	e9 ef 07 00 00       	jmp    c0102b5f <__alltraps>

c0102370 <vector73>:
.globl vector73
vector73:
  pushl $0
c0102370:	6a 00                	push   $0x0
  pushl $73
c0102372:	6a 49                	push   $0x49
  jmp __alltraps
c0102374:	e9 e6 07 00 00       	jmp    c0102b5f <__alltraps>

c0102379 <vector74>:
.globl vector74
vector74:
  pushl $0
c0102379:	6a 00                	push   $0x0
  pushl $74
c010237b:	6a 4a                	push   $0x4a
  jmp __alltraps
c010237d:	e9 dd 07 00 00       	jmp    c0102b5f <__alltraps>

c0102382 <vector75>:
.globl vector75
vector75:
  pushl $0
c0102382:	6a 00                	push   $0x0
  pushl $75
c0102384:	6a 4b                	push   $0x4b
  jmp __alltraps
c0102386:	e9 d4 07 00 00       	jmp    c0102b5f <__alltraps>

c010238b <vector76>:
.globl vector76
vector76:
  pushl $0
c010238b:	6a 00                	push   $0x0
  pushl $76
c010238d:	6a 4c                	push   $0x4c
  jmp __alltraps
c010238f:	e9 cb 07 00 00       	jmp    c0102b5f <__alltraps>

c0102394 <vector77>:
.globl vector77
vector77:
  pushl $0
c0102394:	6a 00                	push   $0x0
  pushl $77
c0102396:	6a 4d                	push   $0x4d
  jmp __alltraps
c0102398:	e9 c2 07 00 00       	jmp    c0102b5f <__alltraps>

c010239d <vector78>:
.globl vector78
vector78:
  pushl $0
c010239d:	6a 00                	push   $0x0
  pushl $78
c010239f:	6a 4e                	push   $0x4e
  jmp __alltraps
c01023a1:	e9 b9 07 00 00       	jmp    c0102b5f <__alltraps>

c01023a6 <vector79>:
.globl vector79
vector79:
  pushl $0
c01023a6:	6a 00                	push   $0x0
  pushl $79
c01023a8:	6a 4f                	push   $0x4f
  jmp __alltraps
c01023aa:	e9 b0 07 00 00       	jmp    c0102b5f <__alltraps>

c01023af <vector80>:
.globl vector80
vector80:
  pushl $0
c01023af:	6a 00                	push   $0x0
  pushl $80
c01023b1:	6a 50                	push   $0x50
  jmp __alltraps
c01023b3:	e9 a7 07 00 00       	jmp    c0102b5f <__alltraps>

c01023b8 <vector81>:
.globl vector81
vector81:
  pushl $0
c01023b8:	6a 00                	push   $0x0
  pushl $81
c01023ba:	6a 51                	push   $0x51
  jmp __alltraps
c01023bc:	e9 9e 07 00 00       	jmp    c0102b5f <__alltraps>

c01023c1 <vector82>:
.globl vector82
vector82:
  pushl $0
c01023c1:	6a 00                	push   $0x0
  pushl $82
c01023c3:	6a 52                	push   $0x52
  jmp __alltraps
c01023c5:	e9 95 07 00 00       	jmp    c0102b5f <__alltraps>

c01023ca <vector83>:
.globl vector83
vector83:
  pushl $0
c01023ca:	6a 00                	push   $0x0
  pushl $83
c01023cc:	6a 53                	push   $0x53
  jmp __alltraps
c01023ce:	e9 8c 07 00 00       	jmp    c0102b5f <__alltraps>

c01023d3 <vector84>:
.globl vector84
vector84:
  pushl $0
c01023d3:	6a 00                	push   $0x0
  pushl $84
c01023d5:	6a 54                	push   $0x54
  jmp __alltraps
c01023d7:	e9 83 07 00 00       	jmp    c0102b5f <__alltraps>

c01023dc <vector85>:
.globl vector85
vector85:
  pushl $0
c01023dc:	6a 00                	push   $0x0
  pushl $85
c01023de:	6a 55                	push   $0x55
  jmp __alltraps
c01023e0:	e9 7a 07 00 00       	jmp    c0102b5f <__alltraps>

c01023e5 <vector86>:
.globl vector86
vector86:
  pushl $0
c01023e5:	6a 00                	push   $0x0
  pushl $86
c01023e7:	6a 56                	push   $0x56
  jmp __alltraps
c01023e9:	e9 71 07 00 00       	jmp    c0102b5f <__alltraps>

c01023ee <vector87>:
.globl vector87
vector87:
  pushl $0
c01023ee:	6a 00                	push   $0x0
  pushl $87
c01023f0:	6a 57                	push   $0x57
  jmp __alltraps
c01023f2:	e9 68 07 00 00       	jmp    c0102b5f <__alltraps>

c01023f7 <vector88>:
.globl vector88
vector88:
  pushl $0
c01023f7:	6a 00                	push   $0x0
  pushl $88
c01023f9:	6a 58                	push   $0x58
  jmp __alltraps
c01023fb:	e9 5f 07 00 00       	jmp    c0102b5f <__alltraps>

c0102400 <vector89>:
.globl vector89
vector89:
  pushl $0
c0102400:	6a 00                	push   $0x0
  pushl $89
c0102402:	6a 59                	push   $0x59
  jmp __alltraps
c0102404:	e9 56 07 00 00       	jmp    c0102b5f <__alltraps>

c0102409 <vector90>:
.globl vector90
vector90:
  pushl $0
c0102409:	6a 00                	push   $0x0
  pushl $90
c010240b:	6a 5a                	push   $0x5a
  jmp __alltraps
c010240d:	e9 4d 07 00 00       	jmp    c0102b5f <__alltraps>

c0102412 <vector91>:
.globl vector91
vector91:
  pushl $0
c0102412:	6a 00                	push   $0x0
  pushl $91
c0102414:	6a 5b                	push   $0x5b
  jmp __alltraps
c0102416:	e9 44 07 00 00       	jmp    c0102b5f <__alltraps>

c010241b <vector92>:
.globl vector92
vector92:
  pushl $0
c010241b:	6a 00                	push   $0x0
  pushl $92
c010241d:	6a 5c                	push   $0x5c
  jmp __alltraps
c010241f:	e9 3b 07 00 00       	jmp    c0102b5f <__alltraps>

c0102424 <vector93>:
.globl vector93
vector93:
  pushl $0
c0102424:	6a 00                	push   $0x0
  pushl $93
c0102426:	6a 5d                	push   $0x5d
  jmp __alltraps
c0102428:	e9 32 07 00 00       	jmp    c0102b5f <__alltraps>

c010242d <vector94>:
.globl vector94
vector94:
  pushl $0
c010242d:	6a 00                	push   $0x0
  pushl $94
c010242f:	6a 5e                	push   $0x5e
  jmp __alltraps
c0102431:	e9 29 07 00 00       	jmp    c0102b5f <__alltraps>

c0102436 <vector95>:
.globl vector95
vector95:
  pushl $0
c0102436:	6a 00                	push   $0x0
  pushl $95
c0102438:	6a 5f                	push   $0x5f
  jmp __alltraps
c010243a:	e9 20 07 00 00       	jmp    c0102b5f <__alltraps>

c010243f <vector96>:
.globl vector96
vector96:
  pushl $0
c010243f:	6a 00                	push   $0x0
  pushl $96
c0102441:	6a 60                	push   $0x60
  jmp __alltraps
c0102443:	e9 17 07 00 00       	jmp    c0102b5f <__alltraps>

c0102448 <vector97>:
.globl vector97
vector97:
  pushl $0
c0102448:	6a 00                	push   $0x0
  pushl $97
c010244a:	6a 61                	push   $0x61
  jmp __alltraps
c010244c:	e9 0e 07 00 00       	jmp    c0102b5f <__alltraps>

c0102451 <vector98>:
.globl vector98
vector98:
  pushl $0
c0102451:	6a 00                	push   $0x0
  pushl $98
c0102453:	6a 62                	push   $0x62
  jmp __alltraps
c0102455:	e9 05 07 00 00       	jmp    c0102b5f <__alltraps>

c010245a <vector99>:
.globl vector99
vector99:
  pushl $0
c010245a:	6a 00                	push   $0x0
  pushl $99
c010245c:	6a 63                	push   $0x63
  jmp __alltraps
c010245e:	e9 fc 06 00 00       	jmp    c0102b5f <__alltraps>

c0102463 <vector100>:
.globl vector100
vector100:
  pushl $0
c0102463:	6a 00                	push   $0x0
  pushl $100
c0102465:	6a 64                	push   $0x64
  jmp __alltraps
c0102467:	e9 f3 06 00 00       	jmp    c0102b5f <__alltraps>

c010246c <vector101>:
.globl vector101
vector101:
  pushl $0
c010246c:	6a 00                	push   $0x0
  pushl $101
c010246e:	6a 65                	push   $0x65
  jmp __alltraps
c0102470:	e9 ea 06 00 00       	jmp    c0102b5f <__alltraps>

c0102475 <vector102>:
.globl vector102
vector102:
  pushl $0
c0102475:	6a 00                	push   $0x0
  pushl $102
c0102477:	6a 66                	push   $0x66
  jmp __alltraps
c0102479:	e9 e1 06 00 00       	jmp    c0102b5f <__alltraps>

c010247e <vector103>:
.globl vector103
vector103:
  pushl $0
c010247e:	6a 00                	push   $0x0
  pushl $103
c0102480:	6a 67                	push   $0x67
  jmp __alltraps
c0102482:	e9 d8 06 00 00       	jmp    c0102b5f <__alltraps>

c0102487 <vector104>:
.globl vector104
vector104:
  pushl $0
c0102487:	6a 00                	push   $0x0
  pushl $104
c0102489:	6a 68                	push   $0x68
  jmp __alltraps
c010248b:	e9 cf 06 00 00       	jmp    c0102b5f <__alltraps>

c0102490 <vector105>:
.globl vector105
vector105:
  pushl $0
c0102490:	6a 00                	push   $0x0
  pushl $105
c0102492:	6a 69                	push   $0x69
  jmp __alltraps
c0102494:	e9 c6 06 00 00       	jmp    c0102b5f <__alltraps>

c0102499 <vector106>:
.globl vector106
vector106:
  pushl $0
c0102499:	6a 00                	push   $0x0
  pushl $106
c010249b:	6a 6a                	push   $0x6a
  jmp __alltraps
c010249d:	e9 bd 06 00 00       	jmp    c0102b5f <__alltraps>

c01024a2 <vector107>:
.globl vector107
vector107:
  pushl $0
c01024a2:	6a 00                	push   $0x0
  pushl $107
c01024a4:	6a 6b                	push   $0x6b
  jmp __alltraps
c01024a6:	e9 b4 06 00 00       	jmp    c0102b5f <__alltraps>

c01024ab <vector108>:
.globl vector108
vector108:
  pushl $0
c01024ab:	6a 00                	push   $0x0
  pushl $108
c01024ad:	6a 6c                	push   $0x6c
  jmp __alltraps
c01024af:	e9 ab 06 00 00       	jmp    c0102b5f <__alltraps>

c01024b4 <vector109>:
.globl vector109
vector109:
  pushl $0
c01024b4:	6a 00                	push   $0x0
  pushl $109
c01024b6:	6a 6d                	push   $0x6d
  jmp __alltraps
c01024b8:	e9 a2 06 00 00       	jmp    c0102b5f <__alltraps>

c01024bd <vector110>:
.globl vector110
vector110:
  pushl $0
c01024bd:	6a 00                	push   $0x0
  pushl $110
c01024bf:	6a 6e                	push   $0x6e
  jmp __alltraps
c01024c1:	e9 99 06 00 00       	jmp    c0102b5f <__alltraps>

c01024c6 <vector111>:
.globl vector111
vector111:
  pushl $0
c01024c6:	6a 00                	push   $0x0
  pushl $111
c01024c8:	6a 6f                	push   $0x6f
  jmp __alltraps
c01024ca:	e9 90 06 00 00       	jmp    c0102b5f <__alltraps>

c01024cf <vector112>:
.globl vector112
vector112:
  pushl $0
c01024cf:	6a 00                	push   $0x0
  pushl $112
c01024d1:	6a 70                	push   $0x70
  jmp __alltraps
c01024d3:	e9 87 06 00 00       	jmp    c0102b5f <__alltraps>

c01024d8 <vector113>:
.globl vector113
vector113:
  pushl $0
c01024d8:	6a 00                	push   $0x0
  pushl $113
c01024da:	6a 71                	push   $0x71
  jmp __alltraps
c01024dc:	e9 7e 06 00 00       	jmp    c0102b5f <__alltraps>

c01024e1 <vector114>:
.globl vector114
vector114:
  pushl $0
c01024e1:	6a 00                	push   $0x0
  pushl $114
c01024e3:	6a 72                	push   $0x72
  jmp __alltraps
c01024e5:	e9 75 06 00 00       	jmp    c0102b5f <__alltraps>

c01024ea <vector115>:
.globl vector115
vector115:
  pushl $0
c01024ea:	6a 00                	push   $0x0
  pushl $115
c01024ec:	6a 73                	push   $0x73
  jmp __alltraps
c01024ee:	e9 6c 06 00 00       	jmp    c0102b5f <__alltraps>

c01024f3 <vector116>:
.globl vector116
vector116:
  pushl $0
c01024f3:	6a 00                	push   $0x0
  pushl $116
c01024f5:	6a 74                	push   $0x74
  jmp __alltraps
c01024f7:	e9 63 06 00 00       	jmp    c0102b5f <__alltraps>

c01024fc <vector117>:
.globl vector117
vector117:
  pushl $0
c01024fc:	6a 00                	push   $0x0
  pushl $117
c01024fe:	6a 75                	push   $0x75
  jmp __alltraps
c0102500:	e9 5a 06 00 00       	jmp    c0102b5f <__alltraps>

c0102505 <vector118>:
.globl vector118
vector118:
  pushl $0
c0102505:	6a 00                	push   $0x0
  pushl $118
c0102507:	6a 76                	push   $0x76
  jmp __alltraps
c0102509:	e9 51 06 00 00       	jmp    c0102b5f <__alltraps>

c010250e <vector119>:
.globl vector119
vector119:
  pushl $0
c010250e:	6a 00                	push   $0x0
  pushl $119
c0102510:	6a 77                	push   $0x77
  jmp __alltraps
c0102512:	e9 48 06 00 00       	jmp    c0102b5f <__alltraps>

c0102517 <vector120>:
.globl vector120
vector120:
  pushl $0
c0102517:	6a 00                	push   $0x0
  pushl $120
c0102519:	6a 78                	push   $0x78
  jmp __alltraps
c010251b:	e9 3f 06 00 00       	jmp    c0102b5f <__alltraps>

c0102520 <vector121>:
.globl vector121
vector121:
  pushl $0
c0102520:	6a 00                	push   $0x0
  pushl $121
c0102522:	6a 79                	push   $0x79
  jmp __alltraps
c0102524:	e9 36 06 00 00       	jmp    c0102b5f <__alltraps>

c0102529 <vector122>:
.globl vector122
vector122:
  pushl $0
c0102529:	6a 00                	push   $0x0
  pushl $122
c010252b:	6a 7a                	push   $0x7a
  jmp __alltraps
c010252d:	e9 2d 06 00 00       	jmp    c0102b5f <__alltraps>

c0102532 <vector123>:
.globl vector123
vector123:
  pushl $0
c0102532:	6a 00                	push   $0x0
  pushl $123
c0102534:	6a 7b                	push   $0x7b
  jmp __alltraps
c0102536:	e9 24 06 00 00       	jmp    c0102b5f <__alltraps>

c010253b <vector124>:
.globl vector124
vector124:
  pushl $0
c010253b:	6a 00                	push   $0x0
  pushl $124
c010253d:	6a 7c                	push   $0x7c
  jmp __alltraps
c010253f:	e9 1b 06 00 00       	jmp    c0102b5f <__alltraps>

c0102544 <vector125>:
.globl vector125
vector125:
  pushl $0
c0102544:	6a 00                	push   $0x0
  pushl $125
c0102546:	6a 7d                	push   $0x7d
  jmp __alltraps
c0102548:	e9 12 06 00 00       	jmp    c0102b5f <__alltraps>

c010254d <vector126>:
.globl vector126
vector126:
  pushl $0
c010254d:	6a 00                	push   $0x0
  pushl $126
c010254f:	6a 7e                	push   $0x7e
  jmp __alltraps
c0102551:	e9 09 06 00 00       	jmp    c0102b5f <__alltraps>

c0102556 <vector127>:
.globl vector127
vector127:
  pushl $0
c0102556:	6a 00                	push   $0x0
  pushl $127
c0102558:	6a 7f                	push   $0x7f
  jmp __alltraps
c010255a:	e9 00 06 00 00       	jmp    c0102b5f <__alltraps>

c010255f <vector128>:
.globl vector128
vector128:
  pushl $0
c010255f:	6a 00                	push   $0x0
  pushl $128
c0102561:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
c0102566:	e9 f4 05 00 00       	jmp    c0102b5f <__alltraps>

c010256b <vector129>:
.globl vector129
vector129:
  pushl $0
c010256b:	6a 00                	push   $0x0
  pushl $129
c010256d:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
c0102572:	e9 e8 05 00 00       	jmp    c0102b5f <__alltraps>

c0102577 <vector130>:
.globl vector130
vector130:
  pushl $0
c0102577:	6a 00                	push   $0x0
  pushl $130
c0102579:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
c010257e:	e9 dc 05 00 00       	jmp    c0102b5f <__alltraps>

c0102583 <vector131>:
.globl vector131
vector131:
  pushl $0
c0102583:	6a 00                	push   $0x0
  pushl $131
c0102585:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
c010258a:	e9 d0 05 00 00       	jmp    c0102b5f <__alltraps>

c010258f <vector132>:
.globl vector132
vector132:
  pushl $0
c010258f:	6a 00                	push   $0x0
  pushl $132
c0102591:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
c0102596:	e9 c4 05 00 00       	jmp    c0102b5f <__alltraps>

c010259b <vector133>:
.globl vector133
vector133:
  pushl $0
c010259b:	6a 00                	push   $0x0
  pushl $133
c010259d:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
c01025a2:	e9 b8 05 00 00       	jmp    c0102b5f <__alltraps>

c01025a7 <vector134>:
.globl vector134
vector134:
  pushl $0
c01025a7:	6a 00                	push   $0x0
  pushl $134
c01025a9:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
c01025ae:	e9 ac 05 00 00       	jmp    c0102b5f <__alltraps>

c01025b3 <vector135>:
.globl vector135
vector135:
  pushl $0
c01025b3:	6a 00                	push   $0x0
  pushl $135
c01025b5:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
c01025ba:	e9 a0 05 00 00       	jmp    c0102b5f <__alltraps>

c01025bf <vector136>:
.globl vector136
vector136:
  pushl $0
c01025bf:	6a 00                	push   $0x0
  pushl $136
c01025c1:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
c01025c6:	e9 94 05 00 00       	jmp    c0102b5f <__alltraps>

c01025cb <vector137>:
.globl vector137
vector137:
  pushl $0
c01025cb:	6a 00                	push   $0x0
  pushl $137
c01025cd:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
c01025d2:	e9 88 05 00 00       	jmp    c0102b5f <__alltraps>

c01025d7 <vector138>:
.globl vector138
vector138:
  pushl $0
c01025d7:	6a 00                	push   $0x0
  pushl $138
c01025d9:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
c01025de:	e9 7c 05 00 00       	jmp    c0102b5f <__alltraps>

c01025e3 <vector139>:
.globl vector139
vector139:
  pushl $0
c01025e3:	6a 00                	push   $0x0
  pushl $139
c01025e5:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
c01025ea:	e9 70 05 00 00       	jmp    c0102b5f <__alltraps>

c01025ef <vector140>:
.globl vector140
vector140:
  pushl $0
c01025ef:	6a 00                	push   $0x0
  pushl $140
c01025f1:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
c01025f6:	e9 64 05 00 00       	jmp    c0102b5f <__alltraps>

c01025fb <vector141>:
.globl vector141
vector141:
  pushl $0
c01025fb:	6a 00                	push   $0x0
  pushl $141
c01025fd:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
c0102602:	e9 58 05 00 00       	jmp    c0102b5f <__alltraps>

c0102607 <vector142>:
.globl vector142
vector142:
  pushl $0
c0102607:	6a 00                	push   $0x0
  pushl $142
c0102609:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
c010260e:	e9 4c 05 00 00       	jmp    c0102b5f <__alltraps>

c0102613 <vector143>:
.globl vector143
vector143:
  pushl $0
c0102613:	6a 00                	push   $0x0
  pushl $143
c0102615:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
c010261a:	e9 40 05 00 00       	jmp    c0102b5f <__alltraps>

c010261f <vector144>:
.globl vector144
vector144:
  pushl $0
c010261f:	6a 00                	push   $0x0
  pushl $144
c0102621:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
c0102626:	e9 34 05 00 00       	jmp    c0102b5f <__alltraps>

c010262b <vector145>:
.globl vector145
vector145:
  pushl $0
c010262b:	6a 00                	push   $0x0
  pushl $145
c010262d:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
c0102632:	e9 28 05 00 00       	jmp    c0102b5f <__alltraps>

c0102637 <vector146>:
.globl vector146
vector146:
  pushl $0
c0102637:	6a 00                	push   $0x0
  pushl $146
c0102639:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
c010263e:	e9 1c 05 00 00       	jmp    c0102b5f <__alltraps>

c0102643 <vector147>:
.globl vector147
vector147:
  pushl $0
c0102643:	6a 00                	push   $0x0
  pushl $147
c0102645:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
c010264a:	e9 10 05 00 00       	jmp    c0102b5f <__alltraps>

c010264f <vector148>:
.globl vector148
vector148:
  pushl $0
c010264f:	6a 00                	push   $0x0
  pushl $148
c0102651:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
c0102656:	e9 04 05 00 00       	jmp    c0102b5f <__alltraps>

c010265b <vector149>:
.globl vector149
vector149:
  pushl $0
c010265b:	6a 00                	push   $0x0
  pushl $149
c010265d:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
c0102662:	e9 f8 04 00 00       	jmp    c0102b5f <__alltraps>

c0102667 <vector150>:
.globl vector150
vector150:
  pushl $0
c0102667:	6a 00                	push   $0x0
  pushl $150
c0102669:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
c010266e:	e9 ec 04 00 00       	jmp    c0102b5f <__alltraps>

c0102673 <vector151>:
.globl vector151
vector151:
  pushl $0
c0102673:	6a 00                	push   $0x0
  pushl $151
c0102675:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
c010267a:	e9 e0 04 00 00       	jmp    c0102b5f <__alltraps>

c010267f <vector152>:
.globl vector152
vector152:
  pushl $0
c010267f:	6a 00                	push   $0x0
  pushl $152
c0102681:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
c0102686:	e9 d4 04 00 00       	jmp    c0102b5f <__alltraps>

c010268b <vector153>:
.globl vector153
vector153:
  pushl $0
c010268b:	6a 00                	push   $0x0
  pushl $153
c010268d:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
c0102692:	e9 c8 04 00 00       	jmp    c0102b5f <__alltraps>

c0102697 <vector154>:
.globl vector154
vector154:
  pushl $0
c0102697:	6a 00                	push   $0x0
  pushl $154
c0102699:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
c010269e:	e9 bc 04 00 00       	jmp    c0102b5f <__alltraps>

c01026a3 <vector155>:
.globl vector155
vector155:
  pushl $0
c01026a3:	6a 00                	push   $0x0
  pushl $155
c01026a5:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
c01026aa:	e9 b0 04 00 00       	jmp    c0102b5f <__alltraps>

c01026af <vector156>:
.globl vector156
vector156:
  pushl $0
c01026af:	6a 00                	push   $0x0
  pushl $156
c01026b1:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
c01026b6:	e9 a4 04 00 00       	jmp    c0102b5f <__alltraps>

c01026bb <vector157>:
.globl vector157
vector157:
  pushl $0
c01026bb:	6a 00                	push   $0x0
  pushl $157
c01026bd:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
c01026c2:	e9 98 04 00 00       	jmp    c0102b5f <__alltraps>

c01026c7 <vector158>:
.globl vector158
vector158:
  pushl $0
c01026c7:	6a 00                	push   $0x0
  pushl $158
c01026c9:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
c01026ce:	e9 8c 04 00 00       	jmp    c0102b5f <__alltraps>

c01026d3 <vector159>:
.globl vector159
vector159:
  pushl $0
c01026d3:	6a 00                	push   $0x0
  pushl $159
c01026d5:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
c01026da:	e9 80 04 00 00       	jmp    c0102b5f <__alltraps>

c01026df <vector160>:
.globl vector160
vector160:
  pushl $0
c01026df:	6a 00                	push   $0x0
  pushl $160
c01026e1:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
c01026e6:	e9 74 04 00 00       	jmp    c0102b5f <__alltraps>

c01026eb <vector161>:
.globl vector161
vector161:
  pushl $0
c01026eb:	6a 00                	push   $0x0
  pushl $161
c01026ed:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
c01026f2:	e9 68 04 00 00       	jmp    c0102b5f <__alltraps>

c01026f7 <vector162>:
.globl vector162
vector162:
  pushl $0
c01026f7:	6a 00                	push   $0x0
  pushl $162
c01026f9:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
c01026fe:	e9 5c 04 00 00       	jmp    c0102b5f <__alltraps>

c0102703 <vector163>:
.globl vector163
vector163:
  pushl $0
c0102703:	6a 00                	push   $0x0
  pushl $163
c0102705:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
c010270a:	e9 50 04 00 00       	jmp    c0102b5f <__alltraps>

c010270f <vector164>:
.globl vector164
vector164:
  pushl $0
c010270f:	6a 00                	push   $0x0
  pushl $164
c0102711:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
c0102716:	e9 44 04 00 00       	jmp    c0102b5f <__alltraps>

c010271b <vector165>:
.globl vector165
vector165:
  pushl $0
c010271b:	6a 00                	push   $0x0
  pushl $165
c010271d:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
c0102722:	e9 38 04 00 00       	jmp    c0102b5f <__alltraps>

c0102727 <vector166>:
.globl vector166
vector166:
  pushl $0
c0102727:	6a 00                	push   $0x0
  pushl $166
c0102729:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
c010272e:	e9 2c 04 00 00       	jmp    c0102b5f <__alltraps>

c0102733 <vector167>:
.globl vector167
vector167:
  pushl $0
c0102733:	6a 00                	push   $0x0
  pushl $167
c0102735:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
c010273a:	e9 20 04 00 00       	jmp    c0102b5f <__alltraps>

c010273f <vector168>:
.globl vector168
vector168:
  pushl $0
c010273f:	6a 00                	push   $0x0
  pushl $168
c0102741:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
c0102746:	e9 14 04 00 00       	jmp    c0102b5f <__alltraps>

c010274b <vector169>:
.globl vector169
vector169:
  pushl $0
c010274b:	6a 00                	push   $0x0
  pushl $169
c010274d:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
c0102752:	e9 08 04 00 00       	jmp    c0102b5f <__alltraps>

c0102757 <vector170>:
.globl vector170
vector170:
  pushl $0
c0102757:	6a 00                	push   $0x0
  pushl $170
c0102759:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
c010275e:	e9 fc 03 00 00       	jmp    c0102b5f <__alltraps>

c0102763 <vector171>:
.globl vector171
vector171:
  pushl $0
c0102763:	6a 00                	push   $0x0
  pushl $171
c0102765:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
c010276a:	e9 f0 03 00 00       	jmp    c0102b5f <__alltraps>

c010276f <vector172>:
.globl vector172
vector172:
  pushl $0
c010276f:	6a 00                	push   $0x0
  pushl $172
c0102771:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
c0102776:	e9 e4 03 00 00       	jmp    c0102b5f <__alltraps>

c010277b <vector173>:
.globl vector173
vector173:
  pushl $0
c010277b:	6a 00                	push   $0x0
  pushl $173
c010277d:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
c0102782:	e9 d8 03 00 00       	jmp    c0102b5f <__alltraps>

c0102787 <vector174>:
.globl vector174
vector174:
  pushl $0
c0102787:	6a 00                	push   $0x0
  pushl $174
c0102789:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
c010278e:	e9 cc 03 00 00       	jmp    c0102b5f <__alltraps>

c0102793 <vector175>:
.globl vector175
vector175:
  pushl $0
c0102793:	6a 00                	push   $0x0
  pushl $175
c0102795:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
c010279a:	e9 c0 03 00 00       	jmp    c0102b5f <__alltraps>

c010279f <vector176>:
.globl vector176
vector176:
  pushl $0
c010279f:	6a 00                	push   $0x0
  pushl $176
c01027a1:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
c01027a6:	e9 b4 03 00 00       	jmp    c0102b5f <__alltraps>

c01027ab <vector177>:
.globl vector177
vector177:
  pushl $0
c01027ab:	6a 00                	push   $0x0
  pushl $177
c01027ad:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
c01027b2:	e9 a8 03 00 00       	jmp    c0102b5f <__alltraps>

c01027b7 <vector178>:
.globl vector178
vector178:
  pushl $0
c01027b7:	6a 00                	push   $0x0
  pushl $178
c01027b9:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
c01027be:	e9 9c 03 00 00       	jmp    c0102b5f <__alltraps>

c01027c3 <vector179>:
.globl vector179
vector179:
  pushl $0
c01027c3:	6a 00                	push   $0x0
  pushl $179
c01027c5:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
c01027ca:	e9 90 03 00 00       	jmp    c0102b5f <__alltraps>

c01027cf <vector180>:
.globl vector180
vector180:
  pushl $0
c01027cf:	6a 00                	push   $0x0
  pushl $180
c01027d1:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
c01027d6:	e9 84 03 00 00       	jmp    c0102b5f <__alltraps>

c01027db <vector181>:
.globl vector181
vector181:
  pushl $0
c01027db:	6a 00                	push   $0x0
  pushl $181
c01027dd:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
c01027e2:	e9 78 03 00 00       	jmp    c0102b5f <__alltraps>

c01027e7 <vector182>:
.globl vector182
vector182:
  pushl $0
c01027e7:	6a 00                	push   $0x0
  pushl $182
c01027e9:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
c01027ee:	e9 6c 03 00 00       	jmp    c0102b5f <__alltraps>

c01027f3 <vector183>:
.globl vector183
vector183:
  pushl $0
c01027f3:	6a 00                	push   $0x0
  pushl $183
c01027f5:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
c01027fa:	e9 60 03 00 00       	jmp    c0102b5f <__alltraps>

c01027ff <vector184>:
.globl vector184
vector184:
  pushl $0
c01027ff:	6a 00                	push   $0x0
  pushl $184
c0102801:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
c0102806:	e9 54 03 00 00       	jmp    c0102b5f <__alltraps>

c010280b <vector185>:
.globl vector185
vector185:
  pushl $0
c010280b:	6a 00                	push   $0x0
  pushl $185
c010280d:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
c0102812:	e9 48 03 00 00       	jmp    c0102b5f <__alltraps>

c0102817 <vector186>:
.globl vector186
vector186:
  pushl $0
c0102817:	6a 00                	push   $0x0
  pushl $186
c0102819:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
c010281e:	e9 3c 03 00 00       	jmp    c0102b5f <__alltraps>

c0102823 <vector187>:
.globl vector187
vector187:
  pushl $0
c0102823:	6a 00                	push   $0x0
  pushl $187
c0102825:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
c010282a:	e9 30 03 00 00       	jmp    c0102b5f <__alltraps>

c010282f <vector188>:
.globl vector188
vector188:
  pushl $0
c010282f:	6a 00                	push   $0x0
  pushl $188
c0102831:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
c0102836:	e9 24 03 00 00       	jmp    c0102b5f <__alltraps>

c010283b <vector189>:
.globl vector189
vector189:
  pushl $0
c010283b:	6a 00                	push   $0x0
  pushl $189
c010283d:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
c0102842:	e9 18 03 00 00       	jmp    c0102b5f <__alltraps>

c0102847 <vector190>:
.globl vector190
vector190:
  pushl $0
c0102847:	6a 00                	push   $0x0
  pushl $190
c0102849:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
c010284e:	e9 0c 03 00 00       	jmp    c0102b5f <__alltraps>

c0102853 <vector191>:
.globl vector191
vector191:
  pushl $0
c0102853:	6a 00                	push   $0x0
  pushl $191
c0102855:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
c010285a:	e9 00 03 00 00       	jmp    c0102b5f <__alltraps>

c010285f <vector192>:
.globl vector192
vector192:
  pushl $0
c010285f:	6a 00                	push   $0x0
  pushl $192
c0102861:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
c0102866:	e9 f4 02 00 00       	jmp    c0102b5f <__alltraps>

c010286b <vector193>:
.globl vector193
vector193:
  pushl $0
c010286b:	6a 00                	push   $0x0
  pushl $193
c010286d:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
c0102872:	e9 e8 02 00 00       	jmp    c0102b5f <__alltraps>

c0102877 <vector194>:
.globl vector194
vector194:
  pushl $0
c0102877:	6a 00                	push   $0x0
  pushl $194
c0102879:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
c010287e:	e9 dc 02 00 00       	jmp    c0102b5f <__alltraps>

c0102883 <vector195>:
.globl vector195
vector195:
  pushl $0
c0102883:	6a 00                	push   $0x0
  pushl $195
c0102885:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
c010288a:	e9 d0 02 00 00       	jmp    c0102b5f <__alltraps>

c010288f <vector196>:
.globl vector196
vector196:
  pushl $0
c010288f:	6a 00                	push   $0x0
  pushl $196
c0102891:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
c0102896:	e9 c4 02 00 00       	jmp    c0102b5f <__alltraps>

c010289b <vector197>:
.globl vector197
vector197:
  pushl $0
c010289b:	6a 00                	push   $0x0
  pushl $197
c010289d:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
c01028a2:	e9 b8 02 00 00       	jmp    c0102b5f <__alltraps>

c01028a7 <vector198>:
.globl vector198
vector198:
  pushl $0
c01028a7:	6a 00                	push   $0x0
  pushl $198
c01028a9:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
c01028ae:	e9 ac 02 00 00       	jmp    c0102b5f <__alltraps>

c01028b3 <vector199>:
.globl vector199
vector199:
  pushl $0
c01028b3:	6a 00                	push   $0x0
  pushl $199
c01028b5:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
c01028ba:	e9 a0 02 00 00       	jmp    c0102b5f <__alltraps>

c01028bf <vector200>:
.globl vector200
vector200:
  pushl $0
c01028bf:	6a 00                	push   $0x0
  pushl $200
c01028c1:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
c01028c6:	e9 94 02 00 00       	jmp    c0102b5f <__alltraps>

c01028cb <vector201>:
.globl vector201
vector201:
  pushl $0
c01028cb:	6a 00                	push   $0x0
  pushl $201
c01028cd:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
c01028d2:	e9 88 02 00 00       	jmp    c0102b5f <__alltraps>

c01028d7 <vector202>:
.globl vector202
vector202:
  pushl $0
c01028d7:	6a 00                	push   $0x0
  pushl $202
c01028d9:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
c01028de:	e9 7c 02 00 00       	jmp    c0102b5f <__alltraps>

c01028e3 <vector203>:
.globl vector203
vector203:
  pushl $0
c01028e3:	6a 00                	push   $0x0
  pushl $203
c01028e5:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
c01028ea:	e9 70 02 00 00       	jmp    c0102b5f <__alltraps>

c01028ef <vector204>:
.globl vector204
vector204:
  pushl $0
c01028ef:	6a 00                	push   $0x0
  pushl $204
c01028f1:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
c01028f6:	e9 64 02 00 00       	jmp    c0102b5f <__alltraps>

c01028fb <vector205>:
.globl vector205
vector205:
  pushl $0
c01028fb:	6a 00                	push   $0x0
  pushl $205
c01028fd:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
c0102902:	e9 58 02 00 00       	jmp    c0102b5f <__alltraps>

c0102907 <vector206>:
.globl vector206
vector206:
  pushl $0
c0102907:	6a 00                	push   $0x0
  pushl $206
c0102909:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
c010290e:	e9 4c 02 00 00       	jmp    c0102b5f <__alltraps>

c0102913 <vector207>:
.globl vector207
vector207:
  pushl $0
c0102913:	6a 00                	push   $0x0
  pushl $207
c0102915:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
c010291a:	e9 40 02 00 00       	jmp    c0102b5f <__alltraps>

c010291f <vector208>:
.globl vector208
vector208:
  pushl $0
c010291f:	6a 00                	push   $0x0
  pushl $208
c0102921:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
c0102926:	e9 34 02 00 00       	jmp    c0102b5f <__alltraps>

c010292b <vector209>:
.globl vector209
vector209:
  pushl $0
c010292b:	6a 00                	push   $0x0
  pushl $209
c010292d:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
c0102932:	e9 28 02 00 00       	jmp    c0102b5f <__alltraps>

c0102937 <vector210>:
.globl vector210
vector210:
  pushl $0
c0102937:	6a 00                	push   $0x0
  pushl $210
c0102939:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
c010293e:	e9 1c 02 00 00       	jmp    c0102b5f <__alltraps>

c0102943 <vector211>:
.globl vector211
vector211:
  pushl $0
c0102943:	6a 00                	push   $0x0
  pushl $211
c0102945:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
c010294a:	e9 10 02 00 00       	jmp    c0102b5f <__alltraps>

c010294f <vector212>:
.globl vector212
vector212:
  pushl $0
c010294f:	6a 00                	push   $0x0
  pushl $212
c0102951:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
c0102956:	e9 04 02 00 00       	jmp    c0102b5f <__alltraps>

c010295b <vector213>:
.globl vector213
vector213:
  pushl $0
c010295b:	6a 00                	push   $0x0
  pushl $213
c010295d:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
c0102962:	e9 f8 01 00 00       	jmp    c0102b5f <__alltraps>

c0102967 <vector214>:
.globl vector214
vector214:
  pushl $0
c0102967:	6a 00                	push   $0x0
  pushl $214
c0102969:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
c010296e:	e9 ec 01 00 00       	jmp    c0102b5f <__alltraps>

c0102973 <vector215>:
.globl vector215
vector215:
  pushl $0
c0102973:	6a 00                	push   $0x0
  pushl $215
c0102975:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
c010297a:	e9 e0 01 00 00       	jmp    c0102b5f <__alltraps>

c010297f <vector216>:
.globl vector216
vector216:
  pushl $0
c010297f:	6a 00                	push   $0x0
  pushl $216
c0102981:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
c0102986:	e9 d4 01 00 00       	jmp    c0102b5f <__alltraps>

c010298b <vector217>:
.globl vector217
vector217:
  pushl $0
c010298b:	6a 00                	push   $0x0
  pushl $217
c010298d:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
c0102992:	e9 c8 01 00 00       	jmp    c0102b5f <__alltraps>

c0102997 <vector218>:
.globl vector218
vector218:
  pushl $0
c0102997:	6a 00                	push   $0x0
  pushl $218
c0102999:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
c010299e:	e9 bc 01 00 00       	jmp    c0102b5f <__alltraps>

c01029a3 <vector219>:
.globl vector219
vector219:
  pushl $0
c01029a3:	6a 00                	push   $0x0
  pushl $219
c01029a5:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
c01029aa:	e9 b0 01 00 00       	jmp    c0102b5f <__alltraps>

c01029af <vector220>:
.globl vector220
vector220:
  pushl $0
c01029af:	6a 00                	push   $0x0
  pushl $220
c01029b1:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
c01029b6:	e9 a4 01 00 00       	jmp    c0102b5f <__alltraps>

c01029bb <vector221>:
.globl vector221
vector221:
  pushl $0
c01029bb:	6a 00                	push   $0x0
  pushl $221
c01029bd:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
c01029c2:	e9 98 01 00 00       	jmp    c0102b5f <__alltraps>

c01029c7 <vector222>:
.globl vector222
vector222:
  pushl $0
c01029c7:	6a 00                	push   $0x0
  pushl $222
c01029c9:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
c01029ce:	e9 8c 01 00 00       	jmp    c0102b5f <__alltraps>

c01029d3 <vector223>:
.globl vector223
vector223:
  pushl $0
c01029d3:	6a 00                	push   $0x0
  pushl $223
c01029d5:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
c01029da:	e9 80 01 00 00       	jmp    c0102b5f <__alltraps>

c01029df <vector224>:
.globl vector224
vector224:
  pushl $0
c01029df:	6a 00                	push   $0x0
  pushl $224
c01029e1:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
c01029e6:	e9 74 01 00 00       	jmp    c0102b5f <__alltraps>

c01029eb <vector225>:
.globl vector225
vector225:
  pushl $0
c01029eb:	6a 00                	push   $0x0
  pushl $225
c01029ed:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
c01029f2:	e9 68 01 00 00       	jmp    c0102b5f <__alltraps>

c01029f7 <vector226>:
.globl vector226
vector226:
  pushl $0
c01029f7:	6a 00                	push   $0x0
  pushl $226
c01029f9:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
c01029fe:	e9 5c 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a03 <vector227>:
.globl vector227
vector227:
  pushl $0
c0102a03:	6a 00                	push   $0x0
  pushl $227
c0102a05:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
c0102a0a:	e9 50 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a0f <vector228>:
.globl vector228
vector228:
  pushl $0
c0102a0f:	6a 00                	push   $0x0
  pushl $228
c0102a11:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
c0102a16:	e9 44 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a1b <vector229>:
.globl vector229
vector229:
  pushl $0
c0102a1b:	6a 00                	push   $0x0
  pushl $229
c0102a1d:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
c0102a22:	e9 38 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a27 <vector230>:
.globl vector230
vector230:
  pushl $0
c0102a27:	6a 00                	push   $0x0
  pushl $230
c0102a29:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
c0102a2e:	e9 2c 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a33 <vector231>:
.globl vector231
vector231:
  pushl $0
c0102a33:	6a 00                	push   $0x0
  pushl $231
c0102a35:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
c0102a3a:	e9 20 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a3f <vector232>:
.globl vector232
vector232:
  pushl $0
c0102a3f:	6a 00                	push   $0x0
  pushl $232
c0102a41:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
c0102a46:	e9 14 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a4b <vector233>:
.globl vector233
vector233:
  pushl $0
c0102a4b:	6a 00                	push   $0x0
  pushl $233
c0102a4d:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
c0102a52:	e9 08 01 00 00       	jmp    c0102b5f <__alltraps>

c0102a57 <vector234>:
.globl vector234
vector234:
  pushl $0
c0102a57:	6a 00                	push   $0x0
  pushl $234
c0102a59:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
c0102a5e:	e9 fc 00 00 00       	jmp    c0102b5f <__alltraps>

c0102a63 <vector235>:
.globl vector235
vector235:
  pushl $0
c0102a63:	6a 00                	push   $0x0
  pushl $235
c0102a65:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
c0102a6a:	e9 f0 00 00 00       	jmp    c0102b5f <__alltraps>

c0102a6f <vector236>:
.globl vector236
vector236:
  pushl $0
c0102a6f:	6a 00                	push   $0x0
  pushl $236
c0102a71:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
c0102a76:	e9 e4 00 00 00       	jmp    c0102b5f <__alltraps>

c0102a7b <vector237>:
.globl vector237
vector237:
  pushl $0
c0102a7b:	6a 00                	push   $0x0
  pushl $237
c0102a7d:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
c0102a82:	e9 d8 00 00 00       	jmp    c0102b5f <__alltraps>

c0102a87 <vector238>:
.globl vector238
vector238:
  pushl $0
c0102a87:	6a 00                	push   $0x0
  pushl $238
c0102a89:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
c0102a8e:	e9 cc 00 00 00       	jmp    c0102b5f <__alltraps>

c0102a93 <vector239>:
.globl vector239
vector239:
  pushl $0
c0102a93:	6a 00                	push   $0x0
  pushl $239
c0102a95:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
c0102a9a:	e9 c0 00 00 00       	jmp    c0102b5f <__alltraps>

c0102a9f <vector240>:
.globl vector240
vector240:
  pushl $0
c0102a9f:	6a 00                	push   $0x0
  pushl $240
c0102aa1:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
c0102aa6:	e9 b4 00 00 00       	jmp    c0102b5f <__alltraps>

c0102aab <vector241>:
.globl vector241
vector241:
  pushl $0
c0102aab:	6a 00                	push   $0x0
  pushl $241
c0102aad:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
c0102ab2:	e9 a8 00 00 00       	jmp    c0102b5f <__alltraps>

c0102ab7 <vector242>:
.globl vector242
vector242:
  pushl $0
c0102ab7:	6a 00                	push   $0x0
  pushl $242
c0102ab9:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
c0102abe:	e9 9c 00 00 00       	jmp    c0102b5f <__alltraps>

c0102ac3 <vector243>:
.globl vector243
vector243:
  pushl $0
c0102ac3:	6a 00                	push   $0x0
  pushl $243
c0102ac5:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
c0102aca:	e9 90 00 00 00       	jmp    c0102b5f <__alltraps>

c0102acf <vector244>:
.globl vector244
vector244:
  pushl $0
c0102acf:	6a 00                	push   $0x0
  pushl $244
c0102ad1:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
c0102ad6:	e9 84 00 00 00       	jmp    c0102b5f <__alltraps>

c0102adb <vector245>:
.globl vector245
vector245:
  pushl $0
c0102adb:	6a 00                	push   $0x0
  pushl $245
c0102add:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
c0102ae2:	e9 78 00 00 00       	jmp    c0102b5f <__alltraps>

c0102ae7 <vector246>:
.globl vector246
vector246:
  pushl $0
c0102ae7:	6a 00                	push   $0x0
  pushl $246
c0102ae9:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
c0102aee:	e9 6c 00 00 00       	jmp    c0102b5f <__alltraps>

c0102af3 <vector247>:
.globl vector247
vector247:
  pushl $0
c0102af3:	6a 00                	push   $0x0
  pushl $247
c0102af5:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
c0102afa:	e9 60 00 00 00       	jmp    c0102b5f <__alltraps>

c0102aff <vector248>:
.globl vector248
vector248:
  pushl $0
c0102aff:	6a 00                	push   $0x0
  pushl $248
c0102b01:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
c0102b06:	e9 54 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b0b <vector249>:
.globl vector249
vector249:
  pushl $0
c0102b0b:	6a 00                	push   $0x0
  pushl $249
c0102b0d:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
c0102b12:	e9 48 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b17 <vector250>:
.globl vector250
vector250:
  pushl $0
c0102b17:	6a 00                	push   $0x0
  pushl $250
c0102b19:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
c0102b1e:	e9 3c 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b23 <vector251>:
.globl vector251
vector251:
  pushl $0
c0102b23:	6a 00                	push   $0x0
  pushl $251
c0102b25:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
c0102b2a:	e9 30 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b2f <vector252>:
.globl vector252
vector252:
  pushl $0
c0102b2f:	6a 00                	push   $0x0
  pushl $252
c0102b31:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
c0102b36:	e9 24 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b3b <vector253>:
.globl vector253
vector253:
  pushl $0
c0102b3b:	6a 00                	push   $0x0
  pushl $253
c0102b3d:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
c0102b42:	e9 18 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b47 <vector254>:
.globl vector254
vector254:
  pushl $0
c0102b47:	6a 00                	push   $0x0
  pushl $254
c0102b49:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
c0102b4e:	e9 0c 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b53 <vector255>:
.globl vector255
vector255:
  pushl $0
c0102b53:	6a 00                	push   $0x0
  pushl $255
c0102b55:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
c0102b5a:	e9 00 00 00 00       	jmp    c0102b5f <__alltraps>

c0102b5f <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
c0102b5f:	1e                   	push   %ds
    pushl %es
c0102b60:	06                   	push   %es
    pushl %fs
c0102b61:	0f a0                	push   %fs
    pushl %gs
c0102b63:	0f a8                	push   %gs
    pushal
c0102b65:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
c0102b66:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c0102b6b:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c0102b6d:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
c0102b6f:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
c0102b70:	e8 5f f5 ff ff       	call   c01020d4 <trap>

    # pop the pushed stack pointer
    popl %esp
c0102b75:	5c                   	pop    %esp

c0102b76 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
c0102b76:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
c0102b77:	0f a9                	pop    %gs
    popl %fs
c0102b79:	0f a1                	pop    %fs
    popl %es
c0102b7b:	07                   	pop    %es
    popl %ds
c0102b7c:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
c0102b7d:	83 c4 08             	add    $0x8,%esp
    iret
c0102b80:	cf                   	iret   

c0102b81 <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
c0102b81:	55                   	push   %ebp
c0102b82:	89 e5                	mov    %esp,%ebp
    return page - pages;
c0102b84:	a1 18 cf 11 c0       	mov    0xc011cf18,%eax
c0102b89:	8b 55 08             	mov    0x8(%ebp),%edx
c0102b8c:	29 c2                	sub    %eax,%edx
c0102b8e:	89 d0                	mov    %edx,%eax
c0102b90:	c1 f8 02             	sar    $0x2,%eax
c0102b93:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0102b99:	5d                   	pop    %ebp
c0102b9a:	c3                   	ret    

c0102b9b <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
c0102b9b:	55                   	push   %ebp
c0102b9c:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
c0102b9e:	ff 75 08             	pushl  0x8(%ebp)
c0102ba1:	e8 db ff ff ff       	call   c0102b81 <page2ppn>
c0102ba6:	83 c4 04             	add    $0x4,%esp
c0102ba9:	c1 e0 0c             	shl    $0xc,%eax
}
c0102bac:	c9                   	leave  
c0102bad:	c3                   	ret    

c0102bae <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
c0102bae:	55                   	push   %ebp
c0102baf:	89 e5                	mov    %esp,%ebp
c0102bb1:	83 ec 08             	sub    $0x8,%esp
    if (PPN(pa) >= npage) {
c0102bb4:	8b 45 08             	mov    0x8(%ebp),%eax
c0102bb7:	c1 e8 0c             	shr    $0xc,%eax
c0102bba:	89 c2                	mov    %eax,%edx
c0102bbc:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0102bc1:	39 c2                	cmp    %eax,%edx
c0102bc3:	72 14                	jb     c0102bd9 <pa2page+0x2b>
        panic("pa2page called with invalid pa");
c0102bc5:	83 ec 04             	sub    $0x4,%esp
c0102bc8:	68 50 64 10 c0       	push   $0xc0106450
c0102bcd:	6a 5a                	push   $0x5a
c0102bcf:	68 6f 64 10 c0       	push   $0xc010646f
c0102bd4:	e8 46 d8 ff ff       	call   c010041f <__panic>
    }
    return &pages[PPN(pa)];
c0102bd9:	8b 0d 18 cf 11 c0    	mov    0xc011cf18,%ecx
c0102bdf:	8b 45 08             	mov    0x8(%ebp),%eax
c0102be2:	c1 e8 0c             	shr    $0xc,%eax
c0102be5:	89 c2                	mov    %eax,%edx
c0102be7:	89 d0                	mov    %edx,%eax
c0102be9:	c1 e0 02             	shl    $0x2,%eax
c0102bec:	01 d0                	add    %edx,%eax
c0102bee:	c1 e0 02             	shl    $0x2,%eax
c0102bf1:	01 c8                	add    %ecx,%eax
}
c0102bf3:	c9                   	leave  
c0102bf4:	c3                   	ret    

c0102bf5 <page2kva>:

static inline void *
page2kva(struct Page *page) {
c0102bf5:	55                   	push   %ebp
c0102bf6:	89 e5                	mov    %esp,%ebp
c0102bf8:	83 ec 18             	sub    $0x18,%esp
    return KADDR(page2pa(page));
c0102bfb:	ff 75 08             	pushl  0x8(%ebp)
c0102bfe:	e8 98 ff ff ff       	call   c0102b9b <page2pa>
c0102c03:	83 c4 04             	add    $0x4,%esp
c0102c06:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0102c09:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102c0c:	c1 e8 0c             	shr    $0xc,%eax
c0102c0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0102c12:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0102c17:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0102c1a:	72 14                	jb     c0102c30 <page2kva+0x3b>
c0102c1c:	ff 75 f4             	pushl  -0xc(%ebp)
c0102c1f:	68 80 64 10 c0       	push   $0xc0106480
c0102c24:	6a 61                	push   $0x61
c0102c26:	68 6f 64 10 c0       	push   $0xc010646f
c0102c2b:	e8 ef d7 ff ff       	call   c010041f <__panic>
c0102c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102c33:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
c0102c38:	c9                   	leave  
c0102c39:	c3                   	ret    

c0102c3a <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
c0102c3a:	55                   	push   %ebp
c0102c3b:	89 e5                	mov    %esp,%ebp
c0102c3d:	83 ec 08             	sub    $0x8,%esp
    if (!(pte & PTE_P)) {
c0102c40:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c43:	83 e0 01             	and    $0x1,%eax
c0102c46:	85 c0                	test   %eax,%eax
c0102c48:	75 14                	jne    c0102c5e <pte2page+0x24>
        panic("pte2page called with invalid pte");
c0102c4a:	83 ec 04             	sub    $0x4,%esp
c0102c4d:	68 a4 64 10 c0       	push   $0xc01064a4
c0102c52:	6a 6c                	push   $0x6c
c0102c54:	68 6f 64 10 c0       	push   $0xc010646f
c0102c59:	e8 c1 d7 ff ff       	call   c010041f <__panic>
    }
    return pa2page(PTE_ADDR(pte));
c0102c5e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0102c66:	83 ec 0c             	sub    $0xc,%esp
c0102c69:	50                   	push   %eax
c0102c6a:	e8 3f ff ff ff       	call   c0102bae <pa2page>
c0102c6f:	83 c4 10             	add    $0x10,%esp
}
c0102c72:	c9                   	leave  
c0102c73:	c3                   	ret    

c0102c74 <page_ref>:
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

static inline int
page_ref(struct Page *page) {
c0102c74:	55                   	push   %ebp
c0102c75:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0102c77:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c7a:	8b 00                	mov    (%eax),%eax
}
c0102c7c:	5d                   	pop    %ebp
c0102c7d:	c3                   	ret    

c0102c7e <page_ref_inc>:
set_page_ref(struct Page *page, int val) {
    page->ref = val;
}

static inline int
page_ref_inc(struct Page *page) {
c0102c7e:	55                   	push   %ebp
c0102c7f:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
c0102c81:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c84:	8b 00                	mov    (%eax),%eax
c0102c86:	8d 50 01             	lea    0x1(%eax),%edx
c0102c89:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c8c:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102c8e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c91:	8b 00                	mov    (%eax),%eax
}
c0102c93:	5d                   	pop    %ebp
c0102c94:	c3                   	ret    

c0102c95 <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
c0102c95:	55                   	push   %ebp
c0102c96:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
c0102c98:	8b 45 08             	mov    0x8(%ebp),%eax
c0102c9b:	8b 00                	mov    (%eax),%eax
c0102c9d:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102ca0:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ca3:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102ca5:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ca8:	8b 00                	mov    (%eax),%eax
}
c0102caa:	5d                   	pop    %ebp
c0102cab:	c3                   	ret    

c0102cac <__intr_save>:
__intr_save(void) {
c0102cac:	55                   	push   %ebp
c0102cad:	89 e5                	mov    %esp,%ebp
c0102caf:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0102cb2:	9c                   	pushf  
c0102cb3:	58                   	pop    %eax
c0102cb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0102cb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0102cba:	25 00 02 00 00       	and    $0x200,%eax
c0102cbf:	85 c0                	test   %eax,%eax
c0102cc1:	74 0c                	je     c0102ccf <__intr_save+0x23>
        intr_disable();
c0102cc3:	e8 bd ec ff ff       	call   c0101985 <intr_disable>
        return 1;
c0102cc8:	b8 01 00 00 00       	mov    $0x1,%eax
c0102ccd:	eb 05                	jmp    c0102cd4 <__intr_save+0x28>
    return 0;
c0102ccf:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0102cd4:	c9                   	leave  
c0102cd5:	c3                   	ret    

c0102cd6 <__intr_restore>:
__intr_restore(bool flag) {
c0102cd6:	55                   	push   %ebp
c0102cd7:	89 e5                	mov    %esp,%ebp
c0102cd9:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0102cdc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0102ce0:	74 05                	je     c0102ce7 <__intr_restore+0x11>
        intr_enable();
c0102ce2:	e8 92 ec ff ff       	call   c0101979 <intr_enable>
}
c0102ce7:	90                   	nop
c0102ce8:	c9                   	leave  
c0102ce9:	c3                   	ret    

c0102cea <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
c0102cea:	55                   	push   %ebp
c0102ceb:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
c0102ced:	8b 45 08             	mov    0x8(%ebp),%eax
c0102cf0:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
c0102cf3:	b8 23 00 00 00       	mov    $0x23,%eax
c0102cf8:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
c0102cfa:	b8 23 00 00 00       	mov    $0x23,%eax
c0102cff:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
c0102d01:	b8 10 00 00 00       	mov    $0x10,%eax
c0102d06:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
c0102d08:	b8 10 00 00 00       	mov    $0x10,%eax
c0102d0d:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
c0102d0f:	b8 10 00 00 00       	mov    $0x10,%eax
c0102d14:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
c0102d16:	ea 1d 2d 10 c0 08 00 	ljmp   $0x8,$0xc0102d1d
}
c0102d1d:	90                   	nop
c0102d1e:	5d                   	pop    %ebp
c0102d1f:	c3                   	ret    

c0102d20 <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
c0102d20:	f3 0f 1e fb          	endbr32 
c0102d24:	55                   	push   %ebp
c0102d25:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
c0102d27:	8b 45 08             	mov    0x8(%ebp),%eax
c0102d2a:	a3 a4 ce 11 c0       	mov    %eax,0xc011cea4
}
c0102d2f:	90                   	nop
c0102d30:	5d                   	pop    %ebp
c0102d31:	c3                   	ret    

c0102d32 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
c0102d32:	f3 0f 1e fb          	endbr32 
c0102d36:	55                   	push   %ebp
c0102d37:	89 e5                	mov    %esp,%ebp
c0102d39:	83 ec 10             	sub    $0x10,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
c0102d3c:	b8 00 90 11 c0       	mov    $0xc0119000,%eax
c0102d41:	50                   	push   %eax
c0102d42:	e8 d9 ff ff ff       	call   c0102d20 <load_esp0>
c0102d47:	83 c4 04             	add    $0x4,%esp
    ts.ts_ss0 = KERNEL_DS;
c0102d4a:	66 c7 05 a8 ce 11 c0 	movw   $0x10,0xc011cea8
c0102d51:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
c0102d53:	66 c7 05 08 9a 11 c0 	movw   $0x68,0xc0119a08
c0102d5a:	68 00 
c0102d5c:	b8 a0 ce 11 c0       	mov    $0xc011cea0,%eax
c0102d61:	66 a3 0a 9a 11 c0    	mov    %ax,0xc0119a0a
c0102d67:	b8 a0 ce 11 c0       	mov    $0xc011cea0,%eax
c0102d6c:	c1 e8 10             	shr    $0x10,%eax
c0102d6f:	a2 0c 9a 11 c0       	mov    %al,0xc0119a0c
c0102d74:	0f b6 05 0d 9a 11 c0 	movzbl 0xc0119a0d,%eax
c0102d7b:	83 e0 f0             	and    $0xfffffff0,%eax
c0102d7e:	83 c8 09             	or     $0x9,%eax
c0102d81:	a2 0d 9a 11 c0       	mov    %al,0xc0119a0d
c0102d86:	0f b6 05 0d 9a 11 c0 	movzbl 0xc0119a0d,%eax
c0102d8d:	83 e0 ef             	and    $0xffffffef,%eax
c0102d90:	a2 0d 9a 11 c0       	mov    %al,0xc0119a0d
c0102d95:	0f b6 05 0d 9a 11 c0 	movzbl 0xc0119a0d,%eax
c0102d9c:	83 e0 9f             	and    $0xffffff9f,%eax
c0102d9f:	a2 0d 9a 11 c0       	mov    %al,0xc0119a0d
c0102da4:	0f b6 05 0d 9a 11 c0 	movzbl 0xc0119a0d,%eax
c0102dab:	83 c8 80             	or     $0xffffff80,%eax
c0102dae:	a2 0d 9a 11 c0       	mov    %al,0xc0119a0d
c0102db3:	0f b6 05 0e 9a 11 c0 	movzbl 0xc0119a0e,%eax
c0102dba:	83 e0 f0             	and    $0xfffffff0,%eax
c0102dbd:	a2 0e 9a 11 c0       	mov    %al,0xc0119a0e
c0102dc2:	0f b6 05 0e 9a 11 c0 	movzbl 0xc0119a0e,%eax
c0102dc9:	83 e0 ef             	and    $0xffffffef,%eax
c0102dcc:	a2 0e 9a 11 c0       	mov    %al,0xc0119a0e
c0102dd1:	0f b6 05 0e 9a 11 c0 	movzbl 0xc0119a0e,%eax
c0102dd8:	83 e0 df             	and    $0xffffffdf,%eax
c0102ddb:	a2 0e 9a 11 c0       	mov    %al,0xc0119a0e
c0102de0:	0f b6 05 0e 9a 11 c0 	movzbl 0xc0119a0e,%eax
c0102de7:	83 c8 40             	or     $0x40,%eax
c0102dea:	a2 0e 9a 11 c0       	mov    %al,0xc0119a0e
c0102def:	0f b6 05 0e 9a 11 c0 	movzbl 0xc0119a0e,%eax
c0102df6:	83 e0 7f             	and    $0x7f,%eax
c0102df9:	a2 0e 9a 11 c0       	mov    %al,0xc0119a0e
c0102dfe:	b8 a0 ce 11 c0       	mov    $0xc011cea0,%eax
c0102e03:	c1 e8 18             	shr    $0x18,%eax
c0102e06:	a2 0f 9a 11 c0       	mov    %al,0xc0119a0f

    // reload all segment registers
    lgdt(&gdt_pd);
c0102e0b:	68 10 9a 11 c0       	push   $0xc0119a10
c0102e10:	e8 d5 fe ff ff       	call   c0102cea <lgdt>
c0102e15:	83 c4 04             	add    $0x4,%esp
c0102e18:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
c0102e1e:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0102e22:	0f 00 d8             	ltr    %ax
}
c0102e25:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
c0102e26:	90                   	nop
c0102e27:	c9                   	leave  
c0102e28:	c3                   	ret    

c0102e29 <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
c0102e29:	f3 0f 1e fb          	endbr32 
c0102e2d:	55                   	push   %ebp
c0102e2e:	89 e5                	mov    %esp,%ebp
c0102e30:	83 ec 08             	sub    $0x8,%esp
    pmm_manager = &default_pmm_manager;
c0102e33:	c7 05 10 cf 11 c0 28 	movl   $0xc0106e28,0xc011cf10
c0102e3a:	6e 10 c0 
    cprintf("memory management: %s\n", pmm_manager->name);
c0102e3d:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102e42:	8b 00                	mov    (%eax),%eax
c0102e44:	83 ec 08             	sub    $0x8,%esp
c0102e47:	50                   	push   %eax
c0102e48:	68 d0 64 10 c0       	push   $0xc01064d0
c0102e4d:	e8 52 d4 ff ff       	call   c01002a4 <cprintf>
c0102e52:	83 c4 10             	add    $0x10,%esp
    pmm_manager->init();
c0102e55:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102e5a:	8b 40 04             	mov    0x4(%eax),%eax
c0102e5d:	ff d0                	call   *%eax
}
c0102e5f:	90                   	nop
c0102e60:	c9                   	leave  
c0102e61:	c3                   	ret    

c0102e62 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
c0102e62:	f3 0f 1e fb          	endbr32 
c0102e66:	55                   	push   %ebp
c0102e67:	89 e5                	mov    %esp,%ebp
c0102e69:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->init_memmap(base, n);
c0102e6c:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102e71:	8b 40 08             	mov    0x8(%eax),%eax
c0102e74:	83 ec 08             	sub    $0x8,%esp
c0102e77:	ff 75 0c             	pushl  0xc(%ebp)
c0102e7a:	ff 75 08             	pushl  0x8(%ebp)
c0102e7d:	ff d0                	call   *%eax
c0102e7f:	83 c4 10             	add    $0x10,%esp
}
c0102e82:	90                   	nop
c0102e83:	c9                   	leave  
c0102e84:	c3                   	ret    

c0102e85 <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
c0102e85:	f3 0f 1e fb          	endbr32 
c0102e89:	55                   	push   %ebp
c0102e8a:	89 e5                	mov    %esp,%ebp
c0102e8c:	83 ec 18             	sub    $0x18,%esp
    struct Page *page=NULL;
c0102e8f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0102e96:	e8 11 fe ff ff       	call   c0102cac <__intr_save>
c0102e9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
c0102e9e:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102ea3:	8b 40 0c             	mov    0xc(%eax),%eax
c0102ea6:	83 ec 0c             	sub    $0xc,%esp
c0102ea9:	ff 75 08             	pushl  0x8(%ebp)
c0102eac:	ff d0                	call   *%eax
c0102eae:	83 c4 10             	add    $0x10,%esp
c0102eb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
c0102eb4:	83 ec 0c             	sub    $0xc,%esp
c0102eb7:	ff 75 f0             	pushl  -0x10(%ebp)
c0102eba:	e8 17 fe ff ff       	call   c0102cd6 <__intr_restore>
c0102ebf:	83 c4 10             	add    $0x10,%esp
    return page;
c0102ec2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0102ec5:	c9                   	leave  
c0102ec6:	c3                   	ret    

c0102ec7 <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
c0102ec7:	f3 0f 1e fb          	endbr32 
c0102ecb:	55                   	push   %ebp
c0102ecc:	89 e5                	mov    %esp,%ebp
c0102ece:	83 ec 18             	sub    $0x18,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c0102ed1:	e8 d6 fd ff ff       	call   c0102cac <__intr_save>
c0102ed6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
c0102ed9:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102ede:	8b 40 10             	mov    0x10(%eax),%eax
c0102ee1:	83 ec 08             	sub    $0x8,%esp
c0102ee4:	ff 75 0c             	pushl  0xc(%ebp)
c0102ee7:	ff 75 08             	pushl  0x8(%ebp)
c0102eea:	ff d0                	call   *%eax
c0102eec:	83 c4 10             	add    $0x10,%esp
    }
    local_intr_restore(intr_flag);
c0102eef:	83 ec 0c             	sub    $0xc,%esp
c0102ef2:	ff 75 f4             	pushl  -0xc(%ebp)
c0102ef5:	e8 dc fd ff ff       	call   c0102cd6 <__intr_restore>
c0102efa:	83 c4 10             	add    $0x10,%esp
}
c0102efd:	90                   	nop
c0102efe:	c9                   	leave  
c0102eff:	c3                   	ret    

c0102f00 <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
c0102f00:	f3 0f 1e fb          	endbr32 
c0102f04:	55                   	push   %ebp
c0102f05:	89 e5                	mov    %esp,%ebp
c0102f07:	83 ec 18             	sub    $0x18,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
c0102f0a:	e8 9d fd ff ff       	call   c0102cac <__intr_save>
c0102f0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
c0102f12:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102f17:	8b 40 14             	mov    0x14(%eax),%eax
c0102f1a:	ff d0                	call   *%eax
c0102f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
c0102f1f:	83 ec 0c             	sub    $0xc,%esp
c0102f22:	ff 75 f4             	pushl  -0xc(%ebp)
c0102f25:	e8 ac fd ff ff       	call   c0102cd6 <__intr_restore>
c0102f2a:	83 c4 10             	add    $0x10,%esp
    return ret;
c0102f2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0102f30:	c9                   	leave  
c0102f31:	c3                   	ret    

c0102f32 <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
c0102f32:	f3 0f 1e fb          	endbr32 
c0102f36:	55                   	push   %ebp
c0102f37:	89 e5                	mov    %esp,%ebp
c0102f39:	57                   	push   %edi
c0102f3a:	56                   	push   %esi
c0102f3b:	53                   	push   %ebx
c0102f3c:	83 ec 7c             	sub    $0x7c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
c0102f3f:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
c0102f46:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c0102f4d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
c0102f54:	83 ec 0c             	sub    $0xc,%esp
c0102f57:	68 e7 64 10 c0       	push   $0xc01064e7
c0102f5c:	e8 43 d3 ff ff       	call   c01002a4 <cprintf>
c0102f61:	83 c4 10             	add    $0x10,%esp
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
c0102f64:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102f6b:	e9 f4 00 00 00       	jmp    c0103064 <page_init+0x132>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0102f70:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102f73:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102f76:	89 d0                	mov    %edx,%eax
c0102f78:	c1 e0 02             	shl    $0x2,%eax
c0102f7b:	01 d0                	add    %edx,%eax
c0102f7d:	c1 e0 02             	shl    $0x2,%eax
c0102f80:	01 c8                	add    %ecx,%eax
c0102f82:	8b 50 08             	mov    0x8(%eax),%edx
c0102f85:	8b 40 04             	mov    0x4(%eax),%eax
c0102f88:	89 45 a0             	mov    %eax,-0x60(%ebp)
c0102f8b:	89 55 a4             	mov    %edx,-0x5c(%ebp)
c0102f8e:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102f91:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102f94:	89 d0                	mov    %edx,%eax
c0102f96:	c1 e0 02             	shl    $0x2,%eax
c0102f99:	01 d0                	add    %edx,%eax
c0102f9b:	c1 e0 02             	shl    $0x2,%eax
c0102f9e:	01 c8                	add    %ecx,%eax
c0102fa0:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102fa3:	8b 58 10             	mov    0x10(%eax),%ebx
c0102fa6:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0102fa9:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c0102fac:	01 c8                	add    %ecx,%eax
c0102fae:	11 da                	adc    %ebx,%edx
c0102fb0:	89 45 98             	mov    %eax,-0x68(%ebp)
c0102fb3:	89 55 9c             	mov    %edx,-0x64(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
c0102fb6:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102fb9:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102fbc:	89 d0                	mov    %edx,%eax
c0102fbe:	c1 e0 02             	shl    $0x2,%eax
c0102fc1:	01 d0                	add    %edx,%eax
c0102fc3:	c1 e0 02             	shl    $0x2,%eax
c0102fc6:	01 c8                	add    %ecx,%eax
c0102fc8:	83 c0 14             	add    $0x14,%eax
c0102fcb:	8b 00                	mov    (%eax),%eax
c0102fcd:	89 45 84             	mov    %eax,-0x7c(%ebp)
c0102fd0:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102fd3:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102fd6:	83 c0 ff             	add    $0xffffffff,%eax
c0102fd9:	83 d2 ff             	adc    $0xffffffff,%edx
c0102fdc:	89 c1                	mov    %eax,%ecx
c0102fde:	89 d3                	mov    %edx,%ebx
c0102fe0:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0102fe3:	89 55 80             	mov    %edx,-0x80(%ebp)
c0102fe6:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102fe9:	89 d0                	mov    %edx,%eax
c0102feb:	c1 e0 02             	shl    $0x2,%eax
c0102fee:	01 d0                	add    %edx,%eax
c0102ff0:	c1 e0 02             	shl    $0x2,%eax
c0102ff3:	03 45 80             	add    -0x80(%ebp),%eax
c0102ff6:	8b 50 10             	mov    0x10(%eax),%edx
c0102ff9:	8b 40 0c             	mov    0xc(%eax),%eax
c0102ffc:	ff 75 84             	pushl  -0x7c(%ebp)
c0102fff:	53                   	push   %ebx
c0103000:	51                   	push   %ecx
c0103001:	ff 75 a4             	pushl  -0x5c(%ebp)
c0103004:	ff 75 a0             	pushl  -0x60(%ebp)
c0103007:	52                   	push   %edx
c0103008:	50                   	push   %eax
c0103009:	68 f4 64 10 c0       	push   $0xc01064f4
c010300e:	e8 91 d2 ff ff       	call   c01002a4 <cprintf>
c0103013:	83 c4 20             	add    $0x20,%esp
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
c0103016:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103019:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010301c:	89 d0                	mov    %edx,%eax
c010301e:	c1 e0 02             	shl    $0x2,%eax
c0103021:	01 d0                	add    %edx,%eax
c0103023:	c1 e0 02             	shl    $0x2,%eax
c0103026:	01 c8                	add    %ecx,%eax
c0103028:	83 c0 14             	add    $0x14,%eax
c010302b:	8b 00                	mov    (%eax),%eax
c010302d:	83 f8 01             	cmp    $0x1,%eax
c0103030:	75 2e                	jne    c0103060 <page_init+0x12e>
            if (maxpa < end && begin < KMEMSIZE) {
c0103032:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103035:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0103038:	3b 45 98             	cmp    -0x68(%ebp),%eax
c010303b:	89 d0                	mov    %edx,%eax
c010303d:	1b 45 9c             	sbb    -0x64(%ebp),%eax
c0103040:	73 1e                	jae    c0103060 <page_init+0x12e>
c0103042:	ba ff ff ff 37       	mov    $0x37ffffff,%edx
c0103047:	b8 00 00 00 00       	mov    $0x0,%eax
c010304c:	3b 55 a0             	cmp    -0x60(%ebp),%edx
c010304f:	1b 45 a4             	sbb    -0x5c(%ebp),%eax
c0103052:	72 0c                	jb     c0103060 <page_init+0x12e>
                maxpa = end;
c0103054:	8b 45 98             	mov    -0x68(%ebp),%eax
c0103057:	8b 55 9c             	mov    -0x64(%ebp),%edx
c010305a:	89 45 e0             	mov    %eax,-0x20(%ebp)
c010305d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (i = 0; i < memmap->nr_map; i ++) {
c0103060:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0103064:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0103067:	8b 00                	mov    (%eax),%eax
c0103069:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c010306c:	0f 8c fe fe ff ff    	jl     c0102f70 <page_init+0x3e>
            }
        }
    }
    if (maxpa > KMEMSIZE) {
c0103072:	ba 00 00 00 38       	mov    $0x38000000,%edx
c0103077:	b8 00 00 00 00       	mov    $0x0,%eax
c010307c:	3b 55 e0             	cmp    -0x20(%ebp),%edx
c010307f:	1b 45 e4             	sbb    -0x1c(%ebp),%eax
c0103082:	73 0e                	jae    c0103092 <page_init+0x160>
        maxpa = KMEMSIZE;
c0103084:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
c010308b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
c0103092:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103095:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0103098:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c010309c:	c1 ea 0c             	shr    $0xc,%edx
c010309f:	a3 80 ce 11 c0       	mov    %eax,0xc011ce80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
c01030a4:	c7 45 c0 00 10 00 00 	movl   $0x1000,-0x40(%ebp)
c01030ab:	b8 28 cf 11 c0       	mov    $0xc011cf28,%eax
c01030b0:	8d 50 ff             	lea    -0x1(%eax),%edx
c01030b3:	8b 45 c0             	mov    -0x40(%ebp),%eax
c01030b6:	01 d0                	add    %edx,%eax
c01030b8:	89 45 bc             	mov    %eax,-0x44(%ebp)
c01030bb:	8b 45 bc             	mov    -0x44(%ebp),%eax
c01030be:	ba 00 00 00 00       	mov    $0x0,%edx
c01030c3:	f7 75 c0             	divl   -0x40(%ebp)
c01030c6:	8b 45 bc             	mov    -0x44(%ebp),%eax
c01030c9:	29 d0                	sub    %edx,%eax
c01030cb:	a3 18 cf 11 c0       	mov    %eax,0xc011cf18

    for (i = 0; i < npage; i ++) {
c01030d0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c01030d7:	eb 30                	jmp    c0103109 <page_init+0x1d7>
        SetPageReserved(pages + i);
c01030d9:	8b 0d 18 cf 11 c0    	mov    0xc011cf18,%ecx
c01030df:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01030e2:	89 d0                	mov    %edx,%eax
c01030e4:	c1 e0 02             	shl    $0x2,%eax
c01030e7:	01 d0                	add    %edx,%eax
c01030e9:	c1 e0 02             	shl    $0x2,%eax
c01030ec:	01 c8                	add    %ecx,%eax
c01030ee:	83 c0 04             	add    $0x4,%eax
c01030f1:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
c01030f8:	89 45 90             	mov    %eax,-0x70(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01030fb:	8b 45 90             	mov    -0x70(%ebp),%eax
c01030fe:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0103101:	0f ab 10             	bts    %edx,(%eax)
}
c0103104:	90                   	nop
    for (i = 0; i < npage; i ++) {
c0103105:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c0103109:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010310c:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103111:	39 c2                	cmp    %eax,%edx
c0103113:	72 c4                	jb     c01030d9 <page_init+0x1a7>
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
c0103115:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c010311b:	89 d0                	mov    %edx,%eax
c010311d:	c1 e0 02             	shl    $0x2,%eax
c0103120:	01 d0                	add    %edx,%eax
c0103122:	c1 e0 02             	shl    $0x2,%eax
c0103125:	89 c2                	mov    %eax,%edx
c0103127:	a1 18 cf 11 c0       	mov    0xc011cf18,%eax
c010312c:	01 d0                	add    %edx,%eax
c010312e:	89 45 b8             	mov    %eax,-0x48(%ebp)
c0103131:	81 7d b8 ff ff ff bf 	cmpl   $0xbfffffff,-0x48(%ebp)
c0103138:	77 17                	ja     c0103151 <page_init+0x21f>
c010313a:	ff 75 b8             	pushl  -0x48(%ebp)
c010313d:	68 24 65 10 c0       	push   $0xc0106524
c0103142:	68 db 00 00 00       	push   $0xdb
c0103147:	68 48 65 10 c0       	push   $0xc0106548
c010314c:	e8 ce d2 ff ff       	call   c010041f <__panic>
c0103151:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0103154:	05 00 00 00 40       	add    $0x40000000,%eax
c0103159:	89 45 b4             	mov    %eax,-0x4c(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
c010315c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0103163:	e9 53 01 00 00       	jmp    c01032bb <page_init+0x389>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0103168:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c010316b:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010316e:	89 d0                	mov    %edx,%eax
c0103170:	c1 e0 02             	shl    $0x2,%eax
c0103173:	01 d0                	add    %edx,%eax
c0103175:	c1 e0 02             	shl    $0x2,%eax
c0103178:	01 c8                	add    %ecx,%eax
c010317a:	8b 50 08             	mov    0x8(%eax),%edx
c010317d:	8b 40 04             	mov    0x4(%eax),%eax
c0103180:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0103183:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0103186:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103189:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010318c:	89 d0                	mov    %edx,%eax
c010318e:	c1 e0 02             	shl    $0x2,%eax
c0103191:	01 d0                	add    %edx,%eax
c0103193:	c1 e0 02             	shl    $0x2,%eax
c0103196:	01 c8                	add    %ecx,%eax
c0103198:	8b 48 0c             	mov    0xc(%eax),%ecx
c010319b:	8b 58 10             	mov    0x10(%eax),%ebx
c010319e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01031a1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01031a4:	01 c8                	add    %ecx,%eax
c01031a6:	11 da                	adc    %ebx,%edx
c01031a8:	89 45 c8             	mov    %eax,-0x38(%ebp)
c01031ab:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
c01031ae:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c01031b1:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01031b4:	89 d0                	mov    %edx,%eax
c01031b6:	c1 e0 02             	shl    $0x2,%eax
c01031b9:	01 d0                	add    %edx,%eax
c01031bb:	c1 e0 02             	shl    $0x2,%eax
c01031be:	01 c8                	add    %ecx,%eax
c01031c0:	83 c0 14             	add    $0x14,%eax
c01031c3:	8b 00                	mov    (%eax),%eax
c01031c5:	83 f8 01             	cmp    $0x1,%eax
c01031c8:	0f 85 e9 00 00 00    	jne    c01032b7 <page_init+0x385>
            if (begin < freemem) {
c01031ce:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c01031d1:	ba 00 00 00 00       	mov    $0x0,%edx
c01031d6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c01031d9:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c01031dc:	19 d1                	sbb    %edx,%ecx
c01031de:	73 0d                	jae    c01031ed <page_init+0x2bb>
                begin = freemem;
c01031e0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c01031e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01031e6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
c01031ed:	ba 00 00 00 38       	mov    $0x38000000,%edx
c01031f2:	b8 00 00 00 00       	mov    $0x0,%eax
c01031f7:	3b 55 c8             	cmp    -0x38(%ebp),%edx
c01031fa:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c01031fd:	73 0e                	jae    c010320d <page_init+0x2db>
                end = KMEMSIZE;
c01031ff:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
c0103206:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
c010320d:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103210:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0103213:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c0103216:	89 d0                	mov    %edx,%eax
c0103218:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c010321b:	0f 83 96 00 00 00    	jae    c01032b7 <page_init+0x385>
                begin = ROUNDUP(begin, PGSIZE);
c0103221:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%ebp)
c0103228:	8b 55 d0             	mov    -0x30(%ebp),%edx
c010322b:	8b 45 b0             	mov    -0x50(%ebp),%eax
c010322e:	01 d0                	add    %edx,%eax
c0103230:	83 e8 01             	sub    $0x1,%eax
c0103233:	89 45 ac             	mov    %eax,-0x54(%ebp)
c0103236:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0103239:	ba 00 00 00 00       	mov    $0x0,%edx
c010323e:	f7 75 b0             	divl   -0x50(%ebp)
c0103241:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0103244:	29 d0                	sub    %edx,%eax
c0103246:	ba 00 00 00 00       	mov    $0x0,%edx
c010324b:	89 45 d0             	mov    %eax,-0x30(%ebp)
c010324e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
c0103251:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0103254:	89 45 a8             	mov    %eax,-0x58(%ebp)
c0103257:	8b 45 a8             	mov    -0x58(%ebp),%eax
c010325a:	ba 00 00 00 00       	mov    $0x0,%edx
c010325f:	89 c3                	mov    %eax,%ebx
c0103261:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
c0103267:	89 de                	mov    %ebx,%esi
c0103269:	89 d0                	mov    %edx,%eax
c010326b:	83 e0 00             	and    $0x0,%eax
c010326e:	89 c7                	mov    %eax,%edi
c0103270:	89 75 c8             	mov    %esi,-0x38(%ebp)
c0103273:	89 7d cc             	mov    %edi,-0x34(%ebp)
                if (begin < end) {
c0103276:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103279:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010327c:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c010327f:	89 d0                	mov    %edx,%eax
c0103281:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c0103284:	73 31                	jae    c01032b7 <page_init+0x385>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
c0103286:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0103289:	8b 55 cc             	mov    -0x34(%ebp),%edx
c010328c:	2b 45 d0             	sub    -0x30(%ebp),%eax
c010328f:	1b 55 d4             	sbb    -0x2c(%ebp),%edx
c0103292:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0103296:	c1 ea 0c             	shr    $0xc,%edx
c0103299:	89 c3                	mov    %eax,%ebx
c010329b:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010329e:	83 ec 0c             	sub    $0xc,%esp
c01032a1:	50                   	push   %eax
c01032a2:	e8 07 f9 ff ff       	call   c0102bae <pa2page>
c01032a7:	83 c4 10             	add    $0x10,%esp
c01032aa:	83 ec 08             	sub    $0x8,%esp
c01032ad:	53                   	push   %ebx
c01032ae:	50                   	push   %eax
c01032af:	e8 ae fb ff ff       	call   c0102e62 <init_memmap>
c01032b4:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < memmap->nr_map; i ++) {
c01032b7:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
c01032bb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c01032be:	8b 00                	mov    (%eax),%eax
c01032c0:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c01032c3:	0f 8c 9f fe ff ff    	jl     c0103168 <page_init+0x236>
                }
            }
        }
    }
}
c01032c9:	90                   	nop
c01032ca:	90                   	nop
c01032cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
c01032ce:	5b                   	pop    %ebx
c01032cf:	5e                   	pop    %esi
c01032d0:	5f                   	pop    %edi
c01032d1:	5d                   	pop    %ebp
c01032d2:	c3                   	ret    

c01032d3 <enable_paging>:

static void
enable_paging(void) {
c01032d3:	f3 0f 1e fb          	endbr32 
c01032d7:	55                   	push   %ebp
c01032d8:	89 e5                	mov    %esp,%ebp
c01032da:	83 ec 10             	sub    $0x10,%esp
    lcr3(boot_cr3);
c01032dd:	a1 14 cf 11 c0       	mov    0xc011cf14,%eax
c01032e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile ("mov %0, %%cr3" :: "r" (cr3) : "memory");
c01032e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01032e8:	0f 22 d8             	mov    %eax,%cr3
}
c01032eb:	90                   	nop
    asm volatile ("mov %%cr0, %0" : "=r" (cr0) :: "memory");
c01032ec:	0f 20 c0             	mov    %cr0,%eax
c01032ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return cr0;
c01032f2:	8b 45 f4             	mov    -0xc(%ebp),%eax

    // turn on paging
    uint32_t cr0 = rcr0();
c01032f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
    cr0 |= CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP;
c01032f8:	81 4d fc 2f 00 05 80 	orl    $0x8005002f,-0x4(%ebp)
    cr0 &= ~(CR0_TS | CR0_EM);
c01032ff:	83 65 fc f3          	andl   $0xfffffff3,-0x4(%ebp)
c0103303:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0103306:	89 45 f8             	mov    %eax,-0x8(%ebp)
    asm volatile ("mov %0, %%cr0" :: "r" (cr0) : "memory");
c0103309:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010330c:	0f 22 c0             	mov    %eax,%cr0
}
c010330f:	90                   	nop
    lcr0(cr0);
}
c0103310:	90                   	nop
c0103311:	c9                   	leave  
c0103312:	c3                   	ret    

c0103313 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
c0103313:	f3 0f 1e fb          	endbr32 
c0103317:	55                   	push   %ebp
c0103318:	89 e5                	mov    %esp,%ebp
c010331a:	83 ec 28             	sub    $0x28,%esp
    assert(PGOFF(la) == PGOFF(pa));
c010331d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103320:	33 45 14             	xor    0x14(%ebp),%eax
c0103323:	25 ff 0f 00 00       	and    $0xfff,%eax
c0103328:	85 c0                	test   %eax,%eax
c010332a:	74 19                	je     c0103345 <boot_map_segment+0x32>
c010332c:	68 56 65 10 c0       	push   $0xc0106556
c0103331:	68 6d 65 10 c0       	push   $0xc010656d
c0103336:	68 04 01 00 00       	push   $0x104
c010333b:	68 48 65 10 c0       	push   $0xc0106548
c0103340:	e8 da d0 ff ff       	call   c010041f <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
c0103345:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
c010334c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010334f:	25 ff 0f 00 00       	and    $0xfff,%eax
c0103354:	89 c2                	mov    %eax,%edx
c0103356:	8b 45 10             	mov    0x10(%ebp),%eax
c0103359:	01 c2                	add    %eax,%edx
c010335b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010335e:	01 d0                	add    %edx,%eax
c0103360:	83 e8 01             	sub    $0x1,%eax
c0103363:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0103366:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103369:	ba 00 00 00 00       	mov    $0x0,%edx
c010336e:	f7 75 f0             	divl   -0x10(%ebp)
c0103371:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103374:	29 d0                	sub    %edx,%eax
c0103376:	c1 e8 0c             	shr    $0xc,%eax
c0103379:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
c010337c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010337f:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0103382:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103385:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c010338a:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
c010338d:	8b 45 14             	mov    0x14(%ebp),%eax
c0103390:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103393:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103396:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c010339b:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c010339e:	eb 57                	jmp    c01033f7 <boot_map_segment+0xe4>
        pte_t *ptep = get_pte(pgdir, la, 1);
c01033a0:	83 ec 04             	sub    $0x4,%esp
c01033a3:	6a 01                	push   $0x1
c01033a5:	ff 75 0c             	pushl  0xc(%ebp)
c01033a8:	ff 75 08             	pushl  0x8(%ebp)
c01033ab:	e8 a1 01 00 00       	call   c0103551 <get_pte>
c01033b0:	83 c4 10             	add    $0x10,%esp
c01033b3:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
c01033b6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c01033ba:	75 19                	jne    c01033d5 <boot_map_segment+0xc2>
c01033bc:	68 82 65 10 c0       	push   $0xc0106582
c01033c1:	68 6d 65 10 c0       	push   $0xc010656d
c01033c6:	68 0a 01 00 00       	push   $0x10a
c01033cb:	68 48 65 10 c0       	push   $0xc0106548
c01033d0:	e8 4a d0 ff ff       	call   c010041f <__panic>
        *ptep = pa | PTE_P | perm;
c01033d5:	8b 45 14             	mov    0x14(%ebp),%eax
c01033d8:	0b 45 18             	or     0x18(%ebp),%eax
c01033db:	83 c8 01             	or     $0x1,%eax
c01033de:	89 c2                	mov    %eax,%edx
c01033e0:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01033e3:	89 10                	mov    %edx,(%eax)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c01033e5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01033e9:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
c01033f0:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
c01033f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01033fb:	75 a3                	jne    c01033a0 <boot_map_segment+0x8d>
    }
}
c01033fd:	90                   	nop
c01033fe:	90                   	nop
c01033ff:	c9                   	leave  
c0103400:	c3                   	ret    

c0103401 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
c0103401:	f3 0f 1e fb          	endbr32 
c0103405:	55                   	push   %ebp
c0103406:	89 e5                	mov    %esp,%ebp
c0103408:	83 ec 18             	sub    $0x18,%esp
    struct Page *p = alloc_page();
c010340b:	83 ec 0c             	sub    $0xc,%esp
c010340e:	6a 01                	push   $0x1
c0103410:	e8 70 fa ff ff       	call   c0102e85 <alloc_pages>
c0103415:	83 c4 10             	add    $0x10,%esp
c0103418:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
c010341b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010341f:	75 17                	jne    c0103438 <boot_alloc_page+0x37>
        panic("boot_alloc_page failed.\n");
c0103421:	83 ec 04             	sub    $0x4,%esp
c0103424:	68 8f 65 10 c0       	push   $0xc010658f
c0103429:	68 16 01 00 00       	push   $0x116
c010342e:	68 48 65 10 c0       	push   $0xc0106548
c0103433:	e8 e7 cf ff ff       	call   c010041f <__panic>
    }
    return page2kva(p);
c0103438:	83 ec 0c             	sub    $0xc,%esp
c010343b:	ff 75 f4             	pushl  -0xc(%ebp)
c010343e:	e8 b2 f7 ff ff       	call   c0102bf5 <page2kva>
c0103443:	83 c4 10             	add    $0x10,%esp
}
c0103446:	c9                   	leave  
c0103447:	c3                   	ret    

c0103448 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
c0103448:	f3 0f 1e fb          	endbr32 
c010344c:	55                   	push   %ebp
c010344d:	89 e5                	mov    %esp,%ebp
c010344f:	83 ec 18             	sub    $0x18,%esp
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
c0103452:	e8 d2 f9 ff ff       	call   c0102e29 <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
c0103457:	e8 d6 fa ff ff       	call   c0102f32 <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
c010345c:	e8 9a 02 00 00       	call   c01036fb <check_alloc_page>

    // create boot_pgdir, an initial page directory(Page Directory Table, PDT)
    boot_pgdir = boot_alloc_page();
c0103461:	e8 9b ff ff ff       	call   c0103401 <boot_alloc_page>
c0103466:	a3 84 ce 11 c0       	mov    %eax,0xc011ce84
    memset(boot_pgdir, 0, PGSIZE);
c010346b:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103470:	83 ec 04             	sub    $0x4,%esp
c0103473:	68 00 10 00 00       	push   $0x1000
c0103478:	6a 00                	push   $0x0
c010347a:	50                   	push   %eax
c010347b:	e8 dc 20 00 00       	call   c010555c <memset>
c0103480:	83 c4 10             	add    $0x10,%esp
    boot_cr3 = PADDR(boot_pgdir);
c0103483:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103488:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010348b:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0103492:	77 17                	ja     c01034ab <pmm_init+0x63>
c0103494:	ff 75 f4             	pushl  -0xc(%ebp)
c0103497:	68 24 65 10 c0       	push   $0xc0106524
c010349c:	68 30 01 00 00       	push   $0x130
c01034a1:	68 48 65 10 c0       	push   $0xc0106548
c01034a6:	e8 74 cf ff ff       	call   c010041f <__panic>
c01034ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01034ae:	05 00 00 00 40       	add    $0x40000000,%eax
c01034b3:	a3 14 cf 11 c0       	mov    %eax,0xc011cf14

    check_pgdir();
c01034b8:	e8 65 02 00 00       	call   c0103722 <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
c01034bd:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c01034c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01034c5:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c01034cc:	77 17                	ja     c01034e5 <pmm_init+0x9d>
c01034ce:	ff 75 f0             	pushl  -0x10(%ebp)
c01034d1:	68 24 65 10 c0       	push   $0xc0106524
c01034d6:	68 38 01 00 00       	push   $0x138
c01034db:	68 48 65 10 c0       	push   $0xc0106548
c01034e0:	e8 3a cf ff ff       	call   c010041f <__panic>
c01034e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01034e8:	8d 90 00 00 00 40    	lea    0x40000000(%eax),%edx
c01034ee:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c01034f3:	05 ac 0f 00 00       	add    $0xfac,%eax
c01034f8:	83 ca 03             	or     $0x3,%edx
c01034fb:	89 10                	mov    %edx,(%eax)

    // map all physical memory to linear memory with base linear addr KERNBASE
    //linear_addr KERNBASE~KERNBASE+KMEMSIZE = phy_addr 0~KMEMSIZE
    //But shouldn't use this map until enable_paging() & gdt_init() finished.
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
c01034fd:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103502:	83 ec 0c             	sub    $0xc,%esp
c0103505:	6a 02                	push   $0x2
c0103507:	6a 00                	push   $0x0
c0103509:	68 00 00 00 38       	push   $0x38000000
c010350e:	68 00 00 00 c0       	push   $0xc0000000
c0103513:	50                   	push   %eax
c0103514:	e8 fa fd ff ff       	call   c0103313 <boot_map_segment>
c0103519:	83 c4 20             	add    $0x20,%esp

    //temporary map: 
    //virtual_addr 3G~3G+4M = linear_addr 0~4M = linear_addr 3G~3G+4M = phy_addr 0~4M     
    boot_pgdir[0] = boot_pgdir[PDX(KERNBASE)];
c010351c:	8b 15 84 ce 11 c0    	mov    0xc011ce84,%edx
c0103522:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103527:	8b 92 00 0c 00 00    	mov    0xc00(%edx),%edx
c010352d:	89 10                	mov    %edx,(%eax)

    enable_paging();
c010352f:	e8 9f fd ff ff       	call   c01032d3 <enable_paging>

    //reload gdt(third time,the last time) to map all physical memory
    //virtual_addr 0~4G=liear_addr 0~4G
    //then set kernel stack(ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
c0103534:	e8 f9 f7 ff ff       	call   c0102d32 <gdt_init>

    //disable the map of virtual_addr 0~4M
    boot_pgdir[0] = 0;
c0103539:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c010353e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
c0103544:	e8 43 07 00 00       	call   c0103c8c <check_boot_pgdir>

    print_pgdir();
c0103549:	e8 4a 0b 00 00       	call   c0104098 <print_pgdir>

}
c010354e:	90                   	nop
c010354f:	c9                   	leave  
c0103550:	c3                   	ret    

c0103551 <get_pte>:
//  pgdir:  the kernel virtual base address of PDT
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
c0103551:	f3 0f 1e fb          	endbr32 
c0103555:	55                   	push   %ebp
c0103556:	89 e5                	mov    %esp,%ebp
                          // (6) clear page content using memset
                          // (7) set page directory entry's permission
    }
    return NULL;          // (8) return page table entry
#endif
}
c0103558:	90                   	nop
c0103559:	5d                   	pop    %ebp
c010355a:	c3                   	ret    

c010355b <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
c010355b:	f3 0f 1e fb          	endbr32 
c010355f:	55                   	push   %ebp
c0103560:	89 e5                	mov    %esp,%ebp
c0103562:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c0103565:	6a 00                	push   $0x0
c0103567:	ff 75 0c             	pushl  0xc(%ebp)
c010356a:	ff 75 08             	pushl  0x8(%ebp)
c010356d:	e8 df ff ff ff       	call   c0103551 <get_pte>
c0103572:	83 c4 0c             	add    $0xc,%esp
c0103575:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
c0103578:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c010357c:	74 08                	je     c0103586 <get_page+0x2b>
        *ptep_store = ptep;
c010357e:	8b 45 10             	mov    0x10(%ebp),%eax
c0103581:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103584:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
c0103586:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010358a:	74 1f                	je     c01035ab <get_page+0x50>
c010358c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010358f:	8b 00                	mov    (%eax),%eax
c0103591:	83 e0 01             	and    $0x1,%eax
c0103594:	85 c0                	test   %eax,%eax
c0103596:	74 13                	je     c01035ab <get_page+0x50>
        return pa2page(*ptep);
c0103598:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010359b:	8b 00                	mov    (%eax),%eax
c010359d:	83 ec 0c             	sub    $0xc,%esp
c01035a0:	50                   	push   %eax
c01035a1:	e8 08 f6 ff ff       	call   c0102bae <pa2page>
c01035a6:	83 c4 10             	add    $0x10,%esp
c01035a9:	eb 05                	jmp    c01035b0 <get_page+0x55>
    }
    return NULL;
c01035ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01035b0:	c9                   	leave  
c01035b1:	c3                   	ret    

c01035b2 <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
c01035b2:	55                   	push   %ebp
c01035b3:	89 e5                	mov    %esp,%ebp
                                  //(4) and free this page when page reference reachs 0
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif
}
c01035b5:	90                   	nop
c01035b6:	5d                   	pop    %ebp
c01035b7:	c3                   	ret    

c01035b8 <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
c01035b8:	f3 0f 1e fb          	endbr32 
c01035bc:	55                   	push   %ebp
c01035bd:	89 e5                	mov    %esp,%ebp
c01035bf:	83 ec 10             	sub    $0x10,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c01035c2:	6a 00                	push   $0x0
c01035c4:	ff 75 0c             	pushl  0xc(%ebp)
c01035c7:	ff 75 08             	pushl  0x8(%ebp)
c01035ca:	e8 82 ff ff ff       	call   c0103551 <get_pte>
c01035cf:	83 c4 0c             	add    $0xc,%esp
c01035d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (ptep != NULL) {
c01035d5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c01035d9:	74 11                	je     c01035ec <page_remove+0x34>
        page_remove_pte(pgdir, la, ptep);
c01035db:	ff 75 fc             	pushl  -0x4(%ebp)
c01035de:	ff 75 0c             	pushl  0xc(%ebp)
c01035e1:	ff 75 08             	pushl  0x8(%ebp)
c01035e4:	e8 c9 ff ff ff       	call   c01035b2 <page_remove_pte>
c01035e9:	83 c4 0c             	add    $0xc,%esp
    }
}
c01035ec:	90                   	nop
c01035ed:	c9                   	leave  
c01035ee:	c3                   	ret    

c01035ef <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
c01035ef:	f3 0f 1e fb          	endbr32 
c01035f3:	55                   	push   %ebp
c01035f4:	89 e5                	mov    %esp,%ebp
c01035f6:	83 ec 18             	sub    $0x18,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
c01035f9:	6a 01                	push   $0x1
c01035fb:	ff 75 10             	pushl  0x10(%ebp)
c01035fe:	ff 75 08             	pushl  0x8(%ebp)
c0103601:	e8 4b ff ff ff       	call   c0103551 <get_pte>
c0103606:	83 c4 0c             	add    $0xc,%esp
c0103609:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
c010360c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0103610:	75 0a                	jne    c010361c <page_insert+0x2d>
        return -E_NO_MEM;
c0103612:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
c0103617:	e9 88 00 00 00       	jmp    c01036a4 <page_insert+0xb5>
    }
    page_ref_inc(page);
c010361c:	ff 75 0c             	pushl  0xc(%ebp)
c010361f:	e8 5a f6 ff ff       	call   c0102c7e <page_ref_inc>
c0103624:	83 c4 04             	add    $0x4,%esp
    if (*ptep & PTE_P) {
c0103627:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010362a:	8b 00                	mov    (%eax),%eax
c010362c:	83 e0 01             	and    $0x1,%eax
c010362f:	85 c0                	test   %eax,%eax
c0103631:	74 40                	je     c0103673 <page_insert+0x84>
        struct Page *p = pte2page(*ptep);
c0103633:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103636:	8b 00                	mov    (%eax),%eax
c0103638:	83 ec 0c             	sub    $0xc,%esp
c010363b:	50                   	push   %eax
c010363c:	e8 f9 f5 ff ff       	call   c0102c3a <pte2page>
c0103641:	83 c4 10             	add    $0x10,%esp
c0103644:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
c0103647:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010364a:	3b 45 0c             	cmp    0xc(%ebp),%eax
c010364d:	75 10                	jne    c010365f <page_insert+0x70>
            page_ref_dec(page);
c010364f:	83 ec 0c             	sub    $0xc,%esp
c0103652:	ff 75 0c             	pushl  0xc(%ebp)
c0103655:	e8 3b f6 ff ff       	call   c0102c95 <page_ref_dec>
c010365a:	83 c4 10             	add    $0x10,%esp
c010365d:	eb 14                	jmp    c0103673 <page_insert+0x84>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
c010365f:	83 ec 04             	sub    $0x4,%esp
c0103662:	ff 75 f4             	pushl  -0xc(%ebp)
c0103665:	ff 75 10             	pushl  0x10(%ebp)
c0103668:	ff 75 08             	pushl  0x8(%ebp)
c010366b:	e8 42 ff ff ff       	call   c01035b2 <page_remove_pte>
c0103670:	83 c4 10             	add    $0x10,%esp
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
c0103673:	83 ec 0c             	sub    $0xc,%esp
c0103676:	ff 75 0c             	pushl  0xc(%ebp)
c0103679:	e8 1d f5 ff ff       	call   c0102b9b <page2pa>
c010367e:	83 c4 10             	add    $0x10,%esp
c0103681:	0b 45 14             	or     0x14(%ebp),%eax
c0103684:	83 c8 01             	or     $0x1,%eax
c0103687:	89 c2                	mov    %eax,%edx
c0103689:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010368c:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
c010368e:	83 ec 08             	sub    $0x8,%esp
c0103691:	ff 75 10             	pushl  0x10(%ebp)
c0103694:	ff 75 08             	pushl  0x8(%ebp)
c0103697:	e8 0a 00 00 00       	call   c01036a6 <tlb_invalidate>
c010369c:	83 c4 10             	add    $0x10,%esp
    return 0;
c010369f:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01036a4:	c9                   	leave  
c01036a5:	c3                   	ret    

c01036a6 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
c01036a6:	f3 0f 1e fb          	endbr32 
c01036aa:	55                   	push   %ebp
c01036ab:	89 e5                	mov    %esp,%ebp
c01036ad:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
c01036b0:	0f 20 d8             	mov    %cr3,%eax
c01036b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
c01036b6:	8b 55 f0             	mov    -0x10(%ebp),%edx
    if (rcr3() == PADDR(pgdir)) {
c01036b9:	8b 45 08             	mov    0x8(%ebp),%eax
c01036bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01036bf:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c01036c6:	77 17                	ja     c01036df <tlb_invalidate+0x39>
c01036c8:	ff 75 f4             	pushl  -0xc(%ebp)
c01036cb:	68 24 65 10 c0       	push   $0xc0106524
c01036d0:	68 d8 01 00 00       	push   $0x1d8
c01036d5:	68 48 65 10 c0       	push   $0xc0106548
c01036da:	e8 40 cd ff ff       	call   c010041f <__panic>
c01036df:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01036e2:	05 00 00 00 40       	add    $0x40000000,%eax
c01036e7:	39 d0                	cmp    %edx,%eax
c01036e9:	75 0d                	jne    c01036f8 <tlb_invalidate+0x52>
        invlpg((void *)la);
c01036eb:	8b 45 0c             	mov    0xc(%ebp),%eax
c01036ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
c01036f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01036f4:	0f 01 38             	invlpg (%eax)
}
c01036f7:	90                   	nop
    }
}
c01036f8:	90                   	nop
c01036f9:	c9                   	leave  
c01036fa:	c3                   	ret    

c01036fb <check_alloc_page>:

static void
check_alloc_page(void) {
c01036fb:	f3 0f 1e fb          	endbr32 
c01036ff:	55                   	push   %ebp
c0103700:	89 e5                	mov    %esp,%ebp
c0103702:	83 ec 08             	sub    $0x8,%esp
    pmm_manager->check();
c0103705:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c010370a:	8b 40 18             	mov    0x18(%eax),%eax
c010370d:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
c010370f:	83 ec 0c             	sub    $0xc,%esp
c0103712:	68 a8 65 10 c0       	push   $0xc01065a8
c0103717:	e8 88 cb ff ff       	call   c01002a4 <cprintf>
c010371c:	83 c4 10             	add    $0x10,%esp
}
c010371f:	90                   	nop
c0103720:	c9                   	leave  
c0103721:	c3                   	ret    

c0103722 <check_pgdir>:

static void
check_pgdir(void) {
c0103722:	f3 0f 1e fb          	endbr32 
c0103726:	55                   	push   %ebp
c0103727:	89 e5                	mov    %esp,%ebp
c0103729:	83 ec 28             	sub    $0x28,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
c010372c:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103731:	3d 00 80 03 00       	cmp    $0x38000,%eax
c0103736:	76 19                	jbe    c0103751 <check_pgdir+0x2f>
c0103738:	68 c7 65 10 c0       	push   $0xc01065c7
c010373d:	68 6d 65 10 c0       	push   $0xc010656d
c0103742:	68 e5 01 00 00       	push   $0x1e5
c0103747:	68 48 65 10 c0       	push   $0xc0106548
c010374c:	e8 ce cc ff ff       	call   c010041f <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
c0103751:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103756:	85 c0                	test   %eax,%eax
c0103758:	74 0e                	je     c0103768 <check_pgdir+0x46>
c010375a:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c010375f:	25 ff 0f 00 00       	and    $0xfff,%eax
c0103764:	85 c0                	test   %eax,%eax
c0103766:	74 19                	je     c0103781 <check_pgdir+0x5f>
c0103768:	68 e4 65 10 c0       	push   $0xc01065e4
c010376d:	68 6d 65 10 c0       	push   $0xc010656d
c0103772:	68 e6 01 00 00       	push   $0x1e6
c0103777:	68 48 65 10 c0       	push   $0xc0106548
c010377c:	e8 9e cc ff ff       	call   c010041f <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
c0103781:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103786:	83 ec 04             	sub    $0x4,%esp
c0103789:	6a 00                	push   $0x0
c010378b:	6a 00                	push   $0x0
c010378d:	50                   	push   %eax
c010378e:	e8 c8 fd ff ff       	call   c010355b <get_page>
c0103793:	83 c4 10             	add    $0x10,%esp
c0103796:	85 c0                	test   %eax,%eax
c0103798:	74 19                	je     c01037b3 <check_pgdir+0x91>
c010379a:	68 1c 66 10 c0       	push   $0xc010661c
c010379f:	68 6d 65 10 c0       	push   $0xc010656d
c01037a4:	68 e7 01 00 00       	push   $0x1e7
c01037a9:	68 48 65 10 c0       	push   $0xc0106548
c01037ae:	e8 6c cc ff ff       	call   c010041f <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
c01037b3:	83 ec 0c             	sub    $0xc,%esp
c01037b6:	6a 01                	push   $0x1
c01037b8:	e8 c8 f6 ff ff       	call   c0102e85 <alloc_pages>
c01037bd:	83 c4 10             	add    $0x10,%esp
c01037c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
c01037c3:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c01037c8:	6a 00                	push   $0x0
c01037ca:	6a 00                	push   $0x0
c01037cc:	ff 75 f4             	pushl  -0xc(%ebp)
c01037cf:	50                   	push   %eax
c01037d0:	e8 1a fe ff ff       	call   c01035ef <page_insert>
c01037d5:	83 c4 10             	add    $0x10,%esp
c01037d8:	85 c0                	test   %eax,%eax
c01037da:	74 19                	je     c01037f5 <check_pgdir+0xd3>
c01037dc:	68 44 66 10 c0       	push   $0xc0106644
c01037e1:	68 6d 65 10 c0       	push   $0xc010656d
c01037e6:	68 eb 01 00 00       	push   $0x1eb
c01037eb:	68 48 65 10 c0       	push   $0xc0106548
c01037f0:	e8 2a cc ff ff       	call   c010041f <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
c01037f5:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c01037fa:	83 ec 04             	sub    $0x4,%esp
c01037fd:	6a 00                	push   $0x0
c01037ff:	6a 00                	push   $0x0
c0103801:	50                   	push   %eax
c0103802:	e8 4a fd ff ff       	call   c0103551 <get_pte>
c0103807:	83 c4 10             	add    $0x10,%esp
c010380a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010380d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103811:	75 19                	jne    c010382c <check_pgdir+0x10a>
c0103813:	68 70 66 10 c0       	push   $0xc0106670
c0103818:	68 6d 65 10 c0       	push   $0xc010656d
c010381d:	68 ee 01 00 00       	push   $0x1ee
c0103822:	68 48 65 10 c0       	push   $0xc0106548
c0103827:	e8 f3 cb ff ff       	call   c010041f <__panic>
    assert(pa2page(*ptep) == p1);
c010382c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010382f:	8b 00                	mov    (%eax),%eax
c0103831:	83 ec 0c             	sub    $0xc,%esp
c0103834:	50                   	push   %eax
c0103835:	e8 74 f3 ff ff       	call   c0102bae <pa2page>
c010383a:	83 c4 10             	add    $0x10,%esp
c010383d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0103840:	74 19                	je     c010385b <check_pgdir+0x139>
c0103842:	68 9d 66 10 c0       	push   $0xc010669d
c0103847:	68 6d 65 10 c0       	push   $0xc010656d
c010384c:	68 ef 01 00 00       	push   $0x1ef
c0103851:	68 48 65 10 c0       	push   $0xc0106548
c0103856:	e8 c4 cb ff ff       	call   c010041f <__panic>
    assert(page_ref(p1) == 1);
c010385b:	83 ec 0c             	sub    $0xc,%esp
c010385e:	ff 75 f4             	pushl  -0xc(%ebp)
c0103861:	e8 0e f4 ff ff       	call   c0102c74 <page_ref>
c0103866:	83 c4 10             	add    $0x10,%esp
c0103869:	83 f8 01             	cmp    $0x1,%eax
c010386c:	74 19                	je     c0103887 <check_pgdir+0x165>
c010386e:	68 b2 66 10 c0       	push   $0xc01066b2
c0103873:	68 6d 65 10 c0       	push   $0xc010656d
c0103878:	68 f0 01 00 00       	push   $0x1f0
c010387d:	68 48 65 10 c0       	push   $0xc0106548
c0103882:	e8 98 cb ff ff       	call   c010041f <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
c0103887:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c010388c:	8b 00                	mov    (%eax),%eax
c010388e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103893:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0103896:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103899:	c1 e8 0c             	shr    $0xc,%eax
c010389c:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010389f:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c01038a4:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c01038a7:	72 17                	jb     c01038c0 <check_pgdir+0x19e>
c01038a9:	ff 75 ec             	pushl  -0x14(%ebp)
c01038ac:	68 80 64 10 c0       	push   $0xc0106480
c01038b1:	68 f2 01 00 00       	push   $0x1f2
c01038b6:	68 48 65 10 c0       	push   $0xc0106548
c01038bb:	e8 5f cb ff ff       	call   c010041f <__panic>
c01038c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01038c3:	2d 00 00 00 40       	sub    $0x40000000,%eax
c01038c8:	83 c0 04             	add    $0x4,%eax
c01038cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
c01038ce:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c01038d3:	83 ec 04             	sub    $0x4,%esp
c01038d6:	6a 00                	push   $0x0
c01038d8:	68 00 10 00 00       	push   $0x1000
c01038dd:	50                   	push   %eax
c01038de:	e8 6e fc ff ff       	call   c0103551 <get_pte>
c01038e3:	83 c4 10             	add    $0x10,%esp
c01038e6:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c01038e9:	74 19                	je     c0103904 <check_pgdir+0x1e2>
c01038eb:	68 c4 66 10 c0       	push   $0xc01066c4
c01038f0:	68 6d 65 10 c0       	push   $0xc010656d
c01038f5:	68 f3 01 00 00       	push   $0x1f3
c01038fa:	68 48 65 10 c0       	push   $0xc0106548
c01038ff:	e8 1b cb ff ff       	call   c010041f <__panic>

    p2 = alloc_page();
c0103904:	83 ec 0c             	sub    $0xc,%esp
c0103907:	6a 01                	push   $0x1
c0103909:	e8 77 f5 ff ff       	call   c0102e85 <alloc_pages>
c010390e:	83 c4 10             	add    $0x10,%esp
c0103911:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
c0103914:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103919:	6a 06                	push   $0x6
c010391b:	68 00 10 00 00       	push   $0x1000
c0103920:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103923:	50                   	push   %eax
c0103924:	e8 c6 fc ff ff       	call   c01035ef <page_insert>
c0103929:	83 c4 10             	add    $0x10,%esp
c010392c:	85 c0                	test   %eax,%eax
c010392e:	74 19                	je     c0103949 <check_pgdir+0x227>
c0103930:	68 ec 66 10 c0       	push   $0xc01066ec
c0103935:	68 6d 65 10 c0       	push   $0xc010656d
c010393a:	68 f6 01 00 00       	push   $0x1f6
c010393f:	68 48 65 10 c0       	push   $0xc0106548
c0103944:	e8 d6 ca ff ff       	call   c010041f <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0103949:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c010394e:	83 ec 04             	sub    $0x4,%esp
c0103951:	6a 00                	push   $0x0
c0103953:	68 00 10 00 00       	push   $0x1000
c0103958:	50                   	push   %eax
c0103959:	e8 f3 fb ff ff       	call   c0103551 <get_pte>
c010395e:	83 c4 10             	add    $0x10,%esp
c0103961:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103964:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103968:	75 19                	jne    c0103983 <check_pgdir+0x261>
c010396a:	68 24 67 10 c0       	push   $0xc0106724
c010396f:	68 6d 65 10 c0       	push   $0xc010656d
c0103974:	68 f7 01 00 00       	push   $0x1f7
c0103979:	68 48 65 10 c0       	push   $0xc0106548
c010397e:	e8 9c ca ff ff       	call   c010041f <__panic>
    assert(*ptep & PTE_U);
c0103983:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103986:	8b 00                	mov    (%eax),%eax
c0103988:	83 e0 04             	and    $0x4,%eax
c010398b:	85 c0                	test   %eax,%eax
c010398d:	75 19                	jne    c01039a8 <check_pgdir+0x286>
c010398f:	68 54 67 10 c0       	push   $0xc0106754
c0103994:	68 6d 65 10 c0       	push   $0xc010656d
c0103999:	68 f8 01 00 00       	push   $0x1f8
c010399e:	68 48 65 10 c0       	push   $0xc0106548
c01039a3:	e8 77 ca ff ff       	call   c010041f <__panic>
    assert(*ptep & PTE_W);
c01039a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01039ab:	8b 00                	mov    (%eax),%eax
c01039ad:	83 e0 02             	and    $0x2,%eax
c01039b0:	85 c0                	test   %eax,%eax
c01039b2:	75 19                	jne    c01039cd <check_pgdir+0x2ab>
c01039b4:	68 62 67 10 c0       	push   $0xc0106762
c01039b9:	68 6d 65 10 c0       	push   $0xc010656d
c01039be:	68 f9 01 00 00       	push   $0x1f9
c01039c3:	68 48 65 10 c0       	push   $0xc0106548
c01039c8:	e8 52 ca ff ff       	call   c010041f <__panic>
    assert(boot_pgdir[0] & PTE_U);
c01039cd:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c01039d2:	8b 00                	mov    (%eax),%eax
c01039d4:	83 e0 04             	and    $0x4,%eax
c01039d7:	85 c0                	test   %eax,%eax
c01039d9:	75 19                	jne    c01039f4 <check_pgdir+0x2d2>
c01039db:	68 70 67 10 c0       	push   $0xc0106770
c01039e0:	68 6d 65 10 c0       	push   $0xc010656d
c01039e5:	68 fa 01 00 00       	push   $0x1fa
c01039ea:	68 48 65 10 c0       	push   $0xc0106548
c01039ef:	e8 2b ca ff ff       	call   c010041f <__panic>
    assert(page_ref(p2) == 1);
c01039f4:	83 ec 0c             	sub    $0xc,%esp
c01039f7:	ff 75 e4             	pushl  -0x1c(%ebp)
c01039fa:	e8 75 f2 ff ff       	call   c0102c74 <page_ref>
c01039ff:	83 c4 10             	add    $0x10,%esp
c0103a02:	83 f8 01             	cmp    $0x1,%eax
c0103a05:	74 19                	je     c0103a20 <check_pgdir+0x2fe>
c0103a07:	68 86 67 10 c0       	push   $0xc0106786
c0103a0c:	68 6d 65 10 c0       	push   $0xc010656d
c0103a11:	68 fb 01 00 00       	push   $0x1fb
c0103a16:	68 48 65 10 c0       	push   $0xc0106548
c0103a1b:	e8 ff c9 ff ff       	call   c010041f <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
c0103a20:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103a25:	6a 00                	push   $0x0
c0103a27:	68 00 10 00 00       	push   $0x1000
c0103a2c:	ff 75 f4             	pushl  -0xc(%ebp)
c0103a2f:	50                   	push   %eax
c0103a30:	e8 ba fb ff ff       	call   c01035ef <page_insert>
c0103a35:	83 c4 10             	add    $0x10,%esp
c0103a38:	85 c0                	test   %eax,%eax
c0103a3a:	74 19                	je     c0103a55 <check_pgdir+0x333>
c0103a3c:	68 98 67 10 c0       	push   $0xc0106798
c0103a41:	68 6d 65 10 c0       	push   $0xc010656d
c0103a46:	68 fd 01 00 00       	push   $0x1fd
c0103a4b:	68 48 65 10 c0       	push   $0xc0106548
c0103a50:	e8 ca c9 ff ff       	call   c010041f <__panic>
    assert(page_ref(p1) == 2);
c0103a55:	83 ec 0c             	sub    $0xc,%esp
c0103a58:	ff 75 f4             	pushl  -0xc(%ebp)
c0103a5b:	e8 14 f2 ff ff       	call   c0102c74 <page_ref>
c0103a60:	83 c4 10             	add    $0x10,%esp
c0103a63:	83 f8 02             	cmp    $0x2,%eax
c0103a66:	74 19                	je     c0103a81 <check_pgdir+0x35f>
c0103a68:	68 c4 67 10 c0       	push   $0xc01067c4
c0103a6d:	68 6d 65 10 c0       	push   $0xc010656d
c0103a72:	68 fe 01 00 00       	push   $0x1fe
c0103a77:	68 48 65 10 c0       	push   $0xc0106548
c0103a7c:	e8 9e c9 ff ff       	call   c010041f <__panic>
    assert(page_ref(p2) == 0);
c0103a81:	83 ec 0c             	sub    $0xc,%esp
c0103a84:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103a87:	e8 e8 f1 ff ff       	call   c0102c74 <page_ref>
c0103a8c:	83 c4 10             	add    $0x10,%esp
c0103a8f:	85 c0                	test   %eax,%eax
c0103a91:	74 19                	je     c0103aac <check_pgdir+0x38a>
c0103a93:	68 d6 67 10 c0       	push   $0xc01067d6
c0103a98:	68 6d 65 10 c0       	push   $0xc010656d
c0103a9d:	68 ff 01 00 00       	push   $0x1ff
c0103aa2:	68 48 65 10 c0       	push   $0xc0106548
c0103aa7:	e8 73 c9 ff ff       	call   c010041f <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0103aac:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103ab1:	83 ec 04             	sub    $0x4,%esp
c0103ab4:	6a 00                	push   $0x0
c0103ab6:	68 00 10 00 00       	push   $0x1000
c0103abb:	50                   	push   %eax
c0103abc:	e8 90 fa ff ff       	call   c0103551 <get_pte>
c0103ac1:	83 c4 10             	add    $0x10,%esp
c0103ac4:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103ac7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103acb:	75 19                	jne    c0103ae6 <check_pgdir+0x3c4>
c0103acd:	68 24 67 10 c0       	push   $0xc0106724
c0103ad2:	68 6d 65 10 c0       	push   $0xc010656d
c0103ad7:	68 00 02 00 00       	push   $0x200
c0103adc:	68 48 65 10 c0       	push   $0xc0106548
c0103ae1:	e8 39 c9 ff ff       	call   c010041f <__panic>
    assert(pa2page(*ptep) == p1);
c0103ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103ae9:	8b 00                	mov    (%eax),%eax
c0103aeb:	83 ec 0c             	sub    $0xc,%esp
c0103aee:	50                   	push   %eax
c0103aef:	e8 ba f0 ff ff       	call   c0102bae <pa2page>
c0103af4:	83 c4 10             	add    $0x10,%esp
c0103af7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0103afa:	74 19                	je     c0103b15 <check_pgdir+0x3f3>
c0103afc:	68 9d 66 10 c0       	push   $0xc010669d
c0103b01:	68 6d 65 10 c0       	push   $0xc010656d
c0103b06:	68 01 02 00 00       	push   $0x201
c0103b0b:	68 48 65 10 c0       	push   $0xc0106548
c0103b10:	e8 0a c9 ff ff       	call   c010041f <__panic>
    assert((*ptep & PTE_U) == 0);
c0103b15:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103b18:	8b 00                	mov    (%eax),%eax
c0103b1a:	83 e0 04             	and    $0x4,%eax
c0103b1d:	85 c0                	test   %eax,%eax
c0103b1f:	74 19                	je     c0103b3a <check_pgdir+0x418>
c0103b21:	68 e8 67 10 c0       	push   $0xc01067e8
c0103b26:	68 6d 65 10 c0       	push   $0xc010656d
c0103b2b:	68 02 02 00 00       	push   $0x202
c0103b30:	68 48 65 10 c0       	push   $0xc0106548
c0103b35:	e8 e5 c8 ff ff       	call   c010041f <__panic>

    page_remove(boot_pgdir, 0x0);
c0103b3a:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103b3f:	83 ec 08             	sub    $0x8,%esp
c0103b42:	6a 00                	push   $0x0
c0103b44:	50                   	push   %eax
c0103b45:	e8 6e fa ff ff       	call   c01035b8 <page_remove>
c0103b4a:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 1);
c0103b4d:	83 ec 0c             	sub    $0xc,%esp
c0103b50:	ff 75 f4             	pushl  -0xc(%ebp)
c0103b53:	e8 1c f1 ff ff       	call   c0102c74 <page_ref>
c0103b58:	83 c4 10             	add    $0x10,%esp
c0103b5b:	83 f8 01             	cmp    $0x1,%eax
c0103b5e:	74 19                	je     c0103b79 <check_pgdir+0x457>
c0103b60:	68 b2 66 10 c0       	push   $0xc01066b2
c0103b65:	68 6d 65 10 c0       	push   $0xc010656d
c0103b6a:	68 05 02 00 00       	push   $0x205
c0103b6f:	68 48 65 10 c0       	push   $0xc0106548
c0103b74:	e8 a6 c8 ff ff       	call   c010041f <__panic>
    assert(page_ref(p2) == 0);
c0103b79:	83 ec 0c             	sub    $0xc,%esp
c0103b7c:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103b7f:	e8 f0 f0 ff ff       	call   c0102c74 <page_ref>
c0103b84:	83 c4 10             	add    $0x10,%esp
c0103b87:	85 c0                	test   %eax,%eax
c0103b89:	74 19                	je     c0103ba4 <check_pgdir+0x482>
c0103b8b:	68 d6 67 10 c0       	push   $0xc01067d6
c0103b90:	68 6d 65 10 c0       	push   $0xc010656d
c0103b95:	68 06 02 00 00       	push   $0x206
c0103b9a:	68 48 65 10 c0       	push   $0xc0106548
c0103b9f:	e8 7b c8 ff ff       	call   c010041f <__panic>

    page_remove(boot_pgdir, PGSIZE);
c0103ba4:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103ba9:	83 ec 08             	sub    $0x8,%esp
c0103bac:	68 00 10 00 00       	push   $0x1000
c0103bb1:	50                   	push   %eax
c0103bb2:	e8 01 fa ff ff       	call   c01035b8 <page_remove>
c0103bb7:	83 c4 10             	add    $0x10,%esp
    assert(page_ref(p1) == 0);
c0103bba:	83 ec 0c             	sub    $0xc,%esp
c0103bbd:	ff 75 f4             	pushl  -0xc(%ebp)
c0103bc0:	e8 af f0 ff ff       	call   c0102c74 <page_ref>
c0103bc5:	83 c4 10             	add    $0x10,%esp
c0103bc8:	85 c0                	test   %eax,%eax
c0103bca:	74 19                	je     c0103be5 <check_pgdir+0x4c3>
c0103bcc:	68 fd 67 10 c0       	push   $0xc01067fd
c0103bd1:	68 6d 65 10 c0       	push   $0xc010656d
c0103bd6:	68 09 02 00 00       	push   $0x209
c0103bdb:	68 48 65 10 c0       	push   $0xc0106548
c0103be0:	e8 3a c8 ff ff       	call   c010041f <__panic>
    assert(page_ref(p2) == 0);
c0103be5:	83 ec 0c             	sub    $0xc,%esp
c0103be8:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103beb:	e8 84 f0 ff ff       	call   c0102c74 <page_ref>
c0103bf0:	83 c4 10             	add    $0x10,%esp
c0103bf3:	85 c0                	test   %eax,%eax
c0103bf5:	74 19                	je     c0103c10 <check_pgdir+0x4ee>
c0103bf7:	68 d6 67 10 c0       	push   $0xc01067d6
c0103bfc:	68 6d 65 10 c0       	push   $0xc010656d
c0103c01:	68 0a 02 00 00       	push   $0x20a
c0103c06:	68 48 65 10 c0       	push   $0xc0106548
c0103c0b:	e8 0f c8 ff ff       	call   c010041f <__panic>

    assert(page_ref(pa2page(boot_pgdir[0])) == 1);
c0103c10:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103c15:	8b 00                	mov    (%eax),%eax
c0103c17:	83 ec 0c             	sub    $0xc,%esp
c0103c1a:	50                   	push   %eax
c0103c1b:	e8 8e ef ff ff       	call   c0102bae <pa2page>
c0103c20:	83 c4 10             	add    $0x10,%esp
c0103c23:	83 ec 0c             	sub    $0xc,%esp
c0103c26:	50                   	push   %eax
c0103c27:	e8 48 f0 ff ff       	call   c0102c74 <page_ref>
c0103c2c:	83 c4 10             	add    $0x10,%esp
c0103c2f:	83 f8 01             	cmp    $0x1,%eax
c0103c32:	74 19                	je     c0103c4d <check_pgdir+0x52b>
c0103c34:	68 10 68 10 c0       	push   $0xc0106810
c0103c39:	68 6d 65 10 c0       	push   $0xc010656d
c0103c3e:	68 0c 02 00 00       	push   $0x20c
c0103c43:	68 48 65 10 c0       	push   $0xc0106548
c0103c48:	e8 d2 c7 ff ff       	call   c010041f <__panic>
    free_page(pa2page(boot_pgdir[0]));
c0103c4d:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103c52:	8b 00                	mov    (%eax),%eax
c0103c54:	83 ec 0c             	sub    $0xc,%esp
c0103c57:	50                   	push   %eax
c0103c58:	e8 51 ef ff ff       	call   c0102bae <pa2page>
c0103c5d:	83 c4 10             	add    $0x10,%esp
c0103c60:	83 ec 08             	sub    $0x8,%esp
c0103c63:	6a 01                	push   $0x1
c0103c65:	50                   	push   %eax
c0103c66:	e8 5c f2 ff ff       	call   c0102ec7 <free_pages>
c0103c6b:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
c0103c6e:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103c73:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
c0103c79:	83 ec 0c             	sub    $0xc,%esp
c0103c7c:	68 36 68 10 c0       	push   $0xc0106836
c0103c81:	e8 1e c6 ff ff       	call   c01002a4 <cprintf>
c0103c86:	83 c4 10             	add    $0x10,%esp
}
c0103c89:	90                   	nop
c0103c8a:	c9                   	leave  
c0103c8b:	c3                   	ret    

c0103c8c <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
c0103c8c:	f3 0f 1e fb          	endbr32 
c0103c90:	55                   	push   %ebp
c0103c91:	89 e5                	mov    %esp,%ebp
c0103c93:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
c0103c96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0103c9d:	e9 a3 00 00 00       	jmp    c0103d45 <check_boot_pgdir+0xb9>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
c0103ca2:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103ca5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103ca8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103cab:	c1 e8 0c             	shr    $0xc,%eax
c0103cae:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0103cb1:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103cb6:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0103cb9:	72 17                	jb     c0103cd2 <check_boot_pgdir+0x46>
c0103cbb:	ff 75 e4             	pushl  -0x1c(%ebp)
c0103cbe:	68 80 64 10 c0       	push   $0xc0106480
c0103cc3:	68 18 02 00 00       	push   $0x218
c0103cc8:	68 48 65 10 c0       	push   $0xc0106548
c0103ccd:	e8 4d c7 ff ff       	call   c010041f <__panic>
c0103cd2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103cd5:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0103cda:	89 c2                	mov    %eax,%edx
c0103cdc:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103ce1:	83 ec 04             	sub    $0x4,%esp
c0103ce4:	6a 00                	push   $0x0
c0103ce6:	52                   	push   %edx
c0103ce7:	50                   	push   %eax
c0103ce8:	e8 64 f8 ff ff       	call   c0103551 <get_pte>
c0103ced:	83 c4 10             	add    $0x10,%esp
c0103cf0:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0103cf3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0103cf7:	75 19                	jne    c0103d12 <check_boot_pgdir+0x86>
c0103cf9:	68 50 68 10 c0       	push   $0xc0106850
c0103cfe:	68 6d 65 10 c0       	push   $0xc010656d
c0103d03:	68 18 02 00 00       	push   $0x218
c0103d08:	68 48 65 10 c0       	push   $0xc0106548
c0103d0d:	e8 0d c7 ff ff       	call   c010041f <__panic>
        assert(PTE_ADDR(*ptep) == i);
c0103d12:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0103d15:	8b 00                	mov    (%eax),%eax
c0103d17:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103d1c:	89 c2                	mov    %eax,%edx
c0103d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103d21:	39 c2                	cmp    %eax,%edx
c0103d23:	74 19                	je     c0103d3e <check_boot_pgdir+0xb2>
c0103d25:	68 8d 68 10 c0       	push   $0xc010688d
c0103d2a:	68 6d 65 10 c0       	push   $0xc010656d
c0103d2f:	68 19 02 00 00       	push   $0x219
c0103d34:	68 48 65 10 c0       	push   $0xc0106548
c0103d39:	e8 e1 c6 ff ff       	call   c010041f <__panic>
    for (i = 0; i < npage; i += PGSIZE) {
c0103d3e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
c0103d45:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103d48:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103d4d:	39 c2                	cmp    %eax,%edx
c0103d4f:	0f 82 4d ff ff ff    	jb     c0103ca2 <check_boot_pgdir+0x16>
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
c0103d55:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103d5a:	05 ac 0f 00 00       	add    $0xfac,%eax
c0103d5f:	8b 00                	mov    (%eax),%eax
c0103d61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103d66:	89 c2                	mov    %eax,%edx
c0103d68:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103d6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103d70:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c0103d77:	77 17                	ja     c0103d90 <check_boot_pgdir+0x104>
c0103d79:	ff 75 f0             	pushl  -0x10(%ebp)
c0103d7c:	68 24 65 10 c0       	push   $0xc0106524
c0103d81:	68 1c 02 00 00       	push   $0x21c
c0103d86:	68 48 65 10 c0       	push   $0xc0106548
c0103d8b:	e8 8f c6 ff ff       	call   c010041f <__panic>
c0103d90:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103d93:	05 00 00 00 40       	add    $0x40000000,%eax
c0103d98:	39 d0                	cmp    %edx,%eax
c0103d9a:	74 19                	je     c0103db5 <check_boot_pgdir+0x129>
c0103d9c:	68 a4 68 10 c0       	push   $0xc01068a4
c0103da1:	68 6d 65 10 c0       	push   $0xc010656d
c0103da6:	68 1c 02 00 00       	push   $0x21c
c0103dab:	68 48 65 10 c0       	push   $0xc0106548
c0103db0:	e8 6a c6 ff ff       	call   c010041f <__panic>

    assert(boot_pgdir[0] == 0);
c0103db5:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103dba:	8b 00                	mov    (%eax),%eax
c0103dbc:	85 c0                	test   %eax,%eax
c0103dbe:	74 19                	je     c0103dd9 <check_boot_pgdir+0x14d>
c0103dc0:	68 d8 68 10 c0       	push   $0xc01068d8
c0103dc5:	68 6d 65 10 c0       	push   $0xc010656d
c0103dca:	68 1e 02 00 00       	push   $0x21e
c0103dcf:	68 48 65 10 c0       	push   $0xc0106548
c0103dd4:	e8 46 c6 ff ff       	call   c010041f <__panic>

    struct Page *p;
    p = alloc_page();
c0103dd9:	83 ec 0c             	sub    $0xc,%esp
c0103ddc:	6a 01                	push   $0x1
c0103dde:	e8 a2 f0 ff ff       	call   c0102e85 <alloc_pages>
c0103de3:	83 c4 10             	add    $0x10,%esp
c0103de6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
c0103de9:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103dee:	6a 02                	push   $0x2
c0103df0:	68 00 01 00 00       	push   $0x100
c0103df5:	ff 75 ec             	pushl  -0x14(%ebp)
c0103df8:	50                   	push   %eax
c0103df9:	e8 f1 f7 ff ff       	call   c01035ef <page_insert>
c0103dfe:	83 c4 10             	add    $0x10,%esp
c0103e01:	85 c0                	test   %eax,%eax
c0103e03:	74 19                	je     c0103e1e <check_boot_pgdir+0x192>
c0103e05:	68 ec 68 10 c0       	push   $0xc01068ec
c0103e0a:	68 6d 65 10 c0       	push   $0xc010656d
c0103e0f:	68 22 02 00 00       	push   $0x222
c0103e14:	68 48 65 10 c0       	push   $0xc0106548
c0103e19:	e8 01 c6 ff ff       	call   c010041f <__panic>
    assert(page_ref(p) == 1);
c0103e1e:	83 ec 0c             	sub    $0xc,%esp
c0103e21:	ff 75 ec             	pushl  -0x14(%ebp)
c0103e24:	e8 4b ee ff ff       	call   c0102c74 <page_ref>
c0103e29:	83 c4 10             	add    $0x10,%esp
c0103e2c:	83 f8 01             	cmp    $0x1,%eax
c0103e2f:	74 19                	je     c0103e4a <check_boot_pgdir+0x1be>
c0103e31:	68 1a 69 10 c0       	push   $0xc010691a
c0103e36:	68 6d 65 10 c0       	push   $0xc010656d
c0103e3b:	68 23 02 00 00       	push   $0x223
c0103e40:	68 48 65 10 c0       	push   $0xc0106548
c0103e45:	e8 d5 c5 ff ff       	call   c010041f <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
c0103e4a:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103e4f:	6a 02                	push   $0x2
c0103e51:	68 00 11 00 00       	push   $0x1100
c0103e56:	ff 75 ec             	pushl  -0x14(%ebp)
c0103e59:	50                   	push   %eax
c0103e5a:	e8 90 f7 ff ff       	call   c01035ef <page_insert>
c0103e5f:	83 c4 10             	add    $0x10,%esp
c0103e62:	85 c0                	test   %eax,%eax
c0103e64:	74 19                	je     c0103e7f <check_boot_pgdir+0x1f3>
c0103e66:	68 2c 69 10 c0       	push   $0xc010692c
c0103e6b:	68 6d 65 10 c0       	push   $0xc010656d
c0103e70:	68 24 02 00 00       	push   $0x224
c0103e75:	68 48 65 10 c0       	push   $0xc0106548
c0103e7a:	e8 a0 c5 ff ff       	call   c010041f <__panic>
    assert(page_ref(p) == 2);
c0103e7f:	83 ec 0c             	sub    $0xc,%esp
c0103e82:	ff 75 ec             	pushl  -0x14(%ebp)
c0103e85:	e8 ea ed ff ff       	call   c0102c74 <page_ref>
c0103e8a:	83 c4 10             	add    $0x10,%esp
c0103e8d:	83 f8 02             	cmp    $0x2,%eax
c0103e90:	74 19                	je     c0103eab <check_boot_pgdir+0x21f>
c0103e92:	68 63 69 10 c0       	push   $0xc0106963
c0103e97:	68 6d 65 10 c0       	push   $0xc010656d
c0103e9c:	68 25 02 00 00       	push   $0x225
c0103ea1:	68 48 65 10 c0       	push   $0xc0106548
c0103ea6:	e8 74 c5 ff ff       	call   c010041f <__panic>

    const char *str = "ucore: Hello world!!";
c0103eab:	c7 45 e8 74 69 10 c0 	movl   $0xc0106974,-0x18(%ebp)
    strcpy((void *)0x100, str);
c0103eb2:	83 ec 08             	sub    $0x8,%esp
c0103eb5:	ff 75 e8             	pushl  -0x18(%ebp)
c0103eb8:	68 00 01 00 00       	push   $0x100
c0103ebd:	e8 a7 13 00 00       	call   c0105269 <strcpy>
c0103ec2:	83 c4 10             	add    $0x10,%esp
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
c0103ec5:	83 ec 08             	sub    $0x8,%esp
c0103ec8:	68 00 11 00 00       	push   $0x1100
c0103ecd:	68 00 01 00 00       	push   $0x100
c0103ed2:	e8 13 14 00 00       	call   c01052ea <strcmp>
c0103ed7:	83 c4 10             	add    $0x10,%esp
c0103eda:	85 c0                	test   %eax,%eax
c0103edc:	74 19                	je     c0103ef7 <check_boot_pgdir+0x26b>
c0103ede:	68 8c 69 10 c0       	push   $0xc010698c
c0103ee3:	68 6d 65 10 c0       	push   $0xc010656d
c0103ee8:	68 29 02 00 00       	push   $0x229
c0103eed:	68 48 65 10 c0       	push   $0xc0106548
c0103ef2:	e8 28 c5 ff ff       	call   c010041f <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
c0103ef7:	83 ec 0c             	sub    $0xc,%esp
c0103efa:	ff 75 ec             	pushl  -0x14(%ebp)
c0103efd:	e8 f3 ec ff ff       	call   c0102bf5 <page2kva>
c0103f02:	83 c4 10             	add    $0x10,%esp
c0103f05:	05 00 01 00 00       	add    $0x100,%eax
c0103f0a:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
c0103f0d:	83 ec 0c             	sub    $0xc,%esp
c0103f10:	68 00 01 00 00       	push   $0x100
c0103f15:	e8 ef 12 00 00       	call   c0105209 <strlen>
c0103f1a:	83 c4 10             	add    $0x10,%esp
c0103f1d:	85 c0                	test   %eax,%eax
c0103f1f:	74 19                	je     c0103f3a <check_boot_pgdir+0x2ae>
c0103f21:	68 c4 69 10 c0       	push   $0xc01069c4
c0103f26:	68 6d 65 10 c0       	push   $0xc010656d
c0103f2b:	68 2c 02 00 00       	push   $0x22c
c0103f30:	68 48 65 10 c0       	push   $0xc0106548
c0103f35:	e8 e5 c4 ff ff       	call   c010041f <__panic>

    free_page(p);
c0103f3a:	83 ec 08             	sub    $0x8,%esp
c0103f3d:	6a 01                	push   $0x1
c0103f3f:	ff 75 ec             	pushl  -0x14(%ebp)
c0103f42:	e8 80 ef ff ff       	call   c0102ec7 <free_pages>
c0103f47:	83 c4 10             	add    $0x10,%esp
    free_page(pa2page(PDE_ADDR(boot_pgdir[0])));
c0103f4a:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103f4f:	8b 00                	mov    (%eax),%eax
c0103f51:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103f56:	83 ec 0c             	sub    $0xc,%esp
c0103f59:	50                   	push   %eax
c0103f5a:	e8 4f ec ff ff       	call   c0102bae <pa2page>
c0103f5f:	83 c4 10             	add    $0x10,%esp
c0103f62:	83 ec 08             	sub    $0x8,%esp
c0103f65:	6a 01                	push   $0x1
c0103f67:	50                   	push   %eax
c0103f68:	e8 5a ef ff ff       	call   c0102ec7 <free_pages>
c0103f6d:	83 c4 10             	add    $0x10,%esp
    boot_pgdir[0] = 0;
c0103f70:	a1 84 ce 11 c0       	mov    0xc011ce84,%eax
c0103f75:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
c0103f7b:	83 ec 0c             	sub    $0xc,%esp
c0103f7e:	68 e8 69 10 c0       	push   $0xc01069e8
c0103f83:	e8 1c c3 ff ff       	call   c01002a4 <cprintf>
c0103f88:	83 c4 10             	add    $0x10,%esp
}
c0103f8b:	90                   	nop
c0103f8c:	c9                   	leave  
c0103f8d:	c3                   	ret    

c0103f8e <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
c0103f8e:	f3 0f 1e fb          	endbr32 
c0103f92:	55                   	push   %ebp
c0103f93:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
c0103f95:	8b 45 08             	mov    0x8(%ebp),%eax
c0103f98:	83 e0 04             	and    $0x4,%eax
c0103f9b:	85 c0                	test   %eax,%eax
c0103f9d:	74 07                	je     c0103fa6 <perm2str+0x18>
c0103f9f:	b8 75 00 00 00       	mov    $0x75,%eax
c0103fa4:	eb 05                	jmp    c0103fab <perm2str+0x1d>
c0103fa6:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0103fab:	a2 08 cf 11 c0       	mov    %al,0xc011cf08
    str[1] = 'r';
c0103fb0:	c6 05 09 cf 11 c0 72 	movb   $0x72,0xc011cf09
    str[2] = (perm & PTE_W) ? 'w' : '-';
c0103fb7:	8b 45 08             	mov    0x8(%ebp),%eax
c0103fba:	83 e0 02             	and    $0x2,%eax
c0103fbd:	85 c0                	test   %eax,%eax
c0103fbf:	74 07                	je     c0103fc8 <perm2str+0x3a>
c0103fc1:	b8 77 00 00 00       	mov    $0x77,%eax
c0103fc6:	eb 05                	jmp    c0103fcd <perm2str+0x3f>
c0103fc8:	b8 2d 00 00 00       	mov    $0x2d,%eax
c0103fcd:	a2 0a cf 11 c0       	mov    %al,0xc011cf0a
    str[3] = '\0';
c0103fd2:	c6 05 0b cf 11 c0 00 	movb   $0x0,0xc011cf0b
    return str;
c0103fd9:	b8 08 cf 11 c0       	mov    $0xc011cf08,%eax
}
c0103fde:	5d                   	pop    %ebp
c0103fdf:	c3                   	ret    

c0103fe0 <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
c0103fe0:	f3 0f 1e fb          	endbr32 
c0103fe4:	55                   	push   %ebp
c0103fe5:	89 e5                	mov    %esp,%ebp
c0103fe7:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
c0103fea:	8b 45 10             	mov    0x10(%ebp),%eax
c0103fed:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0103ff0:	72 0e                	jb     c0104000 <get_pgtable_items+0x20>
        return 0;
c0103ff2:	b8 00 00 00 00       	mov    $0x0,%eax
c0103ff7:	e9 9a 00 00 00       	jmp    c0104096 <get_pgtable_items+0xb6>
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
c0103ffc:	83 45 10 01          	addl   $0x1,0x10(%ebp)
    while (start < right && !(table[start] & PTE_P)) {
c0104000:	8b 45 10             	mov    0x10(%ebp),%eax
c0104003:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0104006:	73 18                	jae    c0104020 <get_pgtable_items+0x40>
c0104008:	8b 45 10             	mov    0x10(%ebp),%eax
c010400b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0104012:	8b 45 14             	mov    0x14(%ebp),%eax
c0104015:	01 d0                	add    %edx,%eax
c0104017:	8b 00                	mov    (%eax),%eax
c0104019:	83 e0 01             	and    $0x1,%eax
c010401c:	85 c0                	test   %eax,%eax
c010401e:	74 dc                	je     c0103ffc <get_pgtable_items+0x1c>
    }
    if (start < right) {
c0104020:	8b 45 10             	mov    0x10(%ebp),%eax
c0104023:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0104026:	73 69                	jae    c0104091 <get_pgtable_items+0xb1>
        if (left_store != NULL) {
c0104028:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
c010402c:	74 08                	je     c0104036 <get_pgtable_items+0x56>
            *left_store = start;
c010402e:	8b 45 18             	mov    0x18(%ebp),%eax
c0104031:	8b 55 10             	mov    0x10(%ebp),%edx
c0104034:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
c0104036:	8b 45 10             	mov    0x10(%ebp),%eax
c0104039:	8d 50 01             	lea    0x1(%eax),%edx
c010403c:	89 55 10             	mov    %edx,0x10(%ebp)
c010403f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0104046:	8b 45 14             	mov    0x14(%ebp),%eax
c0104049:	01 d0                	add    %edx,%eax
c010404b:	8b 00                	mov    (%eax),%eax
c010404d:	83 e0 07             	and    $0x7,%eax
c0104050:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0104053:	eb 04                	jmp    c0104059 <get_pgtable_items+0x79>
            start ++;
c0104055:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0104059:	8b 45 10             	mov    0x10(%ebp),%eax
c010405c:	3b 45 0c             	cmp    0xc(%ebp),%eax
c010405f:	73 1d                	jae    c010407e <get_pgtable_items+0x9e>
c0104061:	8b 45 10             	mov    0x10(%ebp),%eax
c0104064:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c010406b:	8b 45 14             	mov    0x14(%ebp),%eax
c010406e:	01 d0                	add    %edx,%eax
c0104070:	8b 00                	mov    (%eax),%eax
c0104072:	83 e0 07             	and    $0x7,%eax
c0104075:	89 c2                	mov    %eax,%edx
c0104077:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010407a:	39 c2                	cmp    %eax,%edx
c010407c:	74 d7                	je     c0104055 <get_pgtable_items+0x75>
        }
        if (right_store != NULL) {
c010407e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c0104082:	74 08                	je     c010408c <get_pgtable_items+0xac>
            *right_store = start;
c0104084:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0104087:	8b 55 10             	mov    0x10(%ebp),%edx
c010408a:	89 10                	mov    %edx,(%eax)
        }
        return perm;
c010408c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010408f:	eb 05                	jmp    c0104096 <get_pgtable_items+0xb6>
    }
    return 0;
c0104091:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0104096:	c9                   	leave  
c0104097:	c3                   	ret    

c0104098 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
c0104098:	f3 0f 1e fb          	endbr32 
c010409c:	55                   	push   %ebp
c010409d:	89 e5                	mov    %esp,%ebp
c010409f:	57                   	push   %edi
c01040a0:	56                   	push   %esi
c01040a1:	53                   	push   %ebx
c01040a2:	83 ec 2c             	sub    $0x2c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
c01040a5:	83 ec 0c             	sub    $0xc,%esp
c01040a8:	68 08 6a 10 c0       	push   $0xc0106a08
c01040ad:	e8 f2 c1 ff ff       	call   c01002a4 <cprintf>
c01040b2:	83 c4 10             	add    $0x10,%esp
    size_t left, right = 0, perm;
c01040b5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c01040bc:	e9 e1 00 00 00       	jmp    c01041a2 <print_pgdir+0x10a>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c01040c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01040c4:	83 ec 0c             	sub    $0xc,%esp
c01040c7:	50                   	push   %eax
c01040c8:	e8 c1 fe ff ff       	call   c0103f8e <perm2str>
c01040cd:	83 c4 10             	add    $0x10,%esp
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
c01040d0:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c01040d3:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01040d6:	29 d1                	sub    %edx,%ecx
c01040d8:	89 ca                	mov    %ecx,%edx
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c01040da:	89 d6                	mov    %edx,%esi
c01040dc:	c1 e6 16             	shl    $0x16,%esi
c01040df:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01040e2:	89 d3                	mov    %edx,%ebx
c01040e4:	c1 e3 16             	shl    $0x16,%ebx
c01040e7:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01040ea:	89 d1                	mov    %edx,%ecx
c01040ec:	c1 e1 16             	shl    $0x16,%ecx
c01040ef:	8b 7d dc             	mov    -0x24(%ebp),%edi
c01040f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01040f5:	29 d7                	sub    %edx,%edi
c01040f7:	89 fa                	mov    %edi,%edx
c01040f9:	83 ec 08             	sub    $0x8,%esp
c01040fc:	50                   	push   %eax
c01040fd:	56                   	push   %esi
c01040fe:	53                   	push   %ebx
c01040ff:	51                   	push   %ecx
c0104100:	52                   	push   %edx
c0104101:	68 39 6a 10 c0       	push   $0xc0106a39
c0104106:	e8 99 c1 ff ff       	call   c01002a4 <cprintf>
c010410b:	83 c4 20             	add    $0x20,%esp
        size_t l, r = left * NPTEENTRY;
c010410e:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104111:	c1 e0 0a             	shl    $0xa,%eax
c0104114:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0104117:	eb 4d                	jmp    c0104166 <print_pgdir+0xce>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0104119:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010411c:	83 ec 0c             	sub    $0xc,%esp
c010411f:	50                   	push   %eax
c0104120:	e8 69 fe ff ff       	call   c0103f8e <perm2str>
c0104125:	83 c4 10             	add    $0x10,%esp
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
c0104128:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c010412b:	8b 55 d8             	mov    -0x28(%ebp),%edx
c010412e:	29 d1                	sub    %edx,%ecx
c0104130:	89 ca                	mov    %ecx,%edx
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0104132:	89 d6                	mov    %edx,%esi
c0104134:	c1 e6 0c             	shl    $0xc,%esi
c0104137:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010413a:	89 d3                	mov    %edx,%ebx
c010413c:	c1 e3 0c             	shl    $0xc,%ebx
c010413f:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104142:	89 d1                	mov    %edx,%ecx
c0104144:	c1 e1 0c             	shl    $0xc,%ecx
c0104147:	8b 7d d4             	mov    -0x2c(%ebp),%edi
c010414a:	8b 55 d8             	mov    -0x28(%ebp),%edx
c010414d:	29 d7                	sub    %edx,%edi
c010414f:	89 fa                	mov    %edi,%edx
c0104151:	83 ec 08             	sub    $0x8,%esp
c0104154:	50                   	push   %eax
c0104155:	56                   	push   %esi
c0104156:	53                   	push   %ebx
c0104157:	51                   	push   %ecx
c0104158:	52                   	push   %edx
c0104159:	68 58 6a 10 c0       	push   $0xc0106a58
c010415e:	e8 41 c1 ff ff       	call   c01002a4 <cprintf>
c0104163:	83 c4 20             	add    $0x20,%esp
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0104166:	be 00 00 c0 fa       	mov    $0xfac00000,%esi
c010416b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010416e:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104171:	89 d3                	mov    %edx,%ebx
c0104173:	c1 e3 0a             	shl    $0xa,%ebx
c0104176:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0104179:	89 d1                	mov    %edx,%ecx
c010417b:	c1 e1 0a             	shl    $0xa,%ecx
c010417e:	83 ec 08             	sub    $0x8,%esp
c0104181:	8d 55 d4             	lea    -0x2c(%ebp),%edx
c0104184:	52                   	push   %edx
c0104185:	8d 55 d8             	lea    -0x28(%ebp),%edx
c0104188:	52                   	push   %edx
c0104189:	56                   	push   %esi
c010418a:	50                   	push   %eax
c010418b:	53                   	push   %ebx
c010418c:	51                   	push   %ecx
c010418d:	e8 4e fe ff ff       	call   c0103fe0 <get_pgtable_items>
c0104192:	83 c4 20             	add    $0x20,%esp
c0104195:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104198:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010419c:	0f 85 77 ff ff ff    	jne    c0104119 <print_pgdir+0x81>
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c01041a2:	b9 00 b0 fe fa       	mov    $0xfafeb000,%ecx
c01041a7:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01041aa:	83 ec 08             	sub    $0x8,%esp
c01041ad:	8d 55 dc             	lea    -0x24(%ebp),%edx
c01041b0:	52                   	push   %edx
c01041b1:	8d 55 e0             	lea    -0x20(%ebp),%edx
c01041b4:	52                   	push   %edx
c01041b5:	51                   	push   %ecx
c01041b6:	50                   	push   %eax
c01041b7:	68 00 04 00 00       	push   $0x400
c01041bc:	6a 00                	push   $0x0
c01041be:	e8 1d fe ff ff       	call   c0103fe0 <get_pgtable_items>
c01041c3:	83 c4 20             	add    $0x20,%esp
c01041c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01041c9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c01041cd:	0f 85 ee fe ff ff    	jne    c01040c1 <print_pgdir+0x29>
        }
    }
    cprintf("--------------------- END ---------------------\n");
c01041d3:	83 ec 0c             	sub    $0xc,%esp
c01041d6:	68 7c 6a 10 c0       	push   $0xc0106a7c
c01041db:	e8 c4 c0 ff ff       	call   c01002a4 <cprintf>
c01041e0:	83 c4 10             	add    $0x10,%esp
}
c01041e3:	90                   	nop
c01041e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
c01041e7:	5b                   	pop    %ebx
c01041e8:	5e                   	pop    %esi
c01041e9:	5f                   	pop    %edi
c01041ea:	5d                   	pop    %ebp
c01041eb:	c3                   	ret    

c01041ec <page2ppn>:
page2ppn(struct Page *page) {
c01041ec:	55                   	push   %ebp
c01041ed:	89 e5                	mov    %esp,%ebp
    return page - pages;
c01041ef:	a1 18 cf 11 c0       	mov    0xc011cf18,%eax
c01041f4:	8b 55 08             	mov    0x8(%ebp),%edx
c01041f7:	29 c2                	sub    %eax,%edx
c01041f9:	89 d0                	mov    %edx,%eax
c01041fb:	c1 f8 02             	sar    $0x2,%eax
c01041fe:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0104204:	5d                   	pop    %ebp
c0104205:	c3                   	ret    

c0104206 <page2pa>:
page2pa(struct Page *page) {
c0104206:	55                   	push   %ebp
c0104207:	89 e5                	mov    %esp,%ebp
    return page2ppn(page) << PGSHIFT;
c0104209:	ff 75 08             	pushl  0x8(%ebp)
c010420c:	e8 db ff ff ff       	call   c01041ec <page2ppn>
c0104211:	83 c4 04             	add    $0x4,%esp
c0104214:	c1 e0 0c             	shl    $0xc,%eax
}
c0104217:	c9                   	leave  
c0104218:	c3                   	ret    

c0104219 <page_ref>:
page_ref(struct Page *page) {
c0104219:	55                   	push   %ebp
c010421a:	89 e5                	mov    %esp,%ebp
    return page->ref;
c010421c:	8b 45 08             	mov    0x8(%ebp),%eax
c010421f:	8b 00                	mov    (%eax),%eax
}
c0104221:	5d                   	pop    %ebp
c0104222:	c3                   	ret    

c0104223 <set_page_ref>:
set_page_ref(struct Page *page, int val) {
c0104223:	55                   	push   %ebp
c0104224:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0104226:	8b 45 08             	mov    0x8(%ebp),%eax
c0104229:	8b 55 0c             	mov    0xc(%ebp),%edx
c010422c:	89 10                	mov    %edx,(%eax)
}
c010422e:	90                   	nop
c010422f:	5d                   	pop    %ebp
c0104230:	c3                   	ret    

c0104231 <default_init>:

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
c0104231:	f3 0f 1e fb          	endbr32 
c0104235:	55                   	push   %ebp
c0104236:	89 e5                	mov    %esp,%ebp
c0104238:	83 ec 10             	sub    $0x10,%esp
c010423b:	c7 45 fc 1c cf 11 c0 	movl   $0xc011cf1c,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c0104242:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104245:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0104248:	89 50 04             	mov    %edx,0x4(%eax)
c010424b:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010424e:	8b 50 04             	mov    0x4(%eax),%edx
c0104251:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104254:	89 10                	mov    %edx,(%eax)
}
c0104256:	90                   	nop
    list_init(&free_list);
    nr_free = 0;
c0104257:	c7 05 24 cf 11 c0 00 	movl   $0x0,0xc011cf24
c010425e:	00 00 00 
}
c0104261:	90                   	nop
c0104262:	c9                   	leave  
c0104263:	c3                   	ret    

c0104264 <default_init_memmap>:

static void
default_init_memmap(struct Page *base, size_t n) {
c0104264:	f3 0f 1e fb          	endbr32 
c0104268:	55                   	push   %ebp
c0104269:	89 e5                	mov    %esp,%ebp
c010426b:	83 ec 38             	sub    $0x38,%esp
    assert(n > 0);
c010426e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0104272:	75 16                	jne    c010428a <default_init_memmap+0x26>
c0104274:	68 b0 6a 10 c0       	push   $0xc0106ab0
c0104279:	68 b6 6a 10 c0       	push   $0xc0106ab6
c010427e:	6a 6d                	push   $0x6d
c0104280:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104285:	e8 95 c1 ff ff       	call   c010041f <__panic>
    struct Page *p = base;
c010428a:	8b 45 08             	mov    0x8(%ebp),%eax
c010428d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c0104290:	eb 6c                	jmp    c01042fe <default_init_memmap+0x9a>
        assert(PageReserved(p));
c0104292:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104295:	83 c0 04             	add    $0x4,%eax
c0104298:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c010429f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c01042a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01042a5:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01042a8:	0f a3 10             	bt     %edx,(%eax)
c01042ab:	19 c0                	sbb    %eax,%eax
c01042ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
c01042b0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01042b4:	0f 95 c0             	setne  %al
c01042b7:	0f b6 c0             	movzbl %al,%eax
c01042ba:	85 c0                	test   %eax,%eax
c01042bc:	75 16                	jne    c01042d4 <default_init_memmap+0x70>
c01042be:	68 e1 6a 10 c0       	push   $0xc0106ae1
c01042c3:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01042c8:	6a 70                	push   $0x70
c01042ca:	68 cb 6a 10 c0       	push   $0xc0106acb
c01042cf:	e8 4b c1 ff ff       	call   c010041f <__panic>
        p->flags = p->property = 0;
c01042d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01042d7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
c01042de:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01042e1:	8b 50 08             	mov    0x8(%eax),%edx
c01042e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01042e7:	89 50 04             	mov    %edx,0x4(%eax)
        set_page_ref(p, 0);
c01042ea:	83 ec 08             	sub    $0x8,%esp
c01042ed:	6a 00                	push   $0x0
c01042ef:	ff 75 f4             	pushl  -0xc(%ebp)
c01042f2:	e8 2c ff ff ff       	call   c0104223 <set_page_ref>
c01042f7:	83 c4 10             	add    $0x10,%esp
    for (; p != base + n; p ++) {
c01042fa:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c01042fe:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104301:	89 d0                	mov    %edx,%eax
c0104303:	c1 e0 02             	shl    $0x2,%eax
c0104306:	01 d0                	add    %edx,%eax
c0104308:	c1 e0 02             	shl    $0x2,%eax
c010430b:	89 c2                	mov    %eax,%edx
c010430d:	8b 45 08             	mov    0x8(%ebp),%eax
c0104310:	01 d0                	add    %edx,%eax
c0104312:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104315:	0f 85 77 ff ff ff    	jne    c0104292 <default_init_memmap+0x2e>
    }
    base->property = n;
c010431b:	8b 45 08             	mov    0x8(%ebp),%eax
c010431e:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104321:	89 50 08             	mov    %edx,0x8(%eax)
    SetPageProperty(base);
c0104324:	8b 45 08             	mov    0x8(%ebp),%eax
c0104327:	83 c0 04             	add    $0x4,%eax
c010432a:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c0104331:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104334:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104337:	8b 55 d0             	mov    -0x30(%ebp),%edx
c010433a:	0f ab 10             	bts    %edx,(%eax)
}
c010433d:	90                   	nop
    nr_free += n;
c010433e:	8b 15 24 cf 11 c0    	mov    0xc011cf24,%edx
c0104344:	8b 45 0c             	mov    0xc(%ebp),%eax
c0104347:	01 d0                	add    %edx,%eax
c0104349:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24
    list_add_before(&free_list, &(base->page_link));
c010434e:	8b 45 08             	mov    0x8(%ebp),%eax
c0104351:	83 c0 0c             	add    $0xc,%eax
c0104354:	c7 45 e4 1c cf 11 c0 	movl   $0xc011cf1c,-0x1c(%ebp)
c010435b:	89 45 e0             	mov    %eax,-0x20(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
c010435e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104361:	8b 00                	mov    (%eax),%eax
c0104363:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0104366:	89 55 dc             	mov    %edx,-0x24(%ebp)
c0104369:	89 45 d8             	mov    %eax,-0x28(%ebp)
c010436c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010436f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
c0104372:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104375:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104378:	89 10                	mov    %edx,(%eax)
c010437a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010437d:	8b 10                	mov    (%eax),%edx
c010437f:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104382:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0104385:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104388:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010438b:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c010438e:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104391:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104394:	89 10                	mov    %edx,(%eax)
}
c0104396:	90                   	nop
}
c0104397:	90                   	nop
}
c0104398:	90                   	nop
c0104399:	c9                   	leave  
c010439a:	c3                   	ret    

c010439b <default_alloc_pages>:

static struct Page *
default_alloc_pages(size_t n) {
c010439b:	f3 0f 1e fb          	endbr32 
c010439f:	55                   	push   %ebp
c01043a0:	89 e5                	mov    %esp,%ebp
c01043a2:	83 ec 58             	sub    $0x58,%esp
    assert(n > 0);
c01043a5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c01043a9:	75 16                	jne    c01043c1 <default_alloc_pages+0x26>
c01043ab:	68 b0 6a 10 c0       	push   $0xc0106ab0
c01043b0:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01043b5:	6a 7c                	push   $0x7c
c01043b7:	68 cb 6a 10 c0       	push   $0xc0106acb
c01043bc:	e8 5e c0 ff ff       	call   c010041f <__panic>
    // 要的页数比剩余free的页数都多，return null
    if (n > nr_free) {
c01043c1:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c01043c6:	39 45 08             	cmp    %eax,0x8(%ebp)
c01043c9:	76 0a                	jbe    c01043d5 <default_alloc_pages+0x3a>
        return NULL;
c01043cb:	b8 00 00 00 00       	mov    $0x0,%eax
c01043d0:	e9 43 01 00 00       	jmp    c0104518 <default_alloc_pages+0x17d>
    }
    struct Page *page = NULL;
c01043d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    list_entry_t *le = &free_list;
c01043dc:	c7 45 f0 1c cf 11 c0 	movl   $0xc011cf1c,-0x10(%ebp)
    // 找了一圈后退出 TODO: list有空的头结点吗？有吧。
    while ((le = list_next(le)) != &free_list) {
c01043e3:	eb 1c                	jmp    c0104401 <default_alloc_pages+0x66>
        // 这里的page_link就是成员变量的名字，之后会变成宏。。看起来像是一个变量一样，其实不是。
        // ((type *)((char *)(ptr) - offsetof(type, member)))
        // #define offsetof(type, member)
        // ((size_t)(&((type *)0)->member))
        // le2page, 找到这个le所在page结构体的头指针，其中这个le是page变量的page_link成员变量
        struct Page *p = le2page(le, page_link);
c01043e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01043e8:	83 e8 0c             	sub    $0xc,%eax
c01043eb:	89 45 ec             	mov    %eax,-0x14(%ebp)
        // 找到了一个满足的，就把这个空间（的首页）拿出来
        if (p->property >= n) {
c01043ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01043f1:	8b 40 08             	mov    0x8(%eax),%eax
c01043f4:	39 45 08             	cmp    %eax,0x8(%ebp)
c01043f7:	77 08                	ja     c0104401 <default_alloc_pages+0x66>
            page = p;
c01043f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01043fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
            break;
c01043ff:	eb 18                	jmp    c0104419 <default_alloc_pages+0x7e>
c0104401:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104404:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return listelm->next;
c0104407:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010440a:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c010440d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104410:	81 7d f0 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x10(%ebp)
c0104417:	75 cc                	jne    c01043e5 <default_alloc_pages+0x4a>
        }
    }
    //如果找到了可行区域
    if (page != NULL) {
c0104419:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010441d:	0f 84 f2 00 00 00    	je     c0104515 <default_alloc_pages+0x17a>
        // 这个可行区域的空间大于需求空间，拆分，将剩下的一段放到list中【free+list的后面一个】
        if (page->property > n) {
c0104423:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104426:	8b 40 08             	mov    0x8(%eax),%eax
c0104429:	39 45 08             	cmp    %eax,0x8(%ebp)
c010442c:	0f 83 8f 00 00 00    	jae    c01044c1 <default_alloc_pages+0x126>
            struct Page *p = page + n;
c0104432:	8b 55 08             	mov    0x8(%ebp),%edx
c0104435:	89 d0                	mov    %edx,%eax
c0104437:	c1 e0 02             	shl    $0x2,%eax
c010443a:	01 d0                	add    %edx,%eax
c010443c:	c1 e0 02             	shl    $0x2,%eax
c010443f:	89 c2                	mov    %eax,%edx
c0104441:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104444:	01 d0                	add    %edx,%eax
c0104446:	89 45 e8             	mov    %eax,-0x18(%ebp)
            p->property = page->property - n;
c0104449:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010444c:	8b 40 08             	mov    0x8(%eax),%eax
c010444f:	2b 45 08             	sub    0x8(%ebp),%eax
c0104452:	89 c2                	mov    %eax,%edx
c0104454:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104457:	89 50 08             	mov    %edx,0x8(%eax)
            SetPageProperty(p);
c010445a:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010445d:	83 c0 04             	add    $0x4,%eax
c0104460:	c7 45 cc 01 00 00 00 	movl   $0x1,-0x34(%ebp)
c0104467:	89 45 c8             	mov    %eax,-0x38(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c010446a:	8b 45 c8             	mov    -0x38(%ebp),%eax
c010446d:	8b 55 cc             	mov    -0x34(%ebp),%edx
c0104470:	0f ab 10             	bts    %edx,(%eax)
}
c0104473:	90                   	nop
            // 加入后来的，p
            list_add_after(&(page->page_link), &(p->page_link));
c0104474:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104477:	83 c0 0c             	add    $0xc,%eax
c010447a:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010447d:	83 c2 0c             	add    $0xc,%edx
c0104480:	89 55 e0             	mov    %edx,-0x20(%ebp)
c0104483:	89 45 dc             	mov    %eax,-0x24(%ebp)
    __list_add(elm, listelm, listelm->next);
c0104486:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104489:	8b 40 04             	mov    0x4(%eax),%eax
c010448c:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010448f:	89 55 d8             	mov    %edx,-0x28(%ebp)
c0104492:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0104495:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0104498:	89 45 d0             	mov    %eax,-0x30(%ebp)
    prev->next = next->prev = elm;
c010449b:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010449e:	8b 55 d8             	mov    -0x28(%ebp),%edx
c01044a1:	89 10                	mov    %edx,(%eax)
c01044a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01044a6:	8b 10                	mov    (%eax),%edx
c01044a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01044ab:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c01044ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01044b1:	8b 55 d0             	mov    -0x30(%ebp),%edx
c01044b4:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c01044b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01044ba:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01044bd:	89 10                	mov    %edx,(%eax)
}
c01044bf:	90                   	nop
}
c01044c0:	90                   	nop
            // list_add(&free_list, &(p->page_link));
        }
        // 删除原来的
        list_del(&(page->page_link));
c01044c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01044c4:	83 c0 0c             	add    $0xc,%eax
c01044c7:	89 45 bc             	mov    %eax,-0x44(%ebp)
    __list_del(listelm->prev, listelm->next);
c01044ca:	8b 45 bc             	mov    -0x44(%ebp),%eax
c01044cd:	8b 40 04             	mov    0x4(%eax),%eax
c01044d0:	8b 55 bc             	mov    -0x44(%ebp),%edx
c01044d3:	8b 12                	mov    (%edx),%edx
c01044d5:	89 55 b8             	mov    %edx,-0x48(%ebp)
c01044d8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c01044db:	8b 45 b8             	mov    -0x48(%ebp),%eax
c01044de:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c01044e1:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c01044e4:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c01044e7:	8b 55 b8             	mov    -0x48(%ebp),%edx
c01044ea:	89 10                	mov    %edx,(%eax)
}
c01044ec:	90                   	nop
}
c01044ed:	90                   	nop
        // 更新空余空间的状态
        nr_free -= n;
c01044ee:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c01044f3:	2b 45 08             	sub    0x8(%ebp),%eax
c01044f6:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24
        //page被使用了，所以把它的属性clear掉
        ClearPageProperty(page);
c01044fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01044fe:	83 c0 04             	add    $0x4,%eax
c0104501:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
c0104508:	89 45 c0             	mov    %eax,-0x40(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c010450b:	8b 45 c0             	mov    -0x40(%ebp),%eax
c010450e:	8b 55 c4             	mov    -0x3c(%ebp),%edx
c0104511:	0f b3 10             	btr    %edx,(%eax)
}
c0104514:	90                   	nop
    }
    // 返回page
    return page;
c0104515:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0104518:	c9                   	leave  
c0104519:	c3                   	ret    

c010451a <default_free_pages>:

static void
default_free_pages(struct Page *base, size_t n) {
c010451a:	f3 0f 1e fb          	endbr32 
c010451e:	55                   	push   %ebp
c010451f:	89 e5                	mov    %esp,%ebp
c0104521:	81 ec 98 00 00 00    	sub    $0x98,%esp
    assert(n > 0);
c0104527:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010452b:	75 19                	jne    c0104546 <default_free_pages+0x2c>
c010452d:	68 b0 6a 10 c0       	push   $0xc0106ab0
c0104532:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104537:	68 aa 00 00 00       	push   $0xaa
c010453c:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104541:	e8 d9 be ff ff       	call   c010041f <__panic>
    struct Page *p = base;
c0104546:	8b 45 08             	mov    0x8(%ebp),%eax
c0104549:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) {
c010454c:	e9 8f 00 00 00       	jmp    c01045e0 <default_free_pages+0xc6>
        assert(!PageReserved(p) && !PageProperty(p));
c0104551:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104554:	83 c0 04             	add    $0x4,%eax
c0104557:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c010455e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104561:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104564:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0104567:	0f a3 10             	bt     %edx,(%eax)
c010456a:	19 c0                	sbb    %eax,%eax
c010456c:	89 45 dc             	mov    %eax,-0x24(%ebp)
    return oldbit != 0;
c010456f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0104573:	0f 95 c0             	setne  %al
c0104576:	0f b6 c0             	movzbl %al,%eax
c0104579:	85 c0                	test   %eax,%eax
c010457b:	75 2c                	jne    c01045a9 <default_free_pages+0x8f>
c010457d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104580:	83 c0 04             	add    $0x4,%eax
c0104583:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
c010458a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c010458d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104590:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104593:	0f a3 10             	bt     %edx,(%eax)
c0104596:	19 c0                	sbb    %eax,%eax
c0104598:	89 45 d0             	mov    %eax,-0x30(%ebp)
    return oldbit != 0;
c010459b:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
c010459f:	0f 95 c0             	setne  %al
c01045a2:	0f b6 c0             	movzbl %al,%eax
c01045a5:	85 c0                	test   %eax,%eax
c01045a7:	74 19                	je     c01045c2 <default_free_pages+0xa8>
c01045a9:	68 f4 6a 10 c0       	push   $0xc0106af4
c01045ae:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01045b3:	68 ad 00 00 00       	push   $0xad
c01045b8:	68 cb 6a 10 c0       	push   $0xc0106acb
c01045bd:	e8 5d be ff ff       	call   c010041f <__panic>
        p->flags = 0;
c01045c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01045c5:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
        set_page_ref(p, 0);
c01045cc:	83 ec 08             	sub    $0x8,%esp
c01045cf:	6a 00                	push   $0x0
c01045d1:	ff 75 f4             	pushl  -0xc(%ebp)
c01045d4:	e8 4a fc ff ff       	call   c0104223 <set_page_ref>
c01045d9:	83 c4 10             	add    $0x10,%esp
    for (; p != base + n; p ++) {
c01045dc:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c01045e0:	8b 55 0c             	mov    0xc(%ebp),%edx
c01045e3:	89 d0                	mov    %edx,%eax
c01045e5:	c1 e0 02             	shl    $0x2,%eax
c01045e8:	01 d0                	add    %edx,%eax
c01045ea:	c1 e0 02             	shl    $0x2,%eax
c01045ed:	89 c2                	mov    %eax,%edx
c01045ef:	8b 45 08             	mov    0x8(%ebp),%eax
c01045f2:	01 d0                	add    %edx,%eax
c01045f4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01045f7:	0f 85 54 ff ff ff    	jne    c0104551 <default_free_pages+0x37>
    }
    base->property = n;
c01045fd:	8b 45 08             	mov    0x8(%ebp),%eax
c0104600:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104603:	89 50 08             	mov    %edx,0x8(%eax)
    SetPageProperty(base);
c0104606:	8b 45 08             	mov    0x8(%ebp),%eax
c0104609:	83 c0 04             	add    $0x4,%eax
c010460c:	c7 45 c8 01 00 00 00 	movl   $0x1,-0x38(%ebp)
c0104613:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104616:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0104619:	8b 55 c8             	mov    -0x38(%ebp),%edx
c010461c:	0f ab 10             	bts    %edx,(%eax)
}
c010461f:	90                   	nop
c0104620:	c7 45 cc 1c cf 11 c0 	movl   $0xc011cf1c,-0x34(%ebp)
    return listelm->next;
c0104627:	8b 45 cc             	mov    -0x34(%ebp),%eax
c010462a:	8b 40 04             	mov    0x4(%eax),%eax
     list_entry_t *next_entry = list_next(&free_list);
c010462d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    // 找到base的前一块空块的后一块
    while (next_entry != &free_list && le2page(next_entry, page_link) < base)
c0104630:	eb 0f                	jmp    c0104641 <default_free_pages+0x127>
c0104632:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104635:	89 45 c0             	mov    %eax,-0x40(%ebp)
c0104638:	8b 45 c0             	mov    -0x40(%ebp),%eax
c010463b:	8b 40 04             	mov    0x4(%eax),%eax
        next_entry = list_next(next_entry);
c010463e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (next_entry != &free_list && le2page(next_entry, page_link) < base)
c0104641:	81 7d f0 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x10(%ebp)
c0104648:	74 0b                	je     c0104655 <default_free_pages+0x13b>
c010464a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010464d:	83 e8 0c             	sub    $0xc,%eax
c0104650:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104653:	77 dd                	ja     c0104632 <default_free_pages+0x118>
c0104655:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104658:	89 45 bc             	mov    %eax,-0x44(%ebp)
    return listelm->prev;
c010465b:	8b 45 bc             	mov    -0x44(%ebp),%eax
c010465e:	8b 00                	mov    (%eax),%eax
    // 找到前面那块
    list_entry_t *prev_entry = list_prev(next_entry);
c0104660:	89 45 e8             	mov    %eax,-0x18(%ebp)
    // 找到insert的位置
    list_entry_t *insert_entry = prev_entry;
c0104663:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104666:	89 45 ec             	mov    %eax,-0x14(%ebp)
    // 如果和前一块挨在一起，就和前一块合并
    if (prev_entry != &free_list) {
c0104669:	81 7d e8 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x18(%ebp)
c0104670:	0f 84 91 00 00 00    	je     c0104707 <default_free_pages+0x1ed>
        p = le2page(prev_entry, page_link);
c0104676:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104679:	83 e8 0c             	sub    $0xc,%eax
c010467c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (p + p->property == base) {
c010467f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104682:	8b 50 08             	mov    0x8(%eax),%edx
c0104685:	89 d0                	mov    %edx,%eax
c0104687:	c1 e0 02             	shl    $0x2,%eax
c010468a:	01 d0                	add    %edx,%eax
c010468c:	c1 e0 02             	shl    $0x2,%eax
c010468f:	89 c2                	mov    %eax,%edx
c0104691:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104694:	01 d0                	add    %edx,%eax
c0104696:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104699:	75 6c                	jne    c0104707 <default_free_pages+0x1ed>
            p->property += base->property;
c010469b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010469e:	8b 50 08             	mov    0x8(%eax),%edx
c01046a1:	8b 45 08             	mov    0x8(%ebp),%eax
c01046a4:	8b 40 08             	mov    0x8(%eax),%eax
c01046a7:	01 c2                	add    %eax,%edx
c01046a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01046ac:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(base);
c01046af:	8b 45 08             	mov    0x8(%ebp),%eax
c01046b2:	83 c0 04             	add    $0x4,%eax
c01046b5:	c7 45 a8 01 00 00 00 	movl   $0x1,-0x58(%ebp)
c01046bc:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01046bf:	8b 45 a4             	mov    -0x5c(%ebp),%eax
c01046c2:	8b 55 a8             	mov    -0x58(%ebp),%edx
c01046c5:	0f b3 10             	btr    %edx,(%eax)
}
c01046c8:	90                   	nop
            base = p;
c01046c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01046cc:	89 45 08             	mov    %eax,0x8(%ebp)
c01046cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01046d2:	89 45 ac             	mov    %eax,-0x54(%ebp)
c01046d5:	8b 45 ac             	mov    -0x54(%ebp),%eax
c01046d8:	8b 00                	mov    (%eax),%eax
            insert_entry = list_prev(prev_entry);
c01046da:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01046dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01046e0:	89 45 b8             	mov    %eax,-0x48(%ebp)
    __list_del(listelm->prev, listelm->next);
c01046e3:	8b 45 b8             	mov    -0x48(%ebp),%eax
c01046e6:	8b 40 04             	mov    0x4(%eax),%eax
c01046e9:	8b 55 b8             	mov    -0x48(%ebp),%edx
c01046ec:	8b 12                	mov    (%edx),%edx
c01046ee:	89 55 b4             	mov    %edx,-0x4c(%ebp)
c01046f1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    prev->next = next;
c01046f4:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c01046f7:	8b 55 b0             	mov    -0x50(%ebp),%edx
c01046fa:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c01046fd:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104700:	8b 55 b4             	mov    -0x4c(%ebp),%edx
c0104703:	89 10                	mov    %edx,(%eax)
}
c0104705:	90                   	nop
}
c0104706:	90                   	nop
            list_del(prev_entry);
        }
    }
	// 后一块
    if (next_entry != &free_list) {
c0104707:	81 7d f0 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x10(%ebp)
c010470e:	74 7d                	je     c010478d <default_free_pages+0x273>
        p = le2page(next_entry, page_link);
c0104710:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104713:	83 e8 0c             	sub    $0xc,%eax
c0104716:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (base + base->property == p) {
c0104719:	8b 45 08             	mov    0x8(%ebp),%eax
c010471c:	8b 50 08             	mov    0x8(%eax),%edx
c010471f:	89 d0                	mov    %edx,%eax
c0104721:	c1 e0 02             	shl    $0x2,%eax
c0104724:	01 d0                	add    %edx,%eax
c0104726:	c1 e0 02             	shl    $0x2,%eax
c0104729:	89 c2                	mov    %eax,%edx
c010472b:	8b 45 08             	mov    0x8(%ebp),%eax
c010472e:	01 d0                	add    %edx,%eax
c0104730:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0104733:	75 58                	jne    c010478d <default_free_pages+0x273>
            base->property += p->property;
c0104735:	8b 45 08             	mov    0x8(%ebp),%eax
c0104738:	8b 50 08             	mov    0x8(%eax),%edx
c010473b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010473e:	8b 40 08             	mov    0x8(%eax),%eax
c0104741:	01 c2                	add    %eax,%edx
c0104743:	8b 45 08             	mov    0x8(%ebp),%eax
c0104746:	89 50 08             	mov    %edx,0x8(%eax)
            ClearPageProperty(p);
c0104749:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010474c:	83 c0 04             	add    $0x4,%eax
c010474f:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
c0104756:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104759:	8b 45 90             	mov    -0x70(%ebp),%eax
c010475c:	8b 55 94             	mov    -0x6c(%ebp),%edx
c010475f:	0f b3 10             	btr    %edx,(%eax)
}
c0104762:	90                   	nop
c0104763:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104766:	89 45 a0             	mov    %eax,-0x60(%ebp)
    __list_del(listelm->prev, listelm->next);
c0104769:	8b 45 a0             	mov    -0x60(%ebp),%eax
c010476c:	8b 40 04             	mov    0x4(%eax),%eax
c010476f:	8b 55 a0             	mov    -0x60(%ebp),%edx
c0104772:	8b 12                	mov    (%edx),%edx
c0104774:	89 55 9c             	mov    %edx,-0x64(%ebp)
c0104777:	89 45 98             	mov    %eax,-0x68(%ebp)
    prev->next = next;
c010477a:	8b 45 9c             	mov    -0x64(%ebp),%eax
c010477d:	8b 55 98             	mov    -0x68(%ebp),%edx
c0104780:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c0104783:	8b 45 98             	mov    -0x68(%ebp),%eax
c0104786:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0104789:	89 10                	mov    %edx,(%eax)
}
c010478b:	90                   	nop
}
c010478c:	90                   	nop
            list_del(next_entry);
        }
    }
    // 加一下
    nr_free += n;
c010478d:	8b 15 24 cf 11 c0    	mov    0xc011cf24,%edx
c0104793:	8b 45 0c             	mov    0xc(%ebp),%eax
c0104796:	01 d0                	add    %edx,%eax
c0104798:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24
    list_add(insert_entry, &(base->page_link));
c010479d:	8b 45 08             	mov    0x8(%ebp),%eax
c01047a0:	8d 50 0c             	lea    0xc(%eax),%edx
c01047a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01047a6:	89 45 8c             	mov    %eax,-0x74(%ebp)
c01047a9:	89 55 88             	mov    %edx,-0x78(%ebp)
c01047ac:	8b 45 8c             	mov    -0x74(%ebp),%eax
c01047af:	89 45 84             	mov    %eax,-0x7c(%ebp)
c01047b2:	8b 45 88             	mov    -0x78(%ebp),%eax
c01047b5:	89 45 80             	mov    %eax,-0x80(%ebp)
    __list_add(elm, listelm, listelm->next);
c01047b8:	8b 45 84             	mov    -0x7c(%ebp),%eax
c01047bb:	8b 40 04             	mov    0x4(%eax),%eax
c01047be:	8b 55 80             	mov    -0x80(%ebp),%edx
c01047c1:	89 95 7c ff ff ff    	mov    %edx,-0x84(%ebp)
c01047c7:	8b 55 84             	mov    -0x7c(%ebp),%edx
c01047ca:	89 95 78 ff ff ff    	mov    %edx,-0x88(%ebp)
c01047d0:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
    prev->next = next->prev = elm;
c01047d6:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
c01047dc:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
c01047e2:	89 10                	mov    %edx,(%eax)
c01047e4:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
c01047ea:	8b 10                	mov    (%eax),%edx
c01047ec:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
c01047f2:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c01047f5:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
c01047fb:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
c0104801:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c0104804:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
c010480a:	8b 95 78 ff ff ff    	mov    -0x88(%ebp),%edx
c0104810:	89 10                	mov    %edx,(%eax)
}
c0104812:	90                   	nop
}
c0104813:	90                   	nop
}
c0104814:	90                   	nop
}
c0104815:	90                   	nop
c0104816:	c9                   	leave  
c0104817:	c3                   	ret    

c0104818 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
c0104818:	f3 0f 1e fb          	endbr32 
c010481c:	55                   	push   %ebp
c010481d:	89 e5                	mov    %esp,%ebp
    return nr_free;
c010481f:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
}
c0104824:	5d                   	pop    %ebp
c0104825:	c3                   	ret    

c0104826 <basic_check>:

static void
basic_check(void) {
c0104826:	f3 0f 1e fb          	endbr32 
c010482a:	55                   	push   %ebp
c010482b:	89 e5                	mov    %esp,%ebp
c010482d:	83 ec 38             	sub    $0x38,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
c0104830:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104837:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010483a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010483d:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104840:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
c0104843:	83 ec 0c             	sub    $0xc,%esp
c0104846:	6a 01                	push   $0x1
c0104848:	e8 38 e6 ff ff       	call   c0102e85 <alloc_pages>
c010484d:	83 c4 10             	add    $0x10,%esp
c0104850:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104853:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104857:	75 19                	jne    c0104872 <basic_check+0x4c>
c0104859:	68 19 6b 10 c0       	push   $0xc0106b19
c010485e:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104863:	68 dd 00 00 00       	push   $0xdd
c0104868:	68 cb 6a 10 c0       	push   $0xc0106acb
c010486d:	e8 ad bb ff ff       	call   c010041f <__panic>
    assert((p1 = alloc_page()) != NULL);
c0104872:	83 ec 0c             	sub    $0xc,%esp
c0104875:	6a 01                	push   $0x1
c0104877:	e8 09 e6 ff ff       	call   c0102e85 <alloc_pages>
c010487c:	83 c4 10             	add    $0x10,%esp
c010487f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104882:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104886:	75 19                	jne    c01048a1 <basic_check+0x7b>
c0104888:	68 35 6b 10 c0       	push   $0xc0106b35
c010488d:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104892:	68 de 00 00 00       	push   $0xde
c0104897:	68 cb 6a 10 c0       	push   $0xc0106acb
c010489c:	e8 7e bb ff ff       	call   c010041f <__panic>
    assert((p2 = alloc_page()) != NULL);
c01048a1:	83 ec 0c             	sub    $0xc,%esp
c01048a4:	6a 01                	push   $0x1
c01048a6:	e8 da e5 ff ff       	call   c0102e85 <alloc_pages>
c01048ab:	83 c4 10             	add    $0x10,%esp
c01048ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01048b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01048b5:	75 19                	jne    c01048d0 <basic_check+0xaa>
c01048b7:	68 51 6b 10 c0       	push   $0xc0106b51
c01048bc:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01048c1:	68 df 00 00 00       	push   $0xdf
c01048c6:	68 cb 6a 10 c0       	push   $0xc0106acb
c01048cb:	e8 4f bb ff ff       	call   c010041f <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
c01048d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01048d3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
c01048d6:	74 10                	je     c01048e8 <basic_check+0xc2>
c01048d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01048db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c01048de:	74 08                	je     c01048e8 <basic_check+0xc2>
c01048e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01048e3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c01048e6:	75 19                	jne    c0104901 <basic_check+0xdb>
c01048e8:	68 70 6b 10 c0       	push   $0xc0106b70
c01048ed:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01048f2:	68 e1 00 00 00       	push   $0xe1
c01048f7:	68 cb 6a 10 c0       	push   $0xc0106acb
c01048fc:	e8 1e bb ff ff       	call   c010041f <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
c0104901:	83 ec 0c             	sub    $0xc,%esp
c0104904:	ff 75 ec             	pushl  -0x14(%ebp)
c0104907:	e8 0d f9 ff ff       	call   c0104219 <page_ref>
c010490c:	83 c4 10             	add    $0x10,%esp
c010490f:	85 c0                	test   %eax,%eax
c0104911:	75 24                	jne    c0104937 <basic_check+0x111>
c0104913:	83 ec 0c             	sub    $0xc,%esp
c0104916:	ff 75 f0             	pushl  -0x10(%ebp)
c0104919:	e8 fb f8 ff ff       	call   c0104219 <page_ref>
c010491e:	83 c4 10             	add    $0x10,%esp
c0104921:	85 c0                	test   %eax,%eax
c0104923:	75 12                	jne    c0104937 <basic_check+0x111>
c0104925:	83 ec 0c             	sub    $0xc,%esp
c0104928:	ff 75 f4             	pushl  -0xc(%ebp)
c010492b:	e8 e9 f8 ff ff       	call   c0104219 <page_ref>
c0104930:	83 c4 10             	add    $0x10,%esp
c0104933:	85 c0                	test   %eax,%eax
c0104935:	74 19                	je     c0104950 <basic_check+0x12a>
c0104937:	68 94 6b 10 c0       	push   $0xc0106b94
c010493c:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104941:	68 e2 00 00 00       	push   $0xe2
c0104946:	68 cb 6a 10 c0       	push   $0xc0106acb
c010494b:	e8 cf ba ff ff       	call   c010041f <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
c0104950:	83 ec 0c             	sub    $0xc,%esp
c0104953:	ff 75 ec             	pushl  -0x14(%ebp)
c0104956:	e8 ab f8 ff ff       	call   c0104206 <page2pa>
c010495b:	83 c4 10             	add    $0x10,%esp
c010495e:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c0104964:	c1 e2 0c             	shl    $0xc,%edx
c0104967:	39 d0                	cmp    %edx,%eax
c0104969:	72 19                	jb     c0104984 <basic_check+0x15e>
c010496b:	68 d0 6b 10 c0       	push   $0xc0106bd0
c0104970:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104975:	68 e4 00 00 00       	push   $0xe4
c010497a:	68 cb 6a 10 c0       	push   $0xc0106acb
c010497f:	e8 9b ba ff ff       	call   c010041f <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
c0104984:	83 ec 0c             	sub    $0xc,%esp
c0104987:	ff 75 f0             	pushl  -0x10(%ebp)
c010498a:	e8 77 f8 ff ff       	call   c0104206 <page2pa>
c010498f:	83 c4 10             	add    $0x10,%esp
c0104992:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c0104998:	c1 e2 0c             	shl    $0xc,%edx
c010499b:	39 d0                	cmp    %edx,%eax
c010499d:	72 19                	jb     c01049b8 <basic_check+0x192>
c010499f:	68 ed 6b 10 c0       	push   $0xc0106bed
c01049a4:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01049a9:	68 e5 00 00 00       	push   $0xe5
c01049ae:	68 cb 6a 10 c0       	push   $0xc0106acb
c01049b3:	e8 67 ba ff ff       	call   c010041f <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
c01049b8:	83 ec 0c             	sub    $0xc,%esp
c01049bb:	ff 75 f4             	pushl  -0xc(%ebp)
c01049be:	e8 43 f8 ff ff       	call   c0104206 <page2pa>
c01049c3:	83 c4 10             	add    $0x10,%esp
c01049c6:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c01049cc:	c1 e2 0c             	shl    $0xc,%edx
c01049cf:	39 d0                	cmp    %edx,%eax
c01049d1:	72 19                	jb     c01049ec <basic_check+0x1c6>
c01049d3:	68 0a 6c 10 c0       	push   $0xc0106c0a
c01049d8:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01049dd:	68 e6 00 00 00       	push   $0xe6
c01049e2:	68 cb 6a 10 c0       	push   $0xc0106acb
c01049e7:	e8 33 ba ff ff       	call   c010041f <__panic>

    list_entry_t free_list_store = free_list;
c01049ec:	a1 1c cf 11 c0       	mov    0xc011cf1c,%eax
c01049f1:	8b 15 20 cf 11 c0    	mov    0xc011cf20,%edx
c01049f7:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01049fa:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c01049fd:	c7 45 dc 1c cf 11 c0 	movl   $0xc011cf1c,-0x24(%ebp)
    elm->prev = elm->next = elm;
c0104a04:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104a07:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104a0a:	89 50 04             	mov    %edx,0x4(%eax)
c0104a0d:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104a10:	8b 50 04             	mov    0x4(%eax),%edx
c0104a13:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104a16:	89 10                	mov    %edx,(%eax)
}
c0104a18:	90                   	nop
c0104a19:	c7 45 e0 1c cf 11 c0 	movl   $0xc011cf1c,-0x20(%ebp)
    return list->next == list;
c0104a20:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104a23:	8b 40 04             	mov    0x4(%eax),%eax
c0104a26:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0104a29:	0f 94 c0             	sete   %al
c0104a2c:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0104a2f:	85 c0                	test   %eax,%eax
c0104a31:	75 19                	jne    c0104a4c <basic_check+0x226>
c0104a33:	68 27 6c 10 c0       	push   $0xc0106c27
c0104a38:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104a3d:	68 ea 00 00 00       	push   $0xea
c0104a42:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104a47:	e8 d3 b9 ff ff       	call   c010041f <__panic>

    unsigned int nr_free_store = nr_free;
c0104a4c:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104a51:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
c0104a54:	c7 05 24 cf 11 c0 00 	movl   $0x0,0xc011cf24
c0104a5b:	00 00 00 

    assert(alloc_page() == NULL);
c0104a5e:	83 ec 0c             	sub    $0xc,%esp
c0104a61:	6a 01                	push   $0x1
c0104a63:	e8 1d e4 ff ff       	call   c0102e85 <alloc_pages>
c0104a68:	83 c4 10             	add    $0x10,%esp
c0104a6b:	85 c0                	test   %eax,%eax
c0104a6d:	74 19                	je     c0104a88 <basic_check+0x262>
c0104a6f:	68 3e 6c 10 c0       	push   $0xc0106c3e
c0104a74:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104a79:	68 ef 00 00 00       	push   $0xef
c0104a7e:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104a83:	e8 97 b9 ff ff       	call   c010041f <__panic>

    free_page(p0);
c0104a88:	83 ec 08             	sub    $0x8,%esp
c0104a8b:	6a 01                	push   $0x1
c0104a8d:	ff 75 ec             	pushl  -0x14(%ebp)
c0104a90:	e8 32 e4 ff ff       	call   c0102ec7 <free_pages>
c0104a95:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
c0104a98:	83 ec 08             	sub    $0x8,%esp
c0104a9b:	6a 01                	push   $0x1
c0104a9d:	ff 75 f0             	pushl  -0x10(%ebp)
c0104aa0:	e8 22 e4 ff ff       	call   c0102ec7 <free_pages>
c0104aa5:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c0104aa8:	83 ec 08             	sub    $0x8,%esp
c0104aab:	6a 01                	push   $0x1
c0104aad:	ff 75 f4             	pushl  -0xc(%ebp)
c0104ab0:	e8 12 e4 ff ff       	call   c0102ec7 <free_pages>
c0104ab5:	83 c4 10             	add    $0x10,%esp
    assert(nr_free == 3);
c0104ab8:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104abd:	83 f8 03             	cmp    $0x3,%eax
c0104ac0:	74 19                	je     c0104adb <basic_check+0x2b5>
c0104ac2:	68 53 6c 10 c0       	push   $0xc0106c53
c0104ac7:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104acc:	68 f4 00 00 00       	push   $0xf4
c0104ad1:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104ad6:	e8 44 b9 ff ff       	call   c010041f <__panic>

    assert((p0 = alloc_page()) != NULL);
c0104adb:	83 ec 0c             	sub    $0xc,%esp
c0104ade:	6a 01                	push   $0x1
c0104ae0:	e8 a0 e3 ff ff       	call   c0102e85 <alloc_pages>
c0104ae5:	83 c4 10             	add    $0x10,%esp
c0104ae8:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104aeb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104aef:	75 19                	jne    c0104b0a <basic_check+0x2e4>
c0104af1:	68 19 6b 10 c0       	push   $0xc0106b19
c0104af6:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104afb:	68 f6 00 00 00       	push   $0xf6
c0104b00:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104b05:	e8 15 b9 ff ff       	call   c010041f <__panic>
    assert((p1 = alloc_page()) != NULL);
c0104b0a:	83 ec 0c             	sub    $0xc,%esp
c0104b0d:	6a 01                	push   $0x1
c0104b0f:	e8 71 e3 ff ff       	call   c0102e85 <alloc_pages>
c0104b14:	83 c4 10             	add    $0x10,%esp
c0104b17:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104b1a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104b1e:	75 19                	jne    c0104b39 <basic_check+0x313>
c0104b20:	68 35 6b 10 c0       	push   $0xc0106b35
c0104b25:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104b2a:	68 f7 00 00 00       	push   $0xf7
c0104b2f:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104b34:	e8 e6 b8 ff ff       	call   c010041f <__panic>
    assert((p2 = alloc_page()) != NULL);
c0104b39:	83 ec 0c             	sub    $0xc,%esp
c0104b3c:	6a 01                	push   $0x1
c0104b3e:	e8 42 e3 ff ff       	call   c0102e85 <alloc_pages>
c0104b43:	83 c4 10             	add    $0x10,%esp
c0104b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104b49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104b4d:	75 19                	jne    c0104b68 <basic_check+0x342>
c0104b4f:	68 51 6b 10 c0       	push   $0xc0106b51
c0104b54:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104b59:	68 f8 00 00 00       	push   $0xf8
c0104b5e:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104b63:	e8 b7 b8 ff ff       	call   c010041f <__panic>

    assert(alloc_page() == NULL);
c0104b68:	83 ec 0c             	sub    $0xc,%esp
c0104b6b:	6a 01                	push   $0x1
c0104b6d:	e8 13 e3 ff ff       	call   c0102e85 <alloc_pages>
c0104b72:	83 c4 10             	add    $0x10,%esp
c0104b75:	85 c0                	test   %eax,%eax
c0104b77:	74 19                	je     c0104b92 <basic_check+0x36c>
c0104b79:	68 3e 6c 10 c0       	push   $0xc0106c3e
c0104b7e:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104b83:	68 fa 00 00 00       	push   $0xfa
c0104b88:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104b8d:	e8 8d b8 ff ff       	call   c010041f <__panic>

    free_page(p0);
c0104b92:	83 ec 08             	sub    $0x8,%esp
c0104b95:	6a 01                	push   $0x1
c0104b97:	ff 75 ec             	pushl  -0x14(%ebp)
c0104b9a:	e8 28 e3 ff ff       	call   c0102ec7 <free_pages>
c0104b9f:	83 c4 10             	add    $0x10,%esp
c0104ba2:	c7 45 d8 1c cf 11 c0 	movl   $0xc011cf1c,-0x28(%ebp)
c0104ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104bac:	8b 40 04             	mov    0x4(%eax),%eax
c0104baf:	39 45 d8             	cmp    %eax,-0x28(%ebp)
c0104bb2:	0f 94 c0             	sete   %al
c0104bb5:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
c0104bb8:	85 c0                	test   %eax,%eax
c0104bba:	74 19                	je     c0104bd5 <basic_check+0x3af>
c0104bbc:	68 60 6c 10 c0       	push   $0xc0106c60
c0104bc1:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104bc6:	68 fd 00 00 00       	push   $0xfd
c0104bcb:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104bd0:	e8 4a b8 ff ff       	call   c010041f <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
c0104bd5:	83 ec 0c             	sub    $0xc,%esp
c0104bd8:	6a 01                	push   $0x1
c0104bda:	e8 a6 e2 ff ff       	call   c0102e85 <alloc_pages>
c0104bdf:	83 c4 10             	add    $0x10,%esp
c0104be2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104be5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104be8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0104beb:	74 19                	je     c0104c06 <basic_check+0x3e0>
c0104bed:	68 78 6c 10 c0       	push   $0xc0106c78
c0104bf2:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104bf7:	68 00 01 00 00       	push   $0x100
c0104bfc:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104c01:	e8 19 b8 ff ff       	call   c010041f <__panic>
    assert(alloc_page() == NULL);
c0104c06:	83 ec 0c             	sub    $0xc,%esp
c0104c09:	6a 01                	push   $0x1
c0104c0b:	e8 75 e2 ff ff       	call   c0102e85 <alloc_pages>
c0104c10:	83 c4 10             	add    $0x10,%esp
c0104c13:	85 c0                	test   %eax,%eax
c0104c15:	74 19                	je     c0104c30 <basic_check+0x40a>
c0104c17:	68 3e 6c 10 c0       	push   $0xc0106c3e
c0104c1c:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104c21:	68 01 01 00 00       	push   $0x101
c0104c26:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104c2b:	e8 ef b7 ff ff       	call   c010041f <__panic>

    assert(nr_free == 0);
c0104c30:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104c35:	85 c0                	test   %eax,%eax
c0104c37:	74 19                	je     c0104c52 <basic_check+0x42c>
c0104c39:	68 91 6c 10 c0       	push   $0xc0106c91
c0104c3e:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104c43:	68 03 01 00 00       	push   $0x103
c0104c48:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104c4d:	e8 cd b7 ff ff       	call   c010041f <__panic>
    free_list = free_list_store;
c0104c52:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104c55:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104c58:	a3 1c cf 11 c0       	mov    %eax,0xc011cf1c
c0104c5d:	89 15 20 cf 11 c0    	mov    %edx,0xc011cf20
    nr_free = nr_free_store;
c0104c63:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104c66:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24

    free_page(p);
c0104c6b:	83 ec 08             	sub    $0x8,%esp
c0104c6e:	6a 01                	push   $0x1
c0104c70:	ff 75 e4             	pushl  -0x1c(%ebp)
c0104c73:	e8 4f e2 ff ff       	call   c0102ec7 <free_pages>
c0104c78:	83 c4 10             	add    $0x10,%esp
    free_page(p1);
c0104c7b:	83 ec 08             	sub    $0x8,%esp
c0104c7e:	6a 01                	push   $0x1
c0104c80:	ff 75 f0             	pushl  -0x10(%ebp)
c0104c83:	e8 3f e2 ff ff       	call   c0102ec7 <free_pages>
c0104c88:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c0104c8b:	83 ec 08             	sub    $0x8,%esp
c0104c8e:	6a 01                	push   $0x1
c0104c90:	ff 75 f4             	pushl  -0xc(%ebp)
c0104c93:	e8 2f e2 ff ff       	call   c0102ec7 <free_pages>
c0104c98:	83 c4 10             	add    $0x10,%esp
}
c0104c9b:	90                   	nop
c0104c9c:	c9                   	leave  
c0104c9d:	c3                   	ret    

c0104c9e <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
c0104c9e:	f3 0f 1e fb          	endbr32 
c0104ca2:	55                   	push   %ebp
c0104ca3:	89 e5                	mov    %esp,%ebp
c0104ca5:	81 ec 88 00 00 00    	sub    $0x88,%esp
    int count = 0, total = 0;
c0104cab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104cb2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
c0104cb9:	c7 45 ec 1c cf 11 c0 	movl   $0xc011cf1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0104cc0:	eb 60                	jmp    c0104d22 <default_check+0x84>
        struct Page *p = le2page(le, page_link);
c0104cc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104cc5:	83 e8 0c             	sub    $0xc,%eax
c0104cc8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        assert(PageProperty(p));
c0104ccb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104cce:	83 c0 04             	add    $0x4,%eax
c0104cd1:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c0104cd8:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104cdb:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104cde:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104ce1:	0f a3 10             	bt     %edx,(%eax)
c0104ce4:	19 c0                	sbb    %eax,%eax
c0104ce6:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
c0104ce9:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
c0104ced:	0f 95 c0             	setne  %al
c0104cf0:	0f b6 c0             	movzbl %al,%eax
c0104cf3:	85 c0                	test   %eax,%eax
c0104cf5:	75 19                	jne    c0104d10 <default_check+0x72>
c0104cf7:	68 9e 6c 10 c0       	push   $0xc0106c9e
c0104cfc:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104d01:	68 14 01 00 00       	push   $0x114
c0104d06:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104d0b:	e8 0f b7 ff ff       	call   c010041f <__panic>
        count ++, total += p->property;
c0104d10:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
c0104d14:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104d17:	8b 50 08             	mov    0x8(%eax),%edx
c0104d1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104d1d:	01 d0                	add    %edx,%eax
c0104d1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104d22:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104d25:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
c0104d28:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0104d2b:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c0104d2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104d31:	81 7d ec 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x14(%ebp)
c0104d38:	75 88                	jne    c0104cc2 <default_check+0x24>
    }
    assert(total == nr_free_pages());
c0104d3a:	e8 c1 e1 ff ff       	call   c0102f00 <nr_free_pages>
c0104d3f:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0104d42:	39 d0                	cmp    %edx,%eax
c0104d44:	74 19                	je     c0104d5f <default_check+0xc1>
c0104d46:	68 ae 6c 10 c0       	push   $0xc0106cae
c0104d4b:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104d50:	68 17 01 00 00       	push   $0x117
c0104d55:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104d5a:	e8 c0 b6 ff ff       	call   c010041f <__panic>

    basic_check();
c0104d5f:	e8 c2 fa ff ff       	call   c0104826 <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
c0104d64:	83 ec 0c             	sub    $0xc,%esp
c0104d67:	6a 05                	push   $0x5
c0104d69:	e8 17 e1 ff ff       	call   c0102e85 <alloc_pages>
c0104d6e:	83 c4 10             	add    $0x10,%esp
c0104d71:	89 45 e8             	mov    %eax,-0x18(%ebp)
    assert(p0 != NULL);
c0104d74:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0104d78:	75 19                	jne    c0104d93 <default_check+0xf5>
c0104d7a:	68 c7 6c 10 c0       	push   $0xc0106cc7
c0104d7f:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104d84:	68 1c 01 00 00       	push   $0x11c
c0104d89:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104d8e:	e8 8c b6 ff ff       	call   c010041f <__panic>
    assert(!PageProperty(p0));
c0104d93:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104d96:	83 c0 04             	add    $0x4,%eax
c0104d99:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
c0104da0:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104da3:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0104da6:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0104da9:	0f a3 10             	bt     %edx,(%eax)
c0104dac:	19 c0                	sbb    %eax,%eax
c0104dae:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
c0104db1:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
c0104db5:	0f 95 c0             	setne  %al
c0104db8:	0f b6 c0             	movzbl %al,%eax
c0104dbb:	85 c0                	test   %eax,%eax
c0104dbd:	74 19                	je     c0104dd8 <default_check+0x13a>
c0104dbf:	68 d2 6c 10 c0       	push   $0xc0106cd2
c0104dc4:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104dc9:	68 1d 01 00 00       	push   $0x11d
c0104dce:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104dd3:	e8 47 b6 ff ff       	call   c010041f <__panic>

    list_entry_t free_list_store = free_list;
c0104dd8:	a1 1c cf 11 c0       	mov    0xc011cf1c,%eax
c0104ddd:	8b 15 20 cf 11 c0    	mov    0xc011cf20,%edx
c0104de3:	89 45 80             	mov    %eax,-0x80(%ebp)
c0104de6:	89 55 84             	mov    %edx,-0x7c(%ebp)
c0104de9:	c7 45 b0 1c cf 11 c0 	movl   $0xc011cf1c,-0x50(%ebp)
    elm->prev = elm->next = elm;
c0104df0:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104df3:	8b 55 b0             	mov    -0x50(%ebp),%edx
c0104df6:	89 50 04             	mov    %edx,0x4(%eax)
c0104df9:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104dfc:	8b 50 04             	mov    0x4(%eax),%edx
c0104dff:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104e02:	89 10                	mov    %edx,(%eax)
}
c0104e04:	90                   	nop
c0104e05:	c7 45 b4 1c cf 11 c0 	movl   $0xc011cf1c,-0x4c(%ebp)
    return list->next == list;
c0104e0c:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104e0f:	8b 40 04             	mov    0x4(%eax),%eax
c0104e12:	39 45 b4             	cmp    %eax,-0x4c(%ebp)
c0104e15:	0f 94 c0             	sete   %al
c0104e18:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0104e1b:	85 c0                	test   %eax,%eax
c0104e1d:	75 19                	jne    c0104e38 <default_check+0x19a>
c0104e1f:	68 27 6c 10 c0       	push   $0xc0106c27
c0104e24:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104e29:	68 21 01 00 00       	push   $0x121
c0104e2e:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104e33:	e8 e7 b5 ff ff       	call   c010041f <__panic>
    assert(alloc_page() == NULL);
c0104e38:	83 ec 0c             	sub    $0xc,%esp
c0104e3b:	6a 01                	push   $0x1
c0104e3d:	e8 43 e0 ff ff       	call   c0102e85 <alloc_pages>
c0104e42:	83 c4 10             	add    $0x10,%esp
c0104e45:	85 c0                	test   %eax,%eax
c0104e47:	74 19                	je     c0104e62 <default_check+0x1c4>
c0104e49:	68 3e 6c 10 c0       	push   $0xc0106c3e
c0104e4e:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104e53:	68 22 01 00 00       	push   $0x122
c0104e58:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104e5d:	e8 bd b5 ff ff       	call   c010041f <__panic>

    unsigned int nr_free_store = nr_free;
c0104e62:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104e67:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nr_free = 0;
c0104e6a:	c7 05 24 cf 11 c0 00 	movl   $0x0,0xc011cf24
c0104e71:	00 00 00 

    free_pages(p0 + 2, 3);
c0104e74:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104e77:	83 c0 28             	add    $0x28,%eax
c0104e7a:	83 ec 08             	sub    $0x8,%esp
c0104e7d:	6a 03                	push   $0x3
c0104e7f:	50                   	push   %eax
c0104e80:	e8 42 e0 ff ff       	call   c0102ec7 <free_pages>
c0104e85:	83 c4 10             	add    $0x10,%esp
    assert(alloc_pages(4) == NULL);
c0104e88:	83 ec 0c             	sub    $0xc,%esp
c0104e8b:	6a 04                	push   $0x4
c0104e8d:	e8 f3 df ff ff       	call   c0102e85 <alloc_pages>
c0104e92:	83 c4 10             	add    $0x10,%esp
c0104e95:	85 c0                	test   %eax,%eax
c0104e97:	74 19                	je     c0104eb2 <default_check+0x214>
c0104e99:	68 e4 6c 10 c0       	push   $0xc0106ce4
c0104e9e:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104ea3:	68 28 01 00 00       	push   $0x128
c0104ea8:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104ead:	e8 6d b5 ff ff       	call   c010041f <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
c0104eb2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104eb5:	83 c0 28             	add    $0x28,%eax
c0104eb8:	83 c0 04             	add    $0x4,%eax
c0104ebb:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c0104ec2:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104ec5:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0104ec8:	8b 55 ac             	mov    -0x54(%ebp),%edx
c0104ecb:	0f a3 10             	bt     %edx,(%eax)
c0104ece:	19 c0                	sbb    %eax,%eax
c0104ed0:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
c0104ed3:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c0104ed7:	0f 95 c0             	setne  %al
c0104eda:	0f b6 c0             	movzbl %al,%eax
c0104edd:	85 c0                	test   %eax,%eax
c0104edf:	74 0e                	je     c0104eef <default_check+0x251>
c0104ee1:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104ee4:	83 c0 28             	add    $0x28,%eax
c0104ee7:	8b 40 08             	mov    0x8(%eax),%eax
c0104eea:	83 f8 03             	cmp    $0x3,%eax
c0104eed:	74 19                	je     c0104f08 <default_check+0x26a>
c0104eef:	68 fc 6c 10 c0       	push   $0xc0106cfc
c0104ef4:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104ef9:	68 29 01 00 00       	push   $0x129
c0104efe:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104f03:	e8 17 b5 ff ff       	call   c010041f <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
c0104f08:	83 ec 0c             	sub    $0xc,%esp
c0104f0b:	6a 03                	push   $0x3
c0104f0d:	e8 73 df ff ff       	call   c0102e85 <alloc_pages>
c0104f12:	83 c4 10             	add    $0x10,%esp
c0104f15:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0104f18:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c0104f1c:	75 19                	jne    c0104f37 <default_check+0x299>
c0104f1e:	68 28 6d 10 c0       	push   $0xc0106d28
c0104f23:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104f28:	68 2a 01 00 00       	push   $0x12a
c0104f2d:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104f32:	e8 e8 b4 ff ff       	call   c010041f <__panic>
    assert(alloc_page() == NULL);
c0104f37:	83 ec 0c             	sub    $0xc,%esp
c0104f3a:	6a 01                	push   $0x1
c0104f3c:	e8 44 df ff ff       	call   c0102e85 <alloc_pages>
c0104f41:	83 c4 10             	add    $0x10,%esp
c0104f44:	85 c0                	test   %eax,%eax
c0104f46:	74 19                	je     c0104f61 <default_check+0x2c3>
c0104f48:	68 3e 6c 10 c0       	push   $0xc0106c3e
c0104f4d:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104f52:	68 2b 01 00 00       	push   $0x12b
c0104f57:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104f5c:	e8 be b4 ff ff       	call   c010041f <__panic>
    assert(p0 + 2 == p1);
c0104f61:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104f64:	83 c0 28             	add    $0x28,%eax
c0104f67:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0104f6a:	74 19                	je     c0104f85 <default_check+0x2e7>
c0104f6c:	68 46 6d 10 c0       	push   $0xc0106d46
c0104f71:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104f76:	68 2c 01 00 00       	push   $0x12c
c0104f7b:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104f80:	e8 9a b4 ff ff       	call   c010041f <__panic>

    p2 = p0 + 1;
c0104f85:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104f88:	83 c0 14             	add    $0x14,%eax
c0104f8b:	89 45 dc             	mov    %eax,-0x24(%ebp)
    free_page(p0);
c0104f8e:	83 ec 08             	sub    $0x8,%esp
c0104f91:	6a 01                	push   $0x1
c0104f93:	ff 75 e8             	pushl  -0x18(%ebp)
c0104f96:	e8 2c df ff ff       	call   c0102ec7 <free_pages>
c0104f9b:	83 c4 10             	add    $0x10,%esp
    free_pages(p1, 3);
c0104f9e:	83 ec 08             	sub    $0x8,%esp
c0104fa1:	6a 03                	push   $0x3
c0104fa3:	ff 75 e0             	pushl  -0x20(%ebp)
c0104fa6:	e8 1c df ff ff       	call   c0102ec7 <free_pages>
c0104fab:	83 c4 10             	add    $0x10,%esp
    assert(PageProperty(p0) && p0->property == 1);
c0104fae:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104fb1:	83 c0 04             	add    $0x4,%eax
c0104fb4:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
c0104fbb:	89 45 9c             	mov    %eax,-0x64(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104fbe:	8b 45 9c             	mov    -0x64(%ebp),%eax
c0104fc1:	8b 55 a0             	mov    -0x60(%ebp),%edx
c0104fc4:	0f a3 10             	bt     %edx,(%eax)
c0104fc7:	19 c0                	sbb    %eax,%eax
c0104fc9:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
c0104fcc:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
c0104fd0:	0f 95 c0             	setne  %al
c0104fd3:	0f b6 c0             	movzbl %al,%eax
c0104fd6:	85 c0                	test   %eax,%eax
c0104fd8:	74 0b                	je     c0104fe5 <default_check+0x347>
c0104fda:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104fdd:	8b 40 08             	mov    0x8(%eax),%eax
c0104fe0:	83 f8 01             	cmp    $0x1,%eax
c0104fe3:	74 19                	je     c0104ffe <default_check+0x360>
c0104fe5:	68 54 6d 10 c0       	push   $0xc0106d54
c0104fea:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0104fef:	68 31 01 00 00       	push   $0x131
c0104ff4:	68 cb 6a 10 c0       	push   $0xc0106acb
c0104ff9:	e8 21 b4 ff ff       	call   c010041f <__panic>
    assert(PageProperty(p1) && p1->property == 3);
c0104ffe:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105001:	83 c0 04             	add    $0x4,%eax
c0105004:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
c010500b:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c010500e:	8b 45 90             	mov    -0x70(%ebp),%eax
c0105011:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0105014:	0f a3 10             	bt     %edx,(%eax)
c0105017:	19 c0                	sbb    %eax,%eax
c0105019:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
c010501c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
c0105020:	0f 95 c0             	setne  %al
c0105023:	0f b6 c0             	movzbl %al,%eax
c0105026:	85 c0                	test   %eax,%eax
c0105028:	74 0b                	je     c0105035 <default_check+0x397>
c010502a:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010502d:	8b 40 08             	mov    0x8(%eax),%eax
c0105030:	83 f8 03             	cmp    $0x3,%eax
c0105033:	74 19                	je     c010504e <default_check+0x3b0>
c0105035:	68 7c 6d 10 c0       	push   $0xc0106d7c
c010503a:	68 b6 6a 10 c0       	push   $0xc0106ab6
c010503f:	68 32 01 00 00       	push   $0x132
c0105044:	68 cb 6a 10 c0       	push   $0xc0106acb
c0105049:	e8 d1 b3 ff ff       	call   c010041f <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
c010504e:	83 ec 0c             	sub    $0xc,%esp
c0105051:	6a 01                	push   $0x1
c0105053:	e8 2d de ff ff       	call   c0102e85 <alloc_pages>
c0105058:	83 c4 10             	add    $0x10,%esp
c010505b:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010505e:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105061:	83 e8 14             	sub    $0x14,%eax
c0105064:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0105067:	74 19                	je     c0105082 <default_check+0x3e4>
c0105069:	68 a2 6d 10 c0       	push   $0xc0106da2
c010506e:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0105073:	68 34 01 00 00       	push   $0x134
c0105078:	68 cb 6a 10 c0       	push   $0xc0106acb
c010507d:	e8 9d b3 ff ff       	call   c010041f <__panic>
    free_page(p0);
c0105082:	83 ec 08             	sub    $0x8,%esp
c0105085:	6a 01                	push   $0x1
c0105087:	ff 75 e8             	pushl  -0x18(%ebp)
c010508a:	e8 38 de ff ff       	call   c0102ec7 <free_pages>
c010508f:	83 c4 10             	add    $0x10,%esp
    assert((p0 = alloc_pages(2)) == p2 + 1);
c0105092:	83 ec 0c             	sub    $0xc,%esp
c0105095:	6a 02                	push   $0x2
c0105097:	e8 e9 dd ff ff       	call   c0102e85 <alloc_pages>
c010509c:	83 c4 10             	add    $0x10,%esp
c010509f:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01050a2:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01050a5:	83 c0 14             	add    $0x14,%eax
c01050a8:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c01050ab:	74 19                	je     c01050c6 <default_check+0x428>
c01050ad:	68 c0 6d 10 c0       	push   $0xc0106dc0
c01050b2:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01050b7:	68 36 01 00 00       	push   $0x136
c01050bc:	68 cb 6a 10 c0       	push   $0xc0106acb
c01050c1:	e8 59 b3 ff ff       	call   c010041f <__panic>

    free_pages(p0, 2);
c01050c6:	83 ec 08             	sub    $0x8,%esp
c01050c9:	6a 02                	push   $0x2
c01050cb:	ff 75 e8             	pushl  -0x18(%ebp)
c01050ce:	e8 f4 dd ff ff       	call   c0102ec7 <free_pages>
c01050d3:	83 c4 10             	add    $0x10,%esp
    free_page(p2);
c01050d6:	83 ec 08             	sub    $0x8,%esp
c01050d9:	6a 01                	push   $0x1
c01050db:	ff 75 dc             	pushl  -0x24(%ebp)
c01050de:	e8 e4 dd ff ff       	call   c0102ec7 <free_pages>
c01050e3:	83 c4 10             	add    $0x10,%esp

    assert((p0 = alloc_pages(5)) != NULL);
c01050e6:	83 ec 0c             	sub    $0xc,%esp
c01050e9:	6a 05                	push   $0x5
c01050eb:	e8 95 dd ff ff       	call   c0102e85 <alloc_pages>
c01050f0:	83 c4 10             	add    $0x10,%esp
c01050f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01050f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01050fa:	75 19                	jne    c0105115 <default_check+0x477>
c01050fc:	68 e0 6d 10 c0       	push   $0xc0106de0
c0105101:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0105106:	68 3b 01 00 00       	push   $0x13b
c010510b:	68 cb 6a 10 c0       	push   $0xc0106acb
c0105110:	e8 0a b3 ff ff       	call   c010041f <__panic>
    assert(alloc_page() == NULL);
c0105115:	83 ec 0c             	sub    $0xc,%esp
c0105118:	6a 01                	push   $0x1
c010511a:	e8 66 dd ff ff       	call   c0102e85 <alloc_pages>
c010511f:	83 c4 10             	add    $0x10,%esp
c0105122:	85 c0                	test   %eax,%eax
c0105124:	74 19                	je     c010513f <default_check+0x4a1>
c0105126:	68 3e 6c 10 c0       	push   $0xc0106c3e
c010512b:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0105130:	68 3c 01 00 00       	push   $0x13c
c0105135:	68 cb 6a 10 c0       	push   $0xc0106acb
c010513a:	e8 e0 b2 ff ff       	call   c010041f <__panic>

    assert(nr_free == 0);
c010513f:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0105144:	85 c0                	test   %eax,%eax
c0105146:	74 19                	je     c0105161 <default_check+0x4c3>
c0105148:	68 91 6c 10 c0       	push   $0xc0106c91
c010514d:	68 b6 6a 10 c0       	push   $0xc0106ab6
c0105152:	68 3e 01 00 00       	push   $0x13e
c0105157:	68 cb 6a 10 c0       	push   $0xc0106acb
c010515c:	e8 be b2 ff ff       	call   c010041f <__panic>
    nr_free = nr_free_store;
c0105161:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105164:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24

    free_list = free_list_store;
c0105169:	8b 45 80             	mov    -0x80(%ebp),%eax
c010516c:	8b 55 84             	mov    -0x7c(%ebp),%edx
c010516f:	a3 1c cf 11 c0       	mov    %eax,0xc011cf1c
c0105174:	89 15 20 cf 11 c0    	mov    %edx,0xc011cf20
    free_pages(p0, 5);
c010517a:	83 ec 08             	sub    $0x8,%esp
c010517d:	6a 05                	push   $0x5
c010517f:	ff 75 e8             	pushl  -0x18(%ebp)
c0105182:	e8 40 dd ff ff       	call   c0102ec7 <free_pages>
c0105187:	83 c4 10             	add    $0x10,%esp

    le = &free_list;
c010518a:	c7 45 ec 1c cf 11 c0 	movl   $0xc011cf1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0105191:	eb 1d                	jmp    c01051b0 <default_check+0x512>
        struct Page *p = le2page(le, page_link);
c0105193:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105196:	83 e8 0c             	sub    $0xc,%eax
c0105199:	89 45 d8             	mov    %eax,-0x28(%ebp)
        count --, total -= p->property;
c010519c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
c01051a0:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01051a3:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01051a6:	8b 40 08             	mov    0x8(%eax),%eax
c01051a9:	29 c2                	sub    %eax,%edx
c01051ab:	89 d0                	mov    %edx,%eax
c01051ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01051b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01051b3:	89 45 88             	mov    %eax,-0x78(%ebp)
    return listelm->next;
c01051b6:	8b 45 88             	mov    -0x78(%ebp),%eax
c01051b9:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c01051bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01051bf:	81 7d ec 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x14(%ebp)
c01051c6:	75 cb                	jne    c0105193 <default_check+0x4f5>
    }
    assert(count == 0);
c01051c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01051cc:	74 19                	je     c01051e7 <default_check+0x549>
c01051ce:	68 fe 6d 10 c0       	push   $0xc0106dfe
c01051d3:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01051d8:	68 49 01 00 00       	push   $0x149
c01051dd:	68 cb 6a 10 c0       	push   $0xc0106acb
c01051e2:	e8 38 b2 ff ff       	call   c010041f <__panic>
    assert(total == 0);
c01051e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01051eb:	74 19                	je     c0105206 <default_check+0x568>
c01051ed:	68 09 6e 10 c0       	push   $0xc0106e09
c01051f2:	68 b6 6a 10 c0       	push   $0xc0106ab6
c01051f7:	68 4a 01 00 00       	push   $0x14a
c01051fc:	68 cb 6a 10 c0       	push   $0xc0106acb
c0105201:	e8 19 b2 ff ff       	call   c010041f <__panic>
}
c0105206:	90                   	nop
c0105207:	c9                   	leave  
c0105208:	c3                   	ret    

c0105209 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
c0105209:	f3 0f 1e fb          	endbr32 
c010520d:	55                   	push   %ebp
c010520e:	89 e5                	mov    %esp,%ebp
c0105210:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c0105213:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
c010521a:	eb 04                	jmp    c0105220 <strlen+0x17>
        cnt ++;
c010521c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
c0105220:	8b 45 08             	mov    0x8(%ebp),%eax
c0105223:	8d 50 01             	lea    0x1(%eax),%edx
c0105226:	89 55 08             	mov    %edx,0x8(%ebp)
c0105229:	0f b6 00             	movzbl (%eax),%eax
c010522c:	84 c0                	test   %al,%al
c010522e:	75 ec                	jne    c010521c <strlen+0x13>
    }
    return cnt;
c0105230:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0105233:	c9                   	leave  
c0105234:	c3                   	ret    

c0105235 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
c0105235:	f3 0f 1e fb          	endbr32 
c0105239:	55                   	push   %ebp
c010523a:	89 e5                	mov    %esp,%ebp
c010523c:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c010523f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c0105246:	eb 04                	jmp    c010524c <strnlen+0x17>
        cnt ++;
c0105248:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c010524c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010524f:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0105252:	73 10                	jae    c0105264 <strnlen+0x2f>
c0105254:	8b 45 08             	mov    0x8(%ebp),%eax
c0105257:	8d 50 01             	lea    0x1(%eax),%edx
c010525a:	89 55 08             	mov    %edx,0x8(%ebp)
c010525d:	0f b6 00             	movzbl (%eax),%eax
c0105260:	84 c0                	test   %al,%al
c0105262:	75 e4                	jne    c0105248 <strnlen+0x13>
    }
    return cnt;
c0105264:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0105267:	c9                   	leave  
c0105268:	c3                   	ret    

c0105269 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
c0105269:	f3 0f 1e fb          	endbr32 
c010526d:	55                   	push   %ebp
c010526e:	89 e5                	mov    %esp,%ebp
c0105270:	57                   	push   %edi
c0105271:	56                   	push   %esi
c0105272:	83 ec 20             	sub    $0x20,%esp
c0105275:	8b 45 08             	mov    0x8(%ebp),%eax
c0105278:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010527b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010527e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
c0105281:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105284:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105287:	89 d1                	mov    %edx,%ecx
c0105289:	89 c2                	mov    %eax,%edx
c010528b:	89 ce                	mov    %ecx,%esi
c010528d:	89 d7                	mov    %edx,%edi
c010528f:	ac                   	lods   %ds:(%esi),%al
c0105290:	aa                   	stos   %al,%es:(%edi)
c0105291:	84 c0                	test   %al,%al
c0105293:	75 fa                	jne    c010528f <strcpy+0x26>
c0105295:	89 fa                	mov    %edi,%edx
c0105297:	89 f1                	mov    %esi,%ecx
c0105299:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c010529c:	89 55 e8             	mov    %edx,-0x18(%ebp)
c010529f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return dst;
c01052a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
c01052a5:	83 c4 20             	add    $0x20,%esp
c01052a8:	5e                   	pop    %esi
c01052a9:	5f                   	pop    %edi
c01052aa:	5d                   	pop    %ebp
c01052ab:	c3                   	ret    

c01052ac <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
c01052ac:	f3 0f 1e fb          	endbr32 
c01052b0:	55                   	push   %ebp
c01052b1:	89 e5                	mov    %esp,%ebp
c01052b3:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
c01052b6:	8b 45 08             	mov    0x8(%ebp),%eax
c01052b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
c01052bc:	eb 21                	jmp    c01052df <strncpy+0x33>
        if ((*p = *src) != '\0') {
c01052be:	8b 45 0c             	mov    0xc(%ebp),%eax
c01052c1:	0f b6 10             	movzbl (%eax),%edx
c01052c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01052c7:	88 10                	mov    %dl,(%eax)
c01052c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01052cc:	0f b6 00             	movzbl (%eax),%eax
c01052cf:	84 c0                	test   %al,%al
c01052d1:	74 04                	je     c01052d7 <strncpy+0x2b>
            src ++;
c01052d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
c01052d7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01052db:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
c01052df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01052e3:	75 d9                	jne    c01052be <strncpy+0x12>
    }
    return dst;
c01052e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
c01052e8:	c9                   	leave  
c01052e9:	c3                   	ret    

c01052ea <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
c01052ea:	f3 0f 1e fb          	endbr32 
c01052ee:	55                   	push   %ebp
c01052ef:	89 e5                	mov    %esp,%ebp
c01052f1:	57                   	push   %edi
c01052f2:	56                   	push   %esi
c01052f3:	83 ec 20             	sub    $0x20,%esp
c01052f6:	8b 45 08             	mov    0x8(%ebp),%eax
c01052f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01052fc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01052ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
c0105302:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105305:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105308:	89 d1                	mov    %edx,%ecx
c010530a:	89 c2                	mov    %eax,%edx
c010530c:	89 ce                	mov    %ecx,%esi
c010530e:	89 d7                	mov    %edx,%edi
c0105310:	ac                   	lods   %ds:(%esi),%al
c0105311:	ae                   	scas   %es:(%edi),%al
c0105312:	75 08                	jne    c010531c <strcmp+0x32>
c0105314:	84 c0                	test   %al,%al
c0105316:	75 f8                	jne    c0105310 <strcmp+0x26>
c0105318:	31 c0                	xor    %eax,%eax
c010531a:	eb 04                	jmp    c0105320 <strcmp+0x36>
c010531c:	19 c0                	sbb    %eax,%eax
c010531e:	0c 01                	or     $0x1,%al
c0105320:	89 fa                	mov    %edi,%edx
c0105322:	89 f1                	mov    %esi,%ecx
c0105324:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105327:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c010532a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
c010532d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
c0105330:	83 c4 20             	add    $0x20,%esp
c0105333:	5e                   	pop    %esi
c0105334:	5f                   	pop    %edi
c0105335:	5d                   	pop    %ebp
c0105336:	c3                   	ret    

c0105337 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
c0105337:	f3 0f 1e fb          	endbr32 
c010533b:	55                   	push   %ebp
c010533c:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c010533e:	eb 0c                	jmp    c010534c <strncmp+0x15>
        n --, s1 ++, s2 ++;
c0105340:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105344:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105348:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c010534c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105350:	74 1a                	je     c010536c <strncmp+0x35>
c0105352:	8b 45 08             	mov    0x8(%ebp),%eax
c0105355:	0f b6 00             	movzbl (%eax),%eax
c0105358:	84 c0                	test   %al,%al
c010535a:	74 10                	je     c010536c <strncmp+0x35>
c010535c:	8b 45 08             	mov    0x8(%ebp),%eax
c010535f:	0f b6 10             	movzbl (%eax),%edx
c0105362:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105365:	0f b6 00             	movzbl (%eax),%eax
c0105368:	38 c2                	cmp    %al,%dl
c010536a:	74 d4                	je     c0105340 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
c010536c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105370:	74 18                	je     c010538a <strncmp+0x53>
c0105372:	8b 45 08             	mov    0x8(%ebp),%eax
c0105375:	0f b6 00             	movzbl (%eax),%eax
c0105378:	0f b6 d0             	movzbl %al,%edx
c010537b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010537e:	0f b6 00             	movzbl (%eax),%eax
c0105381:	0f b6 c0             	movzbl %al,%eax
c0105384:	29 c2                	sub    %eax,%edx
c0105386:	89 d0                	mov    %edx,%eax
c0105388:	eb 05                	jmp    c010538f <strncmp+0x58>
c010538a:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010538f:	5d                   	pop    %ebp
c0105390:	c3                   	ret    

c0105391 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
c0105391:	f3 0f 1e fb          	endbr32 
c0105395:	55                   	push   %ebp
c0105396:	89 e5                	mov    %esp,%ebp
c0105398:	83 ec 04             	sub    $0x4,%esp
c010539b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010539e:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c01053a1:	eb 14                	jmp    c01053b7 <strchr+0x26>
        if (*s == c) {
c01053a3:	8b 45 08             	mov    0x8(%ebp),%eax
c01053a6:	0f b6 00             	movzbl (%eax),%eax
c01053a9:	38 45 fc             	cmp    %al,-0x4(%ebp)
c01053ac:	75 05                	jne    c01053b3 <strchr+0x22>
            return (char *)s;
c01053ae:	8b 45 08             	mov    0x8(%ebp),%eax
c01053b1:	eb 13                	jmp    c01053c6 <strchr+0x35>
        }
        s ++;
c01053b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
c01053b7:	8b 45 08             	mov    0x8(%ebp),%eax
c01053ba:	0f b6 00             	movzbl (%eax),%eax
c01053bd:	84 c0                	test   %al,%al
c01053bf:	75 e2                	jne    c01053a3 <strchr+0x12>
    }
    return NULL;
c01053c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01053c6:	c9                   	leave  
c01053c7:	c3                   	ret    

c01053c8 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
c01053c8:	f3 0f 1e fb          	endbr32 
c01053cc:	55                   	push   %ebp
c01053cd:	89 e5                	mov    %esp,%ebp
c01053cf:	83 ec 04             	sub    $0x4,%esp
c01053d2:	8b 45 0c             	mov    0xc(%ebp),%eax
c01053d5:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c01053d8:	eb 0f                	jmp    c01053e9 <strfind+0x21>
        if (*s == c) {
c01053da:	8b 45 08             	mov    0x8(%ebp),%eax
c01053dd:	0f b6 00             	movzbl (%eax),%eax
c01053e0:	38 45 fc             	cmp    %al,-0x4(%ebp)
c01053e3:	74 10                	je     c01053f5 <strfind+0x2d>
            break;
        }
        s ++;
c01053e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
c01053e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01053ec:	0f b6 00             	movzbl (%eax),%eax
c01053ef:	84 c0                	test   %al,%al
c01053f1:	75 e7                	jne    c01053da <strfind+0x12>
c01053f3:	eb 01                	jmp    c01053f6 <strfind+0x2e>
            break;
c01053f5:	90                   	nop
    }
    return (char *)s;
c01053f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
c01053f9:	c9                   	leave  
c01053fa:	c3                   	ret    

c01053fb <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
c01053fb:	f3 0f 1e fb          	endbr32 
c01053ff:	55                   	push   %ebp
c0105400:	89 e5                	mov    %esp,%ebp
c0105402:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
c0105405:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
c010540c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
c0105413:	eb 04                	jmp    c0105419 <strtol+0x1e>
        s ++;
c0105415:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
c0105419:	8b 45 08             	mov    0x8(%ebp),%eax
c010541c:	0f b6 00             	movzbl (%eax),%eax
c010541f:	3c 20                	cmp    $0x20,%al
c0105421:	74 f2                	je     c0105415 <strtol+0x1a>
c0105423:	8b 45 08             	mov    0x8(%ebp),%eax
c0105426:	0f b6 00             	movzbl (%eax),%eax
c0105429:	3c 09                	cmp    $0x9,%al
c010542b:	74 e8                	je     c0105415 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
c010542d:	8b 45 08             	mov    0x8(%ebp),%eax
c0105430:	0f b6 00             	movzbl (%eax),%eax
c0105433:	3c 2b                	cmp    $0x2b,%al
c0105435:	75 06                	jne    c010543d <strtol+0x42>
        s ++;
c0105437:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c010543b:	eb 15                	jmp    c0105452 <strtol+0x57>
    }
    else if (*s == '-') {
c010543d:	8b 45 08             	mov    0x8(%ebp),%eax
c0105440:	0f b6 00             	movzbl (%eax),%eax
c0105443:	3c 2d                	cmp    $0x2d,%al
c0105445:	75 0b                	jne    c0105452 <strtol+0x57>
        s ++, neg = 1;
c0105447:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c010544b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
c0105452:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105456:	74 06                	je     c010545e <strtol+0x63>
c0105458:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
c010545c:	75 24                	jne    c0105482 <strtol+0x87>
c010545e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105461:	0f b6 00             	movzbl (%eax),%eax
c0105464:	3c 30                	cmp    $0x30,%al
c0105466:	75 1a                	jne    c0105482 <strtol+0x87>
c0105468:	8b 45 08             	mov    0x8(%ebp),%eax
c010546b:	83 c0 01             	add    $0x1,%eax
c010546e:	0f b6 00             	movzbl (%eax),%eax
c0105471:	3c 78                	cmp    $0x78,%al
c0105473:	75 0d                	jne    c0105482 <strtol+0x87>
        s += 2, base = 16;
c0105475:	83 45 08 02          	addl   $0x2,0x8(%ebp)
c0105479:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
c0105480:	eb 2a                	jmp    c01054ac <strtol+0xb1>
    }
    else if (base == 0 && s[0] == '0') {
c0105482:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105486:	75 17                	jne    c010549f <strtol+0xa4>
c0105488:	8b 45 08             	mov    0x8(%ebp),%eax
c010548b:	0f b6 00             	movzbl (%eax),%eax
c010548e:	3c 30                	cmp    $0x30,%al
c0105490:	75 0d                	jne    c010549f <strtol+0xa4>
        s ++, base = 8;
c0105492:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105496:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
c010549d:	eb 0d                	jmp    c01054ac <strtol+0xb1>
    }
    else if (base == 0) {
c010549f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01054a3:	75 07                	jne    c01054ac <strtol+0xb1>
        base = 10;
c01054a5:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
c01054ac:	8b 45 08             	mov    0x8(%ebp),%eax
c01054af:	0f b6 00             	movzbl (%eax),%eax
c01054b2:	3c 2f                	cmp    $0x2f,%al
c01054b4:	7e 1b                	jle    c01054d1 <strtol+0xd6>
c01054b6:	8b 45 08             	mov    0x8(%ebp),%eax
c01054b9:	0f b6 00             	movzbl (%eax),%eax
c01054bc:	3c 39                	cmp    $0x39,%al
c01054be:	7f 11                	jg     c01054d1 <strtol+0xd6>
            dig = *s - '0';
c01054c0:	8b 45 08             	mov    0x8(%ebp),%eax
c01054c3:	0f b6 00             	movzbl (%eax),%eax
c01054c6:	0f be c0             	movsbl %al,%eax
c01054c9:	83 e8 30             	sub    $0x30,%eax
c01054cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01054cf:	eb 48                	jmp    c0105519 <strtol+0x11e>
        }
        else if (*s >= 'a' && *s <= 'z') {
c01054d1:	8b 45 08             	mov    0x8(%ebp),%eax
c01054d4:	0f b6 00             	movzbl (%eax),%eax
c01054d7:	3c 60                	cmp    $0x60,%al
c01054d9:	7e 1b                	jle    c01054f6 <strtol+0xfb>
c01054db:	8b 45 08             	mov    0x8(%ebp),%eax
c01054de:	0f b6 00             	movzbl (%eax),%eax
c01054e1:	3c 7a                	cmp    $0x7a,%al
c01054e3:	7f 11                	jg     c01054f6 <strtol+0xfb>
            dig = *s - 'a' + 10;
c01054e5:	8b 45 08             	mov    0x8(%ebp),%eax
c01054e8:	0f b6 00             	movzbl (%eax),%eax
c01054eb:	0f be c0             	movsbl %al,%eax
c01054ee:	83 e8 57             	sub    $0x57,%eax
c01054f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01054f4:	eb 23                	jmp    c0105519 <strtol+0x11e>
        }
        else if (*s >= 'A' && *s <= 'Z') {
c01054f6:	8b 45 08             	mov    0x8(%ebp),%eax
c01054f9:	0f b6 00             	movzbl (%eax),%eax
c01054fc:	3c 40                	cmp    $0x40,%al
c01054fe:	7e 3c                	jle    c010553c <strtol+0x141>
c0105500:	8b 45 08             	mov    0x8(%ebp),%eax
c0105503:	0f b6 00             	movzbl (%eax),%eax
c0105506:	3c 5a                	cmp    $0x5a,%al
c0105508:	7f 32                	jg     c010553c <strtol+0x141>
            dig = *s - 'A' + 10;
c010550a:	8b 45 08             	mov    0x8(%ebp),%eax
c010550d:	0f b6 00             	movzbl (%eax),%eax
c0105510:	0f be c0             	movsbl %al,%eax
c0105513:	83 e8 37             	sub    $0x37,%eax
c0105516:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
c0105519:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010551c:	3b 45 10             	cmp    0x10(%ebp),%eax
c010551f:	7d 1a                	jge    c010553b <strtol+0x140>
            break;
        }
        s ++, val = (val * base) + dig;
c0105521:	83 45 08 01          	addl   $0x1,0x8(%ebp)
c0105525:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105528:	0f af 45 10          	imul   0x10(%ebp),%eax
c010552c:	89 c2                	mov    %eax,%edx
c010552e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105531:	01 d0                	add    %edx,%eax
c0105533:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
c0105536:	e9 71 ff ff ff       	jmp    c01054ac <strtol+0xb1>
            break;
c010553b:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
c010553c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0105540:	74 08                	je     c010554a <strtol+0x14f>
        *endptr = (char *) s;
c0105542:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105545:	8b 55 08             	mov    0x8(%ebp),%edx
c0105548:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
c010554a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c010554e:	74 07                	je     c0105557 <strtol+0x15c>
c0105550:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105553:	f7 d8                	neg    %eax
c0105555:	eb 03                	jmp    c010555a <strtol+0x15f>
c0105557:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
c010555a:	c9                   	leave  
c010555b:	c3                   	ret    

c010555c <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
c010555c:	f3 0f 1e fb          	endbr32 
c0105560:	55                   	push   %ebp
c0105561:	89 e5                	mov    %esp,%ebp
c0105563:	57                   	push   %edi
c0105564:	83 ec 24             	sub    $0x24,%esp
c0105567:	8b 45 0c             	mov    0xc(%ebp),%eax
c010556a:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
c010556d:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
c0105571:	8b 55 08             	mov    0x8(%ebp),%edx
c0105574:	89 55 f8             	mov    %edx,-0x8(%ebp)
c0105577:	88 45 f7             	mov    %al,-0x9(%ebp)
c010557a:	8b 45 10             	mov    0x10(%ebp),%eax
c010557d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
c0105580:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0105583:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
c0105587:	8b 55 f8             	mov    -0x8(%ebp),%edx
c010558a:	89 d7                	mov    %edx,%edi
c010558c:	f3 aa                	rep stos %al,%es:(%edi)
c010558e:	89 fa                	mov    %edi,%edx
c0105590:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105593:	89 55 e8             	mov    %edx,-0x18(%ebp)
    return s;
c0105596:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
c0105599:	83 c4 24             	add    $0x24,%esp
c010559c:	5f                   	pop    %edi
c010559d:	5d                   	pop    %ebp
c010559e:	c3                   	ret    

c010559f <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
c010559f:	f3 0f 1e fb          	endbr32 
c01055a3:	55                   	push   %ebp
c01055a4:	89 e5                	mov    %esp,%ebp
c01055a6:	57                   	push   %edi
c01055a7:	56                   	push   %esi
c01055a8:	53                   	push   %ebx
c01055a9:	83 ec 30             	sub    $0x30,%esp
c01055ac:	8b 45 08             	mov    0x8(%ebp),%eax
c01055af:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01055b2:	8b 45 0c             	mov    0xc(%ebp),%eax
c01055b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01055b8:	8b 45 10             	mov    0x10(%ebp),%eax
c01055bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (dst < src) {
c01055be:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055c1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c01055c4:	73 42                	jae    c0105608 <memmove+0x69>
c01055c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01055c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01055cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01055cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01055d2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01055d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c01055d8:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01055db:	c1 e8 02             	shr    $0x2,%eax
c01055de:	89 c1                	mov    %eax,%ecx
    asm volatile (
c01055e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c01055e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01055e6:	89 d7                	mov    %edx,%edi
c01055e8:	89 c6                	mov    %eax,%esi
c01055ea:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c01055ec:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c01055ef:	83 e1 03             	and    $0x3,%ecx
c01055f2:	74 02                	je     c01055f6 <memmove+0x57>
c01055f4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c01055f6:	89 f0                	mov    %esi,%eax
c01055f8:	89 fa                	mov    %edi,%edx
c01055fa:	89 4d d8             	mov    %ecx,-0x28(%ebp)
c01055fd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0105600:	89 45 d0             	mov    %eax,-0x30(%ebp)
        : "memory");
    return dst;
c0105603:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
c0105606:	eb 36                	jmp    c010563e <memmove+0x9f>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
c0105608:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010560b:	8d 50 ff             	lea    -0x1(%eax),%edx
c010560e:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105611:	01 c2                	add    %eax,%edx
c0105613:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105616:	8d 48 ff             	lea    -0x1(%eax),%ecx
c0105619:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010561c:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
c010561f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105622:	89 c1                	mov    %eax,%ecx
c0105624:	89 d8                	mov    %ebx,%eax
c0105626:	89 d6                	mov    %edx,%esi
c0105628:	89 c7                	mov    %eax,%edi
c010562a:	fd                   	std    
c010562b:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c010562d:	fc                   	cld    
c010562e:	89 f8                	mov    %edi,%eax
c0105630:	89 f2                	mov    %esi,%edx
c0105632:	89 4d cc             	mov    %ecx,-0x34(%ebp)
c0105635:	89 55 c8             	mov    %edx,-0x38(%ebp)
c0105638:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
c010563b:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
c010563e:	83 c4 30             	add    $0x30,%esp
c0105641:	5b                   	pop    %ebx
c0105642:	5e                   	pop    %esi
c0105643:	5f                   	pop    %edi
c0105644:	5d                   	pop    %ebp
c0105645:	c3                   	ret    

c0105646 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
c0105646:	f3 0f 1e fb          	endbr32 
c010564a:	55                   	push   %ebp
c010564b:	89 e5                	mov    %esp,%ebp
c010564d:	57                   	push   %edi
c010564e:	56                   	push   %esi
c010564f:	83 ec 20             	sub    $0x20,%esp
c0105652:	8b 45 08             	mov    0x8(%ebp),%eax
c0105655:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105658:	8b 45 0c             	mov    0xc(%ebp),%eax
c010565b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010565e:	8b 45 10             	mov    0x10(%ebp),%eax
c0105661:	89 45 ec             	mov    %eax,-0x14(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c0105664:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105667:	c1 e8 02             	shr    $0x2,%eax
c010566a:	89 c1                	mov    %eax,%ecx
    asm volatile (
c010566c:	8b 55 f4             	mov    -0xc(%ebp),%edx
c010566f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105672:	89 d7                	mov    %edx,%edi
c0105674:	89 c6                	mov    %eax,%esi
c0105676:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0105678:	8b 4d ec             	mov    -0x14(%ebp),%ecx
c010567b:	83 e1 03             	and    $0x3,%ecx
c010567e:	74 02                	je     c0105682 <memcpy+0x3c>
c0105680:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0105682:	89 f0                	mov    %esi,%eax
c0105684:	89 fa                	mov    %edi,%edx
c0105686:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c0105689:	89 55 e4             	mov    %edx,-0x1c(%ebp)
c010568c:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
c010568f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
c0105692:	83 c4 20             	add    $0x20,%esp
c0105695:	5e                   	pop    %esi
c0105696:	5f                   	pop    %edi
c0105697:	5d                   	pop    %ebp
c0105698:	c3                   	ret    

c0105699 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
c0105699:	f3 0f 1e fb          	endbr32 
c010569d:	55                   	push   %ebp
c010569e:	89 e5                	mov    %esp,%ebp
c01056a0:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
c01056a3:	8b 45 08             	mov    0x8(%ebp),%eax
c01056a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
c01056a9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01056ac:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
c01056af:	eb 30                	jmp    c01056e1 <memcmp+0x48>
        if (*s1 != *s2) {
c01056b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01056b4:	0f b6 10             	movzbl (%eax),%edx
c01056b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01056ba:	0f b6 00             	movzbl (%eax),%eax
c01056bd:	38 c2                	cmp    %al,%dl
c01056bf:	74 18                	je     c01056d9 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
c01056c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01056c4:	0f b6 00             	movzbl (%eax),%eax
c01056c7:	0f b6 d0             	movzbl %al,%edx
c01056ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01056cd:	0f b6 00             	movzbl (%eax),%eax
c01056d0:	0f b6 c0             	movzbl %al,%eax
c01056d3:	29 c2                	sub    %eax,%edx
c01056d5:	89 d0                	mov    %edx,%eax
c01056d7:	eb 1a                	jmp    c01056f3 <memcmp+0x5a>
        }
        s1 ++, s2 ++;
c01056d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
c01056dd:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
c01056e1:	8b 45 10             	mov    0x10(%ebp),%eax
c01056e4:	8d 50 ff             	lea    -0x1(%eax),%edx
c01056e7:	89 55 10             	mov    %edx,0x10(%ebp)
c01056ea:	85 c0                	test   %eax,%eax
c01056ec:	75 c3                	jne    c01056b1 <memcmp+0x18>
    }
    return 0;
c01056ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01056f3:	c9                   	leave  
c01056f4:	c3                   	ret    

c01056f5 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
c01056f5:	f3 0f 1e fb          	endbr32 
c01056f9:	55                   	push   %ebp
c01056fa:	89 e5                	mov    %esp,%ebp
c01056fc:	83 ec 38             	sub    $0x38,%esp
c01056ff:	8b 45 10             	mov    0x10(%ebp),%eax
c0105702:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0105705:	8b 45 14             	mov    0x14(%ebp),%eax
c0105708:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
c010570b:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010570e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0105711:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105714:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
c0105717:	8b 45 18             	mov    0x18(%ebp),%eax
c010571a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c010571d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105720:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105723:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105726:	89 55 f0             	mov    %edx,-0x10(%ebp)
c0105729:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010572c:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010572f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0105733:	74 1c                	je     c0105751 <printnum+0x5c>
c0105735:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105738:	ba 00 00 00 00       	mov    $0x0,%edx
c010573d:	f7 75 e4             	divl   -0x1c(%ebp)
c0105740:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0105743:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105746:	ba 00 00 00 00       	mov    $0x0,%edx
c010574b:	f7 75 e4             	divl   -0x1c(%ebp)
c010574e:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105751:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105754:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105757:	f7 75 e4             	divl   -0x1c(%ebp)
c010575a:	89 45 e0             	mov    %eax,-0x20(%ebp)
c010575d:	89 55 dc             	mov    %edx,-0x24(%ebp)
c0105760:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105763:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105766:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105769:	89 55 ec             	mov    %edx,-0x14(%ebp)
c010576c:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010576f:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
c0105772:	8b 45 18             	mov    0x18(%ebp),%eax
c0105775:	ba 00 00 00 00       	mov    $0x0,%edx
c010577a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c010577d:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c0105780:	19 d1                	sbb    %edx,%ecx
c0105782:	72 37                	jb     c01057bb <printnum+0xc6>
        printnum(putch, putdat, result, base, width - 1, padc);
c0105784:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0105787:	83 e8 01             	sub    $0x1,%eax
c010578a:	83 ec 04             	sub    $0x4,%esp
c010578d:	ff 75 20             	pushl  0x20(%ebp)
c0105790:	50                   	push   %eax
c0105791:	ff 75 18             	pushl  0x18(%ebp)
c0105794:	ff 75 ec             	pushl  -0x14(%ebp)
c0105797:	ff 75 e8             	pushl  -0x18(%ebp)
c010579a:	ff 75 0c             	pushl  0xc(%ebp)
c010579d:	ff 75 08             	pushl  0x8(%ebp)
c01057a0:	e8 50 ff ff ff       	call   c01056f5 <printnum>
c01057a5:	83 c4 20             	add    $0x20,%esp
c01057a8:	eb 1b                	jmp    c01057c5 <printnum+0xd0>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
c01057aa:	83 ec 08             	sub    $0x8,%esp
c01057ad:	ff 75 0c             	pushl  0xc(%ebp)
c01057b0:	ff 75 20             	pushl  0x20(%ebp)
c01057b3:	8b 45 08             	mov    0x8(%ebp),%eax
c01057b6:	ff d0                	call   *%eax
c01057b8:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
c01057bb:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
c01057bf:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c01057c3:	7f e5                	jg     c01057aa <printnum+0xb5>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
c01057c5:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01057c8:	05 c4 6e 10 c0       	add    $0xc0106ec4,%eax
c01057cd:	0f b6 00             	movzbl (%eax),%eax
c01057d0:	0f be c0             	movsbl %al,%eax
c01057d3:	83 ec 08             	sub    $0x8,%esp
c01057d6:	ff 75 0c             	pushl  0xc(%ebp)
c01057d9:	50                   	push   %eax
c01057da:	8b 45 08             	mov    0x8(%ebp),%eax
c01057dd:	ff d0                	call   *%eax
c01057df:	83 c4 10             	add    $0x10,%esp
}
c01057e2:	90                   	nop
c01057e3:	c9                   	leave  
c01057e4:	c3                   	ret    

c01057e5 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
c01057e5:	f3 0f 1e fb          	endbr32 
c01057e9:	55                   	push   %ebp
c01057ea:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c01057ec:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c01057f0:	7e 14                	jle    c0105806 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
c01057f2:	8b 45 08             	mov    0x8(%ebp),%eax
c01057f5:	8b 00                	mov    (%eax),%eax
c01057f7:	8d 48 08             	lea    0x8(%eax),%ecx
c01057fa:	8b 55 08             	mov    0x8(%ebp),%edx
c01057fd:	89 0a                	mov    %ecx,(%edx)
c01057ff:	8b 50 04             	mov    0x4(%eax),%edx
c0105802:	8b 00                	mov    (%eax),%eax
c0105804:	eb 30                	jmp    c0105836 <getuint+0x51>
    }
    else if (lflag) {
c0105806:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010580a:	74 16                	je     c0105822 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
c010580c:	8b 45 08             	mov    0x8(%ebp),%eax
c010580f:	8b 00                	mov    (%eax),%eax
c0105811:	8d 48 04             	lea    0x4(%eax),%ecx
c0105814:	8b 55 08             	mov    0x8(%ebp),%edx
c0105817:	89 0a                	mov    %ecx,(%edx)
c0105819:	8b 00                	mov    (%eax),%eax
c010581b:	ba 00 00 00 00       	mov    $0x0,%edx
c0105820:	eb 14                	jmp    c0105836 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
c0105822:	8b 45 08             	mov    0x8(%ebp),%eax
c0105825:	8b 00                	mov    (%eax),%eax
c0105827:	8d 48 04             	lea    0x4(%eax),%ecx
c010582a:	8b 55 08             	mov    0x8(%ebp),%edx
c010582d:	89 0a                	mov    %ecx,(%edx)
c010582f:	8b 00                	mov    (%eax),%eax
c0105831:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
c0105836:	5d                   	pop    %ebp
c0105837:	c3                   	ret    

c0105838 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
c0105838:	f3 0f 1e fb          	endbr32 
c010583c:	55                   	push   %ebp
c010583d:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c010583f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c0105843:	7e 14                	jle    c0105859 <getint+0x21>
        return va_arg(*ap, long long);
c0105845:	8b 45 08             	mov    0x8(%ebp),%eax
c0105848:	8b 00                	mov    (%eax),%eax
c010584a:	8d 48 08             	lea    0x8(%eax),%ecx
c010584d:	8b 55 08             	mov    0x8(%ebp),%edx
c0105850:	89 0a                	mov    %ecx,(%edx)
c0105852:	8b 50 04             	mov    0x4(%eax),%edx
c0105855:	8b 00                	mov    (%eax),%eax
c0105857:	eb 28                	jmp    c0105881 <getint+0x49>
    }
    else if (lflag) {
c0105859:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010585d:	74 12                	je     c0105871 <getint+0x39>
        return va_arg(*ap, long);
c010585f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105862:	8b 00                	mov    (%eax),%eax
c0105864:	8d 48 04             	lea    0x4(%eax),%ecx
c0105867:	8b 55 08             	mov    0x8(%ebp),%edx
c010586a:	89 0a                	mov    %ecx,(%edx)
c010586c:	8b 00                	mov    (%eax),%eax
c010586e:	99                   	cltd   
c010586f:	eb 10                	jmp    c0105881 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
c0105871:	8b 45 08             	mov    0x8(%ebp),%eax
c0105874:	8b 00                	mov    (%eax),%eax
c0105876:	8d 48 04             	lea    0x4(%eax),%ecx
c0105879:	8b 55 08             	mov    0x8(%ebp),%edx
c010587c:	89 0a                	mov    %ecx,(%edx)
c010587e:	8b 00                	mov    (%eax),%eax
c0105880:	99                   	cltd   
    }
}
c0105881:	5d                   	pop    %ebp
c0105882:	c3                   	ret    

c0105883 <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
c0105883:	f3 0f 1e fb          	endbr32 
c0105887:	55                   	push   %ebp
c0105888:	89 e5                	mov    %esp,%ebp
c010588a:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
c010588d:	8d 45 14             	lea    0x14(%ebp),%eax
c0105890:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
c0105893:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105896:	50                   	push   %eax
c0105897:	ff 75 10             	pushl  0x10(%ebp)
c010589a:	ff 75 0c             	pushl  0xc(%ebp)
c010589d:	ff 75 08             	pushl  0x8(%ebp)
c01058a0:	e8 06 00 00 00       	call   c01058ab <vprintfmt>
c01058a5:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
c01058a8:	90                   	nop
c01058a9:	c9                   	leave  
c01058aa:	c3                   	ret    

c01058ab <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
c01058ab:	f3 0f 1e fb          	endbr32 
c01058af:	55                   	push   %ebp
c01058b0:	89 e5                	mov    %esp,%ebp
c01058b2:	56                   	push   %esi
c01058b3:	53                   	push   %ebx
c01058b4:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c01058b7:	eb 17                	jmp    c01058d0 <vprintfmt+0x25>
            if (ch == '\0') {
c01058b9:	85 db                	test   %ebx,%ebx
c01058bb:	0f 84 8f 03 00 00    	je     c0105c50 <vprintfmt+0x3a5>
                return;
            }
            putch(ch, putdat);
c01058c1:	83 ec 08             	sub    $0x8,%esp
c01058c4:	ff 75 0c             	pushl  0xc(%ebp)
c01058c7:	53                   	push   %ebx
c01058c8:	8b 45 08             	mov    0x8(%ebp),%eax
c01058cb:	ff d0                	call   *%eax
c01058cd:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c01058d0:	8b 45 10             	mov    0x10(%ebp),%eax
c01058d3:	8d 50 01             	lea    0x1(%eax),%edx
c01058d6:	89 55 10             	mov    %edx,0x10(%ebp)
c01058d9:	0f b6 00             	movzbl (%eax),%eax
c01058dc:	0f b6 d8             	movzbl %al,%ebx
c01058df:	83 fb 25             	cmp    $0x25,%ebx
c01058e2:	75 d5                	jne    c01058b9 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
c01058e4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
c01058e8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
c01058ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01058f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
c01058f5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c01058fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01058ff:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
c0105902:	8b 45 10             	mov    0x10(%ebp),%eax
c0105905:	8d 50 01             	lea    0x1(%eax),%edx
c0105908:	89 55 10             	mov    %edx,0x10(%ebp)
c010590b:	0f b6 00             	movzbl (%eax),%eax
c010590e:	0f b6 d8             	movzbl %al,%ebx
c0105911:	8d 43 dd             	lea    -0x23(%ebx),%eax
c0105914:	83 f8 55             	cmp    $0x55,%eax
c0105917:	0f 87 06 03 00 00    	ja     c0105c23 <vprintfmt+0x378>
c010591d:	8b 04 85 e8 6e 10 c0 	mov    -0x3fef9118(,%eax,4),%eax
c0105924:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
c0105927:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
c010592b:	eb d5                	jmp    c0105902 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
c010592d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
c0105931:	eb cf                	jmp    c0105902 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
c0105933:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
c010593a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c010593d:	89 d0                	mov    %edx,%eax
c010593f:	c1 e0 02             	shl    $0x2,%eax
c0105942:	01 d0                	add    %edx,%eax
c0105944:	01 c0                	add    %eax,%eax
c0105946:	01 d8                	add    %ebx,%eax
c0105948:	83 e8 30             	sub    $0x30,%eax
c010594b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
c010594e:	8b 45 10             	mov    0x10(%ebp),%eax
c0105951:	0f b6 00             	movzbl (%eax),%eax
c0105954:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
c0105957:	83 fb 2f             	cmp    $0x2f,%ebx
c010595a:	7e 39                	jle    c0105995 <vprintfmt+0xea>
c010595c:	83 fb 39             	cmp    $0x39,%ebx
c010595f:	7f 34                	jg     c0105995 <vprintfmt+0xea>
            for (precision = 0; ; ++ fmt) {
c0105961:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
c0105965:	eb d3                	jmp    c010593a <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
c0105967:	8b 45 14             	mov    0x14(%ebp),%eax
c010596a:	8d 50 04             	lea    0x4(%eax),%edx
c010596d:	89 55 14             	mov    %edx,0x14(%ebp)
c0105970:	8b 00                	mov    (%eax),%eax
c0105972:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
c0105975:	eb 1f                	jmp    c0105996 <vprintfmt+0xeb>

        case '.':
            if (width < 0)
c0105977:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c010597b:	79 85                	jns    c0105902 <vprintfmt+0x57>
                width = 0;
c010597d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
c0105984:	e9 79 ff ff ff       	jmp    c0105902 <vprintfmt+0x57>

        case '#':
            altflag = 1;
c0105989:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
c0105990:	e9 6d ff ff ff       	jmp    c0105902 <vprintfmt+0x57>
            goto process_precision;
c0105995:	90                   	nop

        process_precision:
            if (width < 0)
c0105996:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c010599a:	0f 89 62 ff ff ff    	jns    c0105902 <vprintfmt+0x57>
                width = precision, precision = -1;
c01059a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01059a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01059a6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
c01059ad:	e9 50 ff ff ff       	jmp    c0105902 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
c01059b2:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
c01059b6:	e9 47 ff ff ff       	jmp    c0105902 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
c01059bb:	8b 45 14             	mov    0x14(%ebp),%eax
c01059be:	8d 50 04             	lea    0x4(%eax),%edx
c01059c1:	89 55 14             	mov    %edx,0x14(%ebp)
c01059c4:	8b 00                	mov    (%eax),%eax
c01059c6:	83 ec 08             	sub    $0x8,%esp
c01059c9:	ff 75 0c             	pushl  0xc(%ebp)
c01059cc:	50                   	push   %eax
c01059cd:	8b 45 08             	mov    0x8(%ebp),%eax
c01059d0:	ff d0                	call   *%eax
c01059d2:	83 c4 10             	add    $0x10,%esp
            break;
c01059d5:	e9 71 02 00 00       	jmp    c0105c4b <vprintfmt+0x3a0>

        // error message
        case 'e':
            err = va_arg(ap, int);
c01059da:	8b 45 14             	mov    0x14(%ebp),%eax
c01059dd:	8d 50 04             	lea    0x4(%eax),%edx
c01059e0:	89 55 14             	mov    %edx,0x14(%ebp)
c01059e3:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
c01059e5:	85 db                	test   %ebx,%ebx
c01059e7:	79 02                	jns    c01059eb <vprintfmt+0x140>
                err = -err;
c01059e9:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
c01059eb:	83 fb 06             	cmp    $0x6,%ebx
c01059ee:	7f 0b                	jg     c01059fb <vprintfmt+0x150>
c01059f0:	8b 34 9d a8 6e 10 c0 	mov    -0x3fef9158(,%ebx,4),%esi
c01059f7:	85 f6                	test   %esi,%esi
c01059f9:	75 19                	jne    c0105a14 <vprintfmt+0x169>
                printfmt(putch, putdat, "error %d", err);
c01059fb:	53                   	push   %ebx
c01059fc:	68 d5 6e 10 c0       	push   $0xc0106ed5
c0105a01:	ff 75 0c             	pushl  0xc(%ebp)
c0105a04:	ff 75 08             	pushl  0x8(%ebp)
c0105a07:	e8 77 fe ff ff       	call   c0105883 <printfmt>
c0105a0c:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
c0105a0f:	e9 37 02 00 00       	jmp    c0105c4b <vprintfmt+0x3a0>
                printfmt(putch, putdat, "%s", p);
c0105a14:	56                   	push   %esi
c0105a15:	68 de 6e 10 c0       	push   $0xc0106ede
c0105a1a:	ff 75 0c             	pushl  0xc(%ebp)
c0105a1d:	ff 75 08             	pushl  0x8(%ebp)
c0105a20:	e8 5e fe ff ff       	call   c0105883 <printfmt>
c0105a25:	83 c4 10             	add    $0x10,%esp
            break;
c0105a28:	e9 1e 02 00 00       	jmp    c0105c4b <vprintfmt+0x3a0>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
c0105a2d:	8b 45 14             	mov    0x14(%ebp),%eax
c0105a30:	8d 50 04             	lea    0x4(%eax),%edx
c0105a33:	89 55 14             	mov    %edx,0x14(%ebp)
c0105a36:	8b 30                	mov    (%eax),%esi
c0105a38:	85 f6                	test   %esi,%esi
c0105a3a:	75 05                	jne    c0105a41 <vprintfmt+0x196>
                p = "(null)";
c0105a3c:	be e1 6e 10 c0       	mov    $0xc0106ee1,%esi
            }
            if (width > 0 && padc != '-') {
c0105a41:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105a45:	7e 76                	jle    c0105abd <vprintfmt+0x212>
c0105a47:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
c0105a4b:	74 70                	je     c0105abd <vprintfmt+0x212>
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105a4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105a50:	83 ec 08             	sub    $0x8,%esp
c0105a53:	50                   	push   %eax
c0105a54:	56                   	push   %esi
c0105a55:	e8 db f7 ff ff       	call   c0105235 <strnlen>
c0105a5a:	83 c4 10             	add    $0x10,%esp
c0105a5d:	8b 55 e8             	mov    -0x18(%ebp),%edx
c0105a60:	29 c2                	sub    %eax,%edx
c0105a62:	89 d0                	mov    %edx,%eax
c0105a64:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105a67:	eb 17                	jmp    c0105a80 <vprintfmt+0x1d5>
                    putch(padc, putdat);
c0105a69:	0f be 45 db          	movsbl -0x25(%ebp),%eax
c0105a6d:	83 ec 08             	sub    $0x8,%esp
c0105a70:	ff 75 0c             	pushl  0xc(%ebp)
c0105a73:	50                   	push   %eax
c0105a74:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a77:	ff d0                	call   *%eax
c0105a79:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105a7c:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105a80:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105a84:	7f e3                	jg     c0105a69 <vprintfmt+0x1be>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105a86:	eb 35                	jmp    c0105abd <vprintfmt+0x212>
                if (altflag && (ch < ' ' || ch > '~')) {
c0105a88:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0105a8c:	74 1c                	je     c0105aaa <vprintfmt+0x1ff>
c0105a8e:	83 fb 1f             	cmp    $0x1f,%ebx
c0105a91:	7e 05                	jle    c0105a98 <vprintfmt+0x1ed>
c0105a93:	83 fb 7e             	cmp    $0x7e,%ebx
c0105a96:	7e 12                	jle    c0105aaa <vprintfmt+0x1ff>
                    putch('?', putdat);
c0105a98:	83 ec 08             	sub    $0x8,%esp
c0105a9b:	ff 75 0c             	pushl  0xc(%ebp)
c0105a9e:	6a 3f                	push   $0x3f
c0105aa0:	8b 45 08             	mov    0x8(%ebp),%eax
c0105aa3:	ff d0                	call   *%eax
c0105aa5:	83 c4 10             	add    $0x10,%esp
c0105aa8:	eb 0f                	jmp    c0105ab9 <vprintfmt+0x20e>
                }
                else {
                    putch(ch, putdat);
c0105aaa:	83 ec 08             	sub    $0x8,%esp
c0105aad:	ff 75 0c             	pushl  0xc(%ebp)
c0105ab0:	53                   	push   %ebx
c0105ab1:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ab4:	ff d0                	call   *%eax
c0105ab6:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105ab9:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105abd:	89 f0                	mov    %esi,%eax
c0105abf:	8d 70 01             	lea    0x1(%eax),%esi
c0105ac2:	0f b6 00             	movzbl (%eax),%eax
c0105ac5:	0f be d8             	movsbl %al,%ebx
c0105ac8:	85 db                	test   %ebx,%ebx
c0105aca:	74 26                	je     c0105af2 <vprintfmt+0x247>
c0105acc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105ad0:	78 b6                	js     c0105a88 <vprintfmt+0x1dd>
c0105ad2:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
c0105ad6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105ada:	79 ac                	jns    c0105a88 <vprintfmt+0x1dd>
                }
            }
            for (; width > 0; width --) {
c0105adc:	eb 14                	jmp    c0105af2 <vprintfmt+0x247>
                putch(' ', putdat);
c0105ade:	83 ec 08             	sub    $0x8,%esp
c0105ae1:	ff 75 0c             	pushl  0xc(%ebp)
c0105ae4:	6a 20                	push   $0x20
c0105ae6:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ae9:	ff d0                	call   *%eax
c0105aeb:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
c0105aee:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
c0105af2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105af6:	7f e6                	jg     c0105ade <vprintfmt+0x233>
            }
            break;
c0105af8:	e9 4e 01 00 00       	jmp    c0105c4b <vprintfmt+0x3a0>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
c0105afd:	83 ec 08             	sub    $0x8,%esp
c0105b00:	ff 75 e0             	pushl  -0x20(%ebp)
c0105b03:	8d 45 14             	lea    0x14(%ebp),%eax
c0105b06:	50                   	push   %eax
c0105b07:	e8 2c fd ff ff       	call   c0105838 <getint>
c0105b0c:	83 c4 10             	add    $0x10,%esp
c0105b0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b12:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
c0105b15:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105b18:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105b1b:	85 d2                	test   %edx,%edx
c0105b1d:	79 23                	jns    c0105b42 <vprintfmt+0x297>
                putch('-', putdat);
c0105b1f:	83 ec 08             	sub    $0x8,%esp
c0105b22:	ff 75 0c             	pushl  0xc(%ebp)
c0105b25:	6a 2d                	push   $0x2d
c0105b27:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b2a:	ff d0                	call   *%eax
c0105b2c:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
c0105b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105b32:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105b35:	f7 d8                	neg    %eax
c0105b37:	83 d2 00             	adc    $0x0,%edx
c0105b3a:	f7 da                	neg    %edx
c0105b3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b3f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
c0105b42:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105b49:	e9 9f 00 00 00       	jmp    c0105bed <vprintfmt+0x342>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
c0105b4e:	83 ec 08             	sub    $0x8,%esp
c0105b51:	ff 75 e0             	pushl  -0x20(%ebp)
c0105b54:	8d 45 14             	lea    0x14(%ebp),%eax
c0105b57:	50                   	push   %eax
c0105b58:	e8 88 fc ff ff       	call   c01057e5 <getuint>
c0105b5d:	83 c4 10             	add    $0x10,%esp
c0105b60:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b63:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
c0105b66:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105b6d:	eb 7e                	jmp    c0105bed <vprintfmt+0x342>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
c0105b6f:	83 ec 08             	sub    $0x8,%esp
c0105b72:	ff 75 e0             	pushl  -0x20(%ebp)
c0105b75:	8d 45 14             	lea    0x14(%ebp),%eax
c0105b78:	50                   	push   %eax
c0105b79:	e8 67 fc ff ff       	call   c01057e5 <getuint>
c0105b7e:	83 c4 10             	add    $0x10,%esp
c0105b81:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105b84:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
c0105b87:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
c0105b8e:	eb 5d                	jmp    c0105bed <vprintfmt+0x342>

        // pointer
        case 'p':
            putch('0', putdat);
c0105b90:	83 ec 08             	sub    $0x8,%esp
c0105b93:	ff 75 0c             	pushl  0xc(%ebp)
c0105b96:	6a 30                	push   $0x30
c0105b98:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b9b:	ff d0                	call   *%eax
c0105b9d:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
c0105ba0:	83 ec 08             	sub    $0x8,%esp
c0105ba3:	ff 75 0c             	pushl  0xc(%ebp)
c0105ba6:	6a 78                	push   $0x78
c0105ba8:	8b 45 08             	mov    0x8(%ebp),%eax
c0105bab:	ff d0                	call   *%eax
c0105bad:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
c0105bb0:	8b 45 14             	mov    0x14(%ebp),%eax
c0105bb3:	8d 50 04             	lea    0x4(%eax),%edx
c0105bb6:	89 55 14             	mov    %edx,0x14(%ebp)
c0105bb9:	8b 00                	mov    (%eax),%eax
c0105bbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105bbe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
c0105bc5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
c0105bcc:	eb 1f                	jmp    c0105bed <vprintfmt+0x342>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
c0105bce:	83 ec 08             	sub    $0x8,%esp
c0105bd1:	ff 75 e0             	pushl  -0x20(%ebp)
c0105bd4:	8d 45 14             	lea    0x14(%ebp),%eax
c0105bd7:	50                   	push   %eax
c0105bd8:	e8 08 fc ff ff       	call   c01057e5 <getuint>
c0105bdd:	83 c4 10             	add    $0x10,%esp
c0105be0:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105be3:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
c0105be6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
c0105bed:	0f be 55 db          	movsbl -0x25(%ebp),%edx
c0105bf1:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105bf4:	83 ec 04             	sub    $0x4,%esp
c0105bf7:	52                   	push   %edx
c0105bf8:	ff 75 e8             	pushl  -0x18(%ebp)
c0105bfb:	50                   	push   %eax
c0105bfc:	ff 75 f4             	pushl  -0xc(%ebp)
c0105bff:	ff 75 f0             	pushl  -0x10(%ebp)
c0105c02:	ff 75 0c             	pushl  0xc(%ebp)
c0105c05:	ff 75 08             	pushl  0x8(%ebp)
c0105c08:	e8 e8 fa ff ff       	call   c01056f5 <printnum>
c0105c0d:	83 c4 20             	add    $0x20,%esp
            break;
c0105c10:	eb 39                	jmp    c0105c4b <vprintfmt+0x3a0>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
c0105c12:	83 ec 08             	sub    $0x8,%esp
c0105c15:	ff 75 0c             	pushl  0xc(%ebp)
c0105c18:	53                   	push   %ebx
c0105c19:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c1c:	ff d0                	call   *%eax
c0105c1e:	83 c4 10             	add    $0x10,%esp
            break;
c0105c21:	eb 28                	jmp    c0105c4b <vprintfmt+0x3a0>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
c0105c23:	83 ec 08             	sub    $0x8,%esp
c0105c26:	ff 75 0c             	pushl  0xc(%ebp)
c0105c29:	6a 25                	push   $0x25
c0105c2b:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c2e:	ff d0                	call   *%eax
c0105c30:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
c0105c33:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105c37:	eb 04                	jmp    c0105c3d <vprintfmt+0x392>
c0105c39:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
c0105c3d:	8b 45 10             	mov    0x10(%ebp),%eax
c0105c40:	83 e8 01             	sub    $0x1,%eax
c0105c43:	0f b6 00             	movzbl (%eax),%eax
c0105c46:	3c 25                	cmp    $0x25,%al
c0105c48:	75 ef                	jne    c0105c39 <vprintfmt+0x38e>
                /* do nothing */;
            break;
c0105c4a:	90                   	nop
    while (1) {
c0105c4b:	e9 67 fc ff ff       	jmp    c01058b7 <vprintfmt+0xc>
                return;
c0105c50:	90                   	nop
        }
    }
}
c0105c51:	8d 65 f8             	lea    -0x8(%ebp),%esp
c0105c54:	5b                   	pop    %ebx
c0105c55:	5e                   	pop    %esi
c0105c56:	5d                   	pop    %ebp
c0105c57:	c3                   	ret    

c0105c58 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
c0105c58:	f3 0f 1e fb          	endbr32 
c0105c5c:	55                   	push   %ebp
c0105c5d:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
c0105c5f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c62:	8b 40 08             	mov    0x8(%eax),%eax
c0105c65:	8d 50 01             	lea    0x1(%eax),%edx
c0105c68:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c6b:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
c0105c6e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c71:	8b 10                	mov    (%eax),%edx
c0105c73:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c76:	8b 40 04             	mov    0x4(%eax),%eax
c0105c79:	39 c2                	cmp    %eax,%edx
c0105c7b:	73 12                	jae    c0105c8f <sprintputch+0x37>
        *b->buf ++ = ch;
c0105c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c80:	8b 00                	mov    (%eax),%eax
c0105c82:	8d 48 01             	lea    0x1(%eax),%ecx
c0105c85:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105c88:	89 0a                	mov    %ecx,(%edx)
c0105c8a:	8b 55 08             	mov    0x8(%ebp),%edx
c0105c8d:	88 10                	mov    %dl,(%eax)
    }
}
c0105c8f:	90                   	nop
c0105c90:	5d                   	pop    %ebp
c0105c91:	c3                   	ret    

c0105c92 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
c0105c92:	f3 0f 1e fb          	endbr32 
c0105c96:	55                   	push   %ebp
c0105c97:	89 e5                	mov    %esp,%ebp
c0105c99:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c0105c9c:	8d 45 14             	lea    0x14(%ebp),%eax
c0105c9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
c0105ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105ca5:	50                   	push   %eax
c0105ca6:	ff 75 10             	pushl  0x10(%ebp)
c0105ca9:	ff 75 0c             	pushl  0xc(%ebp)
c0105cac:	ff 75 08             	pushl  0x8(%ebp)
c0105caf:	e8 0b 00 00 00       	call   c0105cbf <vsnprintf>
c0105cb4:	83 c4 10             	add    $0x10,%esp
c0105cb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c0105cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105cbd:	c9                   	leave  
c0105cbe:	c3                   	ret    

c0105cbf <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
c0105cbf:	f3 0f 1e fb          	endbr32 
c0105cc3:	55                   	push   %ebp
c0105cc4:	89 e5                	mov    %esp,%ebp
c0105cc6:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
c0105cc9:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ccc:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105cd2:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105cd5:	8b 45 08             	mov    0x8(%ebp),%eax
c0105cd8:	01 d0                	add    %edx,%eax
c0105cda:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105cdd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
c0105ce4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0105ce8:	74 0a                	je     c0105cf4 <vsnprintf+0x35>
c0105cea:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105ced:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105cf0:	39 c2                	cmp    %eax,%edx
c0105cf2:	76 07                	jbe    c0105cfb <vsnprintf+0x3c>
        return -E_INVAL;
c0105cf4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
c0105cf9:	eb 20                	jmp    c0105d1b <vsnprintf+0x5c>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
c0105cfb:	ff 75 14             	pushl  0x14(%ebp)
c0105cfe:	ff 75 10             	pushl  0x10(%ebp)
c0105d01:	8d 45 ec             	lea    -0x14(%ebp),%eax
c0105d04:	50                   	push   %eax
c0105d05:	68 58 5c 10 c0       	push   $0xc0105c58
c0105d0a:	e8 9c fb ff ff       	call   c01058ab <vprintfmt>
c0105d0f:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
c0105d12:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105d15:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
c0105d18:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0105d1b:	c9                   	leave  
c0105d1c:	c3                   	ret    
