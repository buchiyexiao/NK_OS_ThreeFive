
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	f3 0f 1e fb          	endbr32 
  100004:	55                   	push   %ebp
  100005:	89 e5                	mov    %esp,%ebp
  100007:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  10000a:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  10000f:	2d 16 fa 10 00       	sub    $0x10fa16,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 fa 10 00 	movl   $0x10fa16,(%esp)
  100027:	e8 86 2e 00 00       	call   102eb2 <memset>

    cons_init();                // init the console
  10002c:	e8 17 16 00 00       	call   101648 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 e0 36 10 00 	movl   $0x1036e0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 fc 36 10 00 	movl   $0x1036fc,(%esp)
  100046:	e8 3e 02 00 00       	call   100289 <cprintf>

    print_kerninfo();
  10004b:	e8 fc 08 00 00       	call   10094c <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 07 2b 00 00       	call   102b61 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 3e 17 00 00       	call   10179d <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 e3 18 00 00       	call   101947 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 64 0d 00 00       	call   100dcd <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 7b 18 00 00       	call   1018e9 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 7c 01 00 00       	call   1001ef <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	f3 0f 1e fb          	endbr32 
  100079:	55                   	push   %ebp
  10007a:	89 e5                	mov    %esp,%ebp
  10007c:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100086:	00 
  100087:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008e:	00 
  10008f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100096:	e8 1c 0d 00 00       	call   100db7 <mon_backtrace>
}
  10009b:	90                   	nop
  10009c:	c9                   	leave  
  10009d:	c3                   	ret    

0010009e <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  10009e:	f3 0f 1e fb          	endbr32 
  1000a2:	55                   	push   %ebp
  1000a3:	89 e5                	mov    %esp,%ebp
  1000a5:	53                   	push   %ebx
  1000a6:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a9:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000af:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1000b5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000c1:	89 04 24             	mov    %eax,(%esp)
  1000c4:	e8 ac ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c9:	90                   	nop
  1000ca:	83 c4 14             	add    $0x14,%esp
  1000cd:	5b                   	pop    %ebx
  1000ce:	5d                   	pop    %ebp
  1000cf:	c3                   	ret    

001000d0 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000d0:	f3 0f 1e fb          	endbr32 
  1000d4:	55                   	push   %ebp
  1000d5:	89 e5                	mov    %esp,%ebp
  1000d7:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000da:	8b 45 10             	mov    0x10(%ebp),%eax
  1000dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1000e4:	89 04 24             	mov    %eax,(%esp)
  1000e7:	e8 b2 ff ff ff       	call   10009e <grade_backtrace1>
}
  1000ec:	90                   	nop
  1000ed:	c9                   	leave  
  1000ee:	c3                   	ret    

001000ef <grade_backtrace>:

void
grade_backtrace(void) {
  1000ef:	f3 0f 1e fb          	endbr32 
  1000f3:	55                   	push   %ebp
  1000f4:	89 e5                	mov    %esp,%ebp
  1000f6:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000f9:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000fe:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  100105:	ff 
  100106:	89 44 24 04          	mov    %eax,0x4(%esp)
  10010a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100111:	e8 ba ff ff ff       	call   1000d0 <grade_backtrace0>
}
  100116:	90                   	nop
  100117:	c9                   	leave  
  100118:	c3                   	ret    

00100119 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100119:	f3 0f 1e fb          	endbr32 
  10011d:	55                   	push   %ebp
  10011e:	89 e5                	mov    %esp,%ebp
  100120:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100123:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100126:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100129:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10012c:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  10012f:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100133:	83 e0 03             	and    $0x3,%eax
  100136:	89 c2                	mov    %eax,%edx
  100138:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10013d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100141:	89 44 24 04          	mov    %eax,0x4(%esp)
  100145:	c7 04 24 01 37 10 00 	movl   $0x103701,(%esp)
  10014c:	e8 38 01 00 00       	call   100289 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 0f 37 10 00 	movl   $0x10370f,(%esp)
  10016b:	e8 19 01 00 00       	call   100289 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 1d 37 10 00 	movl   $0x10371d,(%esp)
  10018a:	e8 fa 00 00 00       	call   100289 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 2b 37 10 00 	movl   $0x10372b,(%esp)
  1001a9:	e8 db 00 00 00       	call   100289 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 39 37 10 00 	movl   $0x103739,(%esp)
  1001c8:	e8 bc 00 00 00       	call   100289 <cprintf>
    round ++;
  1001cd:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001d2:	40                   	inc    %eax
  1001d3:	a3 20 fa 10 00       	mov    %eax,0x10fa20
}
  1001d8:	90                   	nop
  1001d9:	c9                   	leave  
  1001da:	c3                   	ret    

001001db <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001db:	f3 0f 1e fb          	endbr32 
  1001df:	55                   	push   %ebp
  1001e0:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001e2:	90                   	nop
  1001e3:	5d                   	pop    %ebp
  1001e4:	c3                   	ret    

001001e5 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001e5:	f3 0f 1e fb          	endbr32 
  1001e9:	55                   	push   %ebp
  1001ea:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001ec:	90                   	nop
  1001ed:	5d                   	pop    %ebp
  1001ee:	c3                   	ret    

001001ef <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001ef:	f3 0f 1e fb          	endbr32 
  1001f3:	55                   	push   %ebp
  1001f4:	89 e5                	mov    %esp,%ebp
  1001f6:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001f9:	e8 1b ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001fe:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
  100205:	e8 7f 00 00 00       	call   100289 <cprintf>
    lab1_switch_to_user();
  10020a:	e8 cc ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  10020f:	e8 05 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100214:	c7 04 24 68 37 10 00 	movl   $0x103768,(%esp)
  10021b:	e8 69 00 00 00       	call   100289 <cprintf>
    lab1_switch_to_kernel();
  100220:	e8 c0 ff ff ff       	call   1001e5 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100225:	e8 ef fe ff ff       	call   100119 <lab1_print_cur_status>
}
  10022a:	90                   	nop
  10022b:	c9                   	leave  
  10022c:	c3                   	ret    

0010022d <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  10022d:	f3 0f 1e fb          	endbr32 
  100231:	55                   	push   %ebp
  100232:	89 e5                	mov    %esp,%ebp
  100234:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100237:	8b 45 08             	mov    0x8(%ebp),%eax
  10023a:	89 04 24             	mov    %eax,(%esp)
  10023d:	e8 37 14 00 00       	call   101679 <cons_putc>
    (*cnt) ++;
  100242:	8b 45 0c             	mov    0xc(%ebp),%eax
  100245:	8b 00                	mov    (%eax),%eax
  100247:	8d 50 01             	lea    0x1(%eax),%edx
  10024a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10024d:	89 10                	mov    %edx,(%eax)
}
  10024f:	90                   	nop
  100250:	c9                   	leave  
  100251:	c3                   	ret    

00100252 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100252:	f3 0f 1e fb          	endbr32 
  100256:	55                   	push   %ebp
  100257:	89 e5                	mov    %esp,%ebp
  100259:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10025c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100263:	8b 45 0c             	mov    0xc(%ebp),%eax
  100266:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10026a:	8b 45 08             	mov    0x8(%ebp),%eax
  10026d:	89 44 24 08          	mov    %eax,0x8(%esp)
  100271:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100274:	89 44 24 04          	mov    %eax,0x4(%esp)
  100278:	c7 04 24 2d 02 10 00 	movl   $0x10022d,(%esp)
  10027f:	e8 9a 2f 00 00       	call   10321e <vprintfmt>
    return cnt;
  100284:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100287:	c9                   	leave  
  100288:	c3                   	ret    

00100289 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100289:	f3 0f 1e fb          	endbr32 
  10028d:	55                   	push   %ebp
  10028e:	89 e5                	mov    %esp,%ebp
  100290:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100293:	8d 45 0c             	lea    0xc(%ebp),%eax
  100296:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100299:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10029c:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1002a3:	89 04 24             	mov    %eax,(%esp)
  1002a6:	e8 a7 ff ff ff       	call   100252 <vcprintf>
  1002ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002b1:	c9                   	leave  
  1002b2:	c3                   	ret    

001002b3 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002b3:	f3 0f 1e fb          	endbr32 
  1002b7:	55                   	push   %ebp
  1002b8:	89 e5                	mov    %esp,%ebp
  1002ba:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c0:	89 04 24             	mov    %eax,(%esp)
  1002c3:	e8 b1 13 00 00       	call   101679 <cons_putc>
}
  1002c8:	90                   	nop
  1002c9:	c9                   	leave  
  1002ca:	c3                   	ret    

001002cb <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002cb:	f3 0f 1e fb          	endbr32 
  1002cf:	55                   	push   %ebp
  1002d0:	89 e5                	mov    %esp,%ebp
  1002d2:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002dc:	eb 13                	jmp    1002f1 <cputs+0x26>
        cputch(c, &cnt);
  1002de:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002e2:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002e5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002e9:	89 04 24             	mov    %eax,(%esp)
  1002ec:	e8 3c ff ff ff       	call   10022d <cputch>
    while ((c = *str ++) != '\0') {
  1002f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1002f4:	8d 50 01             	lea    0x1(%eax),%edx
  1002f7:	89 55 08             	mov    %edx,0x8(%ebp)
  1002fa:	0f b6 00             	movzbl (%eax),%eax
  1002fd:	88 45 f7             	mov    %al,-0x9(%ebp)
  100300:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100304:	75 d8                	jne    1002de <cputs+0x13>
    }
    cputch('\n', &cnt);
  100306:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100309:	89 44 24 04          	mov    %eax,0x4(%esp)
  10030d:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100314:	e8 14 ff ff ff       	call   10022d <cputch>
    return cnt;
  100319:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  10031c:	c9                   	leave  
  10031d:	c3                   	ret    

0010031e <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  10031e:	f3 0f 1e fb          	endbr32 
  100322:	55                   	push   %ebp
  100323:	89 e5                	mov    %esp,%ebp
  100325:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100328:	90                   	nop
  100329:	e8 79 13 00 00       	call   1016a7 <cons_getc>
  10032e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100331:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100335:	74 f2                	je     100329 <getchar+0xb>
        /* do nothing */;
    return c;
  100337:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10033a:	c9                   	leave  
  10033b:	c3                   	ret    

0010033c <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  10033c:	f3 0f 1e fb          	endbr32 
  100340:	55                   	push   %ebp
  100341:	89 e5                	mov    %esp,%ebp
  100343:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100346:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10034a:	74 13                	je     10035f <readline+0x23>
        cprintf("%s", prompt);
  10034c:	8b 45 08             	mov    0x8(%ebp),%eax
  10034f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100353:	c7 04 24 87 37 10 00 	movl   $0x103787,(%esp)
  10035a:	e8 2a ff ff ff       	call   100289 <cprintf>
    }
    int i = 0, c;
  10035f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100366:	e8 b3 ff ff ff       	call   10031e <getchar>
  10036b:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10036e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100372:	79 07                	jns    10037b <readline+0x3f>
            return NULL;
  100374:	b8 00 00 00 00       	mov    $0x0,%eax
  100379:	eb 78                	jmp    1003f3 <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10037b:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10037f:	7e 28                	jle    1003a9 <readline+0x6d>
  100381:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100388:	7f 1f                	jg     1003a9 <readline+0x6d>
            cputchar(c);
  10038a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10038d:	89 04 24             	mov    %eax,(%esp)
  100390:	e8 1e ff ff ff       	call   1002b3 <cputchar>
            buf[i ++] = c;
  100395:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100398:	8d 50 01             	lea    0x1(%eax),%edx
  10039b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10039e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003a1:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  1003a7:	eb 45                	jmp    1003ee <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003a9:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003ad:	75 16                	jne    1003c5 <readline+0x89>
  1003af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003b3:	7e 10                	jle    1003c5 <readline+0x89>
            cputchar(c);
  1003b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003b8:	89 04 24             	mov    %eax,(%esp)
  1003bb:	e8 f3 fe ff ff       	call   1002b3 <cputchar>
            i --;
  1003c0:	ff 4d f4             	decl   -0xc(%ebp)
  1003c3:	eb 29                	jmp    1003ee <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  1003c5:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003c9:	74 06                	je     1003d1 <readline+0x95>
  1003cb:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003cf:	75 95                	jne    100366 <readline+0x2a>
            cputchar(c);
  1003d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003d4:	89 04 24             	mov    %eax,(%esp)
  1003d7:	e8 d7 fe ff ff       	call   1002b3 <cputchar>
            buf[i] = '\0';
  1003dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003df:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1003e4:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003e7:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1003ec:	eb 05                	jmp    1003f3 <readline+0xb7>
        c = getchar();
  1003ee:	e9 73 ff ff ff       	jmp    100366 <readline+0x2a>
        }
    }
}
  1003f3:	c9                   	leave  
  1003f4:	c3                   	ret    

001003f5 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003f5:	f3 0f 1e fb          	endbr32 
  1003f9:	55                   	push   %ebp
  1003fa:	89 e5                	mov    %esp,%ebp
  1003fc:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  1003ff:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  100404:	85 c0                	test   %eax,%eax
  100406:	75 5b                	jne    100463 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  100408:	c7 05 40 fe 10 00 01 	movl   $0x1,0x10fe40
  10040f:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100412:	8d 45 14             	lea    0x14(%ebp),%eax
  100415:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100418:	8b 45 0c             	mov    0xc(%ebp),%eax
  10041b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10041f:	8b 45 08             	mov    0x8(%ebp),%eax
  100422:	89 44 24 04          	mov    %eax,0x4(%esp)
  100426:	c7 04 24 8a 37 10 00 	movl   $0x10378a,(%esp)
  10042d:	e8 57 fe ff ff       	call   100289 <cprintf>
    vcprintf(fmt, ap);
  100432:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100435:	89 44 24 04          	mov    %eax,0x4(%esp)
  100439:	8b 45 10             	mov    0x10(%ebp),%eax
  10043c:	89 04 24             	mov    %eax,(%esp)
  10043f:	e8 0e fe ff ff       	call   100252 <vcprintf>
    cprintf("\n");
  100444:	c7 04 24 a6 37 10 00 	movl   $0x1037a6,(%esp)
  10044b:	e8 39 fe ff ff       	call   100289 <cprintf>
    
    cprintf("stack trackback:\n");
  100450:	c7 04 24 a8 37 10 00 	movl   $0x1037a8,(%esp)
  100457:	e8 2d fe ff ff       	call   100289 <cprintf>
    print_stackframe();
  10045c:	e8 3d 06 00 00       	call   100a9e <print_stackframe>
  100461:	eb 01                	jmp    100464 <__panic+0x6f>
        goto panic_dead;
  100463:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100464:	e8 8c 14 00 00       	call   1018f5 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100469:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100470:	e8 69 08 00 00       	call   100cde <kmonitor>
  100475:	eb f2                	jmp    100469 <__panic+0x74>

00100477 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100477:	f3 0f 1e fb          	endbr32 
  10047b:	55                   	push   %ebp
  10047c:	89 e5                	mov    %esp,%ebp
  10047e:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100481:	8d 45 14             	lea    0x14(%ebp),%eax
  100484:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100487:	8b 45 0c             	mov    0xc(%ebp),%eax
  10048a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10048e:	8b 45 08             	mov    0x8(%ebp),%eax
  100491:	89 44 24 04          	mov    %eax,0x4(%esp)
  100495:	c7 04 24 ba 37 10 00 	movl   $0x1037ba,(%esp)
  10049c:	e8 e8 fd ff ff       	call   100289 <cprintf>
    vcprintf(fmt, ap);
  1004a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004a8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004ab:	89 04 24             	mov    %eax,(%esp)
  1004ae:	e8 9f fd ff ff       	call   100252 <vcprintf>
    cprintf("\n");
  1004b3:	c7 04 24 a6 37 10 00 	movl   $0x1037a6,(%esp)
  1004ba:	e8 ca fd ff ff       	call   100289 <cprintf>
    va_end(ap);
}
  1004bf:	90                   	nop
  1004c0:	c9                   	leave  
  1004c1:	c3                   	ret    

001004c2 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004c2:	f3 0f 1e fb          	endbr32 
  1004c6:	55                   	push   %ebp
  1004c7:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004c9:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  1004ce:	5d                   	pop    %ebp
  1004cf:	c3                   	ret    

001004d0 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004d0:	f3 0f 1e fb          	endbr32 
  1004d4:	55                   	push   %ebp
  1004d5:	89 e5                	mov    %esp,%ebp
  1004d7:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004dd:	8b 00                	mov    (%eax),%eax
  1004df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004e2:	8b 45 10             	mov    0x10(%ebp),%eax
  1004e5:	8b 00                	mov    (%eax),%eax
  1004e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004f1:	e9 ca 00 00 00       	jmp    1005c0 <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  1004f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004fc:	01 d0                	add    %edx,%eax
  1004fe:	89 c2                	mov    %eax,%edx
  100500:	c1 ea 1f             	shr    $0x1f,%edx
  100503:	01 d0                	add    %edx,%eax
  100505:	d1 f8                	sar    %eax
  100507:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10050a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10050d:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100510:	eb 03                	jmp    100515 <stab_binsearch+0x45>
            m --;
  100512:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100515:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100518:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10051b:	7c 1f                	jl     10053c <stab_binsearch+0x6c>
  10051d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100520:	89 d0                	mov    %edx,%eax
  100522:	01 c0                	add    %eax,%eax
  100524:	01 d0                	add    %edx,%eax
  100526:	c1 e0 02             	shl    $0x2,%eax
  100529:	89 c2                	mov    %eax,%edx
  10052b:	8b 45 08             	mov    0x8(%ebp),%eax
  10052e:	01 d0                	add    %edx,%eax
  100530:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100534:	0f b6 c0             	movzbl %al,%eax
  100537:	39 45 14             	cmp    %eax,0x14(%ebp)
  10053a:	75 d6                	jne    100512 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  10053c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10053f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100542:	7d 09                	jge    10054d <stab_binsearch+0x7d>
            l = true_m + 1;
  100544:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100547:	40                   	inc    %eax
  100548:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10054b:	eb 73                	jmp    1005c0 <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  10054d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100554:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100557:	89 d0                	mov    %edx,%eax
  100559:	01 c0                	add    %eax,%eax
  10055b:	01 d0                	add    %edx,%eax
  10055d:	c1 e0 02             	shl    $0x2,%eax
  100560:	89 c2                	mov    %eax,%edx
  100562:	8b 45 08             	mov    0x8(%ebp),%eax
  100565:	01 d0                	add    %edx,%eax
  100567:	8b 40 08             	mov    0x8(%eax),%eax
  10056a:	39 45 18             	cmp    %eax,0x18(%ebp)
  10056d:	76 11                	jbe    100580 <stab_binsearch+0xb0>
            *region_left = m;
  10056f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100572:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100575:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100577:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10057a:	40                   	inc    %eax
  10057b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  10057e:	eb 40                	jmp    1005c0 <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  100580:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100583:	89 d0                	mov    %edx,%eax
  100585:	01 c0                	add    %eax,%eax
  100587:	01 d0                	add    %edx,%eax
  100589:	c1 e0 02             	shl    $0x2,%eax
  10058c:	89 c2                	mov    %eax,%edx
  10058e:	8b 45 08             	mov    0x8(%ebp),%eax
  100591:	01 d0                	add    %edx,%eax
  100593:	8b 40 08             	mov    0x8(%eax),%eax
  100596:	39 45 18             	cmp    %eax,0x18(%ebp)
  100599:	73 14                	jae    1005af <stab_binsearch+0xdf>
            *region_right = m - 1;
  10059b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10059e:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005a1:	8b 45 10             	mov    0x10(%ebp),%eax
  1005a4:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a9:	48                   	dec    %eax
  1005aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005ad:	eb 11                	jmp    1005c0 <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005af:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005b5:	89 10                	mov    %edx,(%eax)
            l = m;
  1005b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005bd:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1005c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005c6:	0f 8e 2a ff ff ff    	jle    1004f6 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005d0:	75 0f                	jne    1005e1 <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  1005d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d5:	8b 00                	mov    (%eax),%eax
  1005d7:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005da:	8b 45 10             	mov    0x10(%ebp),%eax
  1005dd:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005df:	eb 3e                	jmp    10061f <stab_binsearch+0x14f>
        l = *region_right;
  1005e1:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e4:	8b 00                	mov    (%eax),%eax
  1005e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005e9:	eb 03                	jmp    1005ee <stab_binsearch+0x11e>
  1005eb:	ff 4d fc             	decl   -0x4(%ebp)
  1005ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f1:	8b 00                	mov    (%eax),%eax
  1005f3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005f6:	7e 1f                	jle    100617 <stab_binsearch+0x147>
  1005f8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005fb:	89 d0                	mov    %edx,%eax
  1005fd:	01 c0                	add    %eax,%eax
  1005ff:	01 d0                	add    %edx,%eax
  100601:	c1 e0 02             	shl    $0x2,%eax
  100604:	89 c2                	mov    %eax,%edx
  100606:	8b 45 08             	mov    0x8(%ebp),%eax
  100609:	01 d0                	add    %edx,%eax
  10060b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10060f:	0f b6 c0             	movzbl %al,%eax
  100612:	39 45 14             	cmp    %eax,0x14(%ebp)
  100615:	75 d4                	jne    1005eb <stab_binsearch+0x11b>
        *region_left = l;
  100617:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10061d:	89 10                	mov    %edx,(%eax)
}
  10061f:	90                   	nop
  100620:	c9                   	leave  
  100621:	c3                   	ret    

00100622 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100622:	f3 0f 1e fb          	endbr32 
  100626:	55                   	push   %ebp
  100627:	89 e5                	mov    %esp,%ebp
  100629:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10062c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10062f:	c7 00 d8 37 10 00    	movl   $0x1037d8,(%eax)
    info->eip_line = 0;
  100635:	8b 45 0c             	mov    0xc(%ebp),%eax
  100638:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10063f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100642:	c7 40 08 d8 37 10 00 	movl   $0x1037d8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100649:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064c:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100653:	8b 45 0c             	mov    0xc(%ebp),%eax
  100656:	8b 55 08             	mov    0x8(%ebp),%edx
  100659:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10065c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100666:	c7 45 f4 6c 40 10 00 	movl   $0x10406c,-0xc(%ebp)
    stab_end = __STAB_END__;
  10066d:	c7 45 f0 38 ce 10 00 	movl   $0x10ce38,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100674:	c7 45 ec 39 ce 10 00 	movl   $0x10ce39,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10067b:	c7 45 e8 22 ef 10 00 	movl   $0x10ef22,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100682:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100685:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100688:	76 0b                	jbe    100695 <debuginfo_eip+0x73>
  10068a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10068d:	48                   	dec    %eax
  10068e:	0f b6 00             	movzbl (%eax),%eax
  100691:	84 c0                	test   %al,%al
  100693:	74 0a                	je     10069f <debuginfo_eip+0x7d>
        return -1;
  100695:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10069a:	e9 ab 02 00 00       	jmp    10094a <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  10069f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006a9:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006ac:	c1 f8 02             	sar    $0x2,%eax
  1006af:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006b5:	48                   	dec    %eax
  1006b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1006bc:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006c0:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1006c7:	00 
  1006c8:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006cb:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006d2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006d9:	89 04 24             	mov    %eax,(%esp)
  1006dc:	e8 ef fd ff ff       	call   1004d0 <stab_binsearch>
    if (lfile == 0)
  1006e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006e4:	85 c0                	test   %eax,%eax
  1006e6:	75 0a                	jne    1006f2 <debuginfo_eip+0xd0>
        return -1;
  1006e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006ed:	e9 58 02 00 00       	jmp    10094a <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006f2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006f8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006fb:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006fe:	8b 45 08             	mov    0x8(%ebp),%eax
  100701:	89 44 24 10          	mov    %eax,0x10(%esp)
  100705:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  10070c:	00 
  10070d:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100710:	89 44 24 08          	mov    %eax,0x8(%esp)
  100714:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100717:	89 44 24 04          	mov    %eax,0x4(%esp)
  10071b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10071e:	89 04 24             	mov    %eax,(%esp)
  100721:	e8 aa fd ff ff       	call   1004d0 <stab_binsearch>

    if (lfun <= rfun) {
  100726:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100729:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10072c:	39 c2                	cmp    %eax,%edx
  10072e:	7f 78                	jg     1007a8 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100730:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100733:	89 c2                	mov    %eax,%edx
  100735:	89 d0                	mov    %edx,%eax
  100737:	01 c0                	add    %eax,%eax
  100739:	01 d0                	add    %edx,%eax
  10073b:	c1 e0 02             	shl    $0x2,%eax
  10073e:	89 c2                	mov    %eax,%edx
  100740:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100743:	01 d0                	add    %edx,%eax
  100745:	8b 10                	mov    (%eax),%edx
  100747:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10074a:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10074d:	39 c2                	cmp    %eax,%edx
  10074f:	73 22                	jae    100773 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100751:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100754:	89 c2                	mov    %eax,%edx
  100756:	89 d0                	mov    %edx,%eax
  100758:	01 c0                	add    %eax,%eax
  10075a:	01 d0                	add    %edx,%eax
  10075c:	c1 e0 02             	shl    $0x2,%eax
  10075f:	89 c2                	mov    %eax,%edx
  100761:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100764:	01 d0                	add    %edx,%eax
  100766:	8b 10                	mov    (%eax),%edx
  100768:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10076b:	01 c2                	add    %eax,%edx
  10076d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100770:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100773:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100776:	89 c2                	mov    %eax,%edx
  100778:	89 d0                	mov    %edx,%eax
  10077a:	01 c0                	add    %eax,%eax
  10077c:	01 d0                	add    %edx,%eax
  10077e:	c1 e0 02             	shl    $0x2,%eax
  100781:	89 c2                	mov    %eax,%edx
  100783:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100786:	01 d0                	add    %edx,%eax
  100788:	8b 50 08             	mov    0x8(%eax),%edx
  10078b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10078e:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100791:	8b 45 0c             	mov    0xc(%ebp),%eax
  100794:	8b 40 10             	mov    0x10(%eax),%eax
  100797:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10079a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10079d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1007a0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007a3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007a6:	eb 15                	jmp    1007bd <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007ab:	8b 55 08             	mov    0x8(%ebp),%edx
  1007ae:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007ba:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007c0:	8b 40 08             	mov    0x8(%eax),%eax
  1007c3:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1007ca:	00 
  1007cb:	89 04 24             	mov    %eax,(%esp)
  1007ce:	e8 53 25 00 00       	call   102d26 <strfind>
  1007d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007d6:	8b 52 08             	mov    0x8(%edx),%edx
  1007d9:	29 d0                	sub    %edx,%eax
  1007db:	89 c2                	mov    %eax,%edx
  1007dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e0:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  1007e6:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007ea:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007f1:	00 
  1007f2:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007f5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1007f9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  100800:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100803:	89 04 24             	mov    %eax,(%esp)
  100806:	e8 c5 fc ff ff       	call   1004d0 <stab_binsearch>
    if (lline <= rline) {
  10080b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10080e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100811:	39 c2                	cmp    %eax,%edx
  100813:	7f 23                	jg     100838 <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  100815:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100818:	89 c2                	mov    %eax,%edx
  10081a:	89 d0                	mov    %edx,%eax
  10081c:	01 c0                	add    %eax,%eax
  10081e:	01 d0                	add    %edx,%eax
  100820:	c1 e0 02             	shl    $0x2,%eax
  100823:	89 c2                	mov    %eax,%edx
  100825:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100828:	01 d0                	add    %edx,%eax
  10082a:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10082e:	89 c2                	mov    %eax,%edx
  100830:	8b 45 0c             	mov    0xc(%ebp),%eax
  100833:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100836:	eb 11                	jmp    100849 <debuginfo_eip+0x227>
        return -1;
  100838:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10083d:	e9 08 01 00 00       	jmp    10094a <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100842:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100845:	48                   	dec    %eax
  100846:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100849:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10084c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10084f:	39 c2                	cmp    %eax,%edx
  100851:	7c 56                	jl     1008a9 <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  100853:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100856:	89 c2                	mov    %eax,%edx
  100858:	89 d0                	mov    %edx,%eax
  10085a:	01 c0                	add    %eax,%eax
  10085c:	01 d0                	add    %edx,%eax
  10085e:	c1 e0 02             	shl    $0x2,%eax
  100861:	89 c2                	mov    %eax,%edx
  100863:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100866:	01 d0                	add    %edx,%eax
  100868:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10086c:	3c 84                	cmp    $0x84,%al
  10086e:	74 39                	je     1008a9 <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100870:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100873:	89 c2                	mov    %eax,%edx
  100875:	89 d0                	mov    %edx,%eax
  100877:	01 c0                	add    %eax,%eax
  100879:	01 d0                	add    %edx,%eax
  10087b:	c1 e0 02             	shl    $0x2,%eax
  10087e:	89 c2                	mov    %eax,%edx
  100880:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100883:	01 d0                	add    %edx,%eax
  100885:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100889:	3c 64                	cmp    $0x64,%al
  10088b:	75 b5                	jne    100842 <debuginfo_eip+0x220>
  10088d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100890:	89 c2                	mov    %eax,%edx
  100892:	89 d0                	mov    %edx,%eax
  100894:	01 c0                	add    %eax,%eax
  100896:	01 d0                	add    %edx,%eax
  100898:	c1 e0 02             	shl    $0x2,%eax
  10089b:	89 c2                	mov    %eax,%edx
  10089d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a0:	01 d0                	add    %edx,%eax
  1008a2:	8b 40 08             	mov    0x8(%eax),%eax
  1008a5:	85 c0                	test   %eax,%eax
  1008a7:	74 99                	je     100842 <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008a9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008af:	39 c2                	cmp    %eax,%edx
  1008b1:	7c 42                	jl     1008f5 <debuginfo_eip+0x2d3>
  1008b3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008b6:	89 c2                	mov    %eax,%edx
  1008b8:	89 d0                	mov    %edx,%eax
  1008ba:	01 c0                	add    %eax,%eax
  1008bc:	01 d0                	add    %edx,%eax
  1008be:	c1 e0 02             	shl    $0x2,%eax
  1008c1:	89 c2                	mov    %eax,%edx
  1008c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008c6:	01 d0                	add    %edx,%eax
  1008c8:	8b 10                	mov    (%eax),%edx
  1008ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008cd:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008d0:	39 c2                	cmp    %eax,%edx
  1008d2:	73 21                	jae    1008f5 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008d7:	89 c2                	mov    %eax,%edx
  1008d9:	89 d0                	mov    %edx,%eax
  1008db:	01 c0                	add    %eax,%eax
  1008dd:	01 d0                	add    %edx,%eax
  1008df:	c1 e0 02             	shl    $0x2,%eax
  1008e2:	89 c2                	mov    %eax,%edx
  1008e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008e7:	01 d0                	add    %edx,%eax
  1008e9:	8b 10                	mov    (%eax),%edx
  1008eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008ee:	01 c2                	add    %eax,%edx
  1008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008f3:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008f5:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008f8:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008fb:	39 c2                	cmp    %eax,%edx
  1008fd:	7d 46                	jge    100945 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  1008ff:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100902:	40                   	inc    %eax
  100903:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100906:	eb 16                	jmp    10091e <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100908:	8b 45 0c             	mov    0xc(%ebp),%eax
  10090b:	8b 40 14             	mov    0x14(%eax),%eax
  10090e:	8d 50 01             	lea    0x1(%eax),%edx
  100911:	8b 45 0c             	mov    0xc(%ebp),%eax
  100914:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100917:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10091a:	40                   	inc    %eax
  10091b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10091e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100921:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100924:	39 c2                	cmp    %eax,%edx
  100926:	7d 1d                	jge    100945 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100928:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10092b:	89 c2                	mov    %eax,%edx
  10092d:	89 d0                	mov    %edx,%eax
  10092f:	01 c0                	add    %eax,%eax
  100931:	01 d0                	add    %edx,%eax
  100933:	c1 e0 02             	shl    $0x2,%eax
  100936:	89 c2                	mov    %eax,%edx
  100938:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10093b:	01 d0                	add    %edx,%eax
  10093d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100941:	3c a0                	cmp    $0xa0,%al
  100943:	74 c3                	je     100908 <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  100945:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10094a:	c9                   	leave  
  10094b:	c3                   	ret    

0010094c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  10094c:	f3 0f 1e fb          	endbr32 
  100950:	55                   	push   %ebp
  100951:	89 e5                	mov    %esp,%ebp
  100953:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100956:	c7 04 24 e2 37 10 00 	movl   $0x1037e2,(%esp)
  10095d:	e8 27 f9 ff ff       	call   100289 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100962:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100969:	00 
  10096a:	c7 04 24 fb 37 10 00 	movl   $0x1037fb,(%esp)
  100971:	e8 13 f9 ff ff       	call   100289 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100976:	c7 44 24 04 d6 36 10 	movl   $0x1036d6,0x4(%esp)
  10097d:	00 
  10097e:	c7 04 24 13 38 10 00 	movl   $0x103813,(%esp)
  100985:	e8 ff f8 ff ff       	call   100289 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  10098a:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  100991:	00 
  100992:	c7 04 24 2b 38 10 00 	movl   $0x10382b,(%esp)
  100999:	e8 eb f8 ff ff       	call   100289 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  10099e:	c7 44 24 04 20 0d 11 	movl   $0x110d20,0x4(%esp)
  1009a5:	00 
  1009a6:	c7 04 24 43 38 10 00 	movl   $0x103843,(%esp)
  1009ad:	e8 d7 f8 ff ff       	call   100289 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009b2:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  1009b7:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009bc:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009c1:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009c7:	85 c0                	test   %eax,%eax
  1009c9:	0f 48 c2             	cmovs  %edx,%eax
  1009cc:	c1 f8 0a             	sar    $0xa,%eax
  1009cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d3:	c7 04 24 5c 38 10 00 	movl   $0x10385c,(%esp)
  1009da:	e8 aa f8 ff ff       	call   100289 <cprintf>
}
  1009df:	90                   	nop
  1009e0:	c9                   	leave  
  1009e1:	c3                   	ret    

001009e2 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009e2:	f3 0f 1e fb          	endbr32 
  1009e6:	55                   	push   %ebp
  1009e7:	89 e5                	mov    %esp,%ebp
  1009e9:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009ef:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1009f9:	89 04 24             	mov    %eax,(%esp)
  1009fc:	e8 21 fc ff ff       	call   100622 <debuginfo_eip>
  100a01:	85 c0                	test   %eax,%eax
  100a03:	74 15                	je     100a1a <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a05:	8b 45 08             	mov    0x8(%ebp),%eax
  100a08:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a0c:	c7 04 24 86 38 10 00 	movl   $0x103886,(%esp)
  100a13:	e8 71 f8 ff ff       	call   100289 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a18:	eb 6c                	jmp    100a86 <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a1a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a21:	eb 1b                	jmp    100a3e <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a23:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a29:	01 d0                	add    %edx,%eax
  100a2b:	0f b6 10             	movzbl (%eax),%edx
  100a2e:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a37:	01 c8                	add    %ecx,%eax
  100a39:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a3b:	ff 45 f4             	incl   -0xc(%ebp)
  100a3e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a41:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a44:	7c dd                	jl     100a23 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a46:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a4f:	01 d0                	add    %edx,%eax
  100a51:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a54:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a57:	8b 55 08             	mov    0x8(%ebp),%edx
  100a5a:	89 d1                	mov    %edx,%ecx
  100a5c:	29 c1                	sub    %eax,%ecx
  100a5e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a61:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a64:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a68:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a6e:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a72:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a76:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a7a:	c7 04 24 a2 38 10 00 	movl   $0x1038a2,(%esp)
  100a81:	e8 03 f8 ff ff       	call   100289 <cprintf>
}
  100a86:	90                   	nop
  100a87:	c9                   	leave  
  100a88:	c3                   	ret    

00100a89 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a89:	f3 0f 1e fb          	endbr32 
  100a8d:	55                   	push   %ebp
  100a8e:	89 e5                	mov    %esp,%ebp
  100a90:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a93:	8b 45 04             	mov    0x4(%ebp),%eax
  100a96:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a9c:	c9                   	leave  
  100a9d:	c3                   	ret    

00100a9e <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a9e:	f3 0f 1e fb          	endbr32 
  100aa2:	55                   	push   %ebp
  100aa3:	89 e5                	mov    %esp,%ebp
  100aa5:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100aa8:	89 e8                	mov    %ebp,%eax
  100aaa:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100aad:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	    uint32_t ebp = read_ebp();   //(1) call read_ebp() to get the value of ebp. the type is (uint32_t);
  100ab0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        uint32_t eip = read_eip();   //(2) call read_eip() to get the value of eip. the type is (uint32_t);
  100ab3:	e8 d1 ff ff ff       	call   100a89 <read_eip>
  100ab8:	89 45 f0             	mov    %eax,-0x10(%ebp)
        int i, j;
        for(i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++) { 
  100abb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100ac2:	e9 90 00 00 00       	jmp    100b57 <print_stackframe+0xb9>
            //(3) from 0 .. STACKFRAME_DEPTH
                cprintf("ebp:0x%08x eip:0x%08x", ebp, eip);//(3.1) printf value of ebp, eip
  100ac7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100aca:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ace:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ad1:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ad5:	c7 04 24 b4 38 10 00 	movl   $0x1038b4,(%esp)
  100adc:	e8 a8 f7 ff ff       	call   100289 <cprintf>
                uint32_t *arg = (uint32_t *)ebp + 2;
  100ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ae4:	83 c0 08             	add    $0x8,%eax
  100ae7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                cprintf(" arg:");
  100aea:	c7 04 24 ca 38 10 00 	movl   $0x1038ca,(%esp)
  100af1:	e8 93 f7 ff ff       	call   100289 <cprintf>
                for(j = 0; j < 4; j++) {
  100af6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100afd:	eb 24                	jmp    100b23 <print_stackframe+0x85>
                        cprintf("0x%08x ", arg[j]);
  100aff:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b02:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100b0c:	01 d0                	add    %edx,%eax
  100b0e:	8b 00                	mov    (%eax),%eax
  100b10:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b14:	c7 04 24 d0 38 10 00 	movl   $0x1038d0,(%esp)
  100b1b:	e8 69 f7 ff ff       	call   100289 <cprintf>
                for(j = 0; j < 4; j++) {
  100b20:	ff 45 e8             	incl   -0x18(%ebp)
  100b23:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b27:	7e d6                	jle    100aff <print_stackframe+0x61>
                }		//(3.2) (uint32_t)calling arguments [0..4] = the contents in address (unit32_t)ebp +2 [0..4]
                cprintf("\n");	//(3.3) cprintf("\n");
  100b29:	c7 04 24 d8 38 10 00 	movl   $0x1038d8,(%esp)
  100b30:	e8 54 f7 ff ff       	call   100289 <cprintf>
                print_debuginfo(eip - 1);//(3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
  100b35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b38:	48                   	dec    %eax
  100b39:	89 04 24             	mov    %eax,(%esp)
  100b3c:	e8 a1 fe ff ff       	call   1009e2 <print_debuginfo>
                eip = ((uint32_t *)ebp)[1];//(3.5) popup a calling stackframe
  100b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b44:	83 c0 04             	add    $0x4,%eax
  100b47:	8b 00                	mov    (%eax),%eax
  100b49:	89 45 f0             	mov    %eax,-0x10(%ebp)
                ebp = ((uint32_t*)ebp)[0];//eip  = ss:[ebp+4]   ebp = ss:[ebp]
  100b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b4f:	8b 00                	mov    (%eax),%eax
  100b51:	89 45 f4             	mov    %eax,-0xc(%ebp)
        for(i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++) { 
  100b54:	ff 45 ec             	incl   -0x14(%ebp)
  100b57:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b5b:	7f 0a                	jg     100b67 <print_stackframe+0xc9>
  100b5d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b61:	0f 85 60 ff ff ff    	jne    100ac7 <print_stackframe+0x29>
        }
}
  100b67:	90                   	nop
  100b68:	c9                   	leave  
  100b69:	c3                   	ret    

00100b6a <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b6a:	f3 0f 1e fb          	endbr32 
  100b6e:	55                   	push   %ebp
  100b6f:	89 e5                	mov    %esp,%ebp
  100b71:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b7b:	eb 0c                	jmp    100b89 <parse+0x1f>
            *buf ++ = '\0';
  100b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  100b80:	8d 50 01             	lea    0x1(%eax),%edx
  100b83:	89 55 08             	mov    %edx,0x8(%ebp)
  100b86:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b89:	8b 45 08             	mov    0x8(%ebp),%eax
  100b8c:	0f b6 00             	movzbl (%eax),%eax
  100b8f:	84 c0                	test   %al,%al
  100b91:	74 1d                	je     100bb0 <parse+0x46>
  100b93:	8b 45 08             	mov    0x8(%ebp),%eax
  100b96:	0f b6 00             	movzbl (%eax),%eax
  100b99:	0f be c0             	movsbl %al,%eax
  100b9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ba0:	c7 04 24 5c 39 10 00 	movl   $0x10395c,(%esp)
  100ba7:	e8 44 21 00 00       	call   102cf0 <strchr>
  100bac:	85 c0                	test   %eax,%eax
  100bae:	75 cd                	jne    100b7d <parse+0x13>
        }
        if (*buf == '\0') {
  100bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  100bb3:	0f b6 00             	movzbl (%eax),%eax
  100bb6:	84 c0                	test   %al,%al
  100bb8:	74 65                	je     100c1f <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100bba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100bbe:	75 14                	jne    100bd4 <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100bc0:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100bc7:	00 
  100bc8:	c7 04 24 61 39 10 00 	movl   $0x103961,(%esp)
  100bcf:	e8 b5 f6 ff ff       	call   100289 <cprintf>
        }
        argv[argc ++] = buf;
  100bd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bd7:	8d 50 01             	lea    0x1(%eax),%edx
  100bda:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bdd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100be4:	8b 45 0c             	mov    0xc(%ebp),%eax
  100be7:	01 c2                	add    %eax,%edx
  100be9:	8b 45 08             	mov    0x8(%ebp),%eax
  100bec:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bee:	eb 03                	jmp    100bf3 <parse+0x89>
            buf ++;
  100bf0:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf6:	0f b6 00             	movzbl (%eax),%eax
  100bf9:	84 c0                	test   %al,%al
  100bfb:	74 8c                	je     100b89 <parse+0x1f>
  100bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  100c00:	0f b6 00             	movzbl (%eax),%eax
  100c03:	0f be c0             	movsbl %al,%eax
  100c06:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c0a:	c7 04 24 5c 39 10 00 	movl   $0x10395c,(%esp)
  100c11:	e8 da 20 00 00       	call   102cf0 <strchr>
  100c16:	85 c0                	test   %eax,%eax
  100c18:	74 d6                	je     100bf0 <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c1a:	e9 6a ff ff ff       	jmp    100b89 <parse+0x1f>
            break;
  100c1f:	90                   	nop
        }
    }
    return argc;
  100c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c23:	c9                   	leave  
  100c24:	c3                   	ret    

00100c25 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c25:	f3 0f 1e fb          	endbr32 
  100c29:	55                   	push   %ebp
  100c2a:	89 e5                	mov    %esp,%ebp
  100c2c:	53                   	push   %ebx
  100c2d:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c30:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c33:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c37:	8b 45 08             	mov    0x8(%ebp),%eax
  100c3a:	89 04 24             	mov    %eax,(%esp)
  100c3d:	e8 28 ff ff ff       	call   100b6a <parse>
  100c42:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c45:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c49:	75 0a                	jne    100c55 <runcmd+0x30>
        return 0;
  100c4b:	b8 00 00 00 00       	mov    $0x0,%eax
  100c50:	e9 83 00 00 00       	jmp    100cd8 <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c5c:	eb 5a                	jmp    100cb8 <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c5e:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c61:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c64:	89 d0                	mov    %edx,%eax
  100c66:	01 c0                	add    %eax,%eax
  100c68:	01 d0                	add    %edx,%eax
  100c6a:	c1 e0 02             	shl    $0x2,%eax
  100c6d:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c72:	8b 00                	mov    (%eax),%eax
  100c74:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c78:	89 04 24             	mov    %eax,(%esp)
  100c7b:	e8 cc 1f 00 00       	call   102c4c <strcmp>
  100c80:	85 c0                	test   %eax,%eax
  100c82:	75 31                	jne    100cb5 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c84:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c87:	89 d0                	mov    %edx,%eax
  100c89:	01 c0                	add    %eax,%eax
  100c8b:	01 d0                	add    %edx,%eax
  100c8d:	c1 e0 02             	shl    $0x2,%eax
  100c90:	05 08 f0 10 00       	add    $0x10f008,%eax
  100c95:	8b 10                	mov    (%eax),%edx
  100c97:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c9a:	83 c0 04             	add    $0x4,%eax
  100c9d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100ca0:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100ca3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100ca6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100caa:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cae:	89 1c 24             	mov    %ebx,(%esp)
  100cb1:	ff d2                	call   *%edx
  100cb3:	eb 23                	jmp    100cd8 <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100cb5:	ff 45 f4             	incl   -0xc(%ebp)
  100cb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cbb:	83 f8 02             	cmp    $0x2,%eax
  100cbe:	76 9e                	jbe    100c5e <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100cc0:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100cc3:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cc7:	c7 04 24 7f 39 10 00 	movl   $0x10397f,(%esp)
  100cce:	e8 b6 f5 ff ff       	call   100289 <cprintf>
    return 0;
  100cd3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cd8:	83 c4 64             	add    $0x64,%esp
  100cdb:	5b                   	pop    %ebx
  100cdc:	5d                   	pop    %ebp
  100cdd:	c3                   	ret    

00100cde <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100cde:	f3 0f 1e fb          	endbr32 
  100ce2:	55                   	push   %ebp
  100ce3:	89 e5                	mov    %esp,%ebp
  100ce5:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100ce8:	c7 04 24 98 39 10 00 	movl   $0x103998,(%esp)
  100cef:	e8 95 f5 ff ff       	call   100289 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cf4:	c7 04 24 c0 39 10 00 	movl   $0x1039c0,(%esp)
  100cfb:	e8 89 f5 ff ff       	call   100289 <cprintf>

    if (tf != NULL) {
  100d00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100d04:	74 0b                	je     100d11 <kmonitor+0x33>
        print_trapframe(tf);
  100d06:	8b 45 08             	mov    0x8(%ebp),%eax
  100d09:	89 04 24             	mov    %eax,(%esp)
  100d0c:	e8 fb 0d 00 00       	call   101b0c <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d11:	c7 04 24 e5 39 10 00 	movl   $0x1039e5,(%esp)
  100d18:	e8 1f f6 ff ff       	call   10033c <readline>
  100d1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d20:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d24:	74 eb                	je     100d11 <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100d26:	8b 45 08             	mov    0x8(%ebp),%eax
  100d29:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d30:	89 04 24             	mov    %eax,(%esp)
  100d33:	e8 ed fe ff ff       	call   100c25 <runcmd>
  100d38:	85 c0                	test   %eax,%eax
  100d3a:	78 02                	js     100d3e <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100d3c:	eb d3                	jmp    100d11 <kmonitor+0x33>
                break;
  100d3e:	90                   	nop
            }
        }
    }
}
  100d3f:	90                   	nop
  100d40:	c9                   	leave  
  100d41:	c3                   	ret    

00100d42 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d42:	f3 0f 1e fb          	endbr32 
  100d46:	55                   	push   %ebp
  100d47:	89 e5                	mov    %esp,%ebp
  100d49:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d53:	eb 3d                	jmp    100d92 <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d55:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d58:	89 d0                	mov    %edx,%eax
  100d5a:	01 c0                	add    %eax,%eax
  100d5c:	01 d0                	add    %edx,%eax
  100d5e:	c1 e0 02             	shl    $0x2,%eax
  100d61:	05 04 f0 10 00       	add    $0x10f004,%eax
  100d66:	8b 08                	mov    (%eax),%ecx
  100d68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d6b:	89 d0                	mov    %edx,%eax
  100d6d:	01 c0                	add    %eax,%eax
  100d6f:	01 d0                	add    %edx,%eax
  100d71:	c1 e0 02             	shl    $0x2,%eax
  100d74:	05 00 f0 10 00       	add    $0x10f000,%eax
  100d79:	8b 00                	mov    (%eax),%eax
  100d7b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d7f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d83:	c7 04 24 e9 39 10 00 	movl   $0x1039e9,(%esp)
  100d8a:	e8 fa f4 ff ff       	call   100289 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d8f:	ff 45 f4             	incl   -0xc(%ebp)
  100d92:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d95:	83 f8 02             	cmp    $0x2,%eax
  100d98:	76 bb                	jbe    100d55 <mon_help+0x13>
    }
    return 0;
  100d9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d9f:	c9                   	leave  
  100da0:	c3                   	ret    

00100da1 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100da1:	f3 0f 1e fb          	endbr32 
  100da5:	55                   	push   %ebp
  100da6:	89 e5                	mov    %esp,%ebp
  100da8:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100dab:	e8 9c fb ff ff       	call   10094c <print_kerninfo>
    return 0;
  100db0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100db5:	c9                   	leave  
  100db6:	c3                   	ret    

00100db7 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100db7:	f3 0f 1e fb          	endbr32 
  100dbb:	55                   	push   %ebp
  100dbc:	89 e5                	mov    %esp,%ebp
  100dbe:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100dc1:	e8 d8 fc ff ff       	call   100a9e <print_stackframe>
    return 0;
  100dc6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dcb:	c9                   	leave  
  100dcc:	c3                   	ret    

00100dcd <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dcd:	f3 0f 1e fb          	endbr32 
  100dd1:	55                   	push   %ebp
  100dd2:	89 e5                	mov    %esp,%ebp
  100dd4:	83 ec 28             	sub    $0x28,%esp
  100dd7:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100ddd:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100de1:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100de5:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100de9:	ee                   	out    %al,(%dx)
}
  100dea:	90                   	nop
  100deb:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100df1:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100df5:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100df9:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100dfd:	ee                   	out    %al,(%dx)
}
  100dfe:	90                   	nop
  100dff:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100e05:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e09:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e0d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e11:	ee                   	out    %al,(%dx)
}
  100e12:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e13:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  100e1a:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e1d:	c7 04 24 f2 39 10 00 	movl   $0x1039f2,(%esp)
  100e24:	e8 60 f4 ff ff       	call   100289 <cprintf>
    pic_enable(IRQ_TIMER);
  100e29:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e30:	e8 31 09 00 00       	call   101766 <pic_enable>
}
  100e35:	90                   	nop
  100e36:	c9                   	leave  
  100e37:	c3                   	ret    

00100e38 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e38:	f3 0f 1e fb          	endbr32 
  100e3c:	55                   	push   %ebp
  100e3d:	89 e5                	mov    %esp,%ebp
  100e3f:	83 ec 10             	sub    $0x10,%esp
  100e42:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e48:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e4c:	89 c2                	mov    %eax,%edx
  100e4e:	ec                   	in     (%dx),%al
  100e4f:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e52:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e58:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e5c:	89 c2                	mov    %eax,%edx
  100e5e:	ec                   	in     (%dx),%al
  100e5f:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e62:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e68:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e6c:	89 c2                	mov    %eax,%edx
  100e6e:	ec                   	in     (%dx),%al
  100e6f:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e72:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e78:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e7c:	89 c2                	mov    %eax,%edx
  100e7e:	ec                   	in     (%dx),%al
  100e7f:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e82:	90                   	nop
  100e83:	c9                   	leave  
  100e84:	c3                   	ret    

00100e85 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e85:	f3 0f 1e fb          	endbr32 
  100e89:	55                   	push   %ebp
  100e8a:	89 e5                	mov    %esp,%ebp
  100e8c:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e8f:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e99:	0f b7 00             	movzwl (%eax),%eax
  100e9c:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100ea0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea3:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100ea8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eab:	0f b7 00             	movzwl (%eax),%eax
  100eae:	0f b7 c0             	movzwl %ax,%eax
  100eb1:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100eb6:	74 12                	je     100eca <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100eb8:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100ebf:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100ec6:	b4 03 
  100ec8:	eb 13                	jmp    100edd <cga_init+0x58>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100eca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ecd:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ed1:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100ed4:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100edb:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100edd:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ee4:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ee8:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100eec:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ef0:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ef4:	ee                   	out    %al,(%dx)
}
  100ef5:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100ef6:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100efd:	40                   	inc    %eax
  100efe:	0f b7 c0             	movzwl %ax,%eax
  100f01:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f05:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100f09:	89 c2                	mov    %eax,%edx
  100f0b:	ec                   	in     (%dx),%al
  100f0c:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f0f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f13:	0f b6 c0             	movzbl %al,%eax
  100f16:	c1 e0 08             	shl    $0x8,%eax
  100f19:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f1c:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f23:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f27:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f2b:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f2f:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f33:	ee                   	out    %al,(%dx)
}
  100f34:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f35:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f3c:	40                   	inc    %eax
  100f3d:	0f b7 c0             	movzwl %ax,%eax
  100f40:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f44:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f48:	89 c2                	mov    %eax,%edx
  100f4a:	ec                   	in     (%dx),%al
  100f4b:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f4e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f52:	0f b6 c0             	movzbl %al,%eax
  100f55:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f5b:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f60:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f63:	0f b7 c0             	movzwl %ax,%eax
  100f66:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f6c:	90                   	nop
  100f6d:	c9                   	leave  
  100f6e:	c3                   	ret    

00100f6f <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f6f:	f3 0f 1e fb          	endbr32 
  100f73:	55                   	push   %ebp
  100f74:	89 e5                	mov    %esp,%ebp
  100f76:	83 ec 48             	sub    $0x48,%esp
  100f79:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f7f:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f83:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f87:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f8b:	ee                   	out    %al,(%dx)
}
  100f8c:	90                   	nop
  100f8d:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f93:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f97:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f9b:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f9f:	ee                   	out    %al,(%dx)
}
  100fa0:	90                   	nop
  100fa1:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100fa7:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fab:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100faf:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fb3:	ee                   	out    %al,(%dx)
}
  100fb4:	90                   	nop
  100fb5:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fbb:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fbf:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fc3:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fc7:	ee                   	out    %al,(%dx)
}
  100fc8:	90                   	nop
  100fc9:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fcf:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fd3:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fd7:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fdb:	ee                   	out    %al,(%dx)
}
  100fdc:	90                   	nop
  100fdd:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fe3:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fe7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100feb:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fef:	ee                   	out    %al,(%dx)
}
  100ff0:	90                   	nop
  100ff1:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100ff7:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ffb:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fff:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101003:	ee                   	out    %al,(%dx)
}
  101004:	90                   	nop
  101005:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10100b:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  10100f:	89 c2                	mov    %eax,%edx
  101011:	ec                   	in     (%dx),%al
  101012:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  101015:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101019:	3c ff                	cmp    $0xff,%al
  10101b:	0f 95 c0             	setne  %al
  10101e:	0f b6 c0             	movzbl %al,%eax
  101021:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  101026:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10102c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101030:	89 c2                	mov    %eax,%edx
  101032:	ec                   	in     (%dx),%al
  101033:	88 45 f1             	mov    %al,-0xf(%ebp)
  101036:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10103c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101040:	89 c2                	mov    %eax,%edx
  101042:	ec                   	in     (%dx),%al
  101043:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101046:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  10104b:	85 c0                	test   %eax,%eax
  10104d:	74 0c                	je     10105b <serial_init+0xec>
        pic_enable(IRQ_COM1);
  10104f:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101056:	e8 0b 07 00 00       	call   101766 <pic_enable>
    }
}
  10105b:	90                   	nop
  10105c:	c9                   	leave  
  10105d:	c3                   	ret    

0010105e <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  10105e:	f3 0f 1e fb          	endbr32 
  101062:	55                   	push   %ebp
  101063:	89 e5                	mov    %esp,%ebp
  101065:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101068:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10106f:	eb 08                	jmp    101079 <lpt_putc_sub+0x1b>
        delay();
  101071:	e8 c2 fd ff ff       	call   100e38 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101076:	ff 45 fc             	incl   -0x4(%ebp)
  101079:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10107f:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101083:	89 c2                	mov    %eax,%edx
  101085:	ec                   	in     (%dx),%al
  101086:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101089:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10108d:	84 c0                	test   %al,%al
  10108f:	78 09                	js     10109a <lpt_putc_sub+0x3c>
  101091:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101098:	7e d7                	jle    101071 <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  10109a:	8b 45 08             	mov    0x8(%ebp),%eax
  10109d:	0f b6 c0             	movzbl %al,%eax
  1010a0:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  1010a6:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a9:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010ad:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010b1:	ee                   	out    %al,(%dx)
}
  1010b2:	90                   	nop
  1010b3:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010b9:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010bd:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010c1:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010c5:	ee                   	out    %al,(%dx)
}
  1010c6:	90                   	nop
  1010c7:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010cd:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010d1:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010d5:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010d9:	ee                   	out    %al,(%dx)
}
  1010da:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010db:	90                   	nop
  1010dc:	c9                   	leave  
  1010dd:	c3                   	ret    

001010de <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010de:	f3 0f 1e fb          	endbr32 
  1010e2:	55                   	push   %ebp
  1010e3:	89 e5                	mov    %esp,%ebp
  1010e5:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010e8:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010ec:	74 0d                	je     1010fb <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1010f1:	89 04 24             	mov    %eax,(%esp)
  1010f4:	e8 65 ff ff ff       	call   10105e <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010f9:	eb 24                	jmp    10111f <lpt_putc+0x41>
        lpt_putc_sub('\b');
  1010fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101102:	e8 57 ff ff ff       	call   10105e <lpt_putc_sub>
        lpt_putc_sub(' ');
  101107:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10110e:	e8 4b ff ff ff       	call   10105e <lpt_putc_sub>
        lpt_putc_sub('\b');
  101113:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10111a:	e8 3f ff ff ff       	call   10105e <lpt_putc_sub>
}
  10111f:	90                   	nop
  101120:	c9                   	leave  
  101121:	c3                   	ret    

00101122 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101122:	f3 0f 1e fb          	endbr32 
  101126:	55                   	push   %ebp
  101127:	89 e5                	mov    %esp,%ebp
  101129:	53                   	push   %ebx
  10112a:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  10112d:	8b 45 08             	mov    0x8(%ebp),%eax
  101130:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101135:	85 c0                	test   %eax,%eax
  101137:	75 07                	jne    101140 <cga_putc+0x1e>
        c |= 0x0700;
  101139:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101140:	8b 45 08             	mov    0x8(%ebp),%eax
  101143:	0f b6 c0             	movzbl %al,%eax
  101146:	83 f8 0d             	cmp    $0xd,%eax
  101149:	74 72                	je     1011bd <cga_putc+0x9b>
  10114b:	83 f8 0d             	cmp    $0xd,%eax
  10114e:	0f 8f a3 00 00 00    	jg     1011f7 <cga_putc+0xd5>
  101154:	83 f8 08             	cmp    $0x8,%eax
  101157:	74 0a                	je     101163 <cga_putc+0x41>
  101159:	83 f8 0a             	cmp    $0xa,%eax
  10115c:	74 4c                	je     1011aa <cga_putc+0x88>
  10115e:	e9 94 00 00 00       	jmp    1011f7 <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  101163:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10116a:	85 c0                	test   %eax,%eax
  10116c:	0f 84 af 00 00 00    	je     101221 <cga_putc+0xff>
            crt_pos --;
  101172:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101179:	48                   	dec    %eax
  10117a:	0f b7 c0             	movzwl %ax,%eax
  10117d:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101183:	8b 45 08             	mov    0x8(%ebp),%eax
  101186:	98                   	cwtl   
  101187:	25 00 ff ff ff       	and    $0xffffff00,%eax
  10118c:	98                   	cwtl   
  10118d:	83 c8 20             	or     $0x20,%eax
  101190:	98                   	cwtl   
  101191:	8b 15 60 fe 10 00    	mov    0x10fe60,%edx
  101197:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  10119e:	01 c9                	add    %ecx,%ecx
  1011a0:	01 ca                	add    %ecx,%edx
  1011a2:	0f b7 c0             	movzwl %ax,%eax
  1011a5:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1011a8:	eb 77                	jmp    101221 <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  1011aa:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011b1:	83 c0 50             	add    $0x50,%eax
  1011b4:	0f b7 c0             	movzwl %ax,%eax
  1011b7:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011bd:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  1011c4:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011cb:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011d0:	89 c8                	mov    %ecx,%eax
  1011d2:	f7 e2                	mul    %edx
  1011d4:	c1 ea 06             	shr    $0x6,%edx
  1011d7:	89 d0                	mov    %edx,%eax
  1011d9:	c1 e0 02             	shl    $0x2,%eax
  1011dc:	01 d0                	add    %edx,%eax
  1011de:	c1 e0 04             	shl    $0x4,%eax
  1011e1:	29 c1                	sub    %eax,%ecx
  1011e3:	89 c8                	mov    %ecx,%eax
  1011e5:	0f b7 c0             	movzwl %ax,%eax
  1011e8:	29 c3                	sub    %eax,%ebx
  1011ea:	89 d8                	mov    %ebx,%eax
  1011ec:	0f b7 c0             	movzwl %ax,%eax
  1011ef:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  1011f5:	eb 2b                	jmp    101222 <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011f7:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  1011fd:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101204:	8d 50 01             	lea    0x1(%eax),%edx
  101207:	0f b7 d2             	movzwl %dx,%edx
  10120a:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  101211:	01 c0                	add    %eax,%eax
  101213:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  101216:	8b 45 08             	mov    0x8(%ebp),%eax
  101219:	0f b7 c0             	movzwl %ax,%eax
  10121c:	66 89 02             	mov    %ax,(%edx)
        break;
  10121f:	eb 01                	jmp    101222 <cga_putc+0x100>
        break;
  101221:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101222:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101229:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  10122e:	76 5d                	jbe    10128d <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101230:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101235:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10123b:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101240:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  101247:	00 
  101248:	89 54 24 04          	mov    %edx,0x4(%esp)
  10124c:	89 04 24             	mov    %eax,(%esp)
  10124f:	e8 a1 1c 00 00       	call   102ef5 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101254:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10125b:	eb 14                	jmp    101271 <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  10125d:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101262:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101265:	01 d2                	add    %edx,%edx
  101267:	01 d0                	add    %edx,%eax
  101269:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10126e:	ff 45 f4             	incl   -0xc(%ebp)
  101271:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101278:	7e e3                	jle    10125d <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  10127a:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101281:	83 e8 50             	sub    $0x50,%eax
  101284:	0f b7 c0             	movzwl %ax,%eax
  101287:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  10128d:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  101294:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101298:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10129c:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1012a0:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1012a4:	ee                   	out    %al,(%dx)
}
  1012a5:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  1012a6:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012ad:	c1 e8 08             	shr    $0x8,%eax
  1012b0:	0f b7 c0             	movzwl %ax,%eax
  1012b3:	0f b6 c0             	movzbl %al,%eax
  1012b6:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012bd:	42                   	inc    %edx
  1012be:	0f b7 d2             	movzwl %dx,%edx
  1012c1:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012c5:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012c8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012cc:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012d0:	ee                   	out    %al,(%dx)
}
  1012d1:	90                   	nop
    outb(addr_6845, 15);
  1012d2:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012d9:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012dd:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012e1:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012e5:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012e9:	ee                   	out    %al,(%dx)
}
  1012ea:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012eb:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012f2:	0f b6 c0             	movzbl %al,%eax
  1012f5:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012fc:	42                   	inc    %edx
  1012fd:	0f b7 d2             	movzwl %dx,%edx
  101300:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101304:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101307:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10130b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10130f:	ee                   	out    %al,(%dx)
}
  101310:	90                   	nop
}
  101311:	90                   	nop
  101312:	83 c4 34             	add    $0x34,%esp
  101315:	5b                   	pop    %ebx
  101316:	5d                   	pop    %ebp
  101317:	c3                   	ret    

00101318 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101318:	f3 0f 1e fb          	endbr32 
  10131c:	55                   	push   %ebp
  10131d:	89 e5                	mov    %esp,%ebp
  10131f:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101322:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101329:	eb 08                	jmp    101333 <serial_putc_sub+0x1b>
        delay();
  10132b:	e8 08 fb ff ff       	call   100e38 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101330:	ff 45 fc             	incl   -0x4(%ebp)
  101333:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101339:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10133d:	89 c2                	mov    %eax,%edx
  10133f:	ec                   	in     (%dx),%al
  101340:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101343:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101347:	0f b6 c0             	movzbl %al,%eax
  10134a:	83 e0 20             	and    $0x20,%eax
  10134d:	85 c0                	test   %eax,%eax
  10134f:	75 09                	jne    10135a <serial_putc_sub+0x42>
  101351:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101358:	7e d1                	jle    10132b <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  10135a:	8b 45 08             	mov    0x8(%ebp),%eax
  10135d:	0f b6 c0             	movzbl %al,%eax
  101360:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101366:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101369:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10136d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101371:	ee                   	out    %al,(%dx)
}
  101372:	90                   	nop
}
  101373:	90                   	nop
  101374:	c9                   	leave  
  101375:	c3                   	ret    

00101376 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101376:	f3 0f 1e fb          	endbr32 
  10137a:	55                   	push   %ebp
  10137b:	89 e5                	mov    %esp,%ebp
  10137d:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101380:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101384:	74 0d                	je     101393 <serial_putc+0x1d>
        serial_putc_sub(c);
  101386:	8b 45 08             	mov    0x8(%ebp),%eax
  101389:	89 04 24             	mov    %eax,(%esp)
  10138c:	e8 87 ff ff ff       	call   101318 <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101391:	eb 24                	jmp    1013b7 <serial_putc+0x41>
        serial_putc_sub('\b');
  101393:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10139a:	e8 79 ff ff ff       	call   101318 <serial_putc_sub>
        serial_putc_sub(' ');
  10139f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1013a6:	e8 6d ff ff ff       	call   101318 <serial_putc_sub>
        serial_putc_sub('\b');
  1013ab:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1013b2:	e8 61 ff ff ff       	call   101318 <serial_putc_sub>
}
  1013b7:	90                   	nop
  1013b8:	c9                   	leave  
  1013b9:	c3                   	ret    

001013ba <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013ba:	f3 0f 1e fb          	endbr32 
  1013be:	55                   	push   %ebp
  1013bf:	89 e5                	mov    %esp,%ebp
  1013c1:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013c4:	eb 33                	jmp    1013f9 <cons_intr+0x3f>
        if (c != 0) {
  1013c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013ca:	74 2d                	je     1013f9 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013cc:	a1 84 00 11 00       	mov    0x110084,%eax
  1013d1:	8d 50 01             	lea    0x1(%eax),%edx
  1013d4:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013dd:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013e3:	a1 84 00 11 00       	mov    0x110084,%eax
  1013e8:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013ed:	75 0a                	jne    1013f9 <cons_intr+0x3f>
                cons.wpos = 0;
  1013ef:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  1013f6:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1013fc:	ff d0                	call   *%eax
  1013fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101401:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101405:	75 bf                	jne    1013c6 <cons_intr+0xc>
            }
        }
    }
}
  101407:	90                   	nop
  101408:	90                   	nop
  101409:	c9                   	leave  
  10140a:	c3                   	ret    

0010140b <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  10140b:	f3 0f 1e fb          	endbr32 
  10140f:	55                   	push   %ebp
  101410:	89 e5                	mov    %esp,%ebp
  101412:	83 ec 10             	sub    $0x10,%esp
  101415:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10141b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10141f:	89 c2                	mov    %eax,%edx
  101421:	ec                   	in     (%dx),%al
  101422:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101425:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101429:	0f b6 c0             	movzbl %al,%eax
  10142c:	83 e0 01             	and    $0x1,%eax
  10142f:	85 c0                	test   %eax,%eax
  101431:	75 07                	jne    10143a <serial_proc_data+0x2f>
        return -1;
  101433:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101438:	eb 2a                	jmp    101464 <serial_proc_data+0x59>
  10143a:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101440:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101444:	89 c2                	mov    %eax,%edx
  101446:	ec                   	in     (%dx),%al
  101447:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10144a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10144e:	0f b6 c0             	movzbl %al,%eax
  101451:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101454:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101458:	75 07                	jne    101461 <serial_proc_data+0x56>
        c = '\b';
  10145a:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101461:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101464:	c9                   	leave  
  101465:	c3                   	ret    

00101466 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101466:	f3 0f 1e fb          	endbr32 
  10146a:	55                   	push   %ebp
  10146b:	89 e5                	mov    %esp,%ebp
  10146d:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101470:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101475:	85 c0                	test   %eax,%eax
  101477:	74 0c                	je     101485 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  101479:	c7 04 24 0b 14 10 00 	movl   $0x10140b,(%esp)
  101480:	e8 35 ff ff ff       	call   1013ba <cons_intr>
    }
}
  101485:	90                   	nop
  101486:	c9                   	leave  
  101487:	c3                   	ret    

00101488 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101488:	f3 0f 1e fb          	endbr32 
  10148c:	55                   	push   %ebp
  10148d:	89 e5                	mov    %esp,%ebp
  10148f:	83 ec 38             	sub    $0x38,%esp
  101492:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101498:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10149b:	89 c2                	mov    %eax,%edx
  10149d:	ec                   	in     (%dx),%al
  10149e:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1014a1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1014a5:	0f b6 c0             	movzbl %al,%eax
  1014a8:	83 e0 01             	and    $0x1,%eax
  1014ab:	85 c0                	test   %eax,%eax
  1014ad:	75 0a                	jne    1014b9 <kbd_proc_data+0x31>
        return -1;
  1014af:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1014b4:	e9 56 01 00 00       	jmp    10160f <kbd_proc_data+0x187>
  1014b9:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1014c2:	89 c2                	mov    %eax,%edx
  1014c4:	ec                   	in     (%dx),%al
  1014c5:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014c8:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014cc:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014cf:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014d3:	75 17                	jne    1014ec <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  1014d5:	a1 88 00 11 00       	mov    0x110088,%eax
  1014da:	83 c8 40             	or     $0x40,%eax
  1014dd:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014e2:	b8 00 00 00 00       	mov    $0x0,%eax
  1014e7:	e9 23 01 00 00       	jmp    10160f <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014ec:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f0:	84 c0                	test   %al,%al
  1014f2:	79 45                	jns    101539 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014f4:	a1 88 00 11 00       	mov    0x110088,%eax
  1014f9:	83 e0 40             	and    $0x40,%eax
  1014fc:	85 c0                	test   %eax,%eax
  1014fe:	75 08                	jne    101508 <kbd_proc_data+0x80>
  101500:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101504:	24 7f                	and    $0x7f,%al
  101506:	eb 04                	jmp    10150c <kbd_proc_data+0x84>
  101508:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10150c:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  10150f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101513:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  10151a:	0c 40                	or     $0x40,%al
  10151c:	0f b6 c0             	movzbl %al,%eax
  10151f:	f7 d0                	not    %eax
  101521:	89 c2                	mov    %eax,%edx
  101523:	a1 88 00 11 00       	mov    0x110088,%eax
  101528:	21 d0                	and    %edx,%eax
  10152a:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  10152f:	b8 00 00 00 00       	mov    $0x0,%eax
  101534:	e9 d6 00 00 00       	jmp    10160f <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  101539:	a1 88 00 11 00       	mov    0x110088,%eax
  10153e:	83 e0 40             	and    $0x40,%eax
  101541:	85 c0                	test   %eax,%eax
  101543:	74 11                	je     101556 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101545:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101549:	a1 88 00 11 00       	mov    0x110088,%eax
  10154e:	83 e0 bf             	and    $0xffffffbf,%eax
  101551:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  101556:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10155a:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101561:	0f b6 d0             	movzbl %al,%edx
  101564:	a1 88 00 11 00       	mov    0x110088,%eax
  101569:	09 d0                	or     %edx,%eax
  10156b:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  101570:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101574:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  10157b:	0f b6 d0             	movzbl %al,%edx
  10157e:	a1 88 00 11 00       	mov    0x110088,%eax
  101583:	31 d0                	xor    %edx,%eax
  101585:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  10158a:	a1 88 00 11 00       	mov    0x110088,%eax
  10158f:	83 e0 03             	and    $0x3,%eax
  101592:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  101599:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10159d:	01 d0                	add    %edx,%eax
  10159f:	0f b6 00             	movzbl (%eax),%eax
  1015a2:	0f b6 c0             	movzbl %al,%eax
  1015a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1015a8:	a1 88 00 11 00       	mov    0x110088,%eax
  1015ad:	83 e0 08             	and    $0x8,%eax
  1015b0:	85 c0                	test   %eax,%eax
  1015b2:	74 22                	je     1015d6 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1015b4:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015b8:	7e 0c                	jle    1015c6 <kbd_proc_data+0x13e>
  1015ba:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015be:	7f 06                	jg     1015c6 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1015c0:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015c4:	eb 10                	jmp    1015d6 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015c6:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015ca:	7e 0a                	jle    1015d6 <kbd_proc_data+0x14e>
  1015cc:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015d0:	7f 04                	jg     1015d6 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015d2:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015d6:	a1 88 00 11 00       	mov    0x110088,%eax
  1015db:	f7 d0                	not    %eax
  1015dd:	83 e0 06             	and    $0x6,%eax
  1015e0:	85 c0                	test   %eax,%eax
  1015e2:	75 28                	jne    10160c <kbd_proc_data+0x184>
  1015e4:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015eb:	75 1f                	jne    10160c <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015ed:	c7 04 24 0d 3a 10 00 	movl   $0x103a0d,(%esp)
  1015f4:	e8 90 ec ff ff       	call   100289 <cprintf>
  1015f9:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015ff:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101603:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101607:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10160a:	ee                   	out    %al,(%dx)
}
  10160b:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  10160c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10160f:	c9                   	leave  
  101610:	c3                   	ret    

00101611 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101611:	f3 0f 1e fb          	endbr32 
  101615:	55                   	push   %ebp
  101616:	89 e5                	mov    %esp,%ebp
  101618:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10161b:	c7 04 24 88 14 10 00 	movl   $0x101488,(%esp)
  101622:	e8 93 fd ff ff       	call   1013ba <cons_intr>
}
  101627:	90                   	nop
  101628:	c9                   	leave  
  101629:	c3                   	ret    

0010162a <kbd_init>:

static void
kbd_init(void) {
  10162a:	f3 0f 1e fb          	endbr32 
  10162e:	55                   	push   %ebp
  10162f:	89 e5                	mov    %esp,%ebp
  101631:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101634:	e8 d8 ff ff ff       	call   101611 <kbd_intr>
    pic_enable(IRQ_KBD);
  101639:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101640:	e8 21 01 00 00       	call   101766 <pic_enable>
}
  101645:	90                   	nop
  101646:	c9                   	leave  
  101647:	c3                   	ret    

00101648 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101648:	f3 0f 1e fb          	endbr32 
  10164c:	55                   	push   %ebp
  10164d:	89 e5                	mov    %esp,%ebp
  10164f:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101652:	e8 2e f8 ff ff       	call   100e85 <cga_init>
    serial_init();
  101657:	e8 13 f9 ff ff       	call   100f6f <serial_init>
    kbd_init();
  10165c:	e8 c9 ff ff ff       	call   10162a <kbd_init>
    if (!serial_exists) {
  101661:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101666:	85 c0                	test   %eax,%eax
  101668:	75 0c                	jne    101676 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  10166a:	c7 04 24 19 3a 10 00 	movl   $0x103a19,(%esp)
  101671:	e8 13 ec ff ff       	call   100289 <cprintf>
    }
}
  101676:	90                   	nop
  101677:	c9                   	leave  
  101678:	c3                   	ret    

00101679 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101679:	f3 0f 1e fb          	endbr32 
  10167d:	55                   	push   %ebp
  10167e:	89 e5                	mov    %esp,%ebp
  101680:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101683:	8b 45 08             	mov    0x8(%ebp),%eax
  101686:	89 04 24             	mov    %eax,(%esp)
  101689:	e8 50 fa ff ff       	call   1010de <lpt_putc>
    cga_putc(c);
  10168e:	8b 45 08             	mov    0x8(%ebp),%eax
  101691:	89 04 24             	mov    %eax,(%esp)
  101694:	e8 89 fa ff ff       	call   101122 <cga_putc>
    serial_putc(c);
  101699:	8b 45 08             	mov    0x8(%ebp),%eax
  10169c:	89 04 24             	mov    %eax,(%esp)
  10169f:	e8 d2 fc ff ff       	call   101376 <serial_putc>
}
  1016a4:	90                   	nop
  1016a5:	c9                   	leave  
  1016a6:	c3                   	ret    

001016a7 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1016a7:	f3 0f 1e fb          	endbr32 
  1016ab:	55                   	push   %ebp
  1016ac:	89 e5                	mov    %esp,%ebp
  1016ae:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016b1:	e8 b0 fd ff ff       	call   101466 <serial_intr>
    kbd_intr();
  1016b6:	e8 56 ff ff ff       	call   101611 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016bb:	8b 15 80 00 11 00    	mov    0x110080,%edx
  1016c1:	a1 84 00 11 00       	mov    0x110084,%eax
  1016c6:	39 c2                	cmp    %eax,%edx
  1016c8:	74 36                	je     101700 <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016ca:	a1 80 00 11 00       	mov    0x110080,%eax
  1016cf:	8d 50 01             	lea    0x1(%eax),%edx
  1016d2:	89 15 80 00 11 00    	mov    %edx,0x110080
  1016d8:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  1016df:	0f b6 c0             	movzbl %al,%eax
  1016e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016e5:	a1 80 00 11 00       	mov    0x110080,%eax
  1016ea:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016ef:	75 0a                	jne    1016fb <cons_getc+0x54>
            cons.rpos = 0;
  1016f1:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  1016f8:	00 00 00 
        }
        return c;
  1016fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016fe:	eb 05                	jmp    101705 <cons_getc+0x5e>
    }
    return 0;
  101700:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101705:	c9                   	leave  
  101706:	c3                   	ret    

00101707 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101707:	f3 0f 1e fb          	endbr32 
  10170b:	55                   	push   %ebp
  10170c:	89 e5                	mov    %esp,%ebp
  10170e:	83 ec 14             	sub    $0x14,%esp
  101711:	8b 45 08             	mov    0x8(%ebp),%eax
  101714:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101718:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10171b:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  101721:	a1 8c 00 11 00       	mov    0x11008c,%eax
  101726:	85 c0                	test   %eax,%eax
  101728:	74 39                	je     101763 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  10172a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10172d:	0f b6 c0             	movzbl %al,%eax
  101730:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101736:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101739:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10173d:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101741:	ee                   	out    %al,(%dx)
}
  101742:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101743:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101747:	c1 e8 08             	shr    $0x8,%eax
  10174a:	0f b7 c0             	movzwl %ax,%eax
  10174d:	0f b6 c0             	movzbl %al,%eax
  101750:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101756:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101759:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10175d:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101761:	ee                   	out    %al,(%dx)
}
  101762:	90                   	nop
    }
}
  101763:	90                   	nop
  101764:	c9                   	leave  
  101765:	c3                   	ret    

00101766 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101766:	f3 0f 1e fb          	endbr32 
  10176a:	55                   	push   %ebp
  10176b:	89 e5                	mov    %esp,%ebp
  10176d:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101770:	8b 45 08             	mov    0x8(%ebp),%eax
  101773:	ba 01 00 00 00       	mov    $0x1,%edx
  101778:	88 c1                	mov    %al,%cl
  10177a:	d3 e2                	shl    %cl,%edx
  10177c:	89 d0                	mov    %edx,%eax
  10177e:	98                   	cwtl   
  10177f:	f7 d0                	not    %eax
  101781:	0f bf d0             	movswl %ax,%edx
  101784:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  10178b:	98                   	cwtl   
  10178c:	21 d0                	and    %edx,%eax
  10178e:	98                   	cwtl   
  10178f:	0f b7 c0             	movzwl %ax,%eax
  101792:	89 04 24             	mov    %eax,(%esp)
  101795:	e8 6d ff ff ff       	call   101707 <pic_setmask>
}
  10179a:	90                   	nop
  10179b:	c9                   	leave  
  10179c:	c3                   	ret    

0010179d <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  10179d:	f3 0f 1e fb          	endbr32 
  1017a1:	55                   	push   %ebp
  1017a2:	89 e5                	mov    %esp,%ebp
  1017a4:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1017a7:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  1017ae:	00 00 00 
  1017b1:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017b7:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017bb:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017bf:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017c3:	ee                   	out    %al,(%dx)
}
  1017c4:	90                   	nop
  1017c5:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017cb:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017cf:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017d3:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017d7:	ee                   	out    %al,(%dx)
}
  1017d8:	90                   	nop
  1017d9:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017df:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017e3:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017e7:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017eb:	ee                   	out    %al,(%dx)
}
  1017ec:	90                   	nop
  1017ed:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017f3:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017f7:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017fb:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017ff:	ee                   	out    %al,(%dx)
}
  101800:	90                   	nop
  101801:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101807:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10180b:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  10180f:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101813:	ee                   	out    %al,(%dx)
}
  101814:	90                   	nop
  101815:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  10181b:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10181f:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101823:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101827:	ee                   	out    %al,(%dx)
}
  101828:	90                   	nop
  101829:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  10182f:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101833:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101837:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10183b:	ee                   	out    %al,(%dx)
}
  10183c:	90                   	nop
  10183d:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101843:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101847:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10184b:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10184f:	ee                   	out    %al,(%dx)
}
  101850:	90                   	nop
  101851:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101857:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10185b:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10185f:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101863:	ee                   	out    %al,(%dx)
}
  101864:	90                   	nop
  101865:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  10186b:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10186f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101873:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101877:	ee                   	out    %al,(%dx)
}
  101878:	90                   	nop
  101879:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  10187f:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101883:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101887:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10188b:	ee                   	out    %al,(%dx)
}
  10188c:	90                   	nop
  10188d:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101893:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101897:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10189b:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10189f:	ee                   	out    %al,(%dx)
}
  1018a0:	90                   	nop
  1018a1:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  1018a7:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018ab:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1018af:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1018b3:	ee                   	out    %al,(%dx)
}
  1018b4:	90                   	nop
  1018b5:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018bb:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018bf:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018c3:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018c7:	ee                   	out    %al,(%dx)
}
  1018c8:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018c9:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018d0:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018d5:	74 0f                	je     1018e6 <pic_init+0x149>
        pic_setmask(irq_mask);
  1018d7:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018de:	89 04 24             	mov    %eax,(%esp)
  1018e1:	e8 21 fe ff ff       	call   101707 <pic_setmask>
    }
}
  1018e6:	90                   	nop
  1018e7:	c9                   	leave  
  1018e8:	c3                   	ret    

001018e9 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018e9:	f3 0f 1e fb          	endbr32 
  1018ed:	55                   	push   %ebp
  1018ee:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018f0:	fb                   	sti    
}
  1018f1:	90                   	nop
    sti();
}
  1018f2:	90                   	nop
  1018f3:	5d                   	pop    %ebp
  1018f4:	c3                   	ret    

001018f5 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018f5:	f3 0f 1e fb          	endbr32 
  1018f9:	55                   	push   %ebp
  1018fa:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1018fc:	fa                   	cli    
}
  1018fd:	90                   	nop
    cli();
}
  1018fe:	90                   	nop
  1018ff:	5d                   	pop    %ebp
  101900:	c3                   	ret    

00101901 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101901:	f3 0f 1e fb          	endbr32 
  101905:	55                   	push   %ebp
  101906:	89 e5                	mov    %esp,%ebp
  101908:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  10190b:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101912:	00 
  101913:	c7 04 24 40 3a 10 00 	movl   $0x103a40,(%esp)
  10191a:	e8 6a e9 ff ff       	call   100289 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  10191f:	c7 04 24 4a 3a 10 00 	movl   $0x103a4a,(%esp)
  101926:	e8 5e e9 ff ff       	call   100289 <cprintf>
    panic("EOT: kernel seems ok.");
  10192b:	c7 44 24 08 58 3a 10 	movl   $0x103a58,0x8(%esp)
  101932:	00 
  101933:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  10193a:	00 
  10193b:	c7 04 24 6e 3a 10 00 	movl   $0x103a6e,(%esp)
  101942:	e8 ae ea ff ff       	call   1003f5 <__panic>

00101947 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101947:	f3 0f 1e fb          	endbr32 
  10194b:	55                   	push   %ebp
  10194c:	89 e5                	mov    %esp,%ebp
  10194e:	83 ec 10             	sub    $0x10,%esp
  extern uintptr_t __vectors[]; //_vevtors数组保存在vectors.S中的256个中断处理例程的入口地址

 for (int i=0;i<sizeof(idt)/sizeof(struct gatedesc);i++)
  101951:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101958:	e9 c4 00 00 00       	jmp    101a21 <idt_init+0xda>
    { 
SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);
  10195d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101960:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101967:	0f b7 d0             	movzwl %ax,%edx
  10196a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196d:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  101974:	00 
  101975:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101978:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  10197f:	00 08 00 
  101982:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101985:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  10198c:	00 
  10198d:	80 e2 e0             	and    $0xe0,%dl
  101990:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  101997:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10199a:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  1019a1:	00 
  1019a2:	80 e2 1f             	and    $0x1f,%dl
  1019a5:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  1019ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019af:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019b6:	00 
  1019b7:	80 e2 f0             	and    $0xf0,%dl
  1019ba:	80 ca 0e             	or     $0xe,%dl
  1019bd:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c7:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019ce:	00 
  1019cf:	80 e2 ef             	and    $0xef,%dl
  1019d2:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019dc:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019e3:	00 
  1019e4:	80 e2 9f             	and    $0x9f,%dl
  1019e7:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019f1:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019f8:	00 
  1019f9:	80 ca 80             	or     $0x80,%dl
  1019fc:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  101a03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a06:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101a0d:	c1 e8 10             	shr    $0x10,%eax
  101a10:	0f b7 d0             	movzwl %ax,%edx
  101a13:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a16:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  101a1d:	00 
 for (int i=0;i<sizeof(idt)/sizeof(struct gatedesc);i++)
  101a1e:	ff 45 fc             	incl   -0x4(%ebp)
  101a21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a24:	3d ff 00 00 00       	cmp    $0xff,%eax
  101a29:	0f 86 2e ff ff ff    	jbe    10195d <idt_init+0x16>
}
 /*循环调用SETGATE函数对中断门idt[i]依次进行初始化
   其中第一个参数为初始化模板idt[i]；第二个参数为0，表示中断门；第三个参数GD_KTEXT为内核代码段的起始地址；第四个参数_vector[i]为中断处理例程的入口地址；第五个参数表示内核权限\*/
 SETGATE(idt[T_SWITCH_TOK],0,GD_KTEXT,__vectors[T_SWITCH_TOK],DPL_USER);
  101a2f:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a34:	0f b7 c0             	movzwl %ax,%eax
  101a37:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a3d:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a44:	08 00 
  101a46:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a4d:	24 e0                	and    $0xe0,%al
  101a4f:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a54:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a5b:	24 1f                	and    $0x1f,%al
  101a5d:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a62:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a69:	24 f0                	and    $0xf0,%al
  101a6b:	0c 0e                	or     $0xe,%al
  101a6d:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a72:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a79:	24 ef                	and    $0xef,%al
  101a7b:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a80:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a87:	0c 60                	or     $0x60,%al
  101a89:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a8e:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a95:	0c 80                	or     $0x80,%al
  101a97:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a9c:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101aa1:	c1 e8 10             	shr    $0x10,%eax
  101aa4:	0f b7 c0             	movzwl %ax,%eax
  101aa7:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101aad:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101ab4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101ab7:	0f 01 18             	lidtl  (%eax)
}
  101aba:	90                   	nop

lidt(&idt_pd);
//加载idt中断描述符表，并将&idt_pd的首地址加载到IDTR中
}
  101abb:	90                   	nop
  101abc:	c9                   	leave  
  101abd:	c3                   	ret    

00101abe <trapname>:

static const char *
trapname(int trapno) {
  101abe:	f3 0f 1e fb          	endbr32 
  101ac2:	55                   	push   %ebp
  101ac3:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101ac5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ac8:	83 f8 13             	cmp    $0x13,%eax
  101acb:	77 0c                	ja     101ad9 <trapname+0x1b>
        return excnames[trapno];
  101acd:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad0:	8b 04 85 20 3e 10 00 	mov    0x103e20(,%eax,4),%eax
  101ad7:	eb 18                	jmp    101af1 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101ad9:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101add:	7e 0d                	jle    101aec <trapname+0x2e>
  101adf:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ae3:	7f 07                	jg     101aec <trapname+0x2e>
        return "Hardware Interrupt";
  101ae5:	b8 7f 3a 10 00       	mov    $0x103a7f,%eax
  101aea:	eb 05                	jmp    101af1 <trapname+0x33>
    }
    return "(unknown trap)";
  101aec:	b8 92 3a 10 00       	mov    $0x103a92,%eax
}
  101af1:	5d                   	pop    %ebp
  101af2:	c3                   	ret    

00101af3 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101af3:	f3 0f 1e fb          	endbr32 
  101af7:	55                   	push   %ebp
  101af8:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101afa:	8b 45 08             	mov    0x8(%ebp),%eax
  101afd:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b01:	83 f8 08             	cmp    $0x8,%eax
  101b04:	0f 94 c0             	sete   %al
  101b07:	0f b6 c0             	movzbl %al,%eax
}
  101b0a:	5d                   	pop    %ebp
  101b0b:	c3                   	ret    

00101b0c <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101b0c:	f3 0f 1e fb          	endbr32 
  101b10:	55                   	push   %ebp
  101b11:	89 e5                	mov    %esp,%ebp
  101b13:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101b16:	8b 45 08             	mov    0x8(%ebp),%eax
  101b19:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b1d:	c7 04 24 d3 3a 10 00 	movl   $0x103ad3,(%esp)
  101b24:	e8 60 e7 ff ff       	call   100289 <cprintf>
    print_regs(&tf->tf_regs);
  101b29:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2c:	89 04 24             	mov    %eax,(%esp)
  101b2f:	e8 8d 01 00 00       	call   101cc1 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b34:	8b 45 08             	mov    0x8(%ebp),%eax
  101b37:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3f:	c7 04 24 e4 3a 10 00 	movl   $0x103ae4,(%esp)
  101b46:	e8 3e e7 ff ff       	call   100289 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b4e:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b52:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b56:	c7 04 24 f7 3a 10 00 	movl   $0x103af7,(%esp)
  101b5d:	e8 27 e7 ff ff       	call   100289 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b62:	8b 45 08             	mov    0x8(%ebp),%eax
  101b65:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b69:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b6d:	c7 04 24 0a 3b 10 00 	movl   $0x103b0a,(%esp)
  101b74:	e8 10 e7 ff ff       	call   100289 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b79:	8b 45 08             	mov    0x8(%ebp),%eax
  101b7c:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b80:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b84:	c7 04 24 1d 3b 10 00 	movl   $0x103b1d,(%esp)
  101b8b:	e8 f9 e6 ff ff       	call   100289 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b90:	8b 45 08             	mov    0x8(%ebp),%eax
  101b93:	8b 40 30             	mov    0x30(%eax),%eax
  101b96:	89 04 24             	mov    %eax,(%esp)
  101b99:	e8 20 ff ff ff       	call   101abe <trapname>
  101b9e:	8b 55 08             	mov    0x8(%ebp),%edx
  101ba1:	8b 52 30             	mov    0x30(%edx),%edx
  101ba4:	89 44 24 08          	mov    %eax,0x8(%esp)
  101ba8:	89 54 24 04          	mov    %edx,0x4(%esp)
  101bac:	c7 04 24 30 3b 10 00 	movl   $0x103b30,(%esp)
  101bb3:	e8 d1 e6 ff ff       	call   100289 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101bbb:	8b 40 34             	mov    0x34(%eax),%eax
  101bbe:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc2:	c7 04 24 42 3b 10 00 	movl   $0x103b42,(%esp)
  101bc9:	e8 bb e6 ff ff       	call   100289 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bce:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd1:	8b 40 38             	mov    0x38(%eax),%eax
  101bd4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd8:	c7 04 24 51 3b 10 00 	movl   $0x103b51,(%esp)
  101bdf:	e8 a5 e6 ff ff       	call   100289 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101be4:	8b 45 08             	mov    0x8(%ebp),%eax
  101be7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101beb:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bef:	c7 04 24 60 3b 10 00 	movl   $0x103b60,(%esp)
  101bf6:	e8 8e e6 ff ff       	call   100289 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  101bfe:	8b 40 40             	mov    0x40(%eax),%eax
  101c01:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c05:	c7 04 24 73 3b 10 00 	movl   $0x103b73,(%esp)
  101c0c:	e8 78 e6 ff ff       	call   100289 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c18:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c1f:	eb 3d                	jmp    101c5e <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c21:	8b 45 08             	mov    0x8(%ebp),%eax
  101c24:	8b 50 40             	mov    0x40(%eax),%edx
  101c27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c2a:	21 d0                	and    %edx,%eax
  101c2c:	85 c0                	test   %eax,%eax
  101c2e:	74 28                	je     101c58 <print_trapframe+0x14c>
  101c30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c33:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c3a:	85 c0                	test   %eax,%eax
  101c3c:	74 1a                	je     101c58 <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c41:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c48:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c4c:	c7 04 24 82 3b 10 00 	movl   $0x103b82,(%esp)
  101c53:	e8 31 e6 ff ff       	call   100289 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c58:	ff 45 f4             	incl   -0xc(%ebp)
  101c5b:	d1 65 f0             	shll   -0x10(%ebp)
  101c5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c61:	83 f8 17             	cmp    $0x17,%eax
  101c64:	76 bb                	jbe    101c21 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c66:	8b 45 08             	mov    0x8(%ebp),%eax
  101c69:	8b 40 40             	mov    0x40(%eax),%eax
  101c6c:	c1 e8 0c             	shr    $0xc,%eax
  101c6f:	83 e0 03             	and    $0x3,%eax
  101c72:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c76:	c7 04 24 86 3b 10 00 	movl   $0x103b86,(%esp)
  101c7d:	e8 07 e6 ff ff       	call   100289 <cprintf>

    if (!trap_in_kernel(tf)) {
  101c82:	8b 45 08             	mov    0x8(%ebp),%eax
  101c85:	89 04 24             	mov    %eax,(%esp)
  101c88:	e8 66 fe ff ff       	call   101af3 <trap_in_kernel>
  101c8d:	85 c0                	test   %eax,%eax
  101c8f:	75 2d                	jne    101cbe <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c91:	8b 45 08             	mov    0x8(%ebp),%eax
  101c94:	8b 40 44             	mov    0x44(%eax),%eax
  101c97:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c9b:	c7 04 24 8f 3b 10 00 	movl   $0x103b8f,(%esp)
  101ca2:	e8 e2 e5 ff ff       	call   100289 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101ca7:	8b 45 08             	mov    0x8(%ebp),%eax
  101caa:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101cae:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cb2:	c7 04 24 9e 3b 10 00 	movl   $0x103b9e,(%esp)
  101cb9:	e8 cb e5 ff ff       	call   100289 <cprintf>
    }
}
  101cbe:	90                   	nop
  101cbf:	c9                   	leave  
  101cc0:	c3                   	ret    

00101cc1 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101cc1:	f3 0f 1e fb          	endbr32 
  101cc5:	55                   	push   %ebp
  101cc6:	89 e5                	mov    %esp,%ebp
  101cc8:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  101cce:	8b 00                	mov    (%eax),%eax
  101cd0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cd4:	c7 04 24 b1 3b 10 00 	movl   $0x103bb1,(%esp)
  101cdb:	e8 a9 e5 ff ff       	call   100289 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ce3:	8b 40 04             	mov    0x4(%eax),%eax
  101ce6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cea:	c7 04 24 c0 3b 10 00 	movl   $0x103bc0,(%esp)
  101cf1:	e8 93 e5 ff ff       	call   100289 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf9:	8b 40 08             	mov    0x8(%eax),%eax
  101cfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d00:	c7 04 24 cf 3b 10 00 	movl   $0x103bcf,(%esp)
  101d07:	e8 7d e5 ff ff       	call   100289 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d0f:	8b 40 0c             	mov    0xc(%eax),%eax
  101d12:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d16:	c7 04 24 de 3b 10 00 	movl   $0x103bde,(%esp)
  101d1d:	e8 67 e5 ff ff       	call   100289 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d22:	8b 45 08             	mov    0x8(%ebp),%eax
  101d25:	8b 40 10             	mov    0x10(%eax),%eax
  101d28:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d2c:	c7 04 24 ed 3b 10 00 	movl   $0x103bed,(%esp)
  101d33:	e8 51 e5 ff ff       	call   100289 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d38:	8b 45 08             	mov    0x8(%ebp),%eax
  101d3b:	8b 40 14             	mov    0x14(%eax),%eax
  101d3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d42:	c7 04 24 fc 3b 10 00 	movl   $0x103bfc,(%esp)
  101d49:	e8 3b e5 ff ff       	call   100289 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  101d51:	8b 40 18             	mov    0x18(%eax),%eax
  101d54:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d58:	c7 04 24 0b 3c 10 00 	movl   $0x103c0b,(%esp)
  101d5f:	e8 25 e5 ff ff       	call   100289 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d64:	8b 45 08             	mov    0x8(%ebp),%eax
  101d67:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d6a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d6e:	c7 04 24 1a 3c 10 00 	movl   $0x103c1a,(%esp)
  101d75:	e8 0f e5 ff ff       	call   100289 <cprintf>
}
  101d7a:	90                   	nop
  101d7b:	c9                   	leave  
  101d7c:	c3                   	ret    

00101d7d <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d7d:	f3 0f 1e fb          	endbr32 
  101d81:	55                   	push   %ebp
  101d82:	89 e5                	mov    %esp,%ebp
  101d84:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101d87:	8b 45 08             	mov    0x8(%ebp),%eax
  101d8a:	8b 40 30             	mov    0x30(%eax),%eax
  101d8d:	83 f8 79             	cmp    $0x79,%eax
  101d90:	0f 87 af 01 00 00    	ja     101f45 <trap_dispatch+0x1c8>
  101d96:	83 f8 78             	cmp    $0x78,%eax
  101d99:	0f 83 8a 01 00 00    	jae    101f29 <trap_dispatch+0x1ac>
  101d9f:	83 f8 2f             	cmp    $0x2f,%eax
  101da2:	0f 87 9d 01 00 00    	ja     101f45 <trap_dispatch+0x1c8>
  101da8:	83 f8 2e             	cmp    $0x2e,%eax
  101dab:	0f 83 c9 01 00 00    	jae    101f7a <trap_dispatch+0x1fd>
  101db1:	83 f8 24             	cmp    $0x24,%eax
  101db4:	74 5e                	je     101e14 <trap_dispatch+0x97>
  101db6:	83 f8 24             	cmp    $0x24,%eax
  101db9:	0f 87 86 01 00 00    	ja     101f45 <trap_dispatch+0x1c8>
  101dbf:	83 f8 20             	cmp    $0x20,%eax
  101dc2:	74 0a                	je     101dce <trap_dispatch+0x51>
  101dc4:	83 f8 21             	cmp    $0x21,%eax
  101dc7:	74 74                	je     101e3d <trap_dispatch+0xc0>
  101dc9:	e9 77 01 00 00       	jmp    101f45 <trap_dispatch+0x1c8>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
 ticks ++;
  101dce:	a1 08 09 11 00       	mov    0x110908,%eax
  101dd3:	40                   	inc    %eax
  101dd4:	a3 08 09 11 00       	mov    %eax,0x110908
        if (ticks % TICK_NUM == 0) {
  101dd9:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101ddf:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101de4:	89 c8                	mov    %ecx,%eax
  101de6:	f7 e2                	mul    %edx
  101de8:	c1 ea 05             	shr    $0x5,%edx
  101deb:	89 d0                	mov    %edx,%eax
  101ded:	c1 e0 02             	shl    $0x2,%eax
  101df0:	01 d0                	add    %edx,%eax
  101df2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101df9:	01 d0                	add    %edx,%eax
  101dfb:	c1 e0 02             	shl    $0x2,%eax
  101dfe:	29 c1                	sub    %eax,%ecx
  101e00:	89 ca                	mov    %ecx,%edx
  101e02:	85 d2                	test   %edx,%edx
  101e04:	0f 85 73 01 00 00    	jne    101f7d <trap_dispatch+0x200>
            print_ticks();
  101e0a:	e8 f2 fa ff ff       	call   101901 <print_ticks>
//ticks=0;
        }
        break;
  101e0f:	e9 69 01 00 00       	jmp    101f7d <trap_dispatch+0x200>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e14:	e8 8e f8 ff ff       	call   1016a7 <cons_getc>
  101e19:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e1c:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e20:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e24:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e28:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e2c:	c7 04 24 29 3c 10 00 	movl   $0x103c29,(%esp)
  101e33:	e8 51 e4 ff ff       	call   100289 <cprintf>
        break;
  101e38:	e9 41 01 00 00       	jmp    101f7e <trap_dispatch+0x201>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e3d:	e8 65 f8 ff ff       	call   1016a7 <cons_getc>
  101e42:	88 45 f7             	mov    %al,-0x9(%ebp)
         if (c == '0')
  101e45:	80 7d f7 30          	cmpb   $0x30,-0x9(%ebp)
  101e49:	75 56                	jne    101ea1 <trap_dispatch+0x124>
        {
            if (tf->tf_cs != KERNEL_CS) {
  101e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e52:	83 f8 08             	cmp    $0x8,%eax
  101e55:	74 4a                	je     101ea1 <trap_dispatch+0x124>
                tf->tf_cs = KERNEL_CS;
  101e57:	8b 45 08             	mov    0x8(%ebp),%eax
  101e5a:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
                tf->tf_ds = tf->tf_es = KERNEL_DS;
  101e60:	8b 45 08             	mov    0x8(%ebp),%eax
  101e63:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101e69:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6c:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101e70:	8b 45 08             	mov    0x8(%ebp),%eax
  101e73:	66 89 50 2c          	mov    %dx,0x2c(%eax)
                tf->tf_eflags &= ~FL_IOPL_MASK;
  101e77:	8b 45 08             	mov    0x8(%ebp),%eax
  101e7a:	8b 40 40             	mov    0x40(%eax),%eax
  101e7d:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101e82:	89 c2                	mov    %eax,%edx
  101e84:	8b 45 08             	mov    0x8(%ebp),%eax
  101e87:	89 50 40             	mov    %edx,0x40(%eax)
                cprintf("--------switching to kernel mode--------");
  101e8a:	c7 04 24 3c 3c 10 00 	movl   $0x103c3c,(%esp)
  101e91:	e8 f3 e3 ff ff       	call   100289 <cprintf>
                print_trapframe(tf);// 输出此时trapframe的具体信息
  101e96:	8b 45 08             	mov    0x8(%ebp),%eax
  101e99:	89 04 24             	mov    %eax,(%esp)
  101e9c:	e8 6b fc ff ff       	call   101b0c <print_trapframe>
            }// to kernel mode
        }
        if (c == '3')
  101ea1:	80 7d f7 33          	cmpb   $0x33,-0x9(%ebp)
  101ea5:	75 64                	jne    101f0b <trap_dispatch+0x18e>
        {
            if (tf->tf_cs != USER_CS) {
  101ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  101eaa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101eae:	83 f8 1b             	cmp    $0x1b,%eax
  101eb1:	74 58                	je     101f0b <trap_dispatch+0x18e>
                tf->tf_cs = USER_CS;
  101eb3:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb6:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
                tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
  101ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebf:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ec8:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ecf:	66 89 50 28          	mov    %dx,0x28(%eax)
  101ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ed6:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101eda:	8b 45 08             	mov    0x8(%ebp),%eax
  101edd:	66 89 50 2c          	mov    %dx,0x2c(%eax)
                tf->tf_eflags |= FL_IOPL_MASK;
  101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee4:	8b 40 40             	mov    0x40(%eax),%eax
  101ee7:	0d 00 30 00 00       	or     $0x3000,%eax
  101eec:	89 c2                	mov    %eax,%edx
  101eee:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef1:	89 50 40             	mov    %edx,0x40(%eax)
                cprintf("--------switching to user mode--------");
  101ef4:	c7 04 24 68 3c 10 00 	movl   $0x103c68,(%esp)
  101efb:	e8 89 e3 ff ff       	call   100289 <cprintf>
                print_trapframe(tf);// 输出此时trapframe的具体信息
  101f00:	8b 45 08             	mov    0x8(%ebp),%eax
  101f03:	89 04 24             	mov    %eax,(%esp)
  101f06:	e8 01 fc ff ff       	call   101b0c <print_trapframe>
            }  // to user mode
        }
        cprintf("kbd [%03d] %c\n", c, c);
  101f0b:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101f0f:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101f13:	89 54 24 08          	mov    %edx,0x8(%esp)
  101f17:	89 44 24 04          	mov    %eax,0x4(%esp)
  101f1b:	c7 04 24 8f 3c 10 00 	movl   $0x103c8f,(%esp)
  101f22:	e8 62 e3 ff ff       	call   100289 <cprintf>
        break;
  101f27:	eb 55                	jmp    101f7e <trap_dispatch+0x201>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101f29:	c7 44 24 08 9e 3c 10 	movl   $0x103c9e,0x8(%esp)
  101f30:	00 
  101f31:	c7 44 24 04 bc 00 00 	movl   $0xbc,0x4(%esp)
  101f38:	00 
  101f39:	c7 04 24 6e 3a 10 00 	movl   $0x103a6e,(%esp)
  101f40:	e8 b0 e4 ff ff       	call   1003f5 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101f45:	8b 45 08             	mov    0x8(%ebp),%eax
  101f48:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f4c:	83 e0 03             	and    $0x3,%eax
  101f4f:	85 c0                	test   %eax,%eax
  101f51:	75 2b                	jne    101f7e <trap_dispatch+0x201>
            print_trapframe(tf);
  101f53:	8b 45 08             	mov    0x8(%ebp),%eax
  101f56:	89 04 24             	mov    %eax,(%esp)
  101f59:	e8 ae fb ff ff       	call   101b0c <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f5e:	c7 44 24 08 ae 3c 10 	movl   $0x103cae,0x8(%esp)
  101f65:	00 
  101f66:	c7 44 24 04 c6 00 00 	movl   $0xc6,0x4(%esp)
  101f6d:	00 
  101f6e:	c7 04 24 6e 3a 10 00 	movl   $0x103a6e,(%esp)
  101f75:	e8 7b e4 ff ff       	call   1003f5 <__panic>
        break;
  101f7a:	90                   	nop
  101f7b:	eb 01                	jmp    101f7e <trap_dispatch+0x201>
        break;
  101f7d:	90                   	nop
        }
    }
}
  101f7e:	90                   	nop
  101f7f:	c9                   	leave  
  101f80:	c3                   	ret    

00101f81 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f81:	f3 0f 1e fb          	endbr32 
  101f85:	55                   	push   %ebp
  101f86:	89 e5                	mov    %esp,%ebp
  101f88:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f8e:	89 04 24             	mov    %eax,(%esp)
  101f91:	e8 e7 fd ff ff       	call   101d7d <trap_dispatch>
}
  101f96:	90                   	nop
  101f97:	c9                   	leave  
  101f98:	c3                   	ret    

00101f99 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f99:	6a 00                	push   $0x0
  pushl $0
  101f9b:	6a 00                	push   $0x0
  jmp __alltraps
  101f9d:	e9 69 0a 00 00       	jmp    102a0b <__alltraps>

00101fa2 <vector1>:
.globl vector1
vector1:
  pushl $0
  101fa2:	6a 00                	push   $0x0
  pushl $1
  101fa4:	6a 01                	push   $0x1
  jmp __alltraps
  101fa6:	e9 60 0a 00 00       	jmp    102a0b <__alltraps>

00101fab <vector2>:
.globl vector2
vector2:
  pushl $0
  101fab:	6a 00                	push   $0x0
  pushl $2
  101fad:	6a 02                	push   $0x2
  jmp __alltraps
  101faf:	e9 57 0a 00 00       	jmp    102a0b <__alltraps>

00101fb4 <vector3>:
.globl vector3
vector3:
  pushl $0
  101fb4:	6a 00                	push   $0x0
  pushl $3
  101fb6:	6a 03                	push   $0x3
  jmp __alltraps
  101fb8:	e9 4e 0a 00 00       	jmp    102a0b <__alltraps>

00101fbd <vector4>:
.globl vector4
vector4:
  pushl $0
  101fbd:	6a 00                	push   $0x0
  pushl $4
  101fbf:	6a 04                	push   $0x4
  jmp __alltraps
  101fc1:	e9 45 0a 00 00       	jmp    102a0b <__alltraps>

00101fc6 <vector5>:
.globl vector5
vector5:
  pushl $0
  101fc6:	6a 00                	push   $0x0
  pushl $5
  101fc8:	6a 05                	push   $0x5
  jmp __alltraps
  101fca:	e9 3c 0a 00 00       	jmp    102a0b <__alltraps>

00101fcf <vector6>:
.globl vector6
vector6:
  pushl $0
  101fcf:	6a 00                	push   $0x0
  pushl $6
  101fd1:	6a 06                	push   $0x6
  jmp __alltraps
  101fd3:	e9 33 0a 00 00       	jmp    102a0b <__alltraps>

00101fd8 <vector7>:
.globl vector7
vector7:
  pushl $0
  101fd8:	6a 00                	push   $0x0
  pushl $7
  101fda:	6a 07                	push   $0x7
  jmp __alltraps
  101fdc:	e9 2a 0a 00 00       	jmp    102a0b <__alltraps>

00101fe1 <vector8>:
.globl vector8
vector8:
  pushl $8
  101fe1:	6a 08                	push   $0x8
  jmp __alltraps
  101fe3:	e9 23 0a 00 00       	jmp    102a0b <__alltraps>

00101fe8 <vector9>:
.globl vector9
vector9:
  pushl $0
  101fe8:	6a 00                	push   $0x0
  pushl $9
  101fea:	6a 09                	push   $0x9
  jmp __alltraps
  101fec:	e9 1a 0a 00 00       	jmp    102a0b <__alltraps>

00101ff1 <vector10>:
.globl vector10
vector10:
  pushl $10
  101ff1:	6a 0a                	push   $0xa
  jmp __alltraps
  101ff3:	e9 13 0a 00 00       	jmp    102a0b <__alltraps>

00101ff8 <vector11>:
.globl vector11
vector11:
  pushl $11
  101ff8:	6a 0b                	push   $0xb
  jmp __alltraps
  101ffa:	e9 0c 0a 00 00       	jmp    102a0b <__alltraps>

00101fff <vector12>:
.globl vector12
vector12:
  pushl $12
  101fff:	6a 0c                	push   $0xc
  jmp __alltraps
  102001:	e9 05 0a 00 00       	jmp    102a0b <__alltraps>

00102006 <vector13>:
.globl vector13
vector13:
  pushl $13
  102006:	6a 0d                	push   $0xd
  jmp __alltraps
  102008:	e9 fe 09 00 00       	jmp    102a0b <__alltraps>

0010200d <vector14>:
.globl vector14
vector14:
  pushl $14
  10200d:	6a 0e                	push   $0xe
  jmp __alltraps
  10200f:	e9 f7 09 00 00       	jmp    102a0b <__alltraps>

00102014 <vector15>:
.globl vector15
vector15:
  pushl $0
  102014:	6a 00                	push   $0x0
  pushl $15
  102016:	6a 0f                	push   $0xf
  jmp __alltraps
  102018:	e9 ee 09 00 00       	jmp    102a0b <__alltraps>

0010201d <vector16>:
.globl vector16
vector16:
  pushl $0
  10201d:	6a 00                	push   $0x0
  pushl $16
  10201f:	6a 10                	push   $0x10
  jmp __alltraps
  102021:	e9 e5 09 00 00       	jmp    102a0b <__alltraps>

00102026 <vector17>:
.globl vector17
vector17:
  pushl $17
  102026:	6a 11                	push   $0x11
  jmp __alltraps
  102028:	e9 de 09 00 00       	jmp    102a0b <__alltraps>

0010202d <vector18>:
.globl vector18
vector18:
  pushl $0
  10202d:	6a 00                	push   $0x0
  pushl $18
  10202f:	6a 12                	push   $0x12
  jmp __alltraps
  102031:	e9 d5 09 00 00       	jmp    102a0b <__alltraps>

00102036 <vector19>:
.globl vector19
vector19:
  pushl $0
  102036:	6a 00                	push   $0x0
  pushl $19
  102038:	6a 13                	push   $0x13
  jmp __alltraps
  10203a:	e9 cc 09 00 00       	jmp    102a0b <__alltraps>

0010203f <vector20>:
.globl vector20
vector20:
  pushl $0
  10203f:	6a 00                	push   $0x0
  pushl $20
  102041:	6a 14                	push   $0x14
  jmp __alltraps
  102043:	e9 c3 09 00 00       	jmp    102a0b <__alltraps>

00102048 <vector21>:
.globl vector21
vector21:
  pushl $0
  102048:	6a 00                	push   $0x0
  pushl $21
  10204a:	6a 15                	push   $0x15
  jmp __alltraps
  10204c:	e9 ba 09 00 00       	jmp    102a0b <__alltraps>

00102051 <vector22>:
.globl vector22
vector22:
  pushl $0
  102051:	6a 00                	push   $0x0
  pushl $22
  102053:	6a 16                	push   $0x16
  jmp __alltraps
  102055:	e9 b1 09 00 00       	jmp    102a0b <__alltraps>

0010205a <vector23>:
.globl vector23
vector23:
  pushl $0
  10205a:	6a 00                	push   $0x0
  pushl $23
  10205c:	6a 17                	push   $0x17
  jmp __alltraps
  10205e:	e9 a8 09 00 00       	jmp    102a0b <__alltraps>

00102063 <vector24>:
.globl vector24
vector24:
  pushl $0
  102063:	6a 00                	push   $0x0
  pushl $24
  102065:	6a 18                	push   $0x18
  jmp __alltraps
  102067:	e9 9f 09 00 00       	jmp    102a0b <__alltraps>

0010206c <vector25>:
.globl vector25
vector25:
  pushl $0
  10206c:	6a 00                	push   $0x0
  pushl $25
  10206e:	6a 19                	push   $0x19
  jmp __alltraps
  102070:	e9 96 09 00 00       	jmp    102a0b <__alltraps>

00102075 <vector26>:
.globl vector26
vector26:
  pushl $0
  102075:	6a 00                	push   $0x0
  pushl $26
  102077:	6a 1a                	push   $0x1a
  jmp __alltraps
  102079:	e9 8d 09 00 00       	jmp    102a0b <__alltraps>

0010207e <vector27>:
.globl vector27
vector27:
  pushl $0
  10207e:	6a 00                	push   $0x0
  pushl $27
  102080:	6a 1b                	push   $0x1b
  jmp __alltraps
  102082:	e9 84 09 00 00       	jmp    102a0b <__alltraps>

00102087 <vector28>:
.globl vector28
vector28:
  pushl $0
  102087:	6a 00                	push   $0x0
  pushl $28
  102089:	6a 1c                	push   $0x1c
  jmp __alltraps
  10208b:	e9 7b 09 00 00       	jmp    102a0b <__alltraps>

00102090 <vector29>:
.globl vector29
vector29:
  pushl $0
  102090:	6a 00                	push   $0x0
  pushl $29
  102092:	6a 1d                	push   $0x1d
  jmp __alltraps
  102094:	e9 72 09 00 00       	jmp    102a0b <__alltraps>

00102099 <vector30>:
.globl vector30
vector30:
  pushl $0
  102099:	6a 00                	push   $0x0
  pushl $30
  10209b:	6a 1e                	push   $0x1e
  jmp __alltraps
  10209d:	e9 69 09 00 00       	jmp    102a0b <__alltraps>

001020a2 <vector31>:
.globl vector31
vector31:
  pushl $0
  1020a2:	6a 00                	push   $0x0
  pushl $31
  1020a4:	6a 1f                	push   $0x1f
  jmp __alltraps
  1020a6:	e9 60 09 00 00       	jmp    102a0b <__alltraps>

001020ab <vector32>:
.globl vector32
vector32:
  pushl $0
  1020ab:	6a 00                	push   $0x0
  pushl $32
  1020ad:	6a 20                	push   $0x20
  jmp __alltraps
  1020af:	e9 57 09 00 00       	jmp    102a0b <__alltraps>

001020b4 <vector33>:
.globl vector33
vector33:
  pushl $0
  1020b4:	6a 00                	push   $0x0
  pushl $33
  1020b6:	6a 21                	push   $0x21
  jmp __alltraps
  1020b8:	e9 4e 09 00 00       	jmp    102a0b <__alltraps>

001020bd <vector34>:
.globl vector34
vector34:
  pushl $0
  1020bd:	6a 00                	push   $0x0
  pushl $34
  1020bf:	6a 22                	push   $0x22
  jmp __alltraps
  1020c1:	e9 45 09 00 00       	jmp    102a0b <__alltraps>

001020c6 <vector35>:
.globl vector35
vector35:
  pushl $0
  1020c6:	6a 00                	push   $0x0
  pushl $35
  1020c8:	6a 23                	push   $0x23
  jmp __alltraps
  1020ca:	e9 3c 09 00 00       	jmp    102a0b <__alltraps>

001020cf <vector36>:
.globl vector36
vector36:
  pushl $0
  1020cf:	6a 00                	push   $0x0
  pushl $36
  1020d1:	6a 24                	push   $0x24
  jmp __alltraps
  1020d3:	e9 33 09 00 00       	jmp    102a0b <__alltraps>

001020d8 <vector37>:
.globl vector37
vector37:
  pushl $0
  1020d8:	6a 00                	push   $0x0
  pushl $37
  1020da:	6a 25                	push   $0x25
  jmp __alltraps
  1020dc:	e9 2a 09 00 00       	jmp    102a0b <__alltraps>

001020e1 <vector38>:
.globl vector38
vector38:
  pushl $0
  1020e1:	6a 00                	push   $0x0
  pushl $38
  1020e3:	6a 26                	push   $0x26
  jmp __alltraps
  1020e5:	e9 21 09 00 00       	jmp    102a0b <__alltraps>

001020ea <vector39>:
.globl vector39
vector39:
  pushl $0
  1020ea:	6a 00                	push   $0x0
  pushl $39
  1020ec:	6a 27                	push   $0x27
  jmp __alltraps
  1020ee:	e9 18 09 00 00       	jmp    102a0b <__alltraps>

001020f3 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020f3:	6a 00                	push   $0x0
  pushl $40
  1020f5:	6a 28                	push   $0x28
  jmp __alltraps
  1020f7:	e9 0f 09 00 00       	jmp    102a0b <__alltraps>

001020fc <vector41>:
.globl vector41
vector41:
  pushl $0
  1020fc:	6a 00                	push   $0x0
  pushl $41
  1020fe:	6a 29                	push   $0x29
  jmp __alltraps
  102100:	e9 06 09 00 00       	jmp    102a0b <__alltraps>

00102105 <vector42>:
.globl vector42
vector42:
  pushl $0
  102105:	6a 00                	push   $0x0
  pushl $42
  102107:	6a 2a                	push   $0x2a
  jmp __alltraps
  102109:	e9 fd 08 00 00       	jmp    102a0b <__alltraps>

0010210e <vector43>:
.globl vector43
vector43:
  pushl $0
  10210e:	6a 00                	push   $0x0
  pushl $43
  102110:	6a 2b                	push   $0x2b
  jmp __alltraps
  102112:	e9 f4 08 00 00       	jmp    102a0b <__alltraps>

00102117 <vector44>:
.globl vector44
vector44:
  pushl $0
  102117:	6a 00                	push   $0x0
  pushl $44
  102119:	6a 2c                	push   $0x2c
  jmp __alltraps
  10211b:	e9 eb 08 00 00       	jmp    102a0b <__alltraps>

00102120 <vector45>:
.globl vector45
vector45:
  pushl $0
  102120:	6a 00                	push   $0x0
  pushl $45
  102122:	6a 2d                	push   $0x2d
  jmp __alltraps
  102124:	e9 e2 08 00 00       	jmp    102a0b <__alltraps>

00102129 <vector46>:
.globl vector46
vector46:
  pushl $0
  102129:	6a 00                	push   $0x0
  pushl $46
  10212b:	6a 2e                	push   $0x2e
  jmp __alltraps
  10212d:	e9 d9 08 00 00       	jmp    102a0b <__alltraps>

00102132 <vector47>:
.globl vector47
vector47:
  pushl $0
  102132:	6a 00                	push   $0x0
  pushl $47
  102134:	6a 2f                	push   $0x2f
  jmp __alltraps
  102136:	e9 d0 08 00 00       	jmp    102a0b <__alltraps>

0010213b <vector48>:
.globl vector48
vector48:
  pushl $0
  10213b:	6a 00                	push   $0x0
  pushl $48
  10213d:	6a 30                	push   $0x30
  jmp __alltraps
  10213f:	e9 c7 08 00 00       	jmp    102a0b <__alltraps>

00102144 <vector49>:
.globl vector49
vector49:
  pushl $0
  102144:	6a 00                	push   $0x0
  pushl $49
  102146:	6a 31                	push   $0x31
  jmp __alltraps
  102148:	e9 be 08 00 00       	jmp    102a0b <__alltraps>

0010214d <vector50>:
.globl vector50
vector50:
  pushl $0
  10214d:	6a 00                	push   $0x0
  pushl $50
  10214f:	6a 32                	push   $0x32
  jmp __alltraps
  102151:	e9 b5 08 00 00       	jmp    102a0b <__alltraps>

00102156 <vector51>:
.globl vector51
vector51:
  pushl $0
  102156:	6a 00                	push   $0x0
  pushl $51
  102158:	6a 33                	push   $0x33
  jmp __alltraps
  10215a:	e9 ac 08 00 00       	jmp    102a0b <__alltraps>

0010215f <vector52>:
.globl vector52
vector52:
  pushl $0
  10215f:	6a 00                	push   $0x0
  pushl $52
  102161:	6a 34                	push   $0x34
  jmp __alltraps
  102163:	e9 a3 08 00 00       	jmp    102a0b <__alltraps>

00102168 <vector53>:
.globl vector53
vector53:
  pushl $0
  102168:	6a 00                	push   $0x0
  pushl $53
  10216a:	6a 35                	push   $0x35
  jmp __alltraps
  10216c:	e9 9a 08 00 00       	jmp    102a0b <__alltraps>

00102171 <vector54>:
.globl vector54
vector54:
  pushl $0
  102171:	6a 00                	push   $0x0
  pushl $54
  102173:	6a 36                	push   $0x36
  jmp __alltraps
  102175:	e9 91 08 00 00       	jmp    102a0b <__alltraps>

0010217a <vector55>:
.globl vector55
vector55:
  pushl $0
  10217a:	6a 00                	push   $0x0
  pushl $55
  10217c:	6a 37                	push   $0x37
  jmp __alltraps
  10217e:	e9 88 08 00 00       	jmp    102a0b <__alltraps>

00102183 <vector56>:
.globl vector56
vector56:
  pushl $0
  102183:	6a 00                	push   $0x0
  pushl $56
  102185:	6a 38                	push   $0x38
  jmp __alltraps
  102187:	e9 7f 08 00 00       	jmp    102a0b <__alltraps>

0010218c <vector57>:
.globl vector57
vector57:
  pushl $0
  10218c:	6a 00                	push   $0x0
  pushl $57
  10218e:	6a 39                	push   $0x39
  jmp __alltraps
  102190:	e9 76 08 00 00       	jmp    102a0b <__alltraps>

00102195 <vector58>:
.globl vector58
vector58:
  pushl $0
  102195:	6a 00                	push   $0x0
  pushl $58
  102197:	6a 3a                	push   $0x3a
  jmp __alltraps
  102199:	e9 6d 08 00 00       	jmp    102a0b <__alltraps>

0010219e <vector59>:
.globl vector59
vector59:
  pushl $0
  10219e:	6a 00                	push   $0x0
  pushl $59
  1021a0:	6a 3b                	push   $0x3b
  jmp __alltraps
  1021a2:	e9 64 08 00 00       	jmp    102a0b <__alltraps>

001021a7 <vector60>:
.globl vector60
vector60:
  pushl $0
  1021a7:	6a 00                	push   $0x0
  pushl $60
  1021a9:	6a 3c                	push   $0x3c
  jmp __alltraps
  1021ab:	e9 5b 08 00 00       	jmp    102a0b <__alltraps>

001021b0 <vector61>:
.globl vector61
vector61:
  pushl $0
  1021b0:	6a 00                	push   $0x0
  pushl $61
  1021b2:	6a 3d                	push   $0x3d
  jmp __alltraps
  1021b4:	e9 52 08 00 00       	jmp    102a0b <__alltraps>

001021b9 <vector62>:
.globl vector62
vector62:
  pushl $0
  1021b9:	6a 00                	push   $0x0
  pushl $62
  1021bb:	6a 3e                	push   $0x3e
  jmp __alltraps
  1021bd:	e9 49 08 00 00       	jmp    102a0b <__alltraps>

001021c2 <vector63>:
.globl vector63
vector63:
  pushl $0
  1021c2:	6a 00                	push   $0x0
  pushl $63
  1021c4:	6a 3f                	push   $0x3f
  jmp __alltraps
  1021c6:	e9 40 08 00 00       	jmp    102a0b <__alltraps>

001021cb <vector64>:
.globl vector64
vector64:
  pushl $0
  1021cb:	6a 00                	push   $0x0
  pushl $64
  1021cd:	6a 40                	push   $0x40
  jmp __alltraps
  1021cf:	e9 37 08 00 00       	jmp    102a0b <__alltraps>

001021d4 <vector65>:
.globl vector65
vector65:
  pushl $0
  1021d4:	6a 00                	push   $0x0
  pushl $65
  1021d6:	6a 41                	push   $0x41
  jmp __alltraps
  1021d8:	e9 2e 08 00 00       	jmp    102a0b <__alltraps>

001021dd <vector66>:
.globl vector66
vector66:
  pushl $0
  1021dd:	6a 00                	push   $0x0
  pushl $66
  1021df:	6a 42                	push   $0x42
  jmp __alltraps
  1021e1:	e9 25 08 00 00       	jmp    102a0b <__alltraps>

001021e6 <vector67>:
.globl vector67
vector67:
  pushl $0
  1021e6:	6a 00                	push   $0x0
  pushl $67
  1021e8:	6a 43                	push   $0x43
  jmp __alltraps
  1021ea:	e9 1c 08 00 00       	jmp    102a0b <__alltraps>

001021ef <vector68>:
.globl vector68
vector68:
  pushl $0
  1021ef:	6a 00                	push   $0x0
  pushl $68
  1021f1:	6a 44                	push   $0x44
  jmp __alltraps
  1021f3:	e9 13 08 00 00       	jmp    102a0b <__alltraps>

001021f8 <vector69>:
.globl vector69
vector69:
  pushl $0
  1021f8:	6a 00                	push   $0x0
  pushl $69
  1021fa:	6a 45                	push   $0x45
  jmp __alltraps
  1021fc:	e9 0a 08 00 00       	jmp    102a0b <__alltraps>

00102201 <vector70>:
.globl vector70
vector70:
  pushl $0
  102201:	6a 00                	push   $0x0
  pushl $70
  102203:	6a 46                	push   $0x46
  jmp __alltraps
  102205:	e9 01 08 00 00       	jmp    102a0b <__alltraps>

0010220a <vector71>:
.globl vector71
vector71:
  pushl $0
  10220a:	6a 00                	push   $0x0
  pushl $71
  10220c:	6a 47                	push   $0x47
  jmp __alltraps
  10220e:	e9 f8 07 00 00       	jmp    102a0b <__alltraps>

00102213 <vector72>:
.globl vector72
vector72:
  pushl $0
  102213:	6a 00                	push   $0x0
  pushl $72
  102215:	6a 48                	push   $0x48
  jmp __alltraps
  102217:	e9 ef 07 00 00       	jmp    102a0b <__alltraps>

0010221c <vector73>:
.globl vector73
vector73:
  pushl $0
  10221c:	6a 00                	push   $0x0
  pushl $73
  10221e:	6a 49                	push   $0x49
  jmp __alltraps
  102220:	e9 e6 07 00 00       	jmp    102a0b <__alltraps>

00102225 <vector74>:
.globl vector74
vector74:
  pushl $0
  102225:	6a 00                	push   $0x0
  pushl $74
  102227:	6a 4a                	push   $0x4a
  jmp __alltraps
  102229:	e9 dd 07 00 00       	jmp    102a0b <__alltraps>

0010222e <vector75>:
.globl vector75
vector75:
  pushl $0
  10222e:	6a 00                	push   $0x0
  pushl $75
  102230:	6a 4b                	push   $0x4b
  jmp __alltraps
  102232:	e9 d4 07 00 00       	jmp    102a0b <__alltraps>

00102237 <vector76>:
.globl vector76
vector76:
  pushl $0
  102237:	6a 00                	push   $0x0
  pushl $76
  102239:	6a 4c                	push   $0x4c
  jmp __alltraps
  10223b:	e9 cb 07 00 00       	jmp    102a0b <__alltraps>

00102240 <vector77>:
.globl vector77
vector77:
  pushl $0
  102240:	6a 00                	push   $0x0
  pushl $77
  102242:	6a 4d                	push   $0x4d
  jmp __alltraps
  102244:	e9 c2 07 00 00       	jmp    102a0b <__alltraps>

00102249 <vector78>:
.globl vector78
vector78:
  pushl $0
  102249:	6a 00                	push   $0x0
  pushl $78
  10224b:	6a 4e                	push   $0x4e
  jmp __alltraps
  10224d:	e9 b9 07 00 00       	jmp    102a0b <__alltraps>

00102252 <vector79>:
.globl vector79
vector79:
  pushl $0
  102252:	6a 00                	push   $0x0
  pushl $79
  102254:	6a 4f                	push   $0x4f
  jmp __alltraps
  102256:	e9 b0 07 00 00       	jmp    102a0b <__alltraps>

0010225b <vector80>:
.globl vector80
vector80:
  pushl $0
  10225b:	6a 00                	push   $0x0
  pushl $80
  10225d:	6a 50                	push   $0x50
  jmp __alltraps
  10225f:	e9 a7 07 00 00       	jmp    102a0b <__alltraps>

00102264 <vector81>:
.globl vector81
vector81:
  pushl $0
  102264:	6a 00                	push   $0x0
  pushl $81
  102266:	6a 51                	push   $0x51
  jmp __alltraps
  102268:	e9 9e 07 00 00       	jmp    102a0b <__alltraps>

0010226d <vector82>:
.globl vector82
vector82:
  pushl $0
  10226d:	6a 00                	push   $0x0
  pushl $82
  10226f:	6a 52                	push   $0x52
  jmp __alltraps
  102271:	e9 95 07 00 00       	jmp    102a0b <__alltraps>

00102276 <vector83>:
.globl vector83
vector83:
  pushl $0
  102276:	6a 00                	push   $0x0
  pushl $83
  102278:	6a 53                	push   $0x53
  jmp __alltraps
  10227a:	e9 8c 07 00 00       	jmp    102a0b <__alltraps>

0010227f <vector84>:
.globl vector84
vector84:
  pushl $0
  10227f:	6a 00                	push   $0x0
  pushl $84
  102281:	6a 54                	push   $0x54
  jmp __alltraps
  102283:	e9 83 07 00 00       	jmp    102a0b <__alltraps>

00102288 <vector85>:
.globl vector85
vector85:
  pushl $0
  102288:	6a 00                	push   $0x0
  pushl $85
  10228a:	6a 55                	push   $0x55
  jmp __alltraps
  10228c:	e9 7a 07 00 00       	jmp    102a0b <__alltraps>

00102291 <vector86>:
.globl vector86
vector86:
  pushl $0
  102291:	6a 00                	push   $0x0
  pushl $86
  102293:	6a 56                	push   $0x56
  jmp __alltraps
  102295:	e9 71 07 00 00       	jmp    102a0b <__alltraps>

0010229a <vector87>:
.globl vector87
vector87:
  pushl $0
  10229a:	6a 00                	push   $0x0
  pushl $87
  10229c:	6a 57                	push   $0x57
  jmp __alltraps
  10229e:	e9 68 07 00 00       	jmp    102a0b <__alltraps>

001022a3 <vector88>:
.globl vector88
vector88:
  pushl $0
  1022a3:	6a 00                	push   $0x0
  pushl $88
  1022a5:	6a 58                	push   $0x58
  jmp __alltraps
  1022a7:	e9 5f 07 00 00       	jmp    102a0b <__alltraps>

001022ac <vector89>:
.globl vector89
vector89:
  pushl $0
  1022ac:	6a 00                	push   $0x0
  pushl $89
  1022ae:	6a 59                	push   $0x59
  jmp __alltraps
  1022b0:	e9 56 07 00 00       	jmp    102a0b <__alltraps>

001022b5 <vector90>:
.globl vector90
vector90:
  pushl $0
  1022b5:	6a 00                	push   $0x0
  pushl $90
  1022b7:	6a 5a                	push   $0x5a
  jmp __alltraps
  1022b9:	e9 4d 07 00 00       	jmp    102a0b <__alltraps>

001022be <vector91>:
.globl vector91
vector91:
  pushl $0
  1022be:	6a 00                	push   $0x0
  pushl $91
  1022c0:	6a 5b                	push   $0x5b
  jmp __alltraps
  1022c2:	e9 44 07 00 00       	jmp    102a0b <__alltraps>

001022c7 <vector92>:
.globl vector92
vector92:
  pushl $0
  1022c7:	6a 00                	push   $0x0
  pushl $92
  1022c9:	6a 5c                	push   $0x5c
  jmp __alltraps
  1022cb:	e9 3b 07 00 00       	jmp    102a0b <__alltraps>

001022d0 <vector93>:
.globl vector93
vector93:
  pushl $0
  1022d0:	6a 00                	push   $0x0
  pushl $93
  1022d2:	6a 5d                	push   $0x5d
  jmp __alltraps
  1022d4:	e9 32 07 00 00       	jmp    102a0b <__alltraps>

001022d9 <vector94>:
.globl vector94
vector94:
  pushl $0
  1022d9:	6a 00                	push   $0x0
  pushl $94
  1022db:	6a 5e                	push   $0x5e
  jmp __alltraps
  1022dd:	e9 29 07 00 00       	jmp    102a0b <__alltraps>

001022e2 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022e2:	6a 00                	push   $0x0
  pushl $95
  1022e4:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022e6:	e9 20 07 00 00       	jmp    102a0b <__alltraps>

001022eb <vector96>:
.globl vector96
vector96:
  pushl $0
  1022eb:	6a 00                	push   $0x0
  pushl $96
  1022ed:	6a 60                	push   $0x60
  jmp __alltraps
  1022ef:	e9 17 07 00 00       	jmp    102a0b <__alltraps>

001022f4 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022f4:	6a 00                	push   $0x0
  pushl $97
  1022f6:	6a 61                	push   $0x61
  jmp __alltraps
  1022f8:	e9 0e 07 00 00       	jmp    102a0b <__alltraps>

001022fd <vector98>:
.globl vector98
vector98:
  pushl $0
  1022fd:	6a 00                	push   $0x0
  pushl $98
  1022ff:	6a 62                	push   $0x62
  jmp __alltraps
  102301:	e9 05 07 00 00       	jmp    102a0b <__alltraps>

00102306 <vector99>:
.globl vector99
vector99:
  pushl $0
  102306:	6a 00                	push   $0x0
  pushl $99
  102308:	6a 63                	push   $0x63
  jmp __alltraps
  10230a:	e9 fc 06 00 00       	jmp    102a0b <__alltraps>

0010230f <vector100>:
.globl vector100
vector100:
  pushl $0
  10230f:	6a 00                	push   $0x0
  pushl $100
  102311:	6a 64                	push   $0x64
  jmp __alltraps
  102313:	e9 f3 06 00 00       	jmp    102a0b <__alltraps>

00102318 <vector101>:
.globl vector101
vector101:
  pushl $0
  102318:	6a 00                	push   $0x0
  pushl $101
  10231a:	6a 65                	push   $0x65
  jmp __alltraps
  10231c:	e9 ea 06 00 00       	jmp    102a0b <__alltraps>

00102321 <vector102>:
.globl vector102
vector102:
  pushl $0
  102321:	6a 00                	push   $0x0
  pushl $102
  102323:	6a 66                	push   $0x66
  jmp __alltraps
  102325:	e9 e1 06 00 00       	jmp    102a0b <__alltraps>

0010232a <vector103>:
.globl vector103
vector103:
  pushl $0
  10232a:	6a 00                	push   $0x0
  pushl $103
  10232c:	6a 67                	push   $0x67
  jmp __alltraps
  10232e:	e9 d8 06 00 00       	jmp    102a0b <__alltraps>

00102333 <vector104>:
.globl vector104
vector104:
  pushl $0
  102333:	6a 00                	push   $0x0
  pushl $104
  102335:	6a 68                	push   $0x68
  jmp __alltraps
  102337:	e9 cf 06 00 00       	jmp    102a0b <__alltraps>

0010233c <vector105>:
.globl vector105
vector105:
  pushl $0
  10233c:	6a 00                	push   $0x0
  pushl $105
  10233e:	6a 69                	push   $0x69
  jmp __alltraps
  102340:	e9 c6 06 00 00       	jmp    102a0b <__alltraps>

00102345 <vector106>:
.globl vector106
vector106:
  pushl $0
  102345:	6a 00                	push   $0x0
  pushl $106
  102347:	6a 6a                	push   $0x6a
  jmp __alltraps
  102349:	e9 bd 06 00 00       	jmp    102a0b <__alltraps>

0010234e <vector107>:
.globl vector107
vector107:
  pushl $0
  10234e:	6a 00                	push   $0x0
  pushl $107
  102350:	6a 6b                	push   $0x6b
  jmp __alltraps
  102352:	e9 b4 06 00 00       	jmp    102a0b <__alltraps>

00102357 <vector108>:
.globl vector108
vector108:
  pushl $0
  102357:	6a 00                	push   $0x0
  pushl $108
  102359:	6a 6c                	push   $0x6c
  jmp __alltraps
  10235b:	e9 ab 06 00 00       	jmp    102a0b <__alltraps>

00102360 <vector109>:
.globl vector109
vector109:
  pushl $0
  102360:	6a 00                	push   $0x0
  pushl $109
  102362:	6a 6d                	push   $0x6d
  jmp __alltraps
  102364:	e9 a2 06 00 00       	jmp    102a0b <__alltraps>

00102369 <vector110>:
.globl vector110
vector110:
  pushl $0
  102369:	6a 00                	push   $0x0
  pushl $110
  10236b:	6a 6e                	push   $0x6e
  jmp __alltraps
  10236d:	e9 99 06 00 00       	jmp    102a0b <__alltraps>

00102372 <vector111>:
.globl vector111
vector111:
  pushl $0
  102372:	6a 00                	push   $0x0
  pushl $111
  102374:	6a 6f                	push   $0x6f
  jmp __alltraps
  102376:	e9 90 06 00 00       	jmp    102a0b <__alltraps>

0010237b <vector112>:
.globl vector112
vector112:
  pushl $0
  10237b:	6a 00                	push   $0x0
  pushl $112
  10237d:	6a 70                	push   $0x70
  jmp __alltraps
  10237f:	e9 87 06 00 00       	jmp    102a0b <__alltraps>

00102384 <vector113>:
.globl vector113
vector113:
  pushl $0
  102384:	6a 00                	push   $0x0
  pushl $113
  102386:	6a 71                	push   $0x71
  jmp __alltraps
  102388:	e9 7e 06 00 00       	jmp    102a0b <__alltraps>

0010238d <vector114>:
.globl vector114
vector114:
  pushl $0
  10238d:	6a 00                	push   $0x0
  pushl $114
  10238f:	6a 72                	push   $0x72
  jmp __alltraps
  102391:	e9 75 06 00 00       	jmp    102a0b <__alltraps>

00102396 <vector115>:
.globl vector115
vector115:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $115
  102398:	6a 73                	push   $0x73
  jmp __alltraps
  10239a:	e9 6c 06 00 00       	jmp    102a0b <__alltraps>

0010239f <vector116>:
.globl vector116
vector116:
  pushl $0
  10239f:	6a 00                	push   $0x0
  pushl $116
  1023a1:	6a 74                	push   $0x74
  jmp __alltraps
  1023a3:	e9 63 06 00 00       	jmp    102a0b <__alltraps>

001023a8 <vector117>:
.globl vector117
vector117:
  pushl $0
  1023a8:	6a 00                	push   $0x0
  pushl $117
  1023aa:	6a 75                	push   $0x75
  jmp __alltraps
  1023ac:	e9 5a 06 00 00       	jmp    102a0b <__alltraps>

001023b1 <vector118>:
.globl vector118
vector118:
  pushl $0
  1023b1:	6a 00                	push   $0x0
  pushl $118
  1023b3:	6a 76                	push   $0x76
  jmp __alltraps
  1023b5:	e9 51 06 00 00       	jmp    102a0b <__alltraps>

001023ba <vector119>:
.globl vector119
vector119:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $119
  1023bc:	6a 77                	push   $0x77
  jmp __alltraps
  1023be:	e9 48 06 00 00       	jmp    102a0b <__alltraps>

001023c3 <vector120>:
.globl vector120
vector120:
  pushl $0
  1023c3:	6a 00                	push   $0x0
  pushl $120
  1023c5:	6a 78                	push   $0x78
  jmp __alltraps
  1023c7:	e9 3f 06 00 00       	jmp    102a0b <__alltraps>

001023cc <vector121>:
.globl vector121
vector121:
  pushl $0
  1023cc:	6a 00                	push   $0x0
  pushl $121
  1023ce:	6a 79                	push   $0x79
  jmp __alltraps
  1023d0:	e9 36 06 00 00       	jmp    102a0b <__alltraps>

001023d5 <vector122>:
.globl vector122
vector122:
  pushl $0
  1023d5:	6a 00                	push   $0x0
  pushl $122
  1023d7:	6a 7a                	push   $0x7a
  jmp __alltraps
  1023d9:	e9 2d 06 00 00       	jmp    102a0b <__alltraps>

001023de <vector123>:
.globl vector123
vector123:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $123
  1023e0:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023e2:	e9 24 06 00 00       	jmp    102a0b <__alltraps>

001023e7 <vector124>:
.globl vector124
vector124:
  pushl $0
  1023e7:	6a 00                	push   $0x0
  pushl $124
  1023e9:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023eb:	e9 1b 06 00 00       	jmp    102a0b <__alltraps>

001023f0 <vector125>:
.globl vector125
vector125:
  pushl $0
  1023f0:	6a 00                	push   $0x0
  pushl $125
  1023f2:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023f4:	e9 12 06 00 00       	jmp    102a0b <__alltraps>

001023f9 <vector126>:
.globl vector126
vector126:
  pushl $0
  1023f9:	6a 00                	push   $0x0
  pushl $126
  1023fb:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023fd:	e9 09 06 00 00       	jmp    102a0b <__alltraps>

00102402 <vector127>:
.globl vector127
vector127:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $127
  102404:	6a 7f                	push   $0x7f
  jmp __alltraps
  102406:	e9 00 06 00 00       	jmp    102a0b <__alltraps>

0010240b <vector128>:
.globl vector128
vector128:
  pushl $0
  10240b:	6a 00                	push   $0x0
  pushl $128
  10240d:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102412:	e9 f4 05 00 00       	jmp    102a0b <__alltraps>

00102417 <vector129>:
.globl vector129
vector129:
  pushl $0
  102417:	6a 00                	push   $0x0
  pushl $129
  102419:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10241e:	e9 e8 05 00 00       	jmp    102a0b <__alltraps>

00102423 <vector130>:
.globl vector130
vector130:
  pushl $0
  102423:	6a 00                	push   $0x0
  pushl $130
  102425:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10242a:	e9 dc 05 00 00       	jmp    102a0b <__alltraps>

0010242f <vector131>:
.globl vector131
vector131:
  pushl $0
  10242f:	6a 00                	push   $0x0
  pushl $131
  102431:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102436:	e9 d0 05 00 00       	jmp    102a0b <__alltraps>

0010243b <vector132>:
.globl vector132
vector132:
  pushl $0
  10243b:	6a 00                	push   $0x0
  pushl $132
  10243d:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102442:	e9 c4 05 00 00       	jmp    102a0b <__alltraps>

00102447 <vector133>:
.globl vector133
vector133:
  pushl $0
  102447:	6a 00                	push   $0x0
  pushl $133
  102449:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10244e:	e9 b8 05 00 00       	jmp    102a0b <__alltraps>

00102453 <vector134>:
.globl vector134
vector134:
  pushl $0
  102453:	6a 00                	push   $0x0
  pushl $134
  102455:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10245a:	e9 ac 05 00 00       	jmp    102a0b <__alltraps>

0010245f <vector135>:
.globl vector135
vector135:
  pushl $0
  10245f:	6a 00                	push   $0x0
  pushl $135
  102461:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102466:	e9 a0 05 00 00       	jmp    102a0b <__alltraps>

0010246b <vector136>:
.globl vector136
vector136:
  pushl $0
  10246b:	6a 00                	push   $0x0
  pushl $136
  10246d:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102472:	e9 94 05 00 00       	jmp    102a0b <__alltraps>

00102477 <vector137>:
.globl vector137
vector137:
  pushl $0
  102477:	6a 00                	push   $0x0
  pushl $137
  102479:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10247e:	e9 88 05 00 00       	jmp    102a0b <__alltraps>

00102483 <vector138>:
.globl vector138
vector138:
  pushl $0
  102483:	6a 00                	push   $0x0
  pushl $138
  102485:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10248a:	e9 7c 05 00 00       	jmp    102a0b <__alltraps>

0010248f <vector139>:
.globl vector139
vector139:
  pushl $0
  10248f:	6a 00                	push   $0x0
  pushl $139
  102491:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102496:	e9 70 05 00 00       	jmp    102a0b <__alltraps>

0010249b <vector140>:
.globl vector140
vector140:
  pushl $0
  10249b:	6a 00                	push   $0x0
  pushl $140
  10249d:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1024a2:	e9 64 05 00 00       	jmp    102a0b <__alltraps>

001024a7 <vector141>:
.globl vector141
vector141:
  pushl $0
  1024a7:	6a 00                	push   $0x0
  pushl $141
  1024a9:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1024ae:	e9 58 05 00 00       	jmp    102a0b <__alltraps>

001024b3 <vector142>:
.globl vector142
vector142:
  pushl $0
  1024b3:	6a 00                	push   $0x0
  pushl $142
  1024b5:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1024ba:	e9 4c 05 00 00       	jmp    102a0b <__alltraps>

001024bf <vector143>:
.globl vector143
vector143:
  pushl $0
  1024bf:	6a 00                	push   $0x0
  pushl $143
  1024c1:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1024c6:	e9 40 05 00 00       	jmp    102a0b <__alltraps>

001024cb <vector144>:
.globl vector144
vector144:
  pushl $0
  1024cb:	6a 00                	push   $0x0
  pushl $144
  1024cd:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1024d2:	e9 34 05 00 00       	jmp    102a0b <__alltraps>

001024d7 <vector145>:
.globl vector145
vector145:
  pushl $0
  1024d7:	6a 00                	push   $0x0
  pushl $145
  1024d9:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1024de:	e9 28 05 00 00       	jmp    102a0b <__alltraps>

001024e3 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024e3:	6a 00                	push   $0x0
  pushl $146
  1024e5:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024ea:	e9 1c 05 00 00       	jmp    102a0b <__alltraps>

001024ef <vector147>:
.globl vector147
vector147:
  pushl $0
  1024ef:	6a 00                	push   $0x0
  pushl $147
  1024f1:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024f6:	e9 10 05 00 00       	jmp    102a0b <__alltraps>

001024fb <vector148>:
.globl vector148
vector148:
  pushl $0
  1024fb:	6a 00                	push   $0x0
  pushl $148
  1024fd:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102502:	e9 04 05 00 00       	jmp    102a0b <__alltraps>

00102507 <vector149>:
.globl vector149
vector149:
  pushl $0
  102507:	6a 00                	push   $0x0
  pushl $149
  102509:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10250e:	e9 f8 04 00 00       	jmp    102a0b <__alltraps>

00102513 <vector150>:
.globl vector150
vector150:
  pushl $0
  102513:	6a 00                	push   $0x0
  pushl $150
  102515:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10251a:	e9 ec 04 00 00       	jmp    102a0b <__alltraps>

0010251f <vector151>:
.globl vector151
vector151:
  pushl $0
  10251f:	6a 00                	push   $0x0
  pushl $151
  102521:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102526:	e9 e0 04 00 00       	jmp    102a0b <__alltraps>

0010252b <vector152>:
.globl vector152
vector152:
  pushl $0
  10252b:	6a 00                	push   $0x0
  pushl $152
  10252d:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102532:	e9 d4 04 00 00       	jmp    102a0b <__alltraps>

00102537 <vector153>:
.globl vector153
vector153:
  pushl $0
  102537:	6a 00                	push   $0x0
  pushl $153
  102539:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10253e:	e9 c8 04 00 00       	jmp    102a0b <__alltraps>

00102543 <vector154>:
.globl vector154
vector154:
  pushl $0
  102543:	6a 00                	push   $0x0
  pushl $154
  102545:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10254a:	e9 bc 04 00 00       	jmp    102a0b <__alltraps>

0010254f <vector155>:
.globl vector155
vector155:
  pushl $0
  10254f:	6a 00                	push   $0x0
  pushl $155
  102551:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102556:	e9 b0 04 00 00       	jmp    102a0b <__alltraps>

0010255b <vector156>:
.globl vector156
vector156:
  pushl $0
  10255b:	6a 00                	push   $0x0
  pushl $156
  10255d:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102562:	e9 a4 04 00 00       	jmp    102a0b <__alltraps>

00102567 <vector157>:
.globl vector157
vector157:
  pushl $0
  102567:	6a 00                	push   $0x0
  pushl $157
  102569:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10256e:	e9 98 04 00 00       	jmp    102a0b <__alltraps>

00102573 <vector158>:
.globl vector158
vector158:
  pushl $0
  102573:	6a 00                	push   $0x0
  pushl $158
  102575:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10257a:	e9 8c 04 00 00       	jmp    102a0b <__alltraps>

0010257f <vector159>:
.globl vector159
vector159:
  pushl $0
  10257f:	6a 00                	push   $0x0
  pushl $159
  102581:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102586:	e9 80 04 00 00       	jmp    102a0b <__alltraps>

0010258b <vector160>:
.globl vector160
vector160:
  pushl $0
  10258b:	6a 00                	push   $0x0
  pushl $160
  10258d:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102592:	e9 74 04 00 00       	jmp    102a0b <__alltraps>

00102597 <vector161>:
.globl vector161
vector161:
  pushl $0
  102597:	6a 00                	push   $0x0
  pushl $161
  102599:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10259e:	e9 68 04 00 00       	jmp    102a0b <__alltraps>

001025a3 <vector162>:
.globl vector162
vector162:
  pushl $0
  1025a3:	6a 00                	push   $0x0
  pushl $162
  1025a5:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1025aa:	e9 5c 04 00 00       	jmp    102a0b <__alltraps>

001025af <vector163>:
.globl vector163
vector163:
  pushl $0
  1025af:	6a 00                	push   $0x0
  pushl $163
  1025b1:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1025b6:	e9 50 04 00 00       	jmp    102a0b <__alltraps>

001025bb <vector164>:
.globl vector164
vector164:
  pushl $0
  1025bb:	6a 00                	push   $0x0
  pushl $164
  1025bd:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1025c2:	e9 44 04 00 00       	jmp    102a0b <__alltraps>

001025c7 <vector165>:
.globl vector165
vector165:
  pushl $0
  1025c7:	6a 00                	push   $0x0
  pushl $165
  1025c9:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1025ce:	e9 38 04 00 00       	jmp    102a0b <__alltraps>

001025d3 <vector166>:
.globl vector166
vector166:
  pushl $0
  1025d3:	6a 00                	push   $0x0
  pushl $166
  1025d5:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1025da:	e9 2c 04 00 00       	jmp    102a0b <__alltraps>

001025df <vector167>:
.globl vector167
vector167:
  pushl $0
  1025df:	6a 00                	push   $0x0
  pushl $167
  1025e1:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025e6:	e9 20 04 00 00       	jmp    102a0b <__alltraps>

001025eb <vector168>:
.globl vector168
vector168:
  pushl $0
  1025eb:	6a 00                	push   $0x0
  pushl $168
  1025ed:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025f2:	e9 14 04 00 00       	jmp    102a0b <__alltraps>

001025f7 <vector169>:
.globl vector169
vector169:
  pushl $0
  1025f7:	6a 00                	push   $0x0
  pushl $169
  1025f9:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025fe:	e9 08 04 00 00       	jmp    102a0b <__alltraps>

00102603 <vector170>:
.globl vector170
vector170:
  pushl $0
  102603:	6a 00                	push   $0x0
  pushl $170
  102605:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10260a:	e9 fc 03 00 00       	jmp    102a0b <__alltraps>

0010260f <vector171>:
.globl vector171
vector171:
  pushl $0
  10260f:	6a 00                	push   $0x0
  pushl $171
  102611:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102616:	e9 f0 03 00 00       	jmp    102a0b <__alltraps>

0010261b <vector172>:
.globl vector172
vector172:
  pushl $0
  10261b:	6a 00                	push   $0x0
  pushl $172
  10261d:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102622:	e9 e4 03 00 00       	jmp    102a0b <__alltraps>

00102627 <vector173>:
.globl vector173
vector173:
  pushl $0
  102627:	6a 00                	push   $0x0
  pushl $173
  102629:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10262e:	e9 d8 03 00 00       	jmp    102a0b <__alltraps>

00102633 <vector174>:
.globl vector174
vector174:
  pushl $0
  102633:	6a 00                	push   $0x0
  pushl $174
  102635:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10263a:	e9 cc 03 00 00       	jmp    102a0b <__alltraps>

0010263f <vector175>:
.globl vector175
vector175:
  pushl $0
  10263f:	6a 00                	push   $0x0
  pushl $175
  102641:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102646:	e9 c0 03 00 00       	jmp    102a0b <__alltraps>

0010264b <vector176>:
.globl vector176
vector176:
  pushl $0
  10264b:	6a 00                	push   $0x0
  pushl $176
  10264d:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102652:	e9 b4 03 00 00       	jmp    102a0b <__alltraps>

00102657 <vector177>:
.globl vector177
vector177:
  pushl $0
  102657:	6a 00                	push   $0x0
  pushl $177
  102659:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10265e:	e9 a8 03 00 00       	jmp    102a0b <__alltraps>

00102663 <vector178>:
.globl vector178
vector178:
  pushl $0
  102663:	6a 00                	push   $0x0
  pushl $178
  102665:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10266a:	e9 9c 03 00 00       	jmp    102a0b <__alltraps>

0010266f <vector179>:
.globl vector179
vector179:
  pushl $0
  10266f:	6a 00                	push   $0x0
  pushl $179
  102671:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102676:	e9 90 03 00 00       	jmp    102a0b <__alltraps>

0010267b <vector180>:
.globl vector180
vector180:
  pushl $0
  10267b:	6a 00                	push   $0x0
  pushl $180
  10267d:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102682:	e9 84 03 00 00       	jmp    102a0b <__alltraps>

00102687 <vector181>:
.globl vector181
vector181:
  pushl $0
  102687:	6a 00                	push   $0x0
  pushl $181
  102689:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10268e:	e9 78 03 00 00       	jmp    102a0b <__alltraps>

00102693 <vector182>:
.globl vector182
vector182:
  pushl $0
  102693:	6a 00                	push   $0x0
  pushl $182
  102695:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10269a:	e9 6c 03 00 00       	jmp    102a0b <__alltraps>

0010269f <vector183>:
.globl vector183
vector183:
  pushl $0
  10269f:	6a 00                	push   $0x0
  pushl $183
  1026a1:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1026a6:	e9 60 03 00 00       	jmp    102a0b <__alltraps>

001026ab <vector184>:
.globl vector184
vector184:
  pushl $0
  1026ab:	6a 00                	push   $0x0
  pushl $184
  1026ad:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1026b2:	e9 54 03 00 00       	jmp    102a0b <__alltraps>

001026b7 <vector185>:
.globl vector185
vector185:
  pushl $0
  1026b7:	6a 00                	push   $0x0
  pushl $185
  1026b9:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1026be:	e9 48 03 00 00       	jmp    102a0b <__alltraps>

001026c3 <vector186>:
.globl vector186
vector186:
  pushl $0
  1026c3:	6a 00                	push   $0x0
  pushl $186
  1026c5:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1026ca:	e9 3c 03 00 00       	jmp    102a0b <__alltraps>

001026cf <vector187>:
.globl vector187
vector187:
  pushl $0
  1026cf:	6a 00                	push   $0x0
  pushl $187
  1026d1:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1026d6:	e9 30 03 00 00       	jmp    102a0b <__alltraps>

001026db <vector188>:
.globl vector188
vector188:
  pushl $0
  1026db:	6a 00                	push   $0x0
  pushl $188
  1026dd:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026e2:	e9 24 03 00 00       	jmp    102a0b <__alltraps>

001026e7 <vector189>:
.globl vector189
vector189:
  pushl $0
  1026e7:	6a 00                	push   $0x0
  pushl $189
  1026e9:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026ee:	e9 18 03 00 00       	jmp    102a0b <__alltraps>

001026f3 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026f3:	6a 00                	push   $0x0
  pushl $190
  1026f5:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026fa:	e9 0c 03 00 00       	jmp    102a0b <__alltraps>

001026ff <vector191>:
.globl vector191
vector191:
  pushl $0
  1026ff:	6a 00                	push   $0x0
  pushl $191
  102701:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102706:	e9 00 03 00 00       	jmp    102a0b <__alltraps>

0010270b <vector192>:
.globl vector192
vector192:
  pushl $0
  10270b:	6a 00                	push   $0x0
  pushl $192
  10270d:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102712:	e9 f4 02 00 00       	jmp    102a0b <__alltraps>

00102717 <vector193>:
.globl vector193
vector193:
  pushl $0
  102717:	6a 00                	push   $0x0
  pushl $193
  102719:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10271e:	e9 e8 02 00 00       	jmp    102a0b <__alltraps>

00102723 <vector194>:
.globl vector194
vector194:
  pushl $0
  102723:	6a 00                	push   $0x0
  pushl $194
  102725:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10272a:	e9 dc 02 00 00       	jmp    102a0b <__alltraps>

0010272f <vector195>:
.globl vector195
vector195:
  pushl $0
  10272f:	6a 00                	push   $0x0
  pushl $195
  102731:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102736:	e9 d0 02 00 00       	jmp    102a0b <__alltraps>

0010273b <vector196>:
.globl vector196
vector196:
  pushl $0
  10273b:	6a 00                	push   $0x0
  pushl $196
  10273d:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102742:	e9 c4 02 00 00       	jmp    102a0b <__alltraps>

00102747 <vector197>:
.globl vector197
vector197:
  pushl $0
  102747:	6a 00                	push   $0x0
  pushl $197
  102749:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10274e:	e9 b8 02 00 00       	jmp    102a0b <__alltraps>

00102753 <vector198>:
.globl vector198
vector198:
  pushl $0
  102753:	6a 00                	push   $0x0
  pushl $198
  102755:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10275a:	e9 ac 02 00 00       	jmp    102a0b <__alltraps>

0010275f <vector199>:
.globl vector199
vector199:
  pushl $0
  10275f:	6a 00                	push   $0x0
  pushl $199
  102761:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102766:	e9 a0 02 00 00       	jmp    102a0b <__alltraps>

0010276b <vector200>:
.globl vector200
vector200:
  pushl $0
  10276b:	6a 00                	push   $0x0
  pushl $200
  10276d:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102772:	e9 94 02 00 00       	jmp    102a0b <__alltraps>

00102777 <vector201>:
.globl vector201
vector201:
  pushl $0
  102777:	6a 00                	push   $0x0
  pushl $201
  102779:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10277e:	e9 88 02 00 00       	jmp    102a0b <__alltraps>

00102783 <vector202>:
.globl vector202
vector202:
  pushl $0
  102783:	6a 00                	push   $0x0
  pushl $202
  102785:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10278a:	e9 7c 02 00 00       	jmp    102a0b <__alltraps>

0010278f <vector203>:
.globl vector203
vector203:
  pushl $0
  10278f:	6a 00                	push   $0x0
  pushl $203
  102791:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102796:	e9 70 02 00 00       	jmp    102a0b <__alltraps>

0010279b <vector204>:
.globl vector204
vector204:
  pushl $0
  10279b:	6a 00                	push   $0x0
  pushl $204
  10279d:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1027a2:	e9 64 02 00 00       	jmp    102a0b <__alltraps>

001027a7 <vector205>:
.globl vector205
vector205:
  pushl $0
  1027a7:	6a 00                	push   $0x0
  pushl $205
  1027a9:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1027ae:	e9 58 02 00 00       	jmp    102a0b <__alltraps>

001027b3 <vector206>:
.globl vector206
vector206:
  pushl $0
  1027b3:	6a 00                	push   $0x0
  pushl $206
  1027b5:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1027ba:	e9 4c 02 00 00       	jmp    102a0b <__alltraps>

001027bf <vector207>:
.globl vector207
vector207:
  pushl $0
  1027bf:	6a 00                	push   $0x0
  pushl $207
  1027c1:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1027c6:	e9 40 02 00 00       	jmp    102a0b <__alltraps>

001027cb <vector208>:
.globl vector208
vector208:
  pushl $0
  1027cb:	6a 00                	push   $0x0
  pushl $208
  1027cd:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1027d2:	e9 34 02 00 00       	jmp    102a0b <__alltraps>

001027d7 <vector209>:
.globl vector209
vector209:
  pushl $0
  1027d7:	6a 00                	push   $0x0
  pushl $209
  1027d9:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1027de:	e9 28 02 00 00       	jmp    102a0b <__alltraps>

001027e3 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027e3:	6a 00                	push   $0x0
  pushl $210
  1027e5:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027ea:	e9 1c 02 00 00       	jmp    102a0b <__alltraps>

001027ef <vector211>:
.globl vector211
vector211:
  pushl $0
  1027ef:	6a 00                	push   $0x0
  pushl $211
  1027f1:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027f6:	e9 10 02 00 00       	jmp    102a0b <__alltraps>

001027fb <vector212>:
.globl vector212
vector212:
  pushl $0
  1027fb:	6a 00                	push   $0x0
  pushl $212
  1027fd:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102802:	e9 04 02 00 00       	jmp    102a0b <__alltraps>

00102807 <vector213>:
.globl vector213
vector213:
  pushl $0
  102807:	6a 00                	push   $0x0
  pushl $213
  102809:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  10280e:	e9 f8 01 00 00       	jmp    102a0b <__alltraps>

00102813 <vector214>:
.globl vector214
vector214:
  pushl $0
  102813:	6a 00                	push   $0x0
  pushl $214
  102815:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10281a:	e9 ec 01 00 00       	jmp    102a0b <__alltraps>

0010281f <vector215>:
.globl vector215
vector215:
  pushl $0
  10281f:	6a 00                	push   $0x0
  pushl $215
  102821:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102826:	e9 e0 01 00 00       	jmp    102a0b <__alltraps>

0010282b <vector216>:
.globl vector216
vector216:
  pushl $0
  10282b:	6a 00                	push   $0x0
  pushl $216
  10282d:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102832:	e9 d4 01 00 00       	jmp    102a0b <__alltraps>

00102837 <vector217>:
.globl vector217
vector217:
  pushl $0
  102837:	6a 00                	push   $0x0
  pushl $217
  102839:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10283e:	e9 c8 01 00 00       	jmp    102a0b <__alltraps>

00102843 <vector218>:
.globl vector218
vector218:
  pushl $0
  102843:	6a 00                	push   $0x0
  pushl $218
  102845:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10284a:	e9 bc 01 00 00       	jmp    102a0b <__alltraps>

0010284f <vector219>:
.globl vector219
vector219:
  pushl $0
  10284f:	6a 00                	push   $0x0
  pushl $219
  102851:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102856:	e9 b0 01 00 00       	jmp    102a0b <__alltraps>

0010285b <vector220>:
.globl vector220
vector220:
  pushl $0
  10285b:	6a 00                	push   $0x0
  pushl $220
  10285d:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102862:	e9 a4 01 00 00       	jmp    102a0b <__alltraps>

00102867 <vector221>:
.globl vector221
vector221:
  pushl $0
  102867:	6a 00                	push   $0x0
  pushl $221
  102869:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10286e:	e9 98 01 00 00       	jmp    102a0b <__alltraps>

00102873 <vector222>:
.globl vector222
vector222:
  pushl $0
  102873:	6a 00                	push   $0x0
  pushl $222
  102875:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10287a:	e9 8c 01 00 00       	jmp    102a0b <__alltraps>

0010287f <vector223>:
.globl vector223
vector223:
  pushl $0
  10287f:	6a 00                	push   $0x0
  pushl $223
  102881:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102886:	e9 80 01 00 00       	jmp    102a0b <__alltraps>

0010288b <vector224>:
.globl vector224
vector224:
  pushl $0
  10288b:	6a 00                	push   $0x0
  pushl $224
  10288d:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102892:	e9 74 01 00 00       	jmp    102a0b <__alltraps>

00102897 <vector225>:
.globl vector225
vector225:
  pushl $0
  102897:	6a 00                	push   $0x0
  pushl $225
  102899:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10289e:	e9 68 01 00 00       	jmp    102a0b <__alltraps>

001028a3 <vector226>:
.globl vector226
vector226:
  pushl $0
  1028a3:	6a 00                	push   $0x0
  pushl $226
  1028a5:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1028aa:	e9 5c 01 00 00       	jmp    102a0b <__alltraps>

001028af <vector227>:
.globl vector227
vector227:
  pushl $0
  1028af:	6a 00                	push   $0x0
  pushl $227
  1028b1:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1028b6:	e9 50 01 00 00       	jmp    102a0b <__alltraps>

001028bb <vector228>:
.globl vector228
vector228:
  pushl $0
  1028bb:	6a 00                	push   $0x0
  pushl $228
  1028bd:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1028c2:	e9 44 01 00 00       	jmp    102a0b <__alltraps>

001028c7 <vector229>:
.globl vector229
vector229:
  pushl $0
  1028c7:	6a 00                	push   $0x0
  pushl $229
  1028c9:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1028ce:	e9 38 01 00 00       	jmp    102a0b <__alltraps>

001028d3 <vector230>:
.globl vector230
vector230:
  pushl $0
  1028d3:	6a 00                	push   $0x0
  pushl $230
  1028d5:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1028da:	e9 2c 01 00 00       	jmp    102a0b <__alltraps>

001028df <vector231>:
.globl vector231
vector231:
  pushl $0
  1028df:	6a 00                	push   $0x0
  pushl $231
  1028e1:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028e6:	e9 20 01 00 00       	jmp    102a0b <__alltraps>

001028eb <vector232>:
.globl vector232
vector232:
  pushl $0
  1028eb:	6a 00                	push   $0x0
  pushl $232
  1028ed:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028f2:	e9 14 01 00 00       	jmp    102a0b <__alltraps>

001028f7 <vector233>:
.globl vector233
vector233:
  pushl $0
  1028f7:	6a 00                	push   $0x0
  pushl $233
  1028f9:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028fe:	e9 08 01 00 00       	jmp    102a0b <__alltraps>

00102903 <vector234>:
.globl vector234
vector234:
  pushl $0
  102903:	6a 00                	push   $0x0
  pushl $234
  102905:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10290a:	e9 fc 00 00 00       	jmp    102a0b <__alltraps>

0010290f <vector235>:
.globl vector235
vector235:
  pushl $0
  10290f:	6a 00                	push   $0x0
  pushl $235
  102911:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102916:	e9 f0 00 00 00       	jmp    102a0b <__alltraps>

0010291b <vector236>:
.globl vector236
vector236:
  pushl $0
  10291b:	6a 00                	push   $0x0
  pushl $236
  10291d:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102922:	e9 e4 00 00 00       	jmp    102a0b <__alltraps>

00102927 <vector237>:
.globl vector237
vector237:
  pushl $0
  102927:	6a 00                	push   $0x0
  pushl $237
  102929:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  10292e:	e9 d8 00 00 00       	jmp    102a0b <__alltraps>

00102933 <vector238>:
.globl vector238
vector238:
  pushl $0
  102933:	6a 00                	push   $0x0
  pushl $238
  102935:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10293a:	e9 cc 00 00 00       	jmp    102a0b <__alltraps>

0010293f <vector239>:
.globl vector239
vector239:
  pushl $0
  10293f:	6a 00                	push   $0x0
  pushl $239
  102941:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102946:	e9 c0 00 00 00       	jmp    102a0b <__alltraps>

0010294b <vector240>:
.globl vector240
vector240:
  pushl $0
  10294b:	6a 00                	push   $0x0
  pushl $240
  10294d:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102952:	e9 b4 00 00 00       	jmp    102a0b <__alltraps>

00102957 <vector241>:
.globl vector241
vector241:
  pushl $0
  102957:	6a 00                	push   $0x0
  pushl $241
  102959:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10295e:	e9 a8 00 00 00       	jmp    102a0b <__alltraps>

00102963 <vector242>:
.globl vector242
vector242:
  pushl $0
  102963:	6a 00                	push   $0x0
  pushl $242
  102965:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10296a:	e9 9c 00 00 00       	jmp    102a0b <__alltraps>

0010296f <vector243>:
.globl vector243
vector243:
  pushl $0
  10296f:	6a 00                	push   $0x0
  pushl $243
  102971:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102976:	e9 90 00 00 00       	jmp    102a0b <__alltraps>

0010297b <vector244>:
.globl vector244
vector244:
  pushl $0
  10297b:	6a 00                	push   $0x0
  pushl $244
  10297d:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102982:	e9 84 00 00 00       	jmp    102a0b <__alltraps>

00102987 <vector245>:
.globl vector245
vector245:
  pushl $0
  102987:	6a 00                	push   $0x0
  pushl $245
  102989:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10298e:	e9 78 00 00 00       	jmp    102a0b <__alltraps>

00102993 <vector246>:
.globl vector246
vector246:
  pushl $0
  102993:	6a 00                	push   $0x0
  pushl $246
  102995:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10299a:	e9 6c 00 00 00       	jmp    102a0b <__alltraps>

0010299f <vector247>:
.globl vector247
vector247:
  pushl $0
  10299f:	6a 00                	push   $0x0
  pushl $247
  1029a1:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1029a6:	e9 60 00 00 00       	jmp    102a0b <__alltraps>

001029ab <vector248>:
.globl vector248
vector248:
  pushl $0
  1029ab:	6a 00                	push   $0x0
  pushl $248
  1029ad:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1029b2:	e9 54 00 00 00       	jmp    102a0b <__alltraps>

001029b7 <vector249>:
.globl vector249
vector249:
  pushl $0
  1029b7:	6a 00                	push   $0x0
  pushl $249
  1029b9:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1029be:	e9 48 00 00 00       	jmp    102a0b <__alltraps>

001029c3 <vector250>:
.globl vector250
vector250:
  pushl $0
  1029c3:	6a 00                	push   $0x0
  pushl $250
  1029c5:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1029ca:	e9 3c 00 00 00       	jmp    102a0b <__alltraps>

001029cf <vector251>:
.globl vector251
vector251:
  pushl $0
  1029cf:	6a 00                	push   $0x0
  pushl $251
  1029d1:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1029d6:	e9 30 00 00 00       	jmp    102a0b <__alltraps>

001029db <vector252>:
.globl vector252
vector252:
  pushl $0
  1029db:	6a 00                	push   $0x0
  pushl $252
  1029dd:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029e2:	e9 24 00 00 00       	jmp    102a0b <__alltraps>

001029e7 <vector253>:
.globl vector253
vector253:
  pushl $0
  1029e7:	6a 00                	push   $0x0
  pushl $253
  1029e9:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029ee:	e9 18 00 00 00       	jmp    102a0b <__alltraps>

001029f3 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029f3:	6a 00                	push   $0x0
  pushl $254
  1029f5:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029fa:	e9 0c 00 00 00       	jmp    102a0b <__alltraps>

001029ff <vector255>:
.globl vector255
vector255:
  pushl $0
  1029ff:	6a 00                	push   $0x0
  pushl $255
  102a01:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102a06:	e9 00 00 00 00       	jmp    102a0b <__alltraps>

00102a0b <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102a0b:	1e                   	push   %ds
    pushl %es
  102a0c:	06                   	push   %es
    pushl %fs
  102a0d:	0f a0                	push   %fs
    pushl %gs
  102a0f:	0f a8                	push   %gs
    pushal
  102a11:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102a12:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102a17:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102a19:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102a1b:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102a1c:	e8 60 f5 ff ff       	call   101f81 <trap>

    # pop the pushed stack pointer
    popl %esp
  102a21:	5c                   	pop    %esp

00102a22 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102a22:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102a23:	0f a9                	pop    %gs
    popl %fs
  102a25:	0f a1                	pop    %fs
    popl %es
  102a27:	07                   	pop    %es
    popl %ds
  102a28:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102a29:	83 c4 08             	add    $0x8,%esp
    iret
  102a2c:	cf                   	iret   

00102a2d <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102a2d:	55                   	push   %ebp
  102a2e:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102a30:	8b 45 08             	mov    0x8(%ebp),%eax
  102a33:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102a36:	b8 23 00 00 00       	mov    $0x23,%eax
  102a3b:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102a3d:	b8 23 00 00 00       	mov    $0x23,%eax
  102a42:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102a44:	b8 10 00 00 00       	mov    $0x10,%eax
  102a49:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102a4b:	b8 10 00 00 00       	mov    $0x10,%eax
  102a50:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102a52:	b8 10 00 00 00       	mov    $0x10,%eax
  102a57:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102a59:	ea 60 2a 10 00 08 00 	ljmp   $0x8,$0x102a60
}
  102a60:	90                   	nop
  102a61:	5d                   	pop    %ebp
  102a62:	c3                   	ret    

00102a63 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102a63:	f3 0f 1e fb          	endbr32 
  102a67:	55                   	push   %ebp
  102a68:	89 e5                	mov    %esp,%ebp
  102a6a:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102a6d:	b8 20 09 11 00       	mov    $0x110920,%eax
  102a72:	05 00 04 00 00       	add    $0x400,%eax
  102a77:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102a7c:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  102a83:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102a85:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102a8c:	68 00 
  102a8e:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a93:	0f b7 c0             	movzwl %ax,%eax
  102a96:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102a9c:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102aa1:	c1 e8 10             	shr    $0x10,%eax
  102aa4:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102aa9:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ab0:	24 f0                	and    $0xf0,%al
  102ab2:	0c 09                	or     $0x9,%al
  102ab4:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ab9:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ac0:	0c 10                	or     $0x10,%al
  102ac2:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ac7:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ace:	24 9f                	and    $0x9f,%al
  102ad0:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ad5:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102adc:	0c 80                	or     $0x80,%al
  102ade:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ae3:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102aea:	24 f0                	and    $0xf0,%al
  102aec:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102af1:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102af8:	24 ef                	and    $0xef,%al
  102afa:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102aff:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b06:	24 df                	and    $0xdf,%al
  102b08:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b0d:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b14:	0c 40                	or     $0x40,%al
  102b16:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b1b:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b22:	24 7f                	and    $0x7f,%al
  102b24:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b29:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102b2e:	c1 e8 18             	shr    $0x18,%eax
  102b31:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102b36:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b3d:	24 ef                	and    $0xef,%al
  102b3f:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102b44:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102b4b:	e8 dd fe ff ff       	call   102a2d <lgdt>
  102b50:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102b56:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102b5a:	0f 00 d8             	ltr    %ax
}
  102b5d:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102b5e:	90                   	nop
  102b5f:	c9                   	leave  
  102b60:	c3                   	ret    

00102b61 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102b61:	f3 0f 1e fb          	endbr32 
  102b65:	55                   	push   %ebp
  102b66:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102b68:	e8 f6 fe ff ff       	call   102a63 <gdt_init>
}
  102b6d:	90                   	nop
  102b6e:	5d                   	pop    %ebp
  102b6f:	c3                   	ret    

00102b70 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102b70:	f3 0f 1e fb          	endbr32 
  102b74:	55                   	push   %ebp
  102b75:	89 e5                	mov    %esp,%ebp
  102b77:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102b81:	eb 03                	jmp    102b86 <strlen+0x16>
        cnt ++;
  102b83:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102b86:	8b 45 08             	mov    0x8(%ebp),%eax
  102b89:	8d 50 01             	lea    0x1(%eax),%edx
  102b8c:	89 55 08             	mov    %edx,0x8(%ebp)
  102b8f:	0f b6 00             	movzbl (%eax),%eax
  102b92:	84 c0                	test   %al,%al
  102b94:	75 ed                	jne    102b83 <strlen+0x13>
    }
    return cnt;
  102b96:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b99:	c9                   	leave  
  102b9a:	c3                   	ret    

00102b9b <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102b9b:	f3 0f 1e fb          	endbr32 
  102b9f:	55                   	push   %ebp
  102ba0:	89 e5                	mov    %esp,%ebp
  102ba2:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102ba5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102bac:	eb 03                	jmp    102bb1 <strnlen+0x16>
        cnt ++;
  102bae:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102bb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102bb4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102bb7:	73 10                	jae    102bc9 <strnlen+0x2e>
  102bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bbc:	8d 50 01             	lea    0x1(%eax),%edx
  102bbf:	89 55 08             	mov    %edx,0x8(%ebp)
  102bc2:	0f b6 00             	movzbl (%eax),%eax
  102bc5:	84 c0                	test   %al,%al
  102bc7:	75 e5                	jne    102bae <strnlen+0x13>
    }
    return cnt;
  102bc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102bcc:	c9                   	leave  
  102bcd:	c3                   	ret    

00102bce <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102bce:	f3 0f 1e fb          	endbr32 
  102bd2:	55                   	push   %ebp
  102bd3:	89 e5                	mov    %esp,%ebp
  102bd5:	57                   	push   %edi
  102bd6:	56                   	push   %esi
  102bd7:	83 ec 20             	sub    $0x20,%esp
  102bda:	8b 45 08             	mov    0x8(%ebp),%eax
  102bdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102be3:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102be6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bec:	89 d1                	mov    %edx,%ecx
  102bee:	89 c2                	mov    %eax,%edx
  102bf0:	89 ce                	mov    %ecx,%esi
  102bf2:	89 d7                	mov    %edx,%edi
  102bf4:	ac                   	lods   %ds:(%esi),%al
  102bf5:	aa                   	stos   %al,%es:(%edi)
  102bf6:	84 c0                	test   %al,%al
  102bf8:	75 fa                	jne    102bf4 <strcpy+0x26>
  102bfa:	89 fa                	mov    %edi,%edx
  102bfc:	89 f1                	mov    %esi,%ecx
  102bfe:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102c01:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102c04:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102c0a:	83 c4 20             	add    $0x20,%esp
  102c0d:	5e                   	pop    %esi
  102c0e:	5f                   	pop    %edi
  102c0f:	5d                   	pop    %ebp
  102c10:	c3                   	ret    

00102c11 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102c11:	f3 0f 1e fb          	endbr32 
  102c15:	55                   	push   %ebp
  102c16:	89 e5                	mov    %esp,%ebp
  102c18:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c1e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102c21:	eb 1e                	jmp    102c41 <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c26:	0f b6 10             	movzbl (%eax),%edx
  102c29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c2c:	88 10                	mov    %dl,(%eax)
  102c2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c31:	0f b6 00             	movzbl (%eax),%eax
  102c34:	84 c0                	test   %al,%al
  102c36:	74 03                	je     102c3b <strncpy+0x2a>
            src ++;
  102c38:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102c3b:	ff 45 fc             	incl   -0x4(%ebp)
  102c3e:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102c41:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c45:	75 dc                	jne    102c23 <strncpy+0x12>
    }
    return dst;
  102c47:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c4a:	c9                   	leave  
  102c4b:	c3                   	ret    

00102c4c <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102c4c:	f3 0f 1e fb          	endbr32 
  102c50:	55                   	push   %ebp
  102c51:	89 e5                	mov    %esp,%ebp
  102c53:	57                   	push   %edi
  102c54:	56                   	push   %esi
  102c55:	83 ec 20             	sub    $0x20,%esp
  102c58:	8b 45 08             	mov    0x8(%ebp),%eax
  102c5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102c64:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c67:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c6a:	89 d1                	mov    %edx,%ecx
  102c6c:	89 c2                	mov    %eax,%edx
  102c6e:	89 ce                	mov    %ecx,%esi
  102c70:	89 d7                	mov    %edx,%edi
  102c72:	ac                   	lods   %ds:(%esi),%al
  102c73:	ae                   	scas   %es:(%edi),%al
  102c74:	75 08                	jne    102c7e <strcmp+0x32>
  102c76:	84 c0                	test   %al,%al
  102c78:	75 f8                	jne    102c72 <strcmp+0x26>
  102c7a:	31 c0                	xor    %eax,%eax
  102c7c:	eb 04                	jmp    102c82 <strcmp+0x36>
  102c7e:	19 c0                	sbb    %eax,%eax
  102c80:	0c 01                	or     $0x1,%al
  102c82:	89 fa                	mov    %edi,%edx
  102c84:	89 f1                	mov    %esi,%ecx
  102c86:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102c89:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102c8c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102c8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102c92:	83 c4 20             	add    $0x20,%esp
  102c95:	5e                   	pop    %esi
  102c96:	5f                   	pop    %edi
  102c97:	5d                   	pop    %ebp
  102c98:	c3                   	ret    

00102c99 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102c99:	f3 0f 1e fb          	endbr32 
  102c9d:	55                   	push   %ebp
  102c9e:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102ca0:	eb 09                	jmp    102cab <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102ca2:	ff 4d 10             	decl   0x10(%ebp)
  102ca5:	ff 45 08             	incl   0x8(%ebp)
  102ca8:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102cab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102caf:	74 1a                	je     102ccb <strncmp+0x32>
  102cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  102cb4:	0f b6 00             	movzbl (%eax),%eax
  102cb7:	84 c0                	test   %al,%al
  102cb9:	74 10                	je     102ccb <strncmp+0x32>
  102cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  102cbe:	0f b6 10             	movzbl (%eax),%edx
  102cc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cc4:	0f b6 00             	movzbl (%eax),%eax
  102cc7:	38 c2                	cmp    %al,%dl
  102cc9:	74 d7                	je     102ca2 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102ccb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ccf:	74 18                	je     102ce9 <strncmp+0x50>
  102cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd4:	0f b6 00             	movzbl (%eax),%eax
  102cd7:	0f b6 d0             	movzbl %al,%edx
  102cda:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cdd:	0f b6 00             	movzbl (%eax),%eax
  102ce0:	0f b6 c0             	movzbl %al,%eax
  102ce3:	29 c2                	sub    %eax,%edx
  102ce5:	89 d0                	mov    %edx,%eax
  102ce7:	eb 05                	jmp    102cee <strncmp+0x55>
  102ce9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102cee:	5d                   	pop    %ebp
  102cef:	c3                   	ret    

00102cf0 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102cf0:	f3 0f 1e fb          	endbr32 
  102cf4:	55                   	push   %ebp
  102cf5:	89 e5                	mov    %esp,%ebp
  102cf7:	83 ec 04             	sub    $0x4,%esp
  102cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cfd:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d00:	eb 13                	jmp    102d15 <strchr+0x25>
        if (*s == c) {
  102d02:	8b 45 08             	mov    0x8(%ebp),%eax
  102d05:	0f b6 00             	movzbl (%eax),%eax
  102d08:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d0b:	75 05                	jne    102d12 <strchr+0x22>
            return (char *)s;
  102d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d10:	eb 12                	jmp    102d24 <strchr+0x34>
        }
        s ++;
  102d12:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d15:	8b 45 08             	mov    0x8(%ebp),%eax
  102d18:	0f b6 00             	movzbl (%eax),%eax
  102d1b:	84 c0                	test   %al,%al
  102d1d:	75 e3                	jne    102d02 <strchr+0x12>
    }
    return NULL;
  102d1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d24:	c9                   	leave  
  102d25:	c3                   	ret    

00102d26 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102d26:	f3 0f 1e fb          	endbr32 
  102d2a:	55                   	push   %ebp
  102d2b:	89 e5                	mov    %esp,%ebp
  102d2d:	83 ec 04             	sub    $0x4,%esp
  102d30:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d33:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d36:	eb 0e                	jmp    102d46 <strfind+0x20>
        if (*s == c) {
  102d38:	8b 45 08             	mov    0x8(%ebp),%eax
  102d3b:	0f b6 00             	movzbl (%eax),%eax
  102d3e:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d41:	74 0f                	je     102d52 <strfind+0x2c>
            break;
        }
        s ++;
  102d43:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d46:	8b 45 08             	mov    0x8(%ebp),%eax
  102d49:	0f b6 00             	movzbl (%eax),%eax
  102d4c:	84 c0                	test   %al,%al
  102d4e:	75 e8                	jne    102d38 <strfind+0x12>
  102d50:	eb 01                	jmp    102d53 <strfind+0x2d>
            break;
  102d52:	90                   	nop
    }
    return (char *)s;
  102d53:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102d56:	c9                   	leave  
  102d57:	c3                   	ret    

00102d58 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102d58:	f3 0f 1e fb          	endbr32 
  102d5c:	55                   	push   %ebp
  102d5d:	89 e5                	mov    %esp,%ebp
  102d5f:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102d62:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102d69:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102d70:	eb 03                	jmp    102d75 <strtol+0x1d>
        s ++;
  102d72:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102d75:	8b 45 08             	mov    0x8(%ebp),%eax
  102d78:	0f b6 00             	movzbl (%eax),%eax
  102d7b:	3c 20                	cmp    $0x20,%al
  102d7d:	74 f3                	je     102d72 <strtol+0x1a>
  102d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  102d82:	0f b6 00             	movzbl (%eax),%eax
  102d85:	3c 09                	cmp    $0x9,%al
  102d87:	74 e9                	je     102d72 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102d89:	8b 45 08             	mov    0x8(%ebp),%eax
  102d8c:	0f b6 00             	movzbl (%eax),%eax
  102d8f:	3c 2b                	cmp    $0x2b,%al
  102d91:	75 05                	jne    102d98 <strtol+0x40>
        s ++;
  102d93:	ff 45 08             	incl   0x8(%ebp)
  102d96:	eb 14                	jmp    102dac <strtol+0x54>
    }
    else if (*s == '-') {
  102d98:	8b 45 08             	mov    0x8(%ebp),%eax
  102d9b:	0f b6 00             	movzbl (%eax),%eax
  102d9e:	3c 2d                	cmp    $0x2d,%al
  102da0:	75 0a                	jne    102dac <strtol+0x54>
        s ++, neg = 1;
  102da2:	ff 45 08             	incl   0x8(%ebp)
  102da5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102dac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102db0:	74 06                	je     102db8 <strtol+0x60>
  102db2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102db6:	75 22                	jne    102dda <strtol+0x82>
  102db8:	8b 45 08             	mov    0x8(%ebp),%eax
  102dbb:	0f b6 00             	movzbl (%eax),%eax
  102dbe:	3c 30                	cmp    $0x30,%al
  102dc0:	75 18                	jne    102dda <strtol+0x82>
  102dc2:	8b 45 08             	mov    0x8(%ebp),%eax
  102dc5:	40                   	inc    %eax
  102dc6:	0f b6 00             	movzbl (%eax),%eax
  102dc9:	3c 78                	cmp    $0x78,%al
  102dcb:	75 0d                	jne    102dda <strtol+0x82>
        s += 2, base = 16;
  102dcd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102dd1:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102dd8:	eb 29                	jmp    102e03 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102dda:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dde:	75 16                	jne    102df6 <strtol+0x9e>
  102de0:	8b 45 08             	mov    0x8(%ebp),%eax
  102de3:	0f b6 00             	movzbl (%eax),%eax
  102de6:	3c 30                	cmp    $0x30,%al
  102de8:	75 0c                	jne    102df6 <strtol+0x9e>
        s ++, base = 8;
  102dea:	ff 45 08             	incl   0x8(%ebp)
  102ded:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102df4:	eb 0d                	jmp    102e03 <strtol+0xab>
    }
    else if (base == 0) {
  102df6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dfa:	75 07                	jne    102e03 <strtol+0xab>
        base = 10;
  102dfc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102e03:	8b 45 08             	mov    0x8(%ebp),%eax
  102e06:	0f b6 00             	movzbl (%eax),%eax
  102e09:	3c 2f                	cmp    $0x2f,%al
  102e0b:	7e 1b                	jle    102e28 <strtol+0xd0>
  102e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e10:	0f b6 00             	movzbl (%eax),%eax
  102e13:	3c 39                	cmp    $0x39,%al
  102e15:	7f 11                	jg     102e28 <strtol+0xd0>
            dig = *s - '0';
  102e17:	8b 45 08             	mov    0x8(%ebp),%eax
  102e1a:	0f b6 00             	movzbl (%eax),%eax
  102e1d:	0f be c0             	movsbl %al,%eax
  102e20:	83 e8 30             	sub    $0x30,%eax
  102e23:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e26:	eb 48                	jmp    102e70 <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102e28:	8b 45 08             	mov    0x8(%ebp),%eax
  102e2b:	0f b6 00             	movzbl (%eax),%eax
  102e2e:	3c 60                	cmp    $0x60,%al
  102e30:	7e 1b                	jle    102e4d <strtol+0xf5>
  102e32:	8b 45 08             	mov    0x8(%ebp),%eax
  102e35:	0f b6 00             	movzbl (%eax),%eax
  102e38:	3c 7a                	cmp    $0x7a,%al
  102e3a:	7f 11                	jg     102e4d <strtol+0xf5>
            dig = *s - 'a' + 10;
  102e3c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3f:	0f b6 00             	movzbl (%eax),%eax
  102e42:	0f be c0             	movsbl %al,%eax
  102e45:	83 e8 57             	sub    $0x57,%eax
  102e48:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e4b:	eb 23                	jmp    102e70 <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e50:	0f b6 00             	movzbl (%eax),%eax
  102e53:	3c 40                	cmp    $0x40,%al
  102e55:	7e 3b                	jle    102e92 <strtol+0x13a>
  102e57:	8b 45 08             	mov    0x8(%ebp),%eax
  102e5a:	0f b6 00             	movzbl (%eax),%eax
  102e5d:	3c 5a                	cmp    $0x5a,%al
  102e5f:	7f 31                	jg     102e92 <strtol+0x13a>
            dig = *s - 'A' + 10;
  102e61:	8b 45 08             	mov    0x8(%ebp),%eax
  102e64:	0f b6 00             	movzbl (%eax),%eax
  102e67:	0f be c0             	movsbl %al,%eax
  102e6a:	83 e8 37             	sub    $0x37,%eax
  102e6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102e70:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e73:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e76:	7d 19                	jge    102e91 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102e78:	ff 45 08             	incl   0x8(%ebp)
  102e7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e7e:	0f af 45 10          	imul   0x10(%ebp),%eax
  102e82:	89 c2                	mov    %eax,%edx
  102e84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e87:	01 d0                	add    %edx,%eax
  102e89:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102e8c:	e9 72 ff ff ff       	jmp    102e03 <strtol+0xab>
            break;
  102e91:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102e92:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e96:	74 08                	je     102ea0 <strtol+0x148>
        *endptr = (char *) s;
  102e98:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e9b:	8b 55 08             	mov    0x8(%ebp),%edx
  102e9e:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102ea0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102ea4:	74 07                	je     102ead <strtol+0x155>
  102ea6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102ea9:	f7 d8                	neg    %eax
  102eab:	eb 03                	jmp    102eb0 <strtol+0x158>
  102ead:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102eb0:	c9                   	leave  
  102eb1:	c3                   	ret    

00102eb2 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102eb2:	f3 0f 1e fb          	endbr32 
  102eb6:	55                   	push   %ebp
  102eb7:	89 e5                	mov    %esp,%ebp
  102eb9:	57                   	push   %edi
  102eba:	83 ec 24             	sub    $0x24,%esp
  102ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ec0:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102ec3:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102ec7:	8b 45 08             	mov    0x8(%ebp),%eax
  102eca:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102ecd:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102ed0:	8b 45 10             	mov    0x10(%ebp),%eax
  102ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102ed6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102ed9:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102edd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102ee0:	89 d7                	mov    %edx,%edi
  102ee2:	f3 aa                	rep stos %al,%es:(%edi)
  102ee4:	89 fa                	mov    %edi,%edx
  102ee6:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102ee9:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102eec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102eef:	83 c4 24             	add    $0x24,%esp
  102ef2:	5f                   	pop    %edi
  102ef3:	5d                   	pop    %ebp
  102ef4:	c3                   	ret    

00102ef5 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102ef5:	f3 0f 1e fb          	endbr32 
  102ef9:	55                   	push   %ebp
  102efa:	89 e5                	mov    %esp,%ebp
  102efc:	57                   	push   %edi
  102efd:	56                   	push   %esi
  102efe:	53                   	push   %ebx
  102eff:	83 ec 30             	sub    $0x30,%esp
  102f02:	8b 45 08             	mov    0x8(%ebp),%eax
  102f05:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f08:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102f0e:	8b 45 10             	mov    0x10(%ebp),%eax
  102f11:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102f14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f17:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102f1a:	73 42                	jae    102f5e <memmove+0x69>
  102f1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102f22:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f25:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102f28:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102f2e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102f31:	c1 e8 02             	shr    $0x2,%eax
  102f34:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f36:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102f39:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f3c:	89 d7                	mov    %edx,%edi
  102f3e:	89 c6                	mov    %eax,%esi
  102f40:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f42:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102f45:	83 e1 03             	and    $0x3,%ecx
  102f48:	74 02                	je     102f4c <memmove+0x57>
  102f4a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f4c:	89 f0                	mov    %esi,%eax
  102f4e:	89 fa                	mov    %edi,%edx
  102f50:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102f53:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102f56:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102f59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102f5c:	eb 36                	jmp    102f94 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102f5e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f61:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f64:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f67:	01 c2                	add    %eax,%edx
  102f69:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f6c:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102f6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f72:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102f75:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f78:	89 c1                	mov    %eax,%ecx
  102f7a:	89 d8                	mov    %ebx,%eax
  102f7c:	89 d6                	mov    %edx,%esi
  102f7e:	89 c7                	mov    %eax,%edi
  102f80:	fd                   	std    
  102f81:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f83:	fc                   	cld    
  102f84:	89 f8                	mov    %edi,%eax
  102f86:	89 f2                	mov    %esi,%edx
  102f88:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102f8b:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102f8e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102f94:	83 c4 30             	add    $0x30,%esp
  102f97:	5b                   	pop    %ebx
  102f98:	5e                   	pop    %esi
  102f99:	5f                   	pop    %edi
  102f9a:	5d                   	pop    %ebp
  102f9b:	c3                   	ret    

00102f9c <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102f9c:	f3 0f 1e fb          	endbr32 
  102fa0:	55                   	push   %ebp
  102fa1:	89 e5                	mov    %esp,%ebp
  102fa3:	57                   	push   %edi
  102fa4:	56                   	push   %esi
  102fa5:	83 ec 20             	sub    $0x20,%esp
  102fa8:	8b 45 08             	mov    0x8(%ebp),%eax
  102fab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102fae:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fb4:	8b 45 10             	mov    0x10(%ebp),%eax
  102fb7:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102fba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102fbd:	c1 e8 02             	shr    $0x2,%eax
  102fc0:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102fc2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fc8:	89 d7                	mov    %edx,%edi
  102fca:	89 c6                	mov    %eax,%esi
  102fcc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102fce:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102fd1:	83 e1 03             	and    $0x3,%ecx
  102fd4:	74 02                	je     102fd8 <memcpy+0x3c>
  102fd6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102fd8:	89 f0                	mov    %esi,%eax
  102fda:	89 fa                	mov    %edi,%edx
  102fdc:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102fdf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102fe2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102fe8:	83 c4 20             	add    $0x20,%esp
  102feb:	5e                   	pop    %esi
  102fec:	5f                   	pop    %edi
  102fed:	5d                   	pop    %ebp
  102fee:	c3                   	ret    

00102fef <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102fef:	f3 0f 1e fb          	endbr32 
  102ff3:	55                   	push   %ebp
  102ff4:	89 e5                	mov    %esp,%ebp
  102ff6:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  102ffc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103002:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  103005:	eb 2e                	jmp    103035 <memcmp+0x46>
        if (*s1 != *s2) {
  103007:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10300a:	0f b6 10             	movzbl (%eax),%edx
  10300d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103010:	0f b6 00             	movzbl (%eax),%eax
  103013:	38 c2                	cmp    %al,%dl
  103015:	74 18                	je     10302f <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  103017:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10301a:	0f b6 00             	movzbl (%eax),%eax
  10301d:	0f b6 d0             	movzbl %al,%edx
  103020:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103023:	0f b6 00             	movzbl (%eax),%eax
  103026:	0f b6 c0             	movzbl %al,%eax
  103029:	29 c2                	sub    %eax,%edx
  10302b:	89 d0                	mov    %edx,%eax
  10302d:	eb 18                	jmp    103047 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  10302f:	ff 45 fc             	incl   -0x4(%ebp)
  103032:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  103035:	8b 45 10             	mov    0x10(%ebp),%eax
  103038:	8d 50 ff             	lea    -0x1(%eax),%edx
  10303b:	89 55 10             	mov    %edx,0x10(%ebp)
  10303e:	85 c0                	test   %eax,%eax
  103040:	75 c5                	jne    103007 <memcmp+0x18>
    }
    return 0;
  103042:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103047:	c9                   	leave  
  103048:	c3                   	ret    

00103049 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  103049:	f3 0f 1e fb          	endbr32 
  10304d:	55                   	push   %ebp
  10304e:	89 e5                	mov    %esp,%ebp
  103050:	83 ec 58             	sub    $0x58,%esp
  103053:	8b 45 10             	mov    0x10(%ebp),%eax
  103056:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103059:	8b 45 14             	mov    0x14(%ebp),%eax
  10305c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10305f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103062:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103065:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103068:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  10306b:	8b 45 18             	mov    0x18(%ebp),%eax
  10306e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103071:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103074:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103077:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10307a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10307d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103080:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103083:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103087:	74 1c                	je     1030a5 <printnum+0x5c>
  103089:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10308c:	ba 00 00 00 00       	mov    $0x0,%edx
  103091:	f7 75 e4             	divl   -0x1c(%ebp)
  103094:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103097:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10309a:	ba 00 00 00 00       	mov    $0x0,%edx
  10309f:	f7 75 e4             	divl   -0x1c(%ebp)
  1030a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1030a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1030a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1030ab:	f7 75 e4             	divl   -0x1c(%ebp)
  1030ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1030b1:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1030b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1030b7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1030ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1030bd:	89 55 ec             	mov    %edx,-0x14(%ebp)
  1030c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1030c3:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  1030c6:	8b 45 18             	mov    0x18(%ebp),%eax
  1030c9:	ba 00 00 00 00       	mov    $0x0,%edx
  1030ce:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1030d1:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1030d4:	19 d1                	sbb    %edx,%ecx
  1030d6:	72 4c                	jb     103124 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  1030d8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1030db:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030de:	8b 45 20             	mov    0x20(%ebp),%eax
  1030e1:	89 44 24 18          	mov    %eax,0x18(%esp)
  1030e5:	89 54 24 14          	mov    %edx,0x14(%esp)
  1030e9:	8b 45 18             	mov    0x18(%ebp),%eax
  1030ec:	89 44 24 10          	mov    %eax,0x10(%esp)
  1030f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030f3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030f6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030fa:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1030fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  103101:	89 44 24 04          	mov    %eax,0x4(%esp)
  103105:	8b 45 08             	mov    0x8(%ebp),%eax
  103108:	89 04 24             	mov    %eax,(%esp)
  10310b:	e8 39 ff ff ff       	call   103049 <printnum>
  103110:	eb 1b                	jmp    10312d <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  103112:	8b 45 0c             	mov    0xc(%ebp),%eax
  103115:	89 44 24 04          	mov    %eax,0x4(%esp)
  103119:	8b 45 20             	mov    0x20(%ebp),%eax
  10311c:	89 04 24             	mov    %eax,(%esp)
  10311f:	8b 45 08             	mov    0x8(%ebp),%eax
  103122:	ff d0                	call   *%eax
        while (-- width > 0)
  103124:	ff 4d 1c             	decl   0x1c(%ebp)
  103127:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10312b:	7f e5                	jg     103112 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  10312d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  103130:	05 f0 3e 10 00       	add    $0x103ef0,%eax
  103135:	0f b6 00             	movzbl (%eax),%eax
  103138:	0f be c0             	movsbl %al,%eax
  10313b:	8b 55 0c             	mov    0xc(%ebp),%edx
  10313e:	89 54 24 04          	mov    %edx,0x4(%esp)
  103142:	89 04 24             	mov    %eax,(%esp)
  103145:	8b 45 08             	mov    0x8(%ebp),%eax
  103148:	ff d0                	call   *%eax
}
  10314a:	90                   	nop
  10314b:	c9                   	leave  
  10314c:	c3                   	ret    

0010314d <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10314d:	f3 0f 1e fb          	endbr32 
  103151:	55                   	push   %ebp
  103152:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103154:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103158:	7e 14                	jle    10316e <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  10315a:	8b 45 08             	mov    0x8(%ebp),%eax
  10315d:	8b 00                	mov    (%eax),%eax
  10315f:	8d 48 08             	lea    0x8(%eax),%ecx
  103162:	8b 55 08             	mov    0x8(%ebp),%edx
  103165:	89 0a                	mov    %ecx,(%edx)
  103167:	8b 50 04             	mov    0x4(%eax),%edx
  10316a:	8b 00                	mov    (%eax),%eax
  10316c:	eb 30                	jmp    10319e <getuint+0x51>
    }
    else if (lflag) {
  10316e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103172:	74 16                	je     10318a <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  103174:	8b 45 08             	mov    0x8(%ebp),%eax
  103177:	8b 00                	mov    (%eax),%eax
  103179:	8d 48 04             	lea    0x4(%eax),%ecx
  10317c:	8b 55 08             	mov    0x8(%ebp),%edx
  10317f:	89 0a                	mov    %ecx,(%edx)
  103181:	8b 00                	mov    (%eax),%eax
  103183:	ba 00 00 00 00       	mov    $0x0,%edx
  103188:	eb 14                	jmp    10319e <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  10318a:	8b 45 08             	mov    0x8(%ebp),%eax
  10318d:	8b 00                	mov    (%eax),%eax
  10318f:	8d 48 04             	lea    0x4(%eax),%ecx
  103192:	8b 55 08             	mov    0x8(%ebp),%edx
  103195:	89 0a                	mov    %ecx,(%edx)
  103197:	8b 00                	mov    (%eax),%eax
  103199:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10319e:	5d                   	pop    %ebp
  10319f:	c3                   	ret    

001031a0 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1031a0:	f3 0f 1e fb          	endbr32 
  1031a4:	55                   	push   %ebp
  1031a5:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1031a7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1031ab:	7e 14                	jle    1031c1 <getint+0x21>
        return va_arg(*ap, long long);
  1031ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1031b0:	8b 00                	mov    (%eax),%eax
  1031b2:	8d 48 08             	lea    0x8(%eax),%ecx
  1031b5:	8b 55 08             	mov    0x8(%ebp),%edx
  1031b8:	89 0a                	mov    %ecx,(%edx)
  1031ba:	8b 50 04             	mov    0x4(%eax),%edx
  1031bd:	8b 00                	mov    (%eax),%eax
  1031bf:	eb 28                	jmp    1031e9 <getint+0x49>
    }
    else if (lflag) {
  1031c1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1031c5:	74 12                	je     1031d9 <getint+0x39>
        return va_arg(*ap, long);
  1031c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ca:	8b 00                	mov    (%eax),%eax
  1031cc:	8d 48 04             	lea    0x4(%eax),%ecx
  1031cf:	8b 55 08             	mov    0x8(%ebp),%edx
  1031d2:	89 0a                	mov    %ecx,(%edx)
  1031d4:	8b 00                	mov    (%eax),%eax
  1031d6:	99                   	cltd   
  1031d7:	eb 10                	jmp    1031e9 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  1031d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1031dc:	8b 00                	mov    (%eax),%eax
  1031de:	8d 48 04             	lea    0x4(%eax),%ecx
  1031e1:	8b 55 08             	mov    0x8(%ebp),%edx
  1031e4:	89 0a                	mov    %ecx,(%edx)
  1031e6:	8b 00                	mov    (%eax),%eax
  1031e8:	99                   	cltd   
    }
}
  1031e9:	5d                   	pop    %ebp
  1031ea:	c3                   	ret    

001031eb <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1031eb:	f3 0f 1e fb          	endbr32 
  1031ef:	55                   	push   %ebp
  1031f0:	89 e5                	mov    %esp,%ebp
  1031f2:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1031f5:	8d 45 14             	lea    0x14(%ebp),%eax
  1031f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1031fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103202:	8b 45 10             	mov    0x10(%ebp),%eax
  103205:	89 44 24 08          	mov    %eax,0x8(%esp)
  103209:	8b 45 0c             	mov    0xc(%ebp),%eax
  10320c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103210:	8b 45 08             	mov    0x8(%ebp),%eax
  103213:	89 04 24             	mov    %eax,(%esp)
  103216:	e8 03 00 00 00       	call   10321e <vprintfmt>
    va_end(ap);
}
  10321b:	90                   	nop
  10321c:	c9                   	leave  
  10321d:	c3                   	ret    

0010321e <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  10321e:	f3 0f 1e fb          	endbr32 
  103222:	55                   	push   %ebp
  103223:	89 e5                	mov    %esp,%ebp
  103225:	56                   	push   %esi
  103226:	53                   	push   %ebx
  103227:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10322a:	eb 17                	jmp    103243 <vprintfmt+0x25>
            if (ch == '\0') {
  10322c:	85 db                	test   %ebx,%ebx
  10322e:	0f 84 c0 03 00 00    	je     1035f4 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  103234:	8b 45 0c             	mov    0xc(%ebp),%eax
  103237:	89 44 24 04          	mov    %eax,0x4(%esp)
  10323b:	89 1c 24             	mov    %ebx,(%esp)
  10323e:	8b 45 08             	mov    0x8(%ebp),%eax
  103241:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103243:	8b 45 10             	mov    0x10(%ebp),%eax
  103246:	8d 50 01             	lea    0x1(%eax),%edx
  103249:	89 55 10             	mov    %edx,0x10(%ebp)
  10324c:	0f b6 00             	movzbl (%eax),%eax
  10324f:	0f b6 d8             	movzbl %al,%ebx
  103252:	83 fb 25             	cmp    $0x25,%ebx
  103255:	75 d5                	jne    10322c <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103257:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10325b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103262:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103265:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103268:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10326f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103272:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103275:	8b 45 10             	mov    0x10(%ebp),%eax
  103278:	8d 50 01             	lea    0x1(%eax),%edx
  10327b:	89 55 10             	mov    %edx,0x10(%ebp)
  10327e:	0f b6 00             	movzbl (%eax),%eax
  103281:	0f b6 d8             	movzbl %al,%ebx
  103284:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103287:	83 f8 55             	cmp    $0x55,%eax
  10328a:	0f 87 38 03 00 00    	ja     1035c8 <vprintfmt+0x3aa>
  103290:	8b 04 85 14 3f 10 00 	mov    0x103f14(,%eax,4),%eax
  103297:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  10329a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  10329e:	eb d5                	jmp    103275 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1032a0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1032a4:	eb cf                	jmp    103275 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1032a6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1032ad:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1032b0:	89 d0                	mov    %edx,%eax
  1032b2:	c1 e0 02             	shl    $0x2,%eax
  1032b5:	01 d0                	add    %edx,%eax
  1032b7:	01 c0                	add    %eax,%eax
  1032b9:	01 d8                	add    %ebx,%eax
  1032bb:	83 e8 30             	sub    $0x30,%eax
  1032be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1032c1:	8b 45 10             	mov    0x10(%ebp),%eax
  1032c4:	0f b6 00             	movzbl (%eax),%eax
  1032c7:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1032ca:	83 fb 2f             	cmp    $0x2f,%ebx
  1032cd:	7e 38                	jle    103307 <vprintfmt+0xe9>
  1032cf:	83 fb 39             	cmp    $0x39,%ebx
  1032d2:	7f 33                	jg     103307 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  1032d4:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1032d7:	eb d4                	jmp    1032ad <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1032d9:	8b 45 14             	mov    0x14(%ebp),%eax
  1032dc:	8d 50 04             	lea    0x4(%eax),%edx
  1032df:	89 55 14             	mov    %edx,0x14(%ebp)
  1032e2:	8b 00                	mov    (%eax),%eax
  1032e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1032e7:	eb 1f                	jmp    103308 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  1032e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032ed:	79 86                	jns    103275 <vprintfmt+0x57>
                width = 0;
  1032ef:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  1032f6:	e9 7a ff ff ff       	jmp    103275 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  1032fb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  103302:	e9 6e ff ff ff       	jmp    103275 <vprintfmt+0x57>
            goto process_precision;
  103307:	90                   	nop

        process_precision:
            if (width < 0)
  103308:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10330c:	0f 89 63 ff ff ff    	jns    103275 <vprintfmt+0x57>
                width = precision, precision = -1;
  103312:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103315:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103318:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  10331f:	e9 51 ff ff ff       	jmp    103275 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103324:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  103327:	e9 49 ff ff ff       	jmp    103275 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  10332c:	8b 45 14             	mov    0x14(%ebp),%eax
  10332f:	8d 50 04             	lea    0x4(%eax),%edx
  103332:	89 55 14             	mov    %edx,0x14(%ebp)
  103335:	8b 00                	mov    (%eax),%eax
  103337:	8b 55 0c             	mov    0xc(%ebp),%edx
  10333a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10333e:	89 04 24             	mov    %eax,(%esp)
  103341:	8b 45 08             	mov    0x8(%ebp),%eax
  103344:	ff d0                	call   *%eax
            break;
  103346:	e9 a4 02 00 00       	jmp    1035ef <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  10334b:	8b 45 14             	mov    0x14(%ebp),%eax
  10334e:	8d 50 04             	lea    0x4(%eax),%edx
  103351:	89 55 14             	mov    %edx,0x14(%ebp)
  103354:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103356:	85 db                	test   %ebx,%ebx
  103358:	79 02                	jns    10335c <vprintfmt+0x13e>
                err = -err;
  10335a:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10335c:	83 fb 06             	cmp    $0x6,%ebx
  10335f:	7f 0b                	jg     10336c <vprintfmt+0x14e>
  103361:	8b 34 9d d4 3e 10 00 	mov    0x103ed4(,%ebx,4),%esi
  103368:	85 f6                	test   %esi,%esi
  10336a:	75 23                	jne    10338f <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  10336c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  103370:	c7 44 24 08 01 3f 10 	movl   $0x103f01,0x8(%esp)
  103377:	00 
  103378:	8b 45 0c             	mov    0xc(%ebp),%eax
  10337b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10337f:	8b 45 08             	mov    0x8(%ebp),%eax
  103382:	89 04 24             	mov    %eax,(%esp)
  103385:	e8 61 fe ff ff       	call   1031eb <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  10338a:	e9 60 02 00 00       	jmp    1035ef <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  10338f:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103393:	c7 44 24 08 0a 3f 10 	movl   $0x103f0a,0x8(%esp)
  10339a:	00 
  10339b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10339e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1033a5:	89 04 24             	mov    %eax,(%esp)
  1033a8:	e8 3e fe ff ff       	call   1031eb <printfmt>
            break;
  1033ad:	e9 3d 02 00 00       	jmp    1035ef <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1033b2:	8b 45 14             	mov    0x14(%ebp),%eax
  1033b5:	8d 50 04             	lea    0x4(%eax),%edx
  1033b8:	89 55 14             	mov    %edx,0x14(%ebp)
  1033bb:	8b 30                	mov    (%eax),%esi
  1033bd:	85 f6                	test   %esi,%esi
  1033bf:	75 05                	jne    1033c6 <vprintfmt+0x1a8>
                p = "(null)";
  1033c1:	be 0d 3f 10 00       	mov    $0x103f0d,%esi
            }
            if (width > 0 && padc != '-') {
  1033c6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033ca:	7e 76                	jle    103442 <vprintfmt+0x224>
  1033cc:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  1033d0:	74 70                	je     103442 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033d5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033d9:	89 34 24             	mov    %esi,(%esp)
  1033dc:	e8 ba f7 ff ff       	call   102b9b <strnlen>
  1033e1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1033e4:	29 c2                	sub    %eax,%edx
  1033e6:	89 d0                	mov    %edx,%eax
  1033e8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1033eb:	eb 16                	jmp    103403 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  1033ed:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1033f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033f4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033f8:	89 04 24             	mov    %eax,(%esp)
  1033fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fe:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  103400:	ff 4d e8             	decl   -0x18(%ebp)
  103403:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103407:	7f e4                	jg     1033ed <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103409:	eb 37                	jmp    103442 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  10340b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  10340f:	74 1f                	je     103430 <vprintfmt+0x212>
  103411:	83 fb 1f             	cmp    $0x1f,%ebx
  103414:	7e 05                	jle    10341b <vprintfmt+0x1fd>
  103416:	83 fb 7e             	cmp    $0x7e,%ebx
  103419:	7e 15                	jle    103430 <vprintfmt+0x212>
                    putch('?', putdat);
  10341b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10341e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103422:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  103429:	8b 45 08             	mov    0x8(%ebp),%eax
  10342c:	ff d0                	call   *%eax
  10342e:	eb 0f                	jmp    10343f <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  103430:	8b 45 0c             	mov    0xc(%ebp),%eax
  103433:	89 44 24 04          	mov    %eax,0x4(%esp)
  103437:	89 1c 24             	mov    %ebx,(%esp)
  10343a:	8b 45 08             	mov    0x8(%ebp),%eax
  10343d:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10343f:	ff 4d e8             	decl   -0x18(%ebp)
  103442:	89 f0                	mov    %esi,%eax
  103444:	8d 70 01             	lea    0x1(%eax),%esi
  103447:	0f b6 00             	movzbl (%eax),%eax
  10344a:	0f be d8             	movsbl %al,%ebx
  10344d:	85 db                	test   %ebx,%ebx
  10344f:	74 27                	je     103478 <vprintfmt+0x25a>
  103451:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103455:	78 b4                	js     10340b <vprintfmt+0x1ed>
  103457:	ff 4d e4             	decl   -0x1c(%ebp)
  10345a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10345e:	79 ab                	jns    10340b <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  103460:	eb 16                	jmp    103478 <vprintfmt+0x25a>
                putch(' ', putdat);
  103462:	8b 45 0c             	mov    0xc(%ebp),%eax
  103465:	89 44 24 04          	mov    %eax,0x4(%esp)
  103469:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  103470:	8b 45 08             	mov    0x8(%ebp),%eax
  103473:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103475:	ff 4d e8             	decl   -0x18(%ebp)
  103478:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10347c:	7f e4                	jg     103462 <vprintfmt+0x244>
            }
            break;
  10347e:	e9 6c 01 00 00       	jmp    1035ef <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103483:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103486:	89 44 24 04          	mov    %eax,0x4(%esp)
  10348a:	8d 45 14             	lea    0x14(%ebp),%eax
  10348d:	89 04 24             	mov    %eax,(%esp)
  103490:	e8 0b fd ff ff       	call   1031a0 <getint>
  103495:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103498:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  10349b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10349e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034a1:	85 d2                	test   %edx,%edx
  1034a3:	79 26                	jns    1034cb <vprintfmt+0x2ad>
                putch('-', putdat);
  1034a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034ac:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  1034b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1034b6:	ff d0                	call   *%eax
                num = -(long long)num;
  1034b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034be:	f7 d8                	neg    %eax
  1034c0:	83 d2 00             	adc    $0x0,%edx
  1034c3:	f7 da                	neg    %edx
  1034c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  1034cb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034d2:	e9 a8 00 00 00       	jmp    10357f <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1034d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034de:	8d 45 14             	lea    0x14(%ebp),%eax
  1034e1:	89 04 24             	mov    %eax,(%esp)
  1034e4:	e8 64 fc ff ff       	call   10314d <getuint>
  1034e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034ec:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1034ef:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034f6:	e9 84 00 00 00       	jmp    10357f <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1034fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034fe:	89 44 24 04          	mov    %eax,0x4(%esp)
  103502:	8d 45 14             	lea    0x14(%ebp),%eax
  103505:	89 04 24             	mov    %eax,(%esp)
  103508:	e8 40 fc ff ff       	call   10314d <getuint>
  10350d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103510:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103513:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  10351a:	eb 63                	jmp    10357f <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  10351c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10351f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103523:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  10352a:	8b 45 08             	mov    0x8(%ebp),%eax
  10352d:	ff d0                	call   *%eax
            putch('x', putdat);
  10352f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103532:	89 44 24 04          	mov    %eax,0x4(%esp)
  103536:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  10353d:	8b 45 08             	mov    0x8(%ebp),%eax
  103540:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103542:	8b 45 14             	mov    0x14(%ebp),%eax
  103545:	8d 50 04             	lea    0x4(%eax),%edx
  103548:	89 55 14             	mov    %edx,0x14(%ebp)
  10354b:	8b 00                	mov    (%eax),%eax
  10354d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103550:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103557:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10355e:	eb 1f                	jmp    10357f <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103560:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103563:	89 44 24 04          	mov    %eax,0x4(%esp)
  103567:	8d 45 14             	lea    0x14(%ebp),%eax
  10356a:	89 04 24             	mov    %eax,(%esp)
  10356d:	e8 db fb ff ff       	call   10314d <getuint>
  103572:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103575:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103578:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10357f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103583:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103586:	89 54 24 18          	mov    %edx,0x18(%esp)
  10358a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10358d:	89 54 24 14          	mov    %edx,0x14(%esp)
  103591:	89 44 24 10          	mov    %eax,0x10(%esp)
  103595:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103598:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10359b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10359f:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1035a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035a6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1035ad:	89 04 24             	mov    %eax,(%esp)
  1035b0:	e8 94 fa ff ff       	call   103049 <printnum>
            break;
  1035b5:	eb 38                	jmp    1035ef <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1035b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035ba:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035be:	89 1c 24             	mov    %ebx,(%esp)
  1035c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1035c4:	ff d0                	call   *%eax
            break;
  1035c6:	eb 27                	jmp    1035ef <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1035c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035cb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035cf:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1035d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1035d9:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  1035db:	ff 4d 10             	decl   0x10(%ebp)
  1035de:	eb 03                	jmp    1035e3 <vprintfmt+0x3c5>
  1035e0:	ff 4d 10             	decl   0x10(%ebp)
  1035e3:	8b 45 10             	mov    0x10(%ebp),%eax
  1035e6:	48                   	dec    %eax
  1035e7:	0f b6 00             	movzbl (%eax),%eax
  1035ea:	3c 25                	cmp    $0x25,%al
  1035ec:	75 f2                	jne    1035e0 <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  1035ee:	90                   	nop
    while (1) {
  1035ef:	e9 36 fc ff ff       	jmp    10322a <vprintfmt+0xc>
                return;
  1035f4:	90                   	nop
        }
    }
}
  1035f5:	83 c4 40             	add    $0x40,%esp
  1035f8:	5b                   	pop    %ebx
  1035f9:	5e                   	pop    %esi
  1035fa:	5d                   	pop    %ebp
  1035fb:	c3                   	ret    

001035fc <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1035fc:	f3 0f 1e fb          	endbr32 
  103600:	55                   	push   %ebp
  103601:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  103603:	8b 45 0c             	mov    0xc(%ebp),%eax
  103606:	8b 40 08             	mov    0x8(%eax),%eax
  103609:	8d 50 01             	lea    0x1(%eax),%edx
  10360c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10360f:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103612:	8b 45 0c             	mov    0xc(%ebp),%eax
  103615:	8b 10                	mov    (%eax),%edx
  103617:	8b 45 0c             	mov    0xc(%ebp),%eax
  10361a:	8b 40 04             	mov    0x4(%eax),%eax
  10361d:	39 c2                	cmp    %eax,%edx
  10361f:	73 12                	jae    103633 <sprintputch+0x37>
        *b->buf ++ = ch;
  103621:	8b 45 0c             	mov    0xc(%ebp),%eax
  103624:	8b 00                	mov    (%eax),%eax
  103626:	8d 48 01             	lea    0x1(%eax),%ecx
  103629:	8b 55 0c             	mov    0xc(%ebp),%edx
  10362c:	89 0a                	mov    %ecx,(%edx)
  10362e:	8b 55 08             	mov    0x8(%ebp),%edx
  103631:	88 10                	mov    %dl,(%eax)
    }
}
  103633:	90                   	nop
  103634:	5d                   	pop    %ebp
  103635:	c3                   	ret    

00103636 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103636:	f3 0f 1e fb          	endbr32 
  10363a:	55                   	push   %ebp
  10363b:	89 e5                	mov    %esp,%ebp
  10363d:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103640:	8d 45 14             	lea    0x14(%ebp),%eax
  103643:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103646:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103649:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10364d:	8b 45 10             	mov    0x10(%ebp),%eax
  103650:	89 44 24 08          	mov    %eax,0x8(%esp)
  103654:	8b 45 0c             	mov    0xc(%ebp),%eax
  103657:	89 44 24 04          	mov    %eax,0x4(%esp)
  10365b:	8b 45 08             	mov    0x8(%ebp),%eax
  10365e:	89 04 24             	mov    %eax,(%esp)
  103661:	e8 08 00 00 00       	call   10366e <vsnprintf>
  103666:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103669:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10366c:	c9                   	leave  
  10366d:	c3                   	ret    

0010366e <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10366e:	f3 0f 1e fb          	endbr32 
  103672:	55                   	push   %ebp
  103673:	89 e5                	mov    %esp,%ebp
  103675:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103678:	8b 45 08             	mov    0x8(%ebp),%eax
  10367b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10367e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103681:	8d 50 ff             	lea    -0x1(%eax),%edx
  103684:	8b 45 08             	mov    0x8(%ebp),%eax
  103687:	01 d0                	add    %edx,%eax
  103689:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10368c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103693:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103697:	74 0a                	je     1036a3 <vsnprintf+0x35>
  103699:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10369c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10369f:	39 c2                	cmp    %eax,%edx
  1036a1:	76 07                	jbe    1036aa <vsnprintf+0x3c>
        return -E_INVAL;
  1036a3:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1036a8:	eb 2a                	jmp    1036d4 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1036aa:	8b 45 14             	mov    0x14(%ebp),%eax
  1036ad:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1036b1:	8b 45 10             	mov    0x10(%ebp),%eax
  1036b4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1036b8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1036bb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036bf:	c7 04 24 fc 35 10 00 	movl   $0x1035fc,(%esp)
  1036c6:	e8 53 fb ff ff       	call   10321e <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1036cb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036ce:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1036d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1036d4:	c9                   	leave  
  1036d5:	c3                   	ret    
