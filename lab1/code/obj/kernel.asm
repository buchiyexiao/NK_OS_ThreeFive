
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
  100027:	e8 79 2e 00 00       	call   102ea5 <memset>

    cons_init();                // init the console
  10002c:	e8 22 16 00 00       	call   101653 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 e0 36 10 00 	movl   $0x1036e0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 fc 36 10 00 	movl   $0x1036fc,(%esp)
  100046:	e8 49 02 00 00       	call   100294 <cprintf>

    print_kerninfo();
  10004b:	e8 07 09 00 00       	call   100957 <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 fa 2a 00 00       	call   102b54 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 49 17 00 00       	call   1017a8 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 ee 18 00 00       	call   101952 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 6f 0d 00 00       	call   100dd8 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 86 18 00 00       	call   1018f4 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 87 01 00 00       	call   1001fa <lab1_switch_test>

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
  100096:	e8 27 0d 00 00       	call   100dc2 <mon_backtrace>
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
  10014c:	e8 43 01 00 00       	call   100294 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 0f 37 10 00 	movl   $0x10370f,(%esp)
  10016b:	e8 24 01 00 00       	call   100294 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 1d 37 10 00 	movl   $0x10371d,(%esp)
  10018a:	e8 05 01 00 00       	call   100294 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 2b 37 10 00 	movl   $0x10372b,(%esp)
  1001a9:	e8 e6 00 00 00       	call   100294 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 39 37 10 00 	movl   $0x103739,(%esp)
  1001c8:	e8 c7 00 00 00       	call   100294 <cprintf>
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
    asm volatile (
  1001e2:	83 ec 08             	sub    $0x8,%esp
  1001e5:	cd 78                	int    $0x78
  1001e7:	89 ec                	mov    %ebp,%esp
	    "int %0 \n" //%0 为 T_SWITCH_TOU 参数
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  1001e9:	90                   	nop
  1001ea:	5d                   	pop    %ebp
  1001eb:	c3                   	ret    

001001ec <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001ec:	f3 0f 1e fb          	endbr32 
  1001f0:	55                   	push   %ebp
  1001f1:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    //引发对应的中断（T_SWITCH_TOK）
    asm volatile ( 
  1001f3:	cd 79                	int    $0x79
  1001f5:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp \n"
        : 
        : "i"(T_SWITCH_TOK)
    );
}
  1001f7:	90                   	nop
  1001f8:	5d                   	pop    %ebp
  1001f9:	c3                   	ret    

001001fa <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001fa:	f3 0f 1e fb          	endbr32 
  1001fe:	55                   	push   %ebp
  1001ff:	89 e5                	mov    %esp,%ebp
  100201:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  100204:	e8 10 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100209:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
  100210:	e8 7f 00 00 00       	call   100294 <cprintf>
    lab1_switch_to_user();
  100215:	e8 c1 ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  10021a:	e8 fa fe ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10021f:	c7 04 24 68 37 10 00 	movl   $0x103768,(%esp)
  100226:	e8 69 00 00 00       	call   100294 <cprintf>
    lab1_switch_to_kernel();
  10022b:	e8 bc ff ff ff       	call   1001ec <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100230:	e8 e4 fe ff ff       	call   100119 <lab1_print_cur_status>
}
  100235:	90                   	nop
  100236:	c9                   	leave  
  100237:	c3                   	ret    

00100238 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100238:	f3 0f 1e fb          	endbr32 
  10023c:	55                   	push   %ebp
  10023d:	89 e5                	mov    %esp,%ebp
  10023f:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100242:	8b 45 08             	mov    0x8(%ebp),%eax
  100245:	89 04 24             	mov    %eax,(%esp)
  100248:	e8 37 14 00 00       	call   101684 <cons_putc>
    (*cnt) ++;
  10024d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100250:	8b 00                	mov    (%eax),%eax
  100252:	8d 50 01             	lea    0x1(%eax),%edx
  100255:	8b 45 0c             	mov    0xc(%ebp),%eax
  100258:	89 10                	mov    %edx,(%eax)
}
  10025a:	90                   	nop
  10025b:	c9                   	leave  
  10025c:	c3                   	ret    

0010025d <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  10025d:	f3 0f 1e fb          	endbr32 
  100261:	55                   	push   %ebp
  100262:	89 e5                	mov    %esp,%ebp
  100264:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100267:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  10026e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100271:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100275:	8b 45 08             	mov    0x8(%ebp),%eax
  100278:	89 44 24 08          	mov    %eax,0x8(%esp)
  10027c:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10027f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100283:	c7 04 24 38 02 10 00 	movl   $0x100238,(%esp)
  10028a:	e8 82 2f 00 00       	call   103211 <vprintfmt>
    return cnt;
  10028f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100292:	c9                   	leave  
  100293:	c3                   	ret    

00100294 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100294:	f3 0f 1e fb          	endbr32 
  100298:	55                   	push   %ebp
  100299:	89 e5                	mov    %esp,%ebp
  10029b:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10029e:	8d 45 0c             	lea    0xc(%ebp),%eax
  1002a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  1002a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ae:	89 04 24             	mov    %eax,(%esp)
  1002b1:	e8 a7 ff ff ff       	call   10025d <vcprintf>
  1002b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002bc:	c9                   	leave  
  1002bd:	c3                   	ret    

001002be <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002be:	f3 0f 1e fb          	endbr32 
  1002c2:	55                   	push   %ebp
  1002c3:	89 e5                	mov    %esp,%ebp
  1002c5:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1002cb:	89 04 24             	mov    %eax,(%esp)
  1002ce:	e8 b1 13 00 00       	call   101684 <cons_putc>
}
  1002d3:	90                   	nop
  1002d4:	c9                   	leave  
  1002d5:	c3                   	ret    

001002d6 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002d6:	f3 0f 1e fb          	endbr32 
  1002da:	55                   	push   %ebp
  1002db:	89 e5                	mov    %esp,%ebp
  1002dd:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002e7:	eb 13                	jmp    1002fc <cputs+0x26>
        cputch(c, &cnt);
  1002e9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002ed:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002f0:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002f4:	89 04 24             	mov    %eax,(%esp)
  1002f7:	e8 3c ff ff ff       	call   100238 <cputch>
    while ((c = *str ++) != '\0') {
  1002fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ff:	8d 50 01             	lea    0x1(%eax),%edx
  100302:	89 55 08             	mov    %edx,0x8(%ebp)
  100305:	0f b6 00             	movzbl (%eax),%eax
  100308:	88 45 f7             	mov    %al,-0x9(%ebp)
  10030b:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10030f:	75 d8                	jne    1002e9 <cputs+0x13>
    }
    cputch('\n', &cnt);
  100311:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100314:	89 44 24 04          	mov    %eax,0x4(%esp)
  100318:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10031f:	e8 14 ff ff ff       	call   100238 <cputch>
    return cnt;
  100324:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100327:	c9                   	leave  
  100328:	c3                   	ret    

00100329 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100329:	f3 0f 1e fb          	endbr32 
  10032d:	55                   	push   %ebp
  10032e:	89 e5                	mov    %esp,%ebp
  100330:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100333:	90                   	nop
  100334:	e8 79 13 00 00       	call   1016b2 <cons_getc>
  100339:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10033c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100340:	74 f2                	je     100334 <getchar+0xb>
        /* do nothing */;
    return c;
  100342:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100345:	c9                   	leave  
  100346:	c3                   	ret    

00100347 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100347:	f3 0f 1e fb          	endbr32 
  10034b:	55                   	push   %ebp
  10034c:	89 e5                	mov    %esp,%ebp
  10034e:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100351:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100355:	74 13                	je     10036a <readline+0x23>
        cprintf("%s", prompt);
  100357:	8b 45 08             	mov    0x8(%ebp),%eax
  10035a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10035e:	c7 04 24 87 37 10 00 	movl   $0x103787,(%esp)
  100365:	e8 2a ff ff ff       	call   100294 <cprintf>
    }
    int i = 0, c;
  10036a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100371:	e8 b3 ff ff ff       	call   100329 <getchar>
  100376:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100379:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10037d:	79 07                	jns    100386 <readline+0x3f>
            return NULL;
  10037f:	b8 00 00 00 00       	mov    $0x0,%eax
  100384:	eb 78                	jmp    1003fe <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100386:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10038a:	7e 28                	jle    1003b4 <readline+0x6d>
  10038c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100393:	7f 1f                	jg     1003b4 <readline+0x6d>
            cputchar(c);
  100395:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100398:	89 04 24             	mov    %eax,(%esp)
  10039b:	e8 1e ff ff ff       	call   1002be <cputchar>
            buf[i ++] = c;
  1003a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003a3:	8d 50 01             	lea    0x1(%eax),%edx
  1003a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1003a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003ac:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  1003b2:	eb 45                	jmp    1003f9 <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003b4:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003b8:	75 16                	jne    1003d0 <readline+0x89>
  1003ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003be:	7e 10                	jle    1003d0 <readline+0x89>
            cputchar(c);
  1003c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003c3:	89 04 24             	mov    %eax,(%esp)
  1003c6:	e8 f3 fe ff ff       	call   1002be <cputchar>
            i --;
  1003cb:	ff 4d f4             	decl   -0xc(%ebp)
  1003ce:	eb 29                	jmp    1003f9 <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  1003d0:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003d4:	74 06                	je     1003dc <readline+0x95>
  1003d6:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003da:	75 95                	jne    100371 <readline+0x2a>
            cputchar(c);
  1003dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003df:	89 04 24             	mov    %eax,(%esp)
  1003e2:	e8 d7 fe ff ff       	call   1002be <cputchar>
            buf[i] = '\0';
  1003e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003ea:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1003ef:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003f2:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1003f7:	eb 05                	jmp    1003fe <readline+0xb7>
        c = getchar();
  1003f9:	e9 73 ff ff ff       	jmp    100371 <readline+0x2a>
        }
    }
}
  1003fe:	c9                   	leave  
  1003ff:	c3                   	ret    

00100400 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100400:	f3 0f 1e fb          	endbr32 
  100404:	55                   	push   %ebp
  100405:	89 e5                	mov    %esp,%ebp
  100407:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  10040a:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  10040f:	85 c0                	test   %eax,%eax
  100411:	75 5b                	jne    10046e <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  100413:	c7 05 40 fe 10 00 01 	movl   $0x1,0x10fe40
  10041a:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  10041d:	8d 45 14             	lea    0x14(%ebp),%eax
  100420:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100423:	8b 45 0c             	mov    0xc(%ebp),%eax
  100426:	89 44 24 08          	mov    %eax,0x8(%esp)
  10042a:	8b 45 08             	mov    0x8(%ebp),%eax
  10042d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100431:	c7 04 24 8a 37 10 00 	movl   $0x10378a,(%esp)
  100438:	e8 57 fe ff ff       	call   100294 <cprintf>
    vcprintf(fmt, ap);
  10043d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100440:	89 44 24 04          	mov    %eax,0x4(%esp)
  100444:	8b 45 10             	mov    0x10(%ebp),%eax
  100447:	89 04 24             	mov    %eax,(%esp)
  10044a:	e8 0e fe ff ff       	call   10025d <vcprintf>
    cprintf("\n");
  10044f:	c7 04 24 a6 37 10 00 	movl   $0x1037a6,(%esp)
  100456:	e8 39 fe ff ff       	call   100294 <cprintf>
    
    cprintf("stack trackback:\n");
  10045b:	c7 04 24 a8 37 10 00 	movl   $0x1037a8,(%esp)
  100462:	e8 2d fe ff ff       	call   100294 <cprintf>
    print_stackframe();
  100467:	e8 3d 06 00 00       	call   100aa9 <print_stackframe>
  10046c:	eb 01                	jmp    10046f <__panic+0x6f>
        goto panic_dead;
  10046e:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  10046f:	e8 8c 14 00 00       	call   101900 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100474:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10047b:	e8 69 08 00 00       	call   100ce9 <kmonitor>
  100480:	eb f2                	jmp    100474 <__panic+0x74>

00100482 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100482:	f3 0f 1e fb          	endbr32 
  100486:	55                   	push   %ebp
  100487:	89 e5                	mov    %esp,%ebp
  100489:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  10048c:	8d 45 14             	lea    0x14(%ebp),%eax
  10048f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100492:	8b 45 0c             	mov    0xc(%ebp),%eax
  100495:	89 44 24 08          	mov    %eax,0x8(%esp)
  100499:	8b 45 08             	mov    0x8(%ebp),%eax
  10049c:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004a0:	c7 04 24 ba 37 10 00 	movl   $0x1037ba,(%esp)
  1004a7:	e8 e8 fd ff ff       	call   100294 <cprintf>
    vcprintf(fmt, ap);
  1004ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004af:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004b3:	8b 45 10             	mov    0x10(%ebp),%eax
  1004b6:	89 04 24             	mov    %eax,(%esp)
  1004b9:	e8 9f fd ff ff       	call   10025d <vcprintf>
    cprintf("\n");
  1004be:	c7 04 24 a6 37 10 00 	movl   $0x1037a6,(%esp)
  1004c5:	e8 ca fd ff ff       	call   100294 <cprintf>
    va_end(ap);
}
  1004ca:	90                   	nop
  1004cb:	c9                   	leave  
  1004cc:	c3                   	ret    

001004cd <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004cd:	f3 0f 1e fb          	endbr32 
  1004d1:	55                   	push   %ebp
  1004d2:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004d4:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  1004d9:	5d                   	pop    %ebp
  1004da:	c3                   	ret    

001004db <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004db:	f3 0f 1e fb          	endbr32 
  1004df:	55                   	push   %ebp
  1004e0:	89 e5                	mov    %esp,%ebp
  1004e2:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e8:	8b 00                	mov    (%eax),%eax
  1004ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004ed:	8b 45 10             	mov    0x10(%ebp),%eax
  1004f0:	8b 00                	mov    (%eax),%eax
  1004f2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004fc:	e9 ca 00 00 00       	jmp    1005cb <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  100501:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100504:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100507:	01 d0                	add    %edx,%eax
  100509:	89 c2                	mov    %eax,%edx
  10050b:	c1 ea 1f             	shr    $0x1f,%edx
  10050e:	01 d0                	add    %edx,%eax
  100510:	d1 f8                	sar    %eax
  100512:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100515:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100518:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  10051b:	eb 03                	jmp    100520 <stab_binsearch+0x45>
            m --;
  10051d:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100520:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100523:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100526:	7c 1f                	jl     100547 <stab_binsearch+0x6c>
  100528:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10052b:	89 d0                	mov    %edx,%eax
  10052d:	01 c0                	add    %eax,%eax
  10052f:	01 d0                	add    %edx,%eax
  100531:	c1 e0 02             	shl    $0x2,%eax
  100534:	89 c2                	mov    %eax,%edx
  100536:	8b 45 08             	mov    0x8(%ebp),%eax
  100539:	01 d0                	add    %edx,%eax
  10053b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10053f:	0f b6 c0             	movzbl %al,%eax
  100542:	39 45 14             	cmp    %eax,0x14(%ebp)
  100545:	75 d6                	jne    10051d <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100547:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10054a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10054d:	7d 09                	jge    100558 <stab_binsearch+0x7d>
            l = true_m + 1;
  10054f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100552:	40                   	inc    %eax
  100553:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100556:	eb 73                	jmp    1005cb <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  100558:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10055f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100562:	89 d0                	mov    %edx,%eax
  100564:	01 c0                	add    %eax,%eax
  100566:	01 d0                	add    %edx,%eax
  100568:	c1 e0 02             	shl    $0x2,%eax
  10056b:	89 c2                	mov    %eax,%edx
  10056d:	8b 45 08             	mov    0x8(%ebp),%eax
  100570:	01 d0                	add    %edx,%eax
  100572:	8b 40 08             	mov    0x8(%eax),%eax
  100575:	39 45 18             	cmp    %eax,0x18(%ebp)
  100578:	76 11                	jbe    10058b <stab_binsearch+0xb0>
            *region_left = m;
  10057a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10057d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100580:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100582:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100585:	40                   	inc    %eax
  100586:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100589:	eb 40                	jmp    1005cb <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  10058b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10058e:	89 d0                	mov    %edx,%eax
  100590:	01 c0                	add    %eax,%eax
  100592:	01 d0                	add    %edx,%eax
  100594:	c1 e0 02             	shl    $0x2,%eax
  100597:	89 c2                	mov    %eax,%edx
  100599:	8b 45 08             	mov    0x8(%ebp),%eax
  10059c:	01 d0                	add    %edx,%eax
  10059e:	8b 40 08             	mov    0x8(%eax),%eax
  1005a1:	39 45 18             	cmp    %eax,0x18(%ebp)
  1005a4:	73 14                	jae    1005ba <stab_binsearch+0xdf>
            *region_right = m - 1;
  1005a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005ac:	8b 45 10             	mov    0x10(%ebp),%eax
  1005af:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005b4:	48                   	dec    %eax
  1005b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005b8:	eb 11                	jmp    1005cb <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005bd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005c0:	89 10                	mov    %edx,(%eax)
            l = m;
  1005c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005c8:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1005cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005ce:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005d1:	0f 8e 2a ff ff ff    	jle    100501 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005db:	75 0f                	jne    1005ec <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  1005dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005e0:	8b 00                	mov    (%eax),%eax
  1005e2:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005e5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e8:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005ea:	eb 3e                	jmp    10062a <stab_binsearch+0x14f>
        l = *region_right;
  1005ec:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ef:	8b 00                	mov    (%eax),%eax
  1005f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005f4:	eb 03                	jmp    1005f9 <stab_binsearch+0x11e>
  1005f6:	ff 4d fc             	decl   -0x4(%ebp)
  1005f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005fc:	8b 00                	mov    (%eax),%eax
  1005fe:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100601:	7e 1f                	jle    100622 <stab_binsearch+0x147>
  100603:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100606:	89 d0                	mov    %edx,%eax
  100608:	01 c0                	add    %eax,%eax
  10060a:	01 d0                	add    %edx,%eax
  10060c:	c1 e0 02             	shl    $0x2,%eax
  10060f:	89 c2                	mov    %eax,%edx
  100611:	8b 45 08             	mov    0x8(%ebp),%eax
  100614:	01 d0                	add    %edx,%eax
  100616:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10061a:	0f b6 c0             	movzbl %al,%eax
  10061d:	39 45 14             	cmp    %eax,0x14(%ebp)
  100620:	75 d4                	jne    1005f6 <stab_binsearch+0x11b>
        *region_left = l;
  100622:	8b 45 0c             	mov    0xc(%ebp),%eax
  100625:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100628:	89 10                	mov    %edx,(%eax)
}
  10062a:	90                   	nop
  10062b:	c9                   	leave  
  10062c:	c3                   	ret    

0010062d <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10062d:	f3 0f 1e fb          	endbr32 
  100631:	55                   	push   %ebp
  100632:	89 e5                	mov    %esp,%ebp
  100634:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100637:	8b 45 0c             	mov    0xc(%ebp),%eax
  10063a:	c7 00 d8 37 10 00    	movl   $0x1037d8,(%eax)
    info->eip_line = 0;
  100640:	8b 45 0c             	mov    0xc(%ebp),%eax
  100643:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10064a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064d:	c7 40 08 d8 37 10 00 	movl   $0x1037d8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100654:	8b 45 0c             	mov    0xc(%ebp),%eax
  100657:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10065e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100661:	8b 55 08             	mov    0x8(%ebp),%edx
  100664:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100667:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100671:	c7 45 f4 0c 40 10 00 	movl   $0x10400c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100678:	c7 45 f0 e4 cd 10 00 	movl   $0x10cde4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10067f:	c7 45 ec e5 cd 10 00 	movl   $0x10cde5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100686:	c7 45 e8 ce ee 10 00 	movl   $0x10eece,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10068d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100690:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100693:	76 0b                	jbe    1006a0 <debuginfo_eip+0x73>
  100695:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100698:	48                   	dec    %eax
  100699:	0f b6 00             	movzbl (%eax),%eax
  10069c:	84 c0                	test   %al,%al
  10069e:	74 0a                	je     1006aa <debuginfo_eip+0x7d>
        return -1;
  1006a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006a5:	e9 ab 02 00 00       	jmp    100955 <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006aa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006b4:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006b7:	c1 f8 02             	sar    $0x2,%eax
  1006ba:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006c0:	48                   	dec    %eax
  1006c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006c4:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006cb:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1006d2:	00 
  1006d3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006d6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006da:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006e4:	89 04 24             	mov    %eax,(%esp)
  1006e7:	e8 ef fd ff ff       	call   1004db <stab_binsearch>
    if (lfile == 0)
  1006ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006ef:	85 c0                	test   %eax,%eax
  1006f1:	75 0a                	jne    1006fd <debuginfo_eip+0xd0>
        return -1;
  1006f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006f8:	e9 58 02 00 00       	jmp    100955 <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100700:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100703:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100706:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100709:	8b 45 08             	mov    0x8(%ebp),%eax
  10070c:	89 44 24 10          	mov    %eax,0x10(%esp)
  100710:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100717:	00 
  100718:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10071b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10071f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100722:	89 44 24 04          	mov    %eax,0x4(%esp)
  100726:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100729:	89 04 24             	mov    %eax,(%esp)
  10072c:	e8 aa fd ff ff       	call   1004db <stab_binsearch>

    if (lfun <= rfun) {
  100731:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100734:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100737:	39 c2                	cmp    %eax,%edx
  100739:	7f 78                	jg     1007b3 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10073b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10073e:	89 c2                	mov    %eax,%edx
  100740:	89 d0                	mov    %edx,%eax
  100742:	01 c0                	add    %eax,%eax
  100744:	01 d0                	add    %edx,%eax
  100746:	c1 e0 02             	shl    $0x2,%eax
  100749:	89 c2                	mov    %eax,%edx
  10074b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10074e:	01 d0                	add    %edx,%eax
  100750:	8b 10                	mov    (%eax),%edx
  100752:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100755:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100758:	39 c2                	cmp    %eax,%edx
  10075a:	73 22                	jae    10077e <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10075c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10075f:	89 c2                	mov    %eax,%edx
  100761:	89 d0                	mov    %edx,%eax
  100763:	01 c0                	add    %eax,%eax
  100765:	01 d0                	add    %edx,%eax
  100767:	c1 e0 02             	shl    $0x2,%eax
  10076a:	89 c2                	mov    %eax,%edx
  10076c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10076f:	01 d0                	add    %edx,%eax
  100771:	8b 10                	mov    (%eax),%edx
  100773:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100776:	01 c2                	add    %eax,%edx
  100778:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077b:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  10077e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100781:	89 c2                	mov    %eax,%edx
  100783:	89 d0                	mov    %edx,%eax
  100785:	01 c0                	add    %eax,%eax
  100787:	01 d0                	add    %edx,%eax
  100789:	c1 e0 02             	shl    $0x2,%eax
  10078c:	89 c2                	mov    %eax,%edx
  10078e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100791:	01 d0                	add    %edx,%eax
  100793:	8b 50 08             	mov    0x8(%eax),%edx
  100796:	8b 45 0c             	mov    0xc(%ebp),%eax
  100799:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  10079c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10079f:	8b 40 10             	mov    0x10(%eax),%eax
  1007a2:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  1007a5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007a8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1007ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007ae:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007b1:	eb 15                	jmp    1007c8 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007b6:	8b 55 08             	mov    0x8(%ebp),%edx
  1007b9:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007c5:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007cb:	8b 40 08             	mov    0x8(%eax),%eax
  1007ce:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1007d5:	00 
  1007d6:	89 04 24             	mov    %eax,(%esp)
  1007d9:	e8 3b 25 00 00       	call   102d19 <strfind>
  1007de:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007e1:	8b 52 08             	mov    0x8(%edx),%edx
  1007e4:	29 d0                	sub    %edx,%eax
  1007e6:	89 c2                	mov    %eax,%edx
  1007e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007eb:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1007f1:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007f5:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007fc:	00 
  1007fd:	8d 45 d0             	lea    -0x30(%ebp),%eax
  100800:	89 44 24 08          	mov    %eax,0x8(%esp)
  100804:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100807:	89 44 24 04          	mov    %eax,0x4(%esp)
  10080b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10080e:	89 04 24             	mov    %eax,(%esp)
  100811:	e8 c5 fc ff ff       	call   1004db <stab_binsearch>
    if (lline <= rline) {
  100816:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100819:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10081c:	39 c2                	cmp    %eax,%edx
  10081e:	7f 23                	jg     100843 <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  100820:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100823:	89 c2                	mov    %eax,%edx
  100825:	89 d0                	mov    %edx,%eax
  100827:	01 c0                	add    %eax,%eax
  100829:	01 d0                	add    %edx,%eax
  10082b:	c1 e0 02             	shl    $0x2,%eax
  10082e:	89 c2                	mov    %eax,%edx
  100830:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100833:	01 d0                	add    %edx,%eax
  100835:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100839:	89 c2                	mov    %eax,%edx
  10083b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10083e:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100841:	eb 11                	jmp    100854 <debuginfo_eip+0x227>
        return -1;
  100843:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100848:	e9 08 01 00 00       	jmp    100955 <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  10084d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100850:	48                   	dec    %eax
  100851:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100854:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100857:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10085a:	39 c2                	cmp    %eax,%edx
  10085c:	7c 56                	jl     1008b4 <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  10085e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100861:	89 c2                	mov    %eax,%edx
  100863:	89 d0                	mov    %edx,%eax
  100865:	01 c0                	add    %eax,%eax
  100867:	01 d0                	add    %edx,%eax
  100869:	c1 e0 02             	shl    $0x2,%eax
  10086c:	89 c2                	mov    %eax,%edx
  10086e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100871:	01 d0                	add    %edx,%eax
  100873:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100877:	3c 84                	cmp    $0x84,%al
  100879:	74 39                	je     1008b4 <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  10087b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10087e:	89 c2                	mov    %eax,%edx
  100880:	89 d0                	mov    %edx,%eax
  100882:	01 c0                	add    %eax,%eax
  100884:	01 d0                	add    %edx,%eax
  100886:	c1 e0 02             	shl    $0x2,%eax
  100889:	89 c2                	mov    %eax,%edx
  10088b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10088e:	01 d0                	add    %edx,%eax
  100890:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100894:	3c 64                	cmp    $0x64,%al
  100896:	75 b5                	jne    10084d <debuginfo_eip+0x220>
  100898:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10089b:	89 c2                	mov    %eax,%edx
  10089d:	89 d0                	mov    %edx,%eax
  10089f:	01 c0                	add    %eax,%eax
  1008a1:	01 d0                	add    %edx,%eax
  1008a3:	c1 e0 02             	shl    $0x2,%eax
  1008a6:	89 c2                	mov    %eax,%edx
  1008a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008ab:	01 d0                	add    %edx,%eax
  1008ad:	8b 40 08             	mov    0x8(%eax),%eax
  1008b0:	85 c0                	test   %eax,%eax
  1008b2:	74 99                	je     10084d <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008b4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008ba:	39 c2                	cmp    %eax,%edx
  1008bc:	7c 42                	jl     100900 <debuginfo_eip+0x2d3>
  1008be:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008c1:	89 c2                	mov    %eax,%edx
  1008c3:	89 d0                	mov    %edx,%eax
  1008c5:	01 c0                	add    %eax,%eax
  1008c7:	01 d0                	add    %edx,%eax
  1008c9:	c1 e0 02             	shl    $0x2,%eax
  1008cc:	89 c2                	mov    %eax,%edx
  1008ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008d1:	01 d0                	add    %edx,%eax
  1008d3:	8b 10                	mov    (%eax),%edx
  1008d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008d8:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008db:	39 c2                	cmp    %eax,%edx
  1008dd:	73 21                	jae    100900 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008df:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008e2:	89 c2                	mov    %eax,%edx
  1008e4:	89 d0                	mov    %edx,%eax
  1008e6:	01 c0                	add    %eax,%eax
  1008e8:	01 d0                	add    %edx,%eax
  1008ea:	c1 e0 02             	shl    $0x2,%eax
  1008ed:	89 c2                	mov    %eax,%edx
  1008ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008f2:	01 d0                	add    %edx,%eax
  1008f4:	8b 10                	mov    (%eax),%edx
  1008f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008f9:	01 c2                	add    %eax,%edx
  1008fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008fe:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100900:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100903:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100906:	39 c2                	cmp    %eax,%edx
  100908:	7d 46                	jge    100950 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  10090a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10090d:	40                   	inc    %eax
  10090e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100911:	eb 16                	jmp    100929 <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100913:	8b 45 0c             	mov    0xc(%ebp),%eax
  100916:	8b 40 14             	mov    0x14(%eax),%eax
  100919:	8d 50 01             	lea    0x1(%eax),%edx
  10091c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10091f:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100922:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100925:	40                   	inc    %eax
  100926:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100929:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10092c:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  10092f:	39 c2                	cmp    %eax,%edx
  100931:	7d 1d                	jge    100950 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100933:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100936:	89 c2                	mov    %eax,%edx
  100938:	89 d0                	mov    %edx,%eax
  10093a:	01 c0                	add    %eax,%eax
  10093c:	01 d0                	add    %edx,%eax
  10093e:	c1 e0 02             	shl    $0x2,%eax
  100941:	89 c2                	mov    %eax,%edx
  100943:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100946:	01 d0                	add    %edx,%eax
  100948:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10094c:	3c a0                	cmp    $0xa0,%al
  10094e:	74 c3                	je     100913 <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  100950:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100955:	c9                   	leave  
  100956:	c3                   	ret    

00100957 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100957:	f3 0f 1e fb          	endbr32 
  10095b:	55                   	push   %ebp
  10095c:	89 e5                	mov    %esp,%ebp
  10095e:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100961:	c7 04 24 e2 37 10 00 	movl   $0x1037e2,(%esp)
  100968:	e8 27 f9 ff ff       	call   100294 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10096d:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100974:	00 
  100975:	c7 04 24 fb 37 10 00 	movl   $0x1037fb,(%esp)
  10097c:	e8 13 f9 ff ff       	call   100294 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100981:	c7 44 24 04 c9 36 10 	movl   $0x1036c9,0x4(%esp)
  100988:	00 
  100989:	c7 04 24 13 38 10 00 	movl   $0x103813,(%esp)
  100990:	e8 ff f8 ff ff       	call   100294 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100995:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  10099c:	00 
  10099d:	c7 04 24 2b 38 10 00 	movl   $0x10382b,(%esp)
  1009a4:	e8 eb f8 ff ff       	call   100294 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009a9:	c7 44 24 04 20 0d 11 	movl   $0x110d20,0x4(%esp)
  1009b0:	00 
  1009b1:	c7 04 24 43 38 10 00 	movl   $0x103843,(%esp)
  1009b8:	e8 d7 f8 ff ff       	call   100294 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009bd:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  1009c2:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009c7:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009cc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009d2:	85 c0                	test   %eax,%eax
  1009d4:	0f 48 c2             	cmovs  %edx,%eax
  1009d7:	c1 f8 0a             	sar    $0xa,%eax
  1009da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009de:	c7 04 24 5c 38 10 00 	movl   $0x10385c,(%esp)
  1009e5:	e8 aa f8 ff ff       	call   100294 <cprintf>
}
  1009ea:	90                   	nop
  1009eb:	c9                   	leave  
  1009ec:	c3                   	ret    

001009ed <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009ed:	f3 0f 1e fb          	endbr32 
  1009f1:	55                   	push   %ebp
  1009f2:	89 e5                	mov    %esp,%ebp
  1009f4:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009fa:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a01:	8b 45 08             	mov    0x8(%ebp),%eax
  100a04:	89 04 24             	mov    %eax,(%esp)
  100a07:	e8 21 fc ff ff       	call   10062d <debuginfo_eip>
  100a0c:	85 c0                	test   %eax,%eax
  100a0e:	74 15                	je     100a25 <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a10:	8b 45 08             	mov    0x8(%ebp),%eax
  100a13:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a17:	c7 04 24 86 38 10 00 	movl   $0x103886,(%esp)
  100a1e:	e8 71 f8 ff ff       	call   100294 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a23:	eb 6c                	jmp    100a91 <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a2c:	eb 1b                	jmp    100a49 <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a2e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a34:	01 d0                	add    %edx,%eax
  100a36:	0f b6 10             	movzbl (%eax),%edx
  100a39:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a42:	01 c8                	add    %ecx,%eax
  100a44:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a46:	ff 45 f4             	incl   -0xc(%ebp)
  100a49:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a4c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a4f:	7c dd                	jl     100a2e <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a51:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a5a:	01 d0                	add    %edx,%eax
  100a5c:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a62:	8b 55 08             	mov    0x8(%ebp),%edx
  100a65:	89 d1                	mov    %edx,%ecx
  100a67:	29 c1                	sub    %eax,%ecx
  100a69:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a6c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a6f:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a73:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a79:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a7d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a81:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a85:	c7 04 24 a2 38 10 00 	movl   $0x1038a2,(%esp)
  100a8c:	e8 03 f8 ff ff       	call   100294 <cprintf>
}
  100a91:	90                   	nop
  100a92:	c9                   	leave  
  100a93:	c3                   	ret    

00100a94 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a94:	f3 0f 1e fb          	endbr32 
  100a98:	55                   	push   %ebp
  100a99:	89 e5                	mov    %esp,%ebp
  100a9b:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a9e:	8b 45 04             	mov    0x4(%ebp),%eax
  100aa1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100aa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100aa7:	c9                   	leave  
  100aa8:	c3                   	ret    

00100aa9 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100aa9:	f3 0f 1e fb          	endbr32 
  100aad:	55                   	push   %ebp
  100aae:	89 e5                	mov    %esp,%ebp
  100ab0:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100ab3:	89 e8                	mov    %ebp,%eax
  100ab5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100ab8:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	    uint32_t ebp = read_ebp();   //(1) call read_ebp() to get the value of ebp. the type is (uint32_t);
  100abb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        uint32_t eip = read_eip();   //(2) call read_eip() to get the value of eip. the type is (uint32_t);
  100abe:	e8 d1 ff ff ff       	call   100a94 <read_eip>
  100ac3:	89 45 f0             	mov    %eax,-0x10(%ebp)
        int i, j;
        for(i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++) { 
  100ac6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100acd:	e9 90 00 00 00       	jmp    100b62 <print_stackframe+0xb9>
            //(3) from 0 .. STACKFRAME_DEPTH
                cprintf("ebp:0x%08x eip:0x%08x", ebp, eip);//(3.1) printf value of ebp, eip
  100ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ad5:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100adc:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ae0:	c7 04 24 b4 38 10 00 	movl   $0x1038b4,(%esp)
  100ae7:	e8 a8 f7 ff ff       	call   100294 <cprintf>
                uint32_t *arg = (uint32_t *)ebp + 2;
  100aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aef:	83 c0 08             	add    $0x8,%eax
  100af2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                cprintf(" arg:");
  100af5:	c7 04 24 ca 38 10 00 	movl   $0x1038ca,(%esp)
  100afc:	e8 93 f7 ff ff       	call   100294 <cprintf>
                for(j = 0; j < 4; j++) {
  100b01:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100b08:	eb 24                	jmp    100b2e <print_stackframe+0x85>
                        cprintf("0x%08x ", arg[j]);
  100b0a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b0d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100b17:	01 d0                	add    %edx,%eax
  100b19:	8b 00                	mov    (%eax),%eax
  100b1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b1f:	c7 04 24 d0 38 10 00 	movl   $0x1038d0,(%esp)
  100b26:	e8 69 f7 ff ff       	call   100294 <cprintf>
                for(j = 0; j < 4; j++) {
  100b2b:	ff 45 e8             	incl   -0x18(%ebp)
  100b2e:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b32:	7e d6                	jle    100b0a <print_stackframe+0x61>
                }		//(3.2) (uint32_t)calling arguments [0..4] = the contents in address (unit32_t)ebp +2 [0..4]
                cprintf("\n");	//(3.3) cprintf("\n");
  100b34:	c7 04 24 d8 38 10 00 	movl   $0x1038d8,(%esp)
  100b3b:	e8 54 f7 ff ff       	call   100294 <cprintf>
                print_debuginfo(eip - 1);//(3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
  100b40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b43:	48                   	dec    %eax
  100b44:	89 04 24             	mov    %eax,(%esp)
  100b47:	e8 a1 fe ff ff       	call   1009ed <print_debuginfo>
                eip = ((uint32_t *)ebp)[1];//(3.5) popup a calling stackframe
  100b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b4f:	83 c0 04             	add    $0x4,%eax
  100b52:	8b 00                	mov    (%eax),%eax
  100b54:	89 45 f0             	mov    %eax,-0x10(%ebp)
                ebp = ((uint32_t*)ebp)[0];//eip  = ss:[ebp+4]   ebp = ss:[ebp]
  100b57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b5a:	8b 00                	mov    (%eax),%eax
  100b5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        for(i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++) { 
  100b5f:	ff 45 ec             	incl   -0x14(%ebp)
  100b62:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b66:	7f 0a                	jg     100b72 <print_stackframe+0xc9>
  100b68:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b6c:	0f 85 60 ff ff ff    	jne    100ad2 <print_stackframe+0x29>
        }
}
  100b72:	90                   	nop
  100b73:	c9                   	leave  
  100b74:	c3                   	ret    

00100b75 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b75:	f3 0f 1e fb          	endbr32 
  100b79:	55                   	push   %ebp
  100b7a:	89 e5                	mov    %esp,%ebp
  100b7c:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b7f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b86:	eb 0c                	jmp    100b94 <parse+0x1f>
            *buf ++ = '\0';
  100b88:	8b 45 08             	mov    0x8(%ebp),%eax
  100b8b:	8d 50 01             	lea    0x1(%eax),%edx
  100b8e:	89 55 08             	mov    %edx,0x8(%ebp)
  100b91:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b94:	8b 45 08             	mov    0x8(%ebp),%eax
  100b97:	0f b6 00             	movzbl (%eax),%eax
  100b9a:	84 c0                	test   %al,%al
  100b9c:	74 1d                	je     100bbb <parse+0x46>
  100b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  100ba1:	0f b6 00             	movzbl (%eax),%eax
  100ba4:	0f be c0             	movsbl %al,%eax
  100ba7:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bab:	c7 04 24 5c 39 10 00 	movl   $0x10395c,(%esp)
  100bb2:	e8 2c 21 00 00       	call   102ce3 <strchr>
  100bb7:	85 c0                	test   %eax,%eax
  100bb9:	75 cd                	jne    100b88 <parse+0x13>
        }
        if (*buf == '\0') {
  100bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  100bbe:	0f b6 00             	movzbl (%eax),%eax
  100bc1:	84 c0                	test   %al,%al
  100bc3:	74 65                	je     100c2a <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100bc5:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100bc9:	75 14                	jne    100bdf <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100bcb:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100bd2:	00 
  100bd3:	c7 04 24 61 39 10 00 	movl   $0x103961,(%esp)
  100bda:	e8 b5 f6 ff ff       	call   100294 <cprintf>
        }
        argv[argc ++] = buf;
  100bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100be2:	8d 50 01             	lea    0x1(%eax),%edx
  100be5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100be8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bef:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bf2:	01 c2                	add    %eax,%edx
  100bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf7:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bf9:	eb 03                	jmp    100bfe <parse+0x89>
            buf ++;
  100bfb:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  100c01:	0f b6 00             	movzbl (%eax),%eax
  100c04:	84 c0                	test   %al,%al
  100c06:	74 8c                	je     100b94 <parse+0x1f>
  100c08:	8b 45 08             	mov    0x8(%ebp),%eax
  100c0b:	0f b6 00             	movzbl (%eax),%eax
  100c0e:	0f be c0             	movsbl %al,%eax
  100c11:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c15:	c7 04 24 5c 39 10 00 	movl   $0x10395c,(%esp)
  100c1c:	e8 c2 20 00 00       	call   102ce3 <strchr>
  100c21:	85 c0                	test   %eax,%eax
  100c23:	74 d6                	je     100bfb <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c25:	e9 6a ff ff ff       	jmp    100b94 <parse+0x1f>
            break;
  100c2a:	90                   	nop
        }
    }
    return argc;
  100c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c2e:	c9                   	leave  
  100c2f:	c3                   	ret    

00100c30 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c30:	f3 0f 1e fb          	endbr32 
  100c34:	55                   	push   %ebp
  100c35:	89 e5                	mov    %esp,%ebp
  100c37:	53                   	push   %ebx
  100c38:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c3b:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c42:	8b 45 08             	mov    0x8(%ebp),%eax
  100c45:	89 04 24             	mov    %eax,(%esp)
  100c48:	e8 28 ff ff ff       	call   100b75 <parse>
  100c4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c50:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c54:	75 0a                	jne    100c60 <runcmd+0x30>
        return 0;
  100c56:	b8 00 00 00 00       	mov    $0x0,%eax
  100c5b:	e9 83 00 00 00       	jmp    100ce3 <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c67:	eb 5a                	jmp    100cc3 <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c69:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c6f:	89 d0                	mov    %edx,%eax
  100c71:	01 c0                	add    %eax,%eax
  100c73:	01 d0                	add    %edx,%eax
  100c75:	c1 e0 02             	shl    $0x2,%eax
  100c78:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c7d:	8b 00                	mov    (%eax),%eax
  100c7f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c83:	89 04 24             	mov    %eax,(%esp)
  100c86:	e8 b4 1f 00 00       	call   102c3f <strcmp>
  100c8b:	85 c0                	test   %eax,%eax
  100c8d:	75 31                	jne    100cc0 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c8f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c92:	89 d0                	mov    %edx,%eax
  100c94:	01 c0                	add    %eax,%eax
  100c96:	01 d0                	add    %edx,%eax
  100c98:	c1 e0 02             	shl    $0x2,%eax
  100c9b:	05 08 f0 10 00       	add    $0x10f008,%eax
  100ca0:	8b 10                	mov    (%eax),%edx
  100ca2:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100ca5:	83 c0 04             	add    $0x4,%eax
  100ca8:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100cab:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100cae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100cb1:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100cb5:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cb9:	89 1c 24             	mov    %ebx,(%esp)
  100cbc:	ff d2                	call   *%edx
  100cbe:	eb 23                	jmp    100ce3 <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100cc0:	ff 45 f4             	incl   -0xc(%ebp)
  100cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cc6:	83 f8 02             	cmp    $0x2,%eax
  100cc9:	76 9e                	jbe    100c69 <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100ccb:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100cce:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cd2:	c7 04 24 7f 39 10 00 	movl   $0x10397f,(%esp)
  100cd9:	e8 b6 f5 ff ff       	call   100294 <cprintf>
    return 0;
  100cde:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ce3:	83 c4 64             	add    $0x64,%esp
  100ce6:	5b                   	pop    %ebx
  100ce7:	5d                   	pop    %ebp
  100ce8:	c3                   	ret    

00100ce9 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100ce9:	f3 0f 1e fb          	endbr32 
  100ced:	55                   	push   %ebp
  100cee:	89 e5                	mov    %esp,%ebp
  100cf0:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100cf3:	c7 04 24 98 39 10 00 	movl   $0x103998,(%esp)
  100cfa:	e8 95 f5 ff ff       	call   100294 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cff:	c7 04 24 c0 39 10 00 	movl   $0x1039c0,(%esp)
  100d06:	e8 89 f5 ff ff       	call   100294 <cprintf>

    if (tf != NULL) {
  100d0b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100d0f:	74 0b                	je     100d1c <kmonitor+0x33>
        print_trapframe(tf);
  100d11:	8b 45 08             	mov    0x8(%ebp),%eax
  100d14:	89 04 24             	mov    %eax,(%esp)
  100d17:	e8 01 0e 00 00       	call   101b1d <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d1c:	c7 04 24 e5 39 10 00 	movl   $0x1039e5,(%esp)
  100d23:	e8 1f f6 ff ff       	call   100347 <readline>
  100d28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d2b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d2f:	74 eb                	je     100d1c <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100d31:	8b 45 08             	mov    0x8(%ebp),%eax
  100d34:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d3b:	89 04 24             	mov    %eax,(%esp)
  100d3e:	e8 ed fe ff ff       	call   100c30 <runcmd>
  100d43:	85 c0                	test   %eax,%eax
  100d45:	78 02                	js     100d49 <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100d47:	eb d3                	jmp    100d1c <kmonitor+0x33>
                break;
  100d49:	90                   	nop
            }
        }
    }
}
  100d4a:	90                   	nop
  100d4b:	c9                   	leave  
  100d4c:	c3                   	ret    

00100d4d <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d4d:	f3 0f 1e fb          	endbr32 
  100d51:	55                   	push   %ebp
  100d52:	89 e5                	mov    %esp,%ebp
  100d54:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d5e:	eb 3d                	jmp    100d9d <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d63:	89 d0                	mov    %edx,%eax
  100d65:	01 c0                	add    %eax,%eax
  100d67:	01 d0                	add    %edx,%eax
  100d69:	c1 e0 02             	shl    $0x2,%eax
  100d6c:	05 04 f0 10 00       	add    $0x10f004,%eax
  100d71:	8b 08                	mov    (%eax),%ecx
  100d73:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d76:	89 d0                	mov    %edx,%eax
  100d78:	01 c0                	add    %eax,%eax
  100d7a:	01 d0                	add    %edx,%eax
  100d7c:	c1 e0 02             	shl    $0x2,%eax
  100d7f:	05 00 f0 10 00       	add    $0x10f000,%eax
  100d84:	8b 00                	mov    (%eax),%eax
  100d86:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d8e:	c7 04 24 e9 39 10 00 	movl   $0x1039e9,(%esp)
  100d95:	e8 fa f4 ff ff       	call   100294 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d9a:	ff 45 f4             	incl   -0xc(%ebp)
  100d9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100da0:	83 f8 02             	cmp    $0x2,%eax
  100da3:	76 bb                	jbe    100d60 <mon_help+0x13>
    }
    return 0;
  100da5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100daa:	c9                   	leave  
  100dab:	c3                   	ret    

00100dac <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100dac:	f3 0f 1e fb          	endbr32 
  100db0:	55                   	push   %ebp
  100db1:	89 e5                	mov    %esp,%ebp
  100db3:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100db6:	e8 9c fb ff ff       	call   100957 <print_kerninfo>
    return 0;
  100dbb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dc0:	c9                   	leave  
  100dc1:	c3                   	ret    

00100dc2 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100dc2:	f3 0f 1e fb          	endbr32 
  100dc6:	55                   	push   %ebp
  100dc7:	89 e5                	mov    %esp,%ebp
  100dc9:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100dcc:	e8 d8 fc ff ff       	call   100aa9 <print_stackframe>
    return 0;
  100dd1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dd6:	c9                   	leave  
  100dd7:	c3                   	ret    

00100dd8 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dd8:	f3 0f 1e fb          	endbr32 
  100ddc:	55                   	push   %ebp
  100ddd:	89 e5                	mov    %esp,%ebp
  100ddf:	83 ec 28             	sub    $0x28,%esp
  100de2:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100de8:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dec:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100df0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100df4:	ee                   	out    %al,(%dx)
}
  100df5:	90                   	nop
  100df6:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100dfc:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e00:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e04:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e08:	ee                   	out    %al,(%dx)
}
  100e09:	90                   	nop
  100e0a:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100e10:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e14:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e18:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e1c:	ee                   	out    %al,(%dx)
}
  100e1d:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e1e:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  100e25:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e28:	c7 04 24 f2 39 10 00 	movl   $0x1039f2,(%esp)
  100e2f:	e8 60 f4 ff ff       	call   100294 <cprintf>
    pic_enable(IRQ_TIMER);
  100e34:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e3b:	e8 31 09 00 00       	call   101771 <pic_enable>
}
  100e40:	90                   	nop
  100e41:	c9                   	leave  
  100e42:	c3                   	ret    

00100e43 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e43:	f3 0f 1e fb          	endbr32 
  100e47:	55                   	push   %ebp
  100e48:	89 e5                	mov    %esp,%ebp
  100e4a:	83 ec 10             	sub    $0x10,%esp
  100e4d:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e53:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e57:	89 c2                	mov    %eax,%edx
  100e59:	ec                   	in     (%dx),%al
  100e5a:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e5d:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e63:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e67:	89 c2                	mov    %eax,%edx
  100e69:	ec                   	in     (%dx),%al
  100e6a:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e6d:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e73:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e77:	89 c2                	mov    %eax,%edx
  100e79:	ec                   	in     (%dx),%al
  100e7a:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e7d:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e83:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e87:	89 c2                	mov    %eax,%edx
  100e89:	ec                   	in     (%dx),%al
  100e8a:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e8d:	90                   	nop
  100e8e:	c9                   	leave  
  100e8f:	c3                   	ret    

00100e90 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e90:	f3 0f 1e fb          	endbr32 
  100e94:	55                   	push   %ebp
  100e95:	89 e5                	mov    %esp,%ebp
  100e97:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e9a:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100ea1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea4:	0f b7 00             	movzwl (%eax),%eax
  100ea7:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100eab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eae:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100eb3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eb6:	0f b7 00             	movzwl (%eax),%eax
  100eb9:	0f b7 c0             	movzwl %ax,%eax
  100ebc:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100ec1:	74 12                	je     100ed5 <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100ec3:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100eca:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100ed1:	b4 03 
  100ed3:	eb 13                	jmp    100ee8 <cga_init+0x58>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100ed5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ed8:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100edc:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100edf:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100ee6:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100ee8:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100eef:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ef3:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ef7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100efb:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100eff:	ee                   	out    %al,(%dx)
}
  100f00:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100f01:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f08:	40                   	inc    %eax
  100f09:	0f b7 c0             	movzwl %ax,%eax
  100f0c:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f10:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100f14:	89 c2                	mov    %eax,%edx
  100f16:	ec                   	in     (%dx),%al
  100f17:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f1a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f1e:	0f b6 c0             	movzbl %al,%eax
  100f21:	c1 e0 08             	shl    $0x8,%eax
  100f24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f27:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f2e:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f32:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f36:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f3a:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f3e:	ee                   	out    %al,(%dx)
}
  100f3f:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f40:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f47:	40                   	inc    %eax
  100f48:	0f b7 c0             	movzwl %ax,%eax
  100f4b:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f4f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f53:	89 c2                	mov    %eax,%edx
  100f55:	ec                   	in     (%dx),%al
  100f56:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f59:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f5d:	0f b6 c0             	movzbl %al,%eax
  100f60:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f63:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f66:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f6e:	0f b7 c0             	movzwl %ax,%eax
  100f71:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f77:	90                   	nop
  100f78:	c9                   	leave  
  100f79:	c3                   	ret    

00100f7a <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f7a:	f3 0f 1e fb          	endbr32 
  100f7e:	55                   	push   %ebp
  100f7f:	89 e5                	mov    %esp,%ebp
  100f81:	83 ec 48             	sub    $0x48,%esp
  100f84:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f8a:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f8e:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f92:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f96:	ee                   	out    %al,(%dx)
}
  100f97:	90                   	nop
  100f98:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f9e:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fa2:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100fa6:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100faa:	ee                   	out    %al,(%dx)
}
  100fab:	90                   	nop
  100fac:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100fb2:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fb6:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100fba:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fbe:	ee                   	out    %al,(%dx)
}
  100fbf:	90                   	nop
  100fc0:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fc6:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fca:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fce:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fd2:	ee                   	out    %al,(%dx)
}
  100fd3:	90                   	nop
  100fd4:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fda:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fde:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fe2:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fe6:	ee                   	out    %al,(%dx)
}
  100fe7:	90                   	nop
  100fe8:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fee:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ff2:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ff6:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ffa:	ee                   	out    %al,(%dx)
}
  100ffb:	90                   	nop
  100ffc:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  101002:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101006:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10100a:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10100e:	ee                   	out    %al,(%dx)
}
  10100f:	90                   	nop
  101010:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101016:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  10101a:	89 c2                	mov    %eax,%edx
  10101c:	ec                   	in     (%dx),%al
  10101d:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  101020:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101024:	3c ff                	cmp    $0xff,%al
  101026:	0f 95 c0             	setne  %al
  101029:	0f b6 c0             	movzbl %al,%eax
  10102c:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  101031:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101037:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10103b:	89 c2                	mov    %eax,%edx
  10103d:	ec                   	in     (%dx),%al
  10103e:	88 45 f1             	mov    %al,-0xf(%ebp)
  101041:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101047:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10104b:	89 c2                	mov    %eax,%edx
  10104d:	ec                   	in     (%dx),%al
  10104e:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101051:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101056:	85 c0                	test   %eax,%eax
  101058:	74 0c                	je     101066 <serial_init+0xec>
        pic_enable(IRQ_COM1);
  10105a:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101061:	e8 0b 07 00 00       	call   101771 <pic_enable>
    }
}
  101066:	90                   	nop
  101067:	c9                   	leave  
  101068:	c3                   	ret    

00101069 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101069:	f3 0f 1e fb          	endbr32 
  10106d:	55                   	push   %ebp
  10106e:	89 e5                	mov    %esp,%ebp
  101070:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101073:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10107a:	eb 08                	jmp    101084 <lpt_putc_sub+0x1b>
        delay();
  10107c:	e8 c2 fd ff ff       	call   100e43 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101081:	ff 45 fc             	incl   -0x4(%ebp)
  101084:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10108a:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10108e:	89 c2                	mov    %eax,%edx
  101090:	ec                   	in     (%dx),%al
  101091:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101094:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101098:	84 c0                	test   %al,%al
  10109a:	78 09                	js     1010a5 <lpt_putc_sub+0x3c>
  10109c:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1010a3:	7e d7                	jle    10107c <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  1010a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1010a8:	0f b6 c0             	movzbl %al,%eax
  1010ab:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  1010b1:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010b4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010b8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010bc:	ee                   	out    %al,(%dx)
}
  1010bd:	90                   	nop
  1010be:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010c4:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010c8:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010cc:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010d0:	ee                   	out    %al,(%dx)
}
  1010d1:	90                   	nop
  1010d2:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010d8:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010dc:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010e0:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010e4:	ee                   	out    %al,(%dx)
}
  1010e5:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010e6:	90                   	nop
  1010e7:	c9                   	leave  
  1010e8:	c3                   	ret    

001010e9 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010e9:	f3 0f 1e fb          	endbr32 
  1010ed:	55                   	push   %ebp
  1010ee:	89 e5                	mov    %esp,%ebp
  1010f0:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010f3:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010f7:	74 0d                	je     101106 <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1010fc:	89 04 24             	mov    %eax,(%esp)
  1010ff:	e8 65 ff ff ff       	call   101069 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  101104:	eb 24                	jmp    10112a <lpt_putc+0x41>
        lpt_putc_sub('\b');
  101106:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10110d:	e8 57 ff ff ff       	call   101069 <lpt_putc_sub>
        lpt_putc_sub(' ');
  101112:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101119:	e8 4b ff ff ff       	call   101069 <lpt_putc_sub>
        lpt_putc_sub('\b');
  10111e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101125:	e8 3f ff ff ff       	call   101069 <lpt_putc_sub>
}
  10112a:	90                   	nop
  10112b:	c9                   	leave  
  10112c:	c3                   	ret    

0010112d <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  10112d:	f3 0f 1e fb          	endbr32 
  101131:	55                   	push   %ebp
  101132:	89 e5                	mov    %esp,%ebp
  101134:	53                   	push   %ebx
  101135:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101138:	8b 45 08             	mov    0x8(%ebp),%eax
  10113b:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101140:	85 c0                	test   %eax,%eax
  101142:	75 07                	jne    10114b <cga_putc+0x1e>
        c |= 0x0700;
  101144:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10114b:	8b 45 08             	mov    0x8(%ebp),%eax
  10114e:	0f b6 c0             	movzbl %al,%eax
  101151:	83 f8 0d             	cmp    $0xd,%eax
  101154:	74 72                	je     1011c8 <cga_putc+0x9b>
  101156:	83 f8 0d             	cmp    $0xd,%eax
  101159:	0f 8f a3 00 00 00    	jg     101202 <cga_putc+0xd5>
  10115f:	83 f8 08             	cmp    $0x8,%eax
  101162:	74 0a                	je     10116e <cga_putc+0x41>
  101164:	83 f8 0a             	cmp    $0xa,%eax
  101167:	74 4c                	je     1011b5 <cga_putc+0x88>
  101169:	e9 94 00 00 00       	jmp    101202 <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  10116e:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101175:	85 c0                	test   %eax,%eax
  101177:	0f 84 af 00 00 00    	je     10122c <cga_putc+0xff>
            crt_pos --;
  10117d:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101184:	48                   	dec    %eax
  101185:	0f b7 c0             	movzwl %ax,%eax
  101188:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  10118e:	8b 45 08             	mov    0x8(%ebp),%eax
  101191:	98                   	cwtl   
  101192:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101197:	98                   	cwtl   
  101198:	83 c8 20             	or     $0x20,%eax
  10119b:	98                   	cwtl   
  10119c:	8b 15 60 fe 10 00    	mov    0x10fe60,%edx
  1011a2:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011a9:	01 c9                	add    %ecx,%ecx
  1011ab:	01 ca                	add    %ecx,%edx
  1011ad:	0f b7 c0             	movzwl %ax,%eax
  1011b0:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1011b3:	eb 77                	jmp    10122c <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  1011b5:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011bc:	83 c0 50             	add    $0x50,%eax
  1011bf:	0f b7 c0             	movzwl %ax,%eax
  1011c2:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011c8:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  1011cf:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011d6:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011db:	89 c8                	mov    %ecx,%eax
  1011dd:	f7 e2                	mul    %edx
  1011df:	c1 ea 06             	shr    $0x6,%edx
  1011e2:	89 d0                	mov    %edx,%eax
  1011e4:	c1 e0 02             	shl    $0x2,%eax
  1011e7:	01 d0                	add    %edx,%eax
  1011e9:	c1 e0 04             	shl    $0x4,%eax
  1011ec:	29 c1                	sub    %eax,%ecx
  1011ee:	89 c8                	mov    %ecx,%eax
  1011f0:	0f b7 c0             	movzwl %ax,%eax
  1011f3:	29 c3                	sub    %eax,%ebx
  1011f5:	89 d8                	mov    %ebx,%eax
  1011f7:	0f b7 c0             	movzwl %ax,%eax
  1011fa:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  101200:	eb 2b                	jmp    10122d <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  101202:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  101208:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10120f:	8d 50 01             	lea    0x1(%eax),%edx
  101212:	0f b7 d2             	movzwl %dx,%edx
  101215:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  10121c:	01 c0                	add    %eax,%eax
  10121e:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  101221:	8b 45 08             	mov    0x8(%ebp),%eax
  101224:	0f b7 c0             	movzwl %ax,%eax
  101227:	66 89 02             	mov    %ax,(%edx)
        break;
  10122a:	eb 01                	jmp    10122d <cga_putc+0x100>
        break;
  10122c:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  10122d:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101234:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101239:	76 5d                	jbe    101298 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  10123b:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101240:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101246:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  10124b:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  101252:	00 
  101253:	89 54 24 04          	mov    %edx,0x4(%esp)
  101257:	89 04 24             	mov    %eax,(%esp)
  10125a:	e8 89 1c 00 00       	call   102ee8 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10125f:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101266:	eb 14                	jmp    10127c <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  101268:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  10126d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101270:	01 d2                	add    %edx,%edx
  101272:	01 d0                	add    %edx,%eax
  101274:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101279:	ff 45 f4             	incl   -0xc(%ebp)
  10127c:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101283:	7e e3                	jle    101268 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  101285:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10128c:	83 e8 50             	sub    $0x50,%eax
  10128f:	0f b7 c0             	movzwl %ax,%eax
  101292:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101298:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  10129f:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  1012a3:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012a7:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1012ab:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1012af:	ee                   	out    %al,(%dx)
}
  1012b0:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  1012b1:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012b8:	c1 e8 08             	shr    $0x8,%eax
  1012bb:	0f b7 c0             	movzwl %ax,%eax
  1012be:	0f b6 c0             	movzbl %al,%eax
  1012c1:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012c8:	42                   	inc    %edx
  1012c9:	0f b7 d2             	movzwl %dx,%edx
  1012cc:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012d0:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012d3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012d7:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012db:	ee                   	out    %al,(%dx)
}
  1012dc:	90                   	nop
    outb(addr_6845, 15);
  1012dd:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012e4:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012e8:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012ec:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012f0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012f4:	ee                   	out    %al,(%dx)
}
  1012f5:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012f6:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012fd:	0f b6 c0             	movzbl %al,%eax
  101300:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  101307:	42                   	inc    %edx
  101308:	0f b7 d2             	movzwl %dx,%edx
  10130b:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  10130f:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101312:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101316:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10131a:	ee                   	out    %al,(%dx)
}
  10131b:	90                   	nop
}
  10131c:	90                   	nop
  10131d:	83 c4 34             	add    $0x34,%esp
  101320:	5b                   	pop    %ebx
  101321:	5d                   	pop    %ebp
  101322:	c3                   	ret    

00101323 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101323:	f3 0f 1e fb          	endbr32 
  101327:	55                   	push   %ebp
  101328:	89 e5                	mov    %esp,%ebp
  10132a:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10132d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101334:	eb 08                	jmp    10133e <serial_putc_sub+0x1b>
        delay();
  101336:	e8 08 fb ff ff       	call   100e43 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10133b:	ff 45 fc             	incl   -0x4(%ebp)
  10133e:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101344:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101348:	89 c2                	mov    %eax,%edx
  10134a:	ec                   	in     (%dx),%al
  10134b:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10134e:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101352:	0f b6 c0             	movzbl %al,%eax
  101355:	83 e0 20             	and    $0x20,%eax
  101358:	85 c0                	test   %eax,%eax
  10135a:	75 09                	jne    101365 <serial_putc_sub+0x42>
  10135c:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101363:	7e d1                	jle    101336 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  101365:	8b 45 08             	mov    0x8(%ebp),%eax
  101368:	0f b6 c0             	movzbl %al,%eax
  10136b:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101371:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101374:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101378:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10137c:	ee                   	out    %al,(%dx)
}
  10137d:	90                   	nop
}
  10137e:	90                   	nop
  10137f:	c9                   	leave  
  101380:	c3                   	ret    

00101381 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101381:	f3 0f 1e fb          	endbr32 
  101385:	55                   	push   %ebp
  101386:	89 e5                	mov    %esp,%ebp
  101388:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  10138b:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10138f:	74 0d                	je     10139e <serial_putc+0x1d>
        serial_putc_sub(c);
  101391:	8b 45 08             	mov    0x8(%ebp),%eax
  101394:	89 04 24             	mov    %eax,(%esp)
  101397:	e8 87 ff ff ff       	call   101323 <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10139c:	eb 24                	jmp    1013c2 <serial_putc+0x41>
        serial_putc_sub('\b');
  10139e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1013a5:	e8 79 ff ff ff       	call   101323 <serial_putc_sub>
        serial_putc_sub(' ');
  1013aa:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1013b1:	e8 6d ff ff ff       	call   101323 <serial_putc_sub>
        serial_putc_sub('\b');
  1013b6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1013bd:	e8 61 ff ff ff       	call   101323 <serial_putc_sub>
}
  1013c2:	90                   	nop
  1013c3:	c9                   	leave  
  1013c4:	c3                   	ret    

001013c5 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013c5:	f3 0f 1e fb          	endbr32 
  1013c9:	55                   	push   %ebp
  1013ca:	89 e5                	mov    %esp,%ebp
  1013cc:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013cf:	eb 33                	jmp    101404 <cons_intr+0x3f>
        if (c != 0) {
  1013d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013d5:	74 2d                	je     101404 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013d7:	a1 84 00 11 00       	mov    0x110084,%eax
  1013dc:	8d 50 01             	lea    0x1(%eax),%edx
  1013df:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013e8:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013ee:	a1 84 00 11 00       	mov    0x110084,%eax
  1013f3:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013f8:	75 0a                	jne    101404 <cons_intr+0x3f>
                cons.wpos = 0;
  1013fa:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  101401:	00 00 00 
    while ((c = (*proc)()) != -1) {
  101404:	8b 45 08             	mov    0x8(%ebp),%eax
  101407:	ff d0                	call   *%eax
  101409:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10140c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101410:	75 bf                	jne    1013d1 <cons_intr+0xc>
            }
        }
    }
}
  101412:	90                   	nop
  101413:	90                   	nop
  101414:	c9                   	leave  
  101415:	c3                   	ret    

00101416 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101416:	f3 0f 1e fb          	endbr32 
  10141a:	55                   	push   %ebp
  10141b:	89 e5                	mov    %esp,%ebp
  10141d:	83 ec 10             	sub    $0x10,%esp
  101420:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101426:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10142a:	89 c2                	mov    %eax,%edx
  10142c:	ec                   	in     (%dx),%al
  10142d:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101430:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101434:	0f b6 c0             	movzbl %al,%eax
  101437:	83 e0 01             	and    $0x1,%eax
  10143a:	85 c0                	test   %eax,%eax
  10143c:	75 07                	jne    101445 <serial_proc_data+0x2f>
        return -1;
  10143e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101443:	eb 2a                	jmp    10146f <serial_proc_data+0x59>
  101445:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10144b:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10144f:	89 c2                	mov    %eax,%edx
  101451:	ec                   	in     (%dx),%al
  101452:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101455:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101459:	0f b6 c0             	movzbl %al,%eax
  10145c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  10145f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101463:	75 07                	jne    10146c <serial_proc_data+0x56>
        c = '\b';
  101465:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10146c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10146f:	c9                   	leave  
  101470:	c3                   	ret    

00101471 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101471:	f3 0f 1e fb          	endbr32 
  101475:	55                   	push   %ebp
  101476:	89 e5                	mov    %esp,%ebp
  101478:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  10147b:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101480:	85 c0                	test   %eax,%eax
  101482:	74 0c                	je     101490 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  101484:	c7 04 24 16 14 10 00 	movl   $0x101416,(%esp)
  10148b:	e8 35 ff ff ff       	call   1013c5 <cons_intr>
    }
}
  101490:	90                   	nop
  101491:	c9                   	leave  
  101492:	c3                   	ret    

00101493 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101493:	f3 0f 1e fb          	endbr32 
  101497:	55                   	push   %ebp
  101498:	89 e5                	mov    %esp,%ebp
  10149a:	83 ec 38             	sub    $0x38,%esp
  10149d:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1014a6:	89 c2                	mov    %eax,%edx
  1014a8:	ec                   	in     (%dx),%al
  1014a9:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1014ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1014b0:	0f b6 c0             	movzbl %al,%eax
  1014b3:	83 e0 01             	and    $0x1,%eax
  1014b6:	85 c0                	test   %eax,%eax
  1014b8:	75 0a                	jne    1014c4 <kbd_proc_data+0x31>
        return -1;
  1014ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1014bf:	e9 56 01 00 00       	jmp    10161a <kbd_proc_data+0x187>
  1014c4:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1014cd:	89 c2                	mov    %eax,%edx
  1014cf:	ec                   	in     (%dx),%al
  1014d0:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014d3:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014d7:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014da:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014de:	75 17                	jne    1014f7 <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  1014e0:	a1 88 00 11 00       	mov    0x110088,%eax
  1014e5:	83 c8 40             	or     $0x40,%eax
  1014e8:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014ed:	b8 00 00 00 00       	mov    $0x0,%eax
  1014f2:	e9 23 01 00 00       	jmp    10161a <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014f7:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014fb:	84 c0                	test   %al,%al
  1014fd:	79 45                	jns    101544 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014ff:	a1 88 00 11 00       	mov    0x110088,%eax
  101504:	83 e0 40             	and    $0x40,%eax
  101507:	85 c0                	test   %eax,%eax
  101509:	75 08                	jne    101513 <kbd_proc_data+0x80>
  10150b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10150f:	24 7f                	and    $0x7f,%al
  101511:	eb 04                	jmp    101517 <kbd_proc_data+0x84>
  101513:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101517:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  10151a:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10151e:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101525:	0c 40                	or     $0x40,%al
  101527:	0f b6 c0             	movzbl %al,%eax
  10152a:	f7 d0                	not    %eax
  10152c:	89 c2                	mov    %eax,%edx
  10152e:	a1 88 00 11 00       	mov    0x110088,%eax
  101533:	21 d0                	and    %edx,%eax
  101535:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  10153a:	b8 00 00 00 00       	mov    $0x0,%eax
  10153f:	e9 d6 00 00 00       	jmp    10161a <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  101544:	a1 88 00 11 00       	mov    0x110088,%eax
  101549:	83 e0 40             	and    $0x40,%eax
  10154c:	85 c0                	test   %eax,%eax
  10154e:	74 11                	je     101561 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101550:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101554:	a1 88 00 11 00       	mov    0x110088,%eax
  101559:	83 e0 bf             	and    $0xffffffbf,%eax
  10155c:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  101561:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101565:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  10156c:	0f b6 d0             	movzbl %al,%edx
  10156f:	a1 88 00 11 00       	mov    0x110088,%eax
  101574:	09 d0                	or     %edx,%eax
  101576:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  10157b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10157f:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  101586:	0f b6 d0             	movzbl %al,%edx
  101589:	a1 88 00 11 00       	mov    0x110088,%eax
  10158e:	31 d0                	xor    %edx,%eax
  101590:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  101595:	a1 88 00 11 00       	mov    0x110088,%eax
  10159a:	83 e0 03             	and    $0x3,%eax
  10159d:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  1015a4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1015a8:	01 d0                	add    %edx,%eax
  1015aa:	0f b6 00             	movzbl (%eax),%eax
  1015ad:	0f b6 c0             	movzbl %al,%eax
  1015b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1015b3:	a1 88 00 11 00       	mov    0x110088,%eax
  1015b8:	83 e0 08             	and    $0x8,%eax
  1015bb:	85 c0                	test   %eax,%eax
  1015bd:	74 22                	je     1015e1 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1015bf:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015c3:	7e 0c                	jle    1015d1 <kbd_proc_data+0x13e>
  1015c5:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015c9:	7f 06                	jg     1015d1 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1015cb:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015cf:	eb 10                	jmp    1015e1 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015d1:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015d5:	7e 0a                	jle    1015e1 <kbd_proc_data+0x14e>
  1015d7:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015db:	7f 04                	jg     1015e1 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015dd:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015e1:	a1 88 00 11 00       	mov    0x110088,%eax
  1015e6:	f7 d0                	not    %eax
  1015e8:	83 e0 06             	and    $0x6,%eax
  1015eb:	85 c0                	test   %eax,%eax
  1015ed:	75 28                	jne    101617 <kbd_proc_data+0x184>
  1015ef:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015f6:	75 1f                	jne    101617 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015f8:	c7 04 24 0d 3a 10 00 	movl   $0x103a0d,(%esp)
  1015ff:	e8 90 ec ff ff       	call   100294 <cprintf>
  101604:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  10160a:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10160e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  101612:	8b 55 e8             	mov    -0x18(%ebp),%edx
  101615:	ee                   	out    %al,(%dx)
}
  101616:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101617:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10161a:	c9                   	leave  
  10161b:	c3                   	ret    

0010161c <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  10161c:	f3 0f 1e fb          	endbr32 
  101620:	55                   	push   %ebp
  101621:	89 e5                	mov    %esp,%ebp
  101623:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  101626:	c7 04 24 93 14 10 00 	movl   $0x101493,(%esp)
  10162d:	e8 93 fd ff ff       	call   1013c5 <cons_intr>
}
  101632:	90                   	nop
  101633:	c9                   	leave  
  101634:	c3                   	ret    

00101635 <kbd_init>:

static void
kbd_init(void) {
  101635:	f3 0f 1e fb          	endbr32 
  101639:	55                   	push   %ebp
  10163a:	89 e5                	mov    %esp,%ebp
  10163c:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  10163f:	e8 d8 ff ff ff       	call   10161c <kbd_intr>
    pic_enable(IRQ_KBD);
  101644:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10164b:	e8 21 01 00 00       	call   101771 <pic_enable>
}
  101650:	90                   	nop
  101651:	c9                   	leave  
  101652:	c3                   	ret    

00101653 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101653:	f3 0f 1e fb          	endbr32 
  101657:	55                   	push   %ebp
  101658:	89 e5                	mov    %esp,%ebp
  10165a:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  10165d:	e8 2e f8 ff ff       	call   100e90 <cga_init>
    serial_init();
  101662:	e8 13 f9 ff ff       	call   100f7a <serial_init>
    kbd_init();
  101667:	e8 c9 ff ff ff       	call   101635 <kbd_init>
    if (!serial_exists) {
  10166c:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101671:	85 c0                	test   %eax,%eax
  101673:	75 0c                	jne    101681 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  101675:	c7 04 24 19 3a 10 00 	movl   $0x103a19,(%esp)
  10167c:	e8 13 ec ff ff       	call   100294 <cprintf>
    }
}
  101681:	90                   	nop
  101682:	c9                   	leave  
  101683:	c3                   	ret    

00101684 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101684:	f3 0f 1e fb          	endbr32 
  101688:	55                   	push   %ebp
  101689:	89 e5                	mov    %esp,%ebp
  10168b:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  10168e:	8b 45 08             	mov    0x8(%ebp),%eax
  101691:	89 04 24             	mov    %eax,(%esp)
  101694:	e8 50 fa ff ff       	call   1010e9 <lpt_putc>
    cga_putc(c);
  101699:	8b 45 08             	mov    0x8(%ebp),%eax
  10169c:	89 04 24             	mov    %eax,(%esp)
  10169f:	e8 89 fa ff ff       	call   10112d <cga_putc>
    serial_putc(c);
  1016a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1016a7:	89 04 24             	mov    %eax,(%esp)
  1016aa:	e8 d2 fc ff ff       	call   101381 <serial_putc>
}
  1016af:	90                   	nop
  1016b0:	c9                   	leave  
  1016b1:	c3                   	ret    

001016b2 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1016b2:	f3 0f 1e fb          	endbr32 
  1016b6:	55                   	push   %ebp
  1016b7:	89 e5                	mov    %esp,%ebp
  1016b9:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016bc:	e8 b0 fd ff ff       	call   101471 <serial_intr>
    kbd_intr();
  1016c1:	e8 56 ff ff ff       	call   10161c <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016c6:	8b 15 80 00 11 00    	mov    0x110080,%edx
  1016cc:	a1 84 00 11 00       	mov    0x110084,%eax
  1016d1:	39 c2                	cmp    %eax,%edx
  1016d3:	74 36                	je     10170b <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016d5:	a1 80 00 11 00       	mov    0x110080,%eax
  1016da:	8d 50 01             	lea    0x1(%eax),%edx
  1016dd:	89 15 80 00 11 00    	mov    %edx,0x110080
  1016e3:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  1016ea:	0f b6 c0             	movzbl %al,%eax
  1016ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016f0:	a1 80 00 11 00       	mov    0x110080,%eax
  1016f5:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016fa:	75 0a                	jne    101706 <cons_getc+0x54>
            cons.rpos = 0;
  1016fc:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  101703:	00 00 00 
        }
        return c;
  101706:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101709:	eb 05                	jmp    101710 <cons_getc+0x5e>
    }
    return 0;
  10170b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101710:	c9                   	leave  
  101711:	c3                   	ret    

00101712 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101712:	f3 0f 1e fb          	endbr32 
  101716:	55                   	push   %ebp
  101717:	89 e5                	mov    %esp,%ebp
  101719:	83 ec 14             	sub    $0x14,%esp
  10171c:	8b 45 08             	mov    0x8(%ebp),%eax
  10171f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101723:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101726:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  10172c:	a1 8c 00 11 00       	mov    0x11008c,%eax
  101731:	85 c0                	test   %eax,%eax
  101733:	74 39                	je     10176e <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  101735:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101738:	0f b6 c0             	movzbl %al,%eax
  10173b:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101741:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101744:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101748:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10174c:	ee                   	out    %al,(%dx)
}
  10174d:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  10174e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101752:	c1 e8 08             	shr    $0x8,%eax
  101755:	0f b7 c0             	movzwl %ax,%eax
  101758:	0f b6 c0             	movzbl %al,%eax
  10175b:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101761:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101764:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101768:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10176c:	ee                   	out    %al,(%dx)
}
  10176d:	90                   	nop
    }
}
  10176e:	90                   	nop
  10176f:	c9                   	leave  
  101770:	c3                   	ret    

00101771 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101771:	f3 0f 1e fb          	endbr32 
  101775:	55                   	push   %ebp
  101776:	89 e5                	mov    %esp,%ebp
  101778:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  10177b:	8b 45 08             	mov    0x8(%ebp),%eax
  10177e:	ba 01 00 00 00       	mov    $0x1,%edx
  101783:	88 c1                	mov    %al,%cl
  101785:	d3 e2                	shl    %cl,%edx
  101787:	89 d0                	mov    %edx,%eax
  101789:	98                   	cwtl   
  10178a:	f7 d0                	not    %eax
  10178c:	0f bf d0             	movswl %ax,%edx
  10178f:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  101796:	98                   	cwtl   
  101797:	21 d0                	and    %edx,%eax
  101799:	98                   	cwtl   
  10179a:	0f b7 c0             	movzwl %ax,%eax
  10179d:	89 04 24             	mov    %eax,(%esp)
  1017a0:	e8 6d ff ff ff       	call   101712 <pic_setmask>
}
  1017a5:	90                   	nop
  1017a6:	c9                   	leave  
  1017a7:	c3                   	ret    

001017a8 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1017a8:	f3 0f 1e fb          	endbr32 
  1017ac:	55                   	push   %ebp
  1017ad:	89 e5                	mov    %esp,%ebp
  1017af:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1017b2:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  1017b9:	00 00 00 
  1017bc:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017c2:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017c6:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017ca:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017ce:	ee                   	out    %al,(%dx)
}
  1017cf:	90                   	nop
  1017d0:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017d6:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017da:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017de:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017e2:	ee                   	out    %al,(%dx)
}
  1017e3:	90                   	nop
  1017e4:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017ea:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ee:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017f2:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017f6:	ee                   	out    %al,(%dx)
}
  1017f7:	90                   	nop
  1017f8:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017fe:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101802:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101806:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  10180a:	ee                   	out    %al,(%dx)
}
  10180b:	90                   	nop
  10180c:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  101812:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101816:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  10181a:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  10181e:	ee                   	out    %al,(%dx)
}
  10181f:	90                   	nop
  101820:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101826:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10182a:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10182e:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101832:	ee                   	out    %al,(%dx)
}
  101833:	90                   	nop
  101834:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  10183a:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10183e:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101842:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101846:	ee                   	out    %al,(%dx)
}
  101847:	90                   	nop
  101848:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  10184e:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101852:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101856:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10185a:	ee                   	out    %al,(%dx)
}
  10185b:	90                   	nop
  10185c:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101862:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101866:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  10186a:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10186e:	ee                   	out    %al,(%dx)
}
  10186f:	90                   	nop
  101870:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101876:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10187a:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10187e:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101882:	ee                   	out    %al,(%dx)
}
  101883:	90                   	nop
  101884:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  10188a:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10188e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101892:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101896:	ee                   	out    %al,(%dx)
}
  101897:	90                   	nop
  101898:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  10189e:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018a2:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1018a6:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1018aa:	ee                   	out    %al,(%dx)
}
  1018ab:	90                   	nop
  1018ac:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  1018b2:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018b6:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1018ba:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1018be:	ee                   	out    %al,(%dx)
}
  1018bf:	90                   	nop
  1018c0:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018c6:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018ca:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018ce:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018d2:	ee                   	out    %al,(%dx)
}
  1018d3:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018d4:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018db:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018e0:	74 0f                	je     1018f1 <pic_init+0x149>
        pic_setmask(irq_mask);
  1018e2:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018e9:	89 04 24             	mov    %eax,(%esp)
  1018ec:	e8 21 fe ff ff       	call   101712 <pic_setmask>
    }
}
  1018f1:	90                   	nop
  1018f2:	c9                   	leave  
  1018f3:	c3                   	ret    

001018f4 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018f4:	f3 0f 1e fb          	endbr32 
  1018f8:	55                   	push   %ebp
  1018f9:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018fb:	fb                   	sti    
}
  1018fc:	90                   	nop
    sti();
}
  1018fd:	90                   	nop
  1018fe:	5d                   	pop    %ebp
  1018ff:	c3                   	ret    

00101900 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  101900:	f3 0f 1e fb          	endbr32 
  101904:	55                   	push   %ebp
  101905:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  101907:	fa                   	cli    
}
  101908:	90                   	nop
    cli();
}
  101909:	90                   	nop
  10190a:	5d                   	pop    %ebp
  10190b:	c3                   	ret    

0010190c <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  10190c:	f3 0f 1e fb          	endbr32 
  101910:	55                   	push   %ebp
  101911:	89 e5                	mov    %esp,%ebp
  101913:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101916:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  10191d:	00 
  10191e:	c7 04 24 40 3a 10 00 	movl   $0x103a40,(%esp)
  101925:	e8 6a e9 ff ff       	call   100294 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  10192a:	c7 04 24 4a 3a 10 00 	movl   $0x103a4a,(%esp)
  101931:	e8 5e e9 ff ff       	call   100294 <cprintf>
    panic("EOT: kernel seems ok.");
  101936:	c7 44 24 08 58 3a 10 	movl   $0x103a58,0x8(%esp)
  10193d:	00 
  10193e:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  101945:	00 
  101946:	c7 04 24 6e 3a 10 00 	movl   $0x103a6e,(%esp)
  10194d:	e8 ae ea ff ff       	call   100400 <__panic>

00101952 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101952:	f3 0f 1e fb          	endbr32 
  101956:	55                   	push   %ebp
  101957:	89 e5                	mov    %esp,%ebp
  101959:	83 ec 10             	sub    $0x10,%esp
    extern uintptr_t __vectors[]; //_vevtors数组保存在vectors.S中的256个中断处理例程的入口地址

    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
  10195c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101963:	e9 ca 00 00 00       	jmp    101a32 <idt_init+0xe0>
        SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);
  101968:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196b:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101972:	0f b7 d0             	movzwl %ax,%edx
  101975:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101978:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  10197f:	00 
  101980:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101983:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  10198a:	00 08 00 
  10198d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101990:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101997:	00 
  101998:	80 e2 e0             	and    $0xe0,%dl
  10199b:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  1019a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019a5:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  1019ac:	00 
  1019ad:	80 e2 1f             	and    $0x1f,%dl
  1019b0:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  1019b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ba:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019c1:	00 
  1019c2:	80 e2 f0             	and    $0xf0,%dl
  1019c5:	80 ca 0e             	or     $0xe,%dl
  1019c8:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d2:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019d9:	00 
  1019da:	80 e2 ef             	and    $0xef,%dl
  1019dd:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e7:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019ee:	00 
  1019ef:	80 e2 9f             	and    $0x9f,%dl
  1019f2:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019fc:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  101a03:	00 
  101a04:	80 ca 80             	or     $0x80,%dl
  101a07:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  101a0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a11:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101a18:	c1 e8 10             	shr    $0x10,%eax
  101a1b:	0f b7 d0             	movzwl %ax,%edx
  101a1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a21:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  101a28:	00 
    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
  101a29:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a2c:	83 c0 08             	add    $0x8,%eax
  101a2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101a32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a35:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  101a3a:	0f 86 28 ff ff ff    	jbe    101968 <idt_init+0x16>
 /*循环调用SETGATE函数对中断门idt[i]依次进行初始化
   其中第一个参数为初始化模板idt[i]；第二个参数为0，表示中断门；第三个参数GD_KTEXT为内核代码段的起始地址；第四个参数_vector[i]为中断处理例程的入口地址；第五个参数表示内核权限\*/
    SETGATE(idt[T_SWITCH_TOK],0,GD_KTEXT,__vectors[T_SWITCH_TOK],DPL_USER);
  101a40:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a45:	0f b7 c0             	movzwl %ax,%eax
  101a48:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a4e:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a55:	08 00 
  101a57:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a5e:	24 e0                	and    $0xe0,%al
  101a60:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a65:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a6c:	24 1f                	and    $0x1f,%al
  101a6e:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a73:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a7a:	24 f0                	and    $0xf0,%al
  101a7c:	0c 0e                	or     $0xe,%al
  101a7e:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a83:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a8a:	24 ef                	and    $0xef,%al
  101a8c:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a91:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a98:	0c 60                	or     $0x60,%al
  101a9a:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a9f:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101aa6:	0c 80                	or     $0x80,%al
  101aa8:	a2 6d 04 11 00       	mov    %al,0x11046d
  101aad:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101ab2:	c1 e8 10             	shr    $0x10,%eax
  101ab5:	0f b7 c0             	movzwl %ax,%eax
  101ab8:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101abe:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101ac5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101ac8:	0f 01 18             	lidtl  (%eax)
}
  101acb:	90                   	nop

    lidt(&idt_pd);
//加载idt中断描述符表，并将&idt_pd的首地址加载到IDTR中
}
  101acc:	90                   	nop
  101acd:	c9                   	leave  
  101ace:	c3                   	ret    

00101acf <trapname>:

static const char *
trapname(int trapno) {
  101acf:	f3 0f 1e fb          	endbr32 
  101ad3:	55                   	push   %ebp
  101ad4:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad9:	83 f8 13             	cmp    $0x13,%eax
  101adc:	77 0c                	ja     101aea <trapname+0x1b>
        return excnames[trapno];
  101ade:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae1:	8b 04 85 c0 3d 10 00 	mov    0x103dc0(,%eax,4),%eax
  101ae8:	eb 18                	jmp    101b02 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101aea:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101aee:	7e 0d                	jle    101afd <trapname+0x2e>
  101af0:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101af4:	7f 07                	jg     101afd <trapname+0x2e>
        return "Hardware Interrupt";
  101af6:	b8 7f 3a 10 00       	mov    $0x103a7f,%eax
  101afb:	eb 05                	jmp    101b02 <trapname+0x33>
    }
    return "(unknown trap)";
  101afd:	b8 92 3a 10 00       	mov    $0x103a92,%eax
}
  101b02:	5d                   	pop    %ebp
  101b03:	c3                   	ret    

00101b04 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101b04:	f3 0f 1e fb          	endbr32 
  101b08:	55                   	push   %ebp
  101b09:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b0e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b12:	83 f8 08             	cmp    $0x8,%eax
  101b15:	0f 94 c0             	sete   %al
  101b18:	0f b6 c0             	movzbl %al,%eax
}
  101b1b:	5d                   	pop    %ebp
  101b1c:	c3                   	ret    

00101b1d <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101b1d:	f3 0f 1e fb          	endbr32 
  101b21:	55                   	push   %ebp
  101b22:	89 e5                	mov    %esp,%ebp
  101b24:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101b27:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b2e:	c7 04 24 d3 3a 10 00 	movl   $0x103ad3,(%esp)
  101b35:	e8 5a e7 ff ff       	call   100294 <cprintf>
    print_regs(&tf->tf_regs);
  101b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b3d:	89 04 24             	mov    %eax,(%esp)
  101b40:	e8 8d 01 00 00       	call   101cd2 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b45:	8b 45 08             	mov    0x8(%ebp),%eax
  101b48:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b4c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b50:	c7 04 24 e4 3a 10 00 	movl   $0x103ae4,(%esp)
  101b57:	e8 38 e7 ff ff       	call   100294 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b5f:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b63:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b67:	c7 04 24 f7 3a 10 00 	movl   $0x103af7,(%esp)
  101b6e:	e8 21 e7 ff ff       	call   100294 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b73:	8b 45 08             	mov    0x8(%ebp),%eax
  101b76:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b7e:	c7 04 24 0a 3b 10 00 	movl   $0x103b0a,(%esp)
  101b85:	e8 0a e7 ff ff       	call   100294 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b8d:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b91:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b95:	c7 04 24 1d 3b 10 00 	movl   $0x103b1d,(%esp)
  101b9c:	e8 f3 e6 ff ff       	call   100294 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ba4:	8b 40 30             	mov    0x30(%eax),%eax
  101ba7:	89 04 24             	mov    %eax,(%esp)
  101baa:	e8 20 ff ff ff       	call   101acf <trapname>
  101baf:	8b 55 08             	mov    0x8(%ebp),%edx
  101bb2:	8b 52 30             	mov    0x30(%edx),%edx
  101bb5:	89 44 24 08          	mov    %eax,0x8(%esp)
  101bb9:	89 54 24 04          	mov    %edx,0x4(%esp)
  101bbd:	c7 04 24 30 3b 10 00 	movl   $0x103b30,(%esp)
  101bc4:	e8 cb e6 ff ff       	call   100294 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bcc:	8b 40 34             	mov    0x34(%eax),%eax
  101bcf:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd3:	c7 04 24 42 3b 10 00 	movl   $0x103b42,(%esp)
  101bda:	e8 b5 e6 ff ff       	call   100294 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  101be2:	8b 40 38             	mov    0x38(%eax),%eax
  101be5:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be9:	c7 04 24 51 3b 10 00 	movl   $0x103b51,(%esp)
  101bf0:	e8 9f e6 ff ff       	call   100294 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  101bf8:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bfc:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c00:	c7 04 24 60 3b 10 00 	movl   $0x103b60,(%esp)
  101c07:	e8 88 e6 ff ff       	call   100294 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c0f:	8b 40 40             	mov    0x40(%eax),%eax
  101c12:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c16:	c7 04 24 73 3b 10 00 	movl   $0x103b73,(%esp)
  101c1d:	e8 72 e6 ff ff       	call   100294 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c29:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c30:	eb 3d                	jmp    101c6f <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c32:	8b 45 08             	mov    0x8(%ebp),%eax
  101c35:	8b 50 40             	mov    0x40(%eax),%edx
  101c38:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c3b:	21 d0                	and    %edx,%eax
  101c3d:	85 c0                	test   %eax,%eax
  101c3f:	74 28                	je     101c69 <print_trapframe+0x14c>
  101c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c44:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c4b:	85 c0                	test   %eax,%eax
  101c4d:	74 1a                	je     101c69 <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c52:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c59:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c5d:	c7 04 24 82 3b 10 00 	movl   $0x103b82,(%esp)
  101c64:	e8 2b e6 ff ff       	call   100294 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c69:	ff 45 f4             	incl   -0xc(%ebp)
  101c6c:	d1 65 f0             	shll   -0x10(%ebp)
  101c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c72:	83 f8 17             	cmp    $0x17,%eax
  101c75:	76 bb                	jbe    101c32 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c77:	8b 45 08             	mov    0x8(%ebp),%eax
  101c7a:	8b 40 40             	mov    0x40(%eax),%eax
  101c7d:	c1 e8 0c             	shr    $0xc,%eax
  101c80:	83 e0 03             	and    $0x3,%eax
  101c83:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c87:	c7 04 24 86 3b 10 00 	movl   $0x103b86,(%esp)
  101c8e:	e8 01 e6 ff ff       	call   100294 <cprintf>

    if (!trap_in_kernel(tf)) {
  101c93:	8b 45 08             	mov    0x8(%ebp),%eax
  101c96:	89 04 24             	mov    %eax,(%esp)
  101c99:	e8 66 fe ff ff       	call   101b04 <trap_in_kernel>
  101c9e:	85 c0                	test   %eax,%eax
  101ca0:	75 2d                	jne    101ccf <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ca5:	8b 40 44             	mov    0x44(%eax),%eax
  101ca8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cac:	c7 04 24 8f 3b 10 00 	movl   $0x103b8f,(%esp)
  101cb3:	e8 dc e5 ff ff       	call   100294 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101cbb:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101cbf:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cc3:	c7 04 24 9e 3b 10 00 	movl   $0x103b9e,(%esp)
  101cca:	e8 c5 e5 ff ff       	call   100294 <cprintf>
    }
}
  101ccf:	90                   	nop
  101cd0:	c9                   	leave  
  101cd1:	c3                   	ret    

00101cd2 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101cd2:	f3 0f 1e fb          	endbr32 
  101cd6:	55                   	push   %ebp
  101cd7:	89 e5                	mov    %esp,%ebp
  101cd9:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  101cdf:	8b 00                	mov    (%eax),%eax
  101ce1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce5:	c7 04 24 b1 3b 10 00 	movl   $0x103bb1,(%esp)
  101cec:	e8 a3 e5 ff ff       	call   100294 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf4:	8b 40 04             	mov    0x4(%eax),%eax
  101cf7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cfb:	c7 04 24 c0 3b 10 00 	movl   $0x103bc0,(%esp)
  101d02:	e8 8d e5 ff ff       	call   100294 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101d07:	8b 45 08             	mov    0x8(%ebp),%eax
  101d0a:	8b 40 08             	mov    0x8(%eax),%eax
  101d0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d11:	c7 04 24 cf 3b 10 00 	movl   $0x103bcf,(%esp)
  101d18:	e8 77 e5 ff ff       	call   100294 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  101d20:	8b 40 0c             	mov    0xc(%eax),%eax
  101d23:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d27:	c7 04 24 de 3b 10 00 	movl   $0x103bde,(%esp)
  101d2e:	e8 61 e5 ff ff       	call   100294 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d33:	8b 45 08             	mov    0x8(%ebp),%eax
  101d36:	8b 40 10             	mov    0x10(%eax),%eax
  101d39:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d3d:	c7 04 24 ed 3b 10 00 	movl   $0x103bed,(%esp)
  101d44:	e8 4b e5 ff ff       	call   100294 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d49:	8b 45 08             	mov    0x8(%ebp),%eax
  101d4c:	8b 40 14             	mov    0x14(%eax),%eax
  101d4f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d53:	c7 04 24 fc 3b 10 00 	movl   $0x103bfc,(%esp)
  101d5a:	e8 35 e5 ff ff       	call   100294 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d5f:	8b 45 08             	mov    0x8(%ebp),%eax
  101d62:	8b 40 18             	mov    0x18(%eax),%eax
  101d65:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d69:	c7 04 24 0b 3c 10 00 	movl   $0x103c0b,(%esp)
  101d70:	e8 1f e5 ff ff       	call   100294 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d75:	8b 45 08             	mov    0x8(%ebp),%eax
  101d78:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d7b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d7f:	c7 04 24 1a 3c 10 00 	movl   $0x103c1a,(%esp)
  101d86:	e8 09 e5 ff ff       	call   100294 <cprintf>
}
  101d8b:	90                   	nop
  101d8c:	c9                   	leave  
  101d8d:	c3                   	ret    

00101d8e <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d8e:	f3 0f 1e fb          	endbr32 
  101d92:	55                   	push   %ebp
  101d93:	89 e5                	mov    %esp,%ebp
  101d95:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101d98:	8b 45 08             	mov    0x8(%ebp),%eax
  101d9b:	8b 40 30             	mov    0x30(%eax),%eax
  101d9e:	83 f8 79             	cmp    $0x79,%eax
  101da1:	0f 84 4a 01 00 00    	je     101ef1 <trap_dispatch+0x163>
  101da7:	83 f8 79             	cmp    $0x79,%eax
  101daa:	0f 87 82 01 00 00    	ja     101f32 <trap_dispatch+0x1a4>
  101db0:	83 f8 78             	cmp    $0x78,%eax
  101db3:	0f 84 da 00 00 00    	je     101e93 <trap_dispatch+0x105>
  101db9:	83 f8 78             	cmp    $0x78,%eax
  101dbc:	0f 87 70 01 00 00    	ja     101f32 <trap_dispatch+0x1a4>
  101dc2:	83 f8 2f             	cmp    $0x2f,%eax
  101dc5:	0f 87 67 01 00 00    	ja     101f32 <trap_dispatch+0x1a4>
  101dcb:	83 f8 2e             	cmp    $0x2e,%eax
  101dce:	0f 83 93 01 00 00    	jae    101f67 <trap_dispatch+0x1d9>
  101dd4:	83 f8 24             	cmp    $0x24,%eax
  101dd7:	74 68                	je     101e41 <trap_dispatch+0xb3>
  101dd9:	83 f8 24             	cmp    $0x24,%eax
  101ddc:	0f 87 50 01 00 00    	ja     101f32 <trap_dispatch+0x1a4>
  101de2:	83 f8 20             	cmp    $0x20,%eax
  101de5:	74 0a                	je     101df1 <trap_dispatch+0x63>
  101de7:	83 f8 21             	cmp    $0x21,%eax
  101dea:	74 7e                	je     101e6a <trap_dispatch+0xdc>
  101dec:	e9 41 01 00 00       	jmp    101f32 <trap_dispatch+0x1a4>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
 ticks ++;
  101df1:	a1 08 09 11 00       	mov    0x110908,%eax
  101df6:	40                   	inc    %eax
  101df7:	a3 08 09 11 00       	mov    %eax,0x110908
        if (ticks % TICK_NUM == 0) {
  101dfc:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101e02:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101e07:	89 c8                	mov    %ecx,%eax
  101e09:	f7 e2                	mul    %edx
  101e0b:	c1 ea 05             	shr    $0x5,%edx
  101e0e:	89 d0                	mov    %edx,%eax
  101e10:	c1 e0 02             	shl    $0x2,%eax
  101e13:	01 d0                	add    %edx,%eax
  101e15:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101e1c:	01 d0                	add    %edx,%eax
  101e1e:	c1 e0 02             	shl    $0x2,%eax
  101e21:	29 c1                	sub    %eax,%ecx
  101e23:	89 ca                	mov    %ecx,%edx
  101e25:	85 d2                	test   %edx,%edx
  101e27:	0f 85 3d 01 00 00    	jne    101f6a <trap_dispatch+0x1dc>
            print_ticks();
  101e2d:	e8 da fa ff ff       	call   10190c <print_ticks>
ticks=0;
  101e32:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  101e39:	00 00 00 
        }
        break;
  101e3c:	e9 29 01 00 00       	jmp    101f6a <trap_dispatch+0x1dc>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e41:	e8 6c f8 ff ff       	call   1016b2 <cons_getc>
  101e46:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e49:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e4d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e51:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e55:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e59:	c7 04 24 29 3c 10 00 	movl   $0x103c29,(%esp)
  101e60:	e8 2f e4 ff ff       	call   100294 <cprintf>
        break;
  101e65:	e9 07 01 00 00       	jmp    101f71 <trap_dispatch+0x1e3>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e6a:	e8 43 f8 ff ff       	call   1016b2 <cons_getc>
  101e6f:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e72:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e76:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e7a:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e7e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e82:	c7 04 24 3b 3c 10 00 	movl   $0x103c3b,(%esp)
  101e89:	e8 06 e4 ff ff       	call   100294 <cprintf>
        break;
  101e8e:	e9 de 00 00 00       	jmp    101f71 <trap_dispatch+0x1e3>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) { //要保证自己再对应的模式中
  101e93:	8b 45 08             	mov    0x8(%ebp),%eax
  101e96:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e9a:	83 f8 1b             	cmp    $0x1b,%eax
  101e9d:	0f 84 ca 00 00 00    	je     101f6d <trap_dispatch+0x1df>
            tf->tf_cs = USER_CS;
  101ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea6:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
  101eac:	8b 45 08             	mov    0x8(%ebp),%eax
  101eaf:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb8:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebf:	66 89 50 28          	mov    %dx,0x28(%eax)
  101ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ec6:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101eca:	8b 45 08             	mov    0x8(%ebp),%eax
  101ecd:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags |= FL_IOPL_MASK;
  101ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ed4:	8b 40 40             	mov    0x40(%eax),%eax
  101ed7:	0d 00 30 00 00       	or     $0x3000,%eax
  101edc:	89 c2                	mov    %eax,%edx
  101ede:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee1:	89 50 40             	mov    %edx,0x40(%eax)
            print_trapframe(tf);
  101ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee7:	89 04 24             	mov    %eax,(%esp)
  101eea:	e8 2e fc ff ff       	call   101b1d <print_trapframe>
        }
        break;
  101eef:	eb 7c                	jmp    101f6d <trap_dispatch+0x1df>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef4:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ef8:	83 f8 08             	cmp    $0x8,%eax
  101efb:	74 73                	je     101f70 <trap_dispatch+0x1e2>
            tf->tf_cs = KERNEL_CS;
  101efd:	8b 45 08             	mov    0x8(%ebp),%eax
  101f00:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101f06:	8b 45 08             	mov    0x8(%ebp),%eax
  101f09:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  101f12:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101f16:	8b 45 08             	mov    0x8(%ebp),%eax
  101f19:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  101f20:	8b 40 40             	mov    0x40(%eax),%eax
  101f23:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101f28:	89 c2                	mov    %eax,%edx
  101f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f2d:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101f30:	eb 3e                	jmp    101f70 <trap_dispatch+0x1e2>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101f32:	8b 45 08             	mov    0x8(%ebp),%eax
  101f35:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f39:	83 e0 03             	and    $0x3,%eax
  101f3c:	85 c0                	test   %eax,%eax
  101f3e:	75 31                	jne    101f71 <trap_dispatch+0x1e3>
            print_trapframe(tf);
  101f40:	8b 45 08             	mov    0x8(%ebp),%eax
  101f43:	89 04 24             	mov    %eax,(%esp)
  101f46:	e8 d2 fb ff ff       	call   101b1d <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f4b:	c7 44 24 08 4a 3c 10 	movl   $0x103c4a,0x8(%esp)
  101f52:	00 
  101f53:	c7 44 24 04 bb 00 00 	movl   $0xbb,0x4(%esp)
  101f5a:	00 
  101f5b:	c7 04 24 6e 3a 10 00 	movl   $0x103a6e,(%esp)
  101f62:	e8 99 e4 ff ff       	call   100400 <__panic>
        break;
  101f67:	90                   	nop
  101f68:	eb 07                	jmp    101f71 <trap_dispatch+0x1e3>
        break;
  101f6a:	90                   	nop
  101f6b:	eb 04                	jmp    101f71 <trap_dispatch+0x1e3>
        break;
  101f6d:	90                   	nop
  101f6e:	eb 01                	jmp    101f71 <trap_dispatch+0x1e3>
        break;
  101f70:	90                   	nop
        }
    }
}
  101f71:	90                   	nop
  101f72:	c9                   	leave  
  101f73:	c3                   	ret    

00101f74 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f74:	f3 0f 1e fb          	endbr32 
  101f78:	55                   	push   %ebp
  101f79:	89 e5                	mov    %esp,%ebp
  101f7b:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f81:	89 04 24             	mov    %eax,(%esp)
  101f84:	e8 05 fe ff ff       	call   101d8e <trap_dispatch>
}
  101f89:	90                   	nop
  101f8a:	c9                   	leave  
  101f8b:	c3                   	ret    

00101f8c <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f8c:	6a 00                	push   $0x0
  pushl $0
  101f8e:	6a 00                	push   $0x0
  jmp __alltraps
  101f90:	e9 69 0a 00 00       	jmp    1029fe <__alltraps>

00101f95 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f95:	6a 00                	push   $0x0
  pushl $1
  101f97:	6a 01                	push   $0x1
  jmp __alltraps
  101f99:	e9 60 0a 00 00       	jmp    1029fe <__alltraps>

00101f9e <vector2>:
.globl vector2
vector2:
  pushl $0
  101f9e:	6a 00                	push   $0x0
  pushl $2
  101fa0:	6a 02                	push   $0x2
  jmp __alltraps
  101fa2:	e9 57 0a 00 00       	jmp    1029fe <__alltraps>

00101fa7 <vector3>:
.globl vector3
vector3:
  pushl $0
  101fa7:	6a 00                	push   $0x0
  pushl $3
  101fa9:	6a 03                	push   $0x3
  jmp __alltraps
  101fab:	e9 4e 0a 00 00       	jmp    1029fe <__alltraps>

00101fb0 <vector4>:
.globl vector4
vector4:
  pushl $0
  101fb0:	6a 00                	push   $0x0
  pushl $4
  101fb2:	6a 04                	push   $0x4
  jmp __alltraps
  101fb4:	e9 45 0a 00 00       	jmp    1029fe <__alltraps>

00101fb9 <vector5>:
.globl vector5
vector5:
  pushl $0
  101fb9:	6a 00                	push   $0x0
  pushl $5
  101fbb:	6a 05                	push   $0x5
  jmp __alltraps
  101fbd:	e9 3c 0a 00 00       	jmp    1029fe <__alltraps>

00101fc2 <vector6>:
.globl vector6
vector6:
  pushl $0
  101fc2:	6a 00                	push   $0x0
  pushl $6
  101fc4:	6a 06                	push   $0x6
  jmp __alltraps
  101fc6:	e9 33 0a 00 00       	jmp    1029fe <__alltraps>

00101fcb <vector7>:
.globl vector7
vector7:
  pushl $0
  101fcb:	6a 00                	push   $0x0
  pushl $7
  101fcd:	6a 07                	push   $0x7
  jmp __alltraps
  101fcf:	e9 2a 0a 00 00       	jmp    1029fe <__alltraps>

00101fd4 <vector8>:
.globl vector8
vector8:
  pushl $8
  101fd4:	6a 08                	push   $0x8
  jmp __alltraps
  101fd6:	e9 23 0a 00 00       	jmp    1029fe <__alltraps>

00101fdb <vector9>:
.globl vector9
vector9:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $9
  101fdd:	6a 09                	push   $0x9
  jmp __alltraps
  101fdf:	e9 1a 0a 00 00       	jmp    1029fe <__alltraps>

00101fe4 <vector10>:
.globl vector10
vector10:
  pushl $10
  101fe4:	6a 0a                	push   $0xa
  jmp __alltraps
  101fe6:	e9 13 0a 00 00       	jmp    1029fe <__alltraps>

00101feb <vector11>:
.globl vector11
vector11:
  pushl $11
  101feb:	6a 0b                	push   $0xb
  jmp __alltraps
  101fed:	e9 0c 0a 00 00       	jmp    1029fe <__alltraps>

00101ff2 <vector12>:
.globl vector12
vector12:
  pushl $12
  101ff2:	6a 0c                	push   $0xc
  jmp __alltraps
  101ff4:	e9 05 0a 00 00       	jmp    1029fe <__alltraps>

00101ff9 <vector13>:
.globl vector13
vector13:
  pushl $13
  101ff9:	6a 0d                	push   $0xd
  jmp __alltraps
  101ffb:	e9 fe 09 00 00       	jmp    1029fe <__alltraps>

00102000 <vector14>:
.globl vector14
vector14:
  pushl $14
  102000:	6a 0e                	push   $0xe
  jmp __alltraps
  102002:	e9 f7 09 00 00       	jmp    1029fe <__alltraps>

00102007 <vector15>:
.globl vector15
vector15:
  pushl $0
  102007:	6a 00                	push   $0x0
  pushl $15
  102009:	6a 0f                	push   $0xf
  jmp __alltraps
  10200b:	e9 ee 09 00 00       	jmp    1029fe <__alltraps>

00102010 <vector16>:
.globl vector16
vector16:
  pushl $0
  102010:	6a 00                	push   $0x0
  pushl $16
  102012:	6a 10                	push   $0x10
  jmp __alltraps
  102014:	e9 e5 09 00 00       	jmp    1029fe <__alltraps>

00102019 <vector17>:
.globl vector17
vector17:
  pushl $17
  102019:	6a 11                	push   $0x11
  jmp __alltraps
  10201b:	e9 de 09 00 00       	jmp    1029fe <__alltraps>

00102020 <vector18>:
.globl vector18
vector18:
  pushl $0
  102020:	6a 00                	push   $0x0
  pushl $18
  102022:	6a 12                	push   $0x12
  jmp __alltraps
  102024:	e9 d5 09 00 00       	jmp    1029fe <__alltraps>

00102029 <vector19>:
.globl vector19
vector19:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $19
  10202b:	6a 13                	push   $0x13
  jmp __alltraps
  10202d:	e9 cc 09 00 00       	jmp    1029fe <__alltraps>

00102032 <vector20>:
.globl vector20
vector20:
  pushl $0
  102032:	6a 00                	push   $0x0
  pushl $20
  102034:	6a 14                	push   $0x14
  jmp __alltraps
  102036:	e9 c3 09 00 00       	jmp    1029fe <__alltraps>

0010203b <vector21>:
.globl vector21
vector21:
  pushl $0
  10203b:	6a 00                	push   $0x0
  pushl $21
  10203d:	6a 15                	push   $0x15
  jmp __alltraps
  10203f:	e9 ba 09 00 00       	jmp    1029fe <__alltraps>

00102044 <vector22>:
.globl vector22
vector22:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $22
  102046:	6a 16                	push   $0x16
  jmp __alltraps
  102048:	e9 b1 09 00 00       	jmp    1029fe <__alltraps>

0010204d <vector23>:
.globl vector23
vector23:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $23
  10204f:	6a 17                	push   $0x17
  jmp __alltraps
  102051:	e9 a8 09 00 00       	jmp    1029fe <__alltraps>

00102056 <vector24>:
.globl vector24
vector24:
  pushl $0
  102056:	6a 00                	push   $0x0
  pushl $24
  102058:	6a 18                	push   $0x18
  jmp __alltraps
  10205a:	e9 9f 09 00 00       	jmp    1029fe <__alltraps>

0010205f <vector25>:
.globl vector25
vector25:
  pushl $0
  10205f:	6a 00                	push   $0x0
  pushl $25
  102061:	6a 19                	push   $0x19
  jmp __alltraps
  102063:	e9 96 09 00 00       	jmp    1029fe <__alltraps>

00102068 <vector26>:
.globl vector26
vector26:
  pushl $0
  102068:	6a 00                	push   $0x0
  pushl $26
  10206a:	6a 1a                	push   $0x1a
  jmp __alltraps
  10206c:	e9 8d 09 00 00       	jmp    1029fe <__alltraps>

00102071 <vector27>:
.globl vector27
vector27:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $27
  102073:	6a 1b                	push   $0x1b
  jmp __alltraps
  102075:	e9 84 09 00 00       	jmp    1029fe <__alltraps>

0010207a <vector28>:
.globl vector28
vector28:
  pushl $0
  10207a:	6a 00                	push   $0x0
  pushl $28
  10207c:	6a 1c                	push   $0x1c
  jmp __alltraps
  10207e:	e9 7b 09 00 00       	jmp    1029fe <__alltraps>

00102083 <vector29>:
.globl vector29
vector29:
  pushl $0
  102083:	6a 00                	push   $0x0
  pushl $29
  102085:	6a 1d                	push   $0x1d
  jmp __alltraps
  102087:	e9 72 09 00 00       	jmp    1029fe <__alltraps>

0010208c <vector30>:
.globl vector30
vector30:
  pushl $0
  10208c:	6a 00                	push   $0x0
  pushl $30
  10208e:	6a 1e                	push   $0x1e
  jmp __alltraps
  102090:	e9 69 09 00 00       	jmp    1029fe <__alltraps>

00102095 <vector31>:
.globl vector31
vector31:
  pushl $0
  102095:	6a 00                	push   $0x0
  pushl $31
  102097:	6a 1f                	push   $0x1f
  jmp __alltraps
  102099:	e9 60 09 00 00       	jmp    1029fe <__alltraps>

0010209e <vector32>:
.globl vector32
vector32:
  pushl $0
  10209e:	6a 00                	push   $0x0
  pushl $32
  1020a0:	6a 20                	push   $0x20
  jmp __alltraps
  1020a2:	e9 57 09 00 00       	jmp    1029fe <__alltraps>

001020a7 <vector33>:
.globl vector33
vector33:
  pushl $0
  1020a7:	6a 00                	push   $0x0
  pushl $33
  1020a9:	6a 21                	push   $0x21
  jmp __alltraps
  1020ab:	e9 4e 09 00 00       	jmp    1029fe <__alltraps>

001020b0 <vector34>:
.globl vector34
vector34:
  pushl $0
  1020b0:	6a 00                	push   $0x0
  pushl $34
  1020b2:	6a 22                	push   $0x22
  jmp __alltraps
  1020b4:	e9 45 09 00 00       	jmp    1029fe <__alltraps>

001020b9 <vector35>:
.globl vector35
vector35:
  pushl $0
  1020b9:	6a 00                	push   $0x0
  pushl $35
  1020bb:	6a 23                	push   $0x23
  jmp __alltraps
  1020bd:	e9 3c 09 00 00       	jmp    1029fe <__alltraps>

001020c2 <vector36>:
.globl vector36
vector36:
  pushl $0
  1020c2:	6a 00                	push   $0x0
  pushl $36
  1020c4:	6a 24                	push   $0x24
  jmp __alltraps
  1020c6:	e9 33 09 00 00       	jmp    1029fe <__alltraps>

001020cb <vector37>:
.globl vector37
vector37:
  pushl $0
  1020cb:	6a 00                	push   $0x0
  pushl $37
  1020cd:	6a 25                	push   $0x25
  jmp __alltraps
  1020cf:	e9 2a 09 00 00       	jmp    1029fe <__alltraps>

001020d4 <vector38>:
.globl vector38
vector38:
  pushl $0
  1020d4:	6a 00                	push   $0x0
  pushl $38
  1020d6:	6a 26                	push   $0x26
  jmp __alltraps
  1020d8:	e9 21 09 00 00       	jmp    1029fe <__alltraps>

001020dd <vector39>:
.globl vector39
vector39:
  pushl $0
  1020dd:	6a 00                	push   $0x0
  pushl $39
  1020df:	6a 27                	push   $0x27
  jmp __alltraps
  1020e1:	e9 18 09 00 00       	jmp    1029fe <__alltraps>

001020e6 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020e6:	6a 00                	push   $0x0
  pushl $40
  1020e8:	6a 28                	push   $0x28
  jmp __alltraps
  1020ea:	e9 0f 09 00 00       	jmp    1029fe <__alltraps>

001020ef <vector41>:
.globl vector41
vector41:
  pushl $0
  1020ef:	6a 00                	push   $0x0
  pushl $41
  1020f1:	6a 29                	push   $0x29
  jmp __alltraps
  1020f3:	e9 06 09 00 00       	jmp    1029fe <__alltraps>

001020f8 <vector42>:
.globl vector42
vector42:
  pushl $0
  1020f8:	6a 00                	push   $0x0
  pushl $42
  1020fa:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020fc:	e9 fd 08 00 00       	jmp    1029fe <__alltraps>

00102101 <vector43>:
.globl vector43
vector43:
  pushl $0
  102101:	6a 00                	push   $0x0
  pushl $43
  102103:	6a 2b                	push   $0x2b
  jmp __alltraps
  102105:	e9 f4 08 00 00       	jmp    1029fe <__alltraps>

0010210a <vector44>:
.globl vector44
vector44:
  pushl $0
  10210a:	6a 00                	push   $0x0
  pushl $44
  10210c:	6a 2c                	push   $0x2c
  jmp __alltraps
  10210e:	e9 eb 08 00 00       	jmp    1029fe <__alltraps>

00102113 <vector45>:
.globl vector45
vector45:
  pushl $0
  102113:	6a 00                	push   $0x0
  pushl $45
  102115:	6a 2d                	push   $0x2d
  jmp __alltraps
  102117:	e9 e2 08 00 00       	jmp    1029fe <__alltraps>

0010211c <vector46>:
.globl vector46
vector46:
  pushl $0
  10211c:	6a 00                	push   $0x0
  pushl $46
  10211e:	6a 2e                	push   $0x2e
  jmp __alltraps
  102120:	e9 d9 08 00 00       	jmp    1029fe <__alltraps>

00102125 <vector47>:
.globl vector47
vector47:
  pushl $0
  102125:	6a 00                	push   $0x0
  pushl $47
  102127:	6a 2f                	push   $0x2f
  jmp __alltraps
  102129:	e9 d0 08 00 00       	jmp    1029fe <__alltraps>

0010212e <vector48>:
.globl vector48
vector48:
  pushl $0
  10212e:	6a 00                	push   $0x0
  pushl $48
  102130:	6a 30                	push   $0x30
  jmp __alltraps
  102132:	e9 c7 08 00 00       	jmp    1029fe <__alltraps>

00102137 <vector49>:
.globl vector49
vector49:
  pushl $0
  102137:	6a 00                	push   $0x0
  pushl $49
  102139:	6a 31                	push   $0x31
  jmp __alltraps
  10213b:	e9 be 08 00 00       	jmp    1029fe <__alltraps>

00102140 <vector50>:
.globl vector50
vector50:
  pushl $0
  102140:	6a 00                	push   $0x0
  pushl $50
  102142:	6a 32                	push   $0x32
  jmp __alltraps
  102144:	e9 b5 08 00 00       	jmp    1029fe <__alltraps>

00102149 <vector51>:
.globl vector51
vector51:
  pushl $0
  102149:	6a 00                	push   $0x0
  pushl $51
  10214b:	6a 33                	push   $0x33
  jmp __alltraps
  10214d:	e9 ac 08 00 00       	jmp    1029fe <__alltraps>

00102152 <vector52>:
.globl vector52
vector52:
  pushl $0
  102152:	6a 00                	push   $0x0
  pushl $52
  102154:	6a 34                	push   $0x34
  jmp __alltraps
  102156:	e9 a3 08 00 00       	jmp    1029fe <__alltraps>

0010215b <vector53>:
.globl vector53
vector53:
  pushl $0
  10215b:	6a 00                	push   $0x0
  pushl $53
  10215d:	6a 35                	push   $0x35
  jmp __alltraps
  10215f:	e9 9a 08 00 00       	jmp    1029fe <__alltraps>

00102164 <vector54>:
.globl vector54
vector54:
  pushl $0
  102164:	6a 00                	push   $0x0
  pushl $54
  102166:	6a 36                	push   $0x36
  jmp __alltraps
  102168:	e9 91 08 00 00       	jmp    1029fe <__alltraps>

0010216d <vector55>:
.globl vector55
vector55:
  pushl $0
  10216d:	6a 00                	push   $0x0
  pushl $55
  10216f:	6a 37                	push   $0x37
  jmp __alltraps
  102171:	e9 88 08 00 00       	jmp    1029fe <__alltraps>

00102176 <vector56>:
.globl vector56
vector56:
  pushl $0
  102176:	6a 00                	push   $0x0
  pushl $56
  102178:	6a 38                	push   $0x38
  jmp __alltraps
  10217a:	e9 7f 08 00 00       	jmp    1029fe <__alltraps>

0010217f <vector57>:
.globl vector57
vector57:
  pushl $0
  10217f:	6a 00                	push   $0x0
  pushl $57
  102181:	6a 39                	push   $0x39
  jmp __alltraps
  102183:	e9 76 08 00 00       	jmp    1029fe <__alltraps>

00102188 <vector58>:
.globl vector58
vector58:
  pushl $0
  102188:	6a 00                	push   $0x0
  pushl $58
  10218a:	6a 3a                	push   $0x3a
  jmp __alltraps
  10218c:	e9 6d 08 00 00       	jmp    1029fe <__alltraps>

00102191 <vector59>:
.globl vector59
vector59:
  pushl $0
  102191:	6a 00                	push   $0x0
  pushl $59
  102193:	6a 3b                	push   $0x3b
  jmp __alltraps
  102195:	e9 64 08 00 00       	jmp    1029fe <__alltraps>

0010219a <vector60>:
.globl vector60
vector60:
  pushl $0
  10219a:	6a 00                	push   $0x0
  pushl $60
  10219c:	6a 3c                	push   $0x3c
  jmp __alltraps
  10219e:	e9 5b 08 00 00       	jmp    1029fe <__alltraps>

001021a3 <vector61>:
.globl vector61
vector61:
  pushl $0
  1021a3:	6a 00                	push   $0x0
  pushl $61
  1021a5:	6a 3d                	push   $0x3d
  jmp __alltraps
  1021a7:	e9 52 08 00 00       	jmp    1029fe <__alltraps>

001021ac <vector62>:
.globl vector62
vector62:
  pushl $0
  1021ac:	6a 00                	push   $0x0
  pushl $62
  1021ae:	6a 3e                	push   $0x3e
  jmp __alltraps
  1021b0:	e9 49 08 00 00       	jmp    1029fe <__alltraps>

001021b5 <vector63>:
.globl vector63
vector63:
  pushl $0
  1021b5:	6a 00                	push   $0x0
  pushl $63
  1021b7:	6a 3f                	push   $0x3f
  jmp __alltraps
  1021b9:	e9 40 08 00 00       	jmp    1029fe <__alltraps>

001021be <vector64>:
.globl vector64
vector64:
  pushl $0
  1021be:	6a 00                	push   $0x0
  pushl $64
  1021c0:	6a 40                	push   $0x40
  jmp __alltraps
  1021c2:	e9 37 08 00 00       	jmp    1029fe <__alltraps>

001021c7 <vector65>:
.globl vector65
vector65:
  pushl $0
  1021c7:	6a 00                	push   $0x0
  pushl $65
  1021c9:	6a 41                	push   $0x41
  jmp __alltraps
  1021cb:	e9 2e 08 00 00       	jmp    1029fe <__alltraps>

001021d0 <vector66>:
.globl vector66
vector66:
  pushl $0
  1021d0:	6a 00                	push   $0x0
  pushl $66
  1021d2:	6a 42                	push   $0x42
  jmp __alltraps
  1021d4:	e9 25 08 00 00       	jmp    1029fe <__alltraps>

001021d9 <vector67>:
.globl vector67
vector67:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $67
  1021db:	6a 43                	push   $0x43
  jmp __alltraps
  1021dd:	e9 1c 08 00 00       	jmp    1029fe <__alltraps>

001021e2 <vector68>:
.globl vector68
vector68:
  pushl $0
  1021e2:	6a 00                	push   $0x0
  pushl $68
  1021e4:	6a 44                	push   $0x44
  jmp __alltraps
  1021e6:	e9 13 08 00 00       	jmp    1029fe <__alltraps>

001021eb <vector69>:
.globl vector69
vector69:
  pushl $0
  1021eb:	6a 00                	push   $0x0
  pushl $69
  1021ed:	6a 45                	push   $0x45
  jmp __alltraps
  1021ef:	e9 0a 08 00 00       	jmp    1029fe <__alltraps>

001021f4 <vector70>:
.globl vector70
vector70:
  pushl $0
  1021f4:	6a 00                	push   $0x0
  pushl $70
  1021f6:	6a 46                	push   $0x46
  jmp __alltraps
  1021f8:	e9 01 08 00 00       	jmp    1029fe <__alltraps>

001021fd <vector71>:
.globl vector71
vector71:
  pushl $0
  1021fd:	6a 00                	push   $0x0
  pushl $71
  1021ff:	6a 47                	push   $0x47
  jmp __alltraps
  102201:	e9 f8 07 00 00       	jmp    1029fe <__alltraps>

00102206 <vector72>:
.globl vector72
vector72:
  pushl $0
  102206:	6a 00                	push   $0x0
  pushl $72
  102208:	6a 48                	push   $0x48
  jmp __alltraps
  10220a:	e9 ef 07 00 00       	jmp    1029fe <__alltraps>

0010220f <vector73>:
.globl vector73
vector73:
  pushl $0
  10220f:	6a 00                	push   $0x0
  pushl $73
  102211:	6a 49                	push   $0x49
  jmp __alltraps
  102213:	e9 e6 07 00 00       	jmp    1029fe <__alltraps>

00102218 <vector74>:
.globl vector74
vector74:
  pushl $0
  102218:	6a 00                	push   $0x0
  pushl $74
  10221a:	6a 4a                	push   $0x4a
  jmp __alltraps
  10221c:	e9 dd 07 00 00       	jmp    1029fe <__alltraps>

00102221 <vector75>:
.globl vector75
vector75:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $75
  102223:	6a 4b                	push   $0x4b
  jmp __alltraps
  102225:	e9 d4 07 00 00       	jmp    1029fe <__alltraps>

0010222a <vector76>:
.globl vector76
vector76:
  pushl $0
  10222a:	6a 00                	push   $0x0
  pushl $76
  10222c:	6a 4c                	push   $0x4c
  jmp __alltraps
  10222e:	e9 cb 07 00 00       	jmp    1029fe <__alltraps>

00102233 <vector77>:
.globl vector77
vector77:
  pushl $0
  102233:	6a 00                	push   $0x0
  pushl $77
  102235:	6a 4d                	push   $0x4d
  jmp __alltraps
  102237:	e9 c2 07 00 00       	jmp    1029fe <__alltraps>

0010223c <vector78>:
.globl vector78
vector78:
  pushl $0
  10223c:	6a 00                	push   $0x0
  pushl $78
  10223e:	6a 4e                	push   $0x4e
  jmp __alltraps
  102240:	e9 b9 07 00 00       	jmp    1029fe <__alltraps>

00102245 <vector79>:
.globl vector79
vector79:
  pushl $0
  102245:	6a 00                	push   $0x0
  pushl $79
  102247:	6a 4f                	push   $0x4f
  jmp __alltraps
  102249:	e9 b0 07 00 00       	jmp    1029fe <__alltraps>

0010224e <vector80>:
.globl vector80
vector80:
  pushl $0
  10224e:	6a 00                	push   $0x0
  pushl $80
  102250:	6a 50                	push   $0x50
  jmp __alltraps
  102252:	e9 a7 07 00 00       	jmp    1029fe <__alltraps>

00102257 <vector81>:
.globl vector81
vector81:
  pushl $0
  102257:	6a 00                	push   $0x0
  pushl $81
  102259:	6a 51                	push   $0x51
  jmp __alltraps
  10225b:	e9 9e 07 00 00       	jmp    1029fe <__alltraps>

00102260 <vector82>:
.globl vector82
vector82:
  pushl $0
  102260:	6a 00                	push   $0x0
  pushl $82
  102262:	6a 52                	push   $0x52
  jmp __alltraps
  102264:	e9 95 07 00 00       	jmp    1029fe <__alltraps>

00102269 <vector83>:
.globl vector83
vector83:
  pushl $0
  102269:	6a 00                	push   $0x0
  pushl $83
  10226b:	6a 53                	push   $0x53
  jmp __alltraps
  10226d:	e9 8c 07 00 00       	jmp    1029fe <__alltraps>

00102272 <vector84>:
.globl vector84
vector84:
  pushl $0
  102272:	6a 00                	push   $0x0
  pushl $84
  102274:	6a 54                	push   $0x54
  jmp __alltraps
  102276:	e9 83 07 00 00       	jmp    1029fe <__alltraps>

0010227b <vector85>:
.globl vector85
vector85:
  pushl $0
  10227b:	6a 00                	push   $0x0
  pushl $85
  10227d:	6a 55                	push   $0x55
  jmp __alltraps
  10227f:	e9 7a 07 00 00       	jmp    1029fe <__alltraps>

00102284 <vector86>:
.globl vector86
vector86:
  pushl $0
  102284:	6a 00                	push   $0x0
  pushl $86
  102286:	6a 56                	push   $0x56
  jmp __alltraps
  102288:	e9 71 07 00 00       	jmp    1029fe <__alltraps>

0010228d <vector87>:
.globl vector87
vector87:
  pushl $0
  10228d:	6a 00                	push   $0x0
  pushl $87
  10228f:	6a 57                	push   $0x57
  jmp __alltraps
  102291:	e9 68 07 00 00       	jmp    1029fe <__alltraps>

00102296 <vector88>:
.globl vector88
vector88:
  pushl $0
  102296:	6a 00                	push   $0x0
  pushl $88
  102298:	6a 58                	push   $0x58
  jmp __alltraps
  10229a:	e9 5f 07 00 00       	jmp    1029fe <__alltraps>

0010229f <vector89>:
.globl vector89
vector89:
  pushl $0
  10229f:	6a 00                	push   $0x0
  pushl $89
  1022a1:	6a 59                	push   $0x59
  jmp __alltraps
  1022a3:	e9 56 07 00 00       	jmp    1029fe <__alltraps>

001022a8 <vector90>:
.globl vector90
vector90:
  pushl $0
  1022a8:	6a 00                	push   $0x0
  pushl $90
  1022aa:	6a 5a                	push   $0x5a
  jmp __alltraps
  1022ac:	e9 4d 07 00 00       	jmp    1029fe <__alltraps>

001022b1 <vector91>:
.globl vector91
vector91:
  pushl $0
  1022b1:	6a 00                	push   $0x0
  pushl $91
  1022b3:	6a 5b                	push   $0x5b
  jmp __alltraps
  1022b5:	e9 44 07 00 00       	jmp    1029fe <__alltraps>

001022ba <vector92>:
.globl vector92
vector92:
  pushl $0
  1022ba:	6a 00                	push   $0x0
  pushl $92
  1022bc:	6a 5c                	push   $0x5c
  jmp __alltraps
  1022be:	e9 3b 07 00 00       	jmp    1029fe <__alltraps>

001022c3 <vector93>:
.globl vector93
vector93:
  pushl $0
  1022c3:	6a 00                	push   $0x0
  pushl $93
  1022c5:	6a 5d                	push   $0x5d
  jmp __alltraps
  1022c7:	e9 32 07 00 00       	jmp    1029fe <__alltraps>

001022cc <vector94>:
.globl vector94
vector94:
  pushl $0
  1022cc:	6a 00                	push   $0x0
  pushl $94
  1022ce:	6a 5e                	push   $0x5e
  jmp __alltraps
  1022d0:	e9 29 07 00 00       	jmp    1029fe <__alltraps>

001022d5 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022d5:	6a 00                	push   $0x0
  pushl $95
  1022d7:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022d9:	e9 20 07 00 00       	jmp    1029fe <__alltraps>

001022de <vector96>:
.globl vector96
vector96:
  pushl $0
  1022de:	6a 00                	push   $0x0
  pushl $96
  1022e0:	6a 60                	push   $0x60
  jmp __alltraps
  1022e2:	e9 17 07 00 00       	jmp    1029fe <__alltraps>

001022e7 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022e7:	6a 00                	push   $0x0
  pushl $97
  1022e9:	6a 61                	push   $0x61
  jmp __alltraps
  1022eb:	e9 0e 07 00 00       	jmp    1029fe <__alltraps>

001022f0 <vector98>:
.globl vector98
vector98:
  pushl $0
  1022f0:	6a 00                	push   $0x0
  pushl $98
  1022f2:	6a 62                	push   $0x62
  jmp __alltraps
  1022f4:	e9 05 07 00 00       	jmp    1029fe <__alltraps>

001022f9 <vector99>:
.globl vector99
vector99:
  pushl $0
  1022f9:	6a 00                	push   $0x0
  pushl $99
  1022fb:	6a 63                	push   $0x63
  jmp __alltraps
  1022fd:	e9 fc 06 00 00       	jmp    1029fe <__alltraps>

00102302 <vector100>:
.globl vector100
vector100:
  pushl $0
  102302:	6a 00                	push   $0x0
  pushl $100
  102304:	6a 64                	push   $0x64
  jmp __alltraps
  102306:	e9 f3 06 00 00       	jmp    1029fe <__alltraps>

0010230b <vector101>:
.globl vector101
vector101:
  pushl $0
  10230b:	6a 00                	push   $0x0
  pushl $101
  10230d:	6a 65                	push   $0x65
  jmp __alltraps
  10230f:	e9 ea 06 00 00       	jmp    1029fe <__alltraps>

00102314 <vector102>:
.globl vector102
vector102:
  pushl $0
  102314:	6a 00                	push   $0x0
  pushl $102
  102316:	6a 66                	push   $0x66
  jmp __alltraps
  102318:	e9 e1 06 00 00       	jmp    1029fe <__alltraps>

0010231d <vector103>:
.globl vector103
vector103:
  pushl $0
  10231d:	6a 00                	push   $0x0
  pushl $103
  10231f:	6a 67                	push   $0x67
  jmp __alltraps
  102321:	e9 d8 06 00 00       	jmp    1029fe <__alltraps>

00102326 <vector104>:
.globl vector104
vector104:
  pushl $0
  102326:	6a 00                	push   $0x0
  pushl $104
  102328:	6a 68                	push   $0x68
  jmp __alltraps
  10232a:	e9 cf 06 00 00       	jmp    1029fe <__alltraps>

0010232f <vector105>:
.globl vector105
vector105:
  pushl $0
  10232f:	6a 00                	push   $0x0
  pushl $105
  102331:	6a 69                	push   $0x69
  jmp __alltraps
  102333:	e9 c6 06 00 00       	jmp    1029fe <__alltraps>

00102338 <vector106>:
.globl vector106
vector106:
  pushl $0
  102338:	6a 00                	push   $0x0
  pushl $106
  10233a:	6a 6a                	push   $0x6a
  jmp __alltraps
  10233c:	e9 bd 06 00 00       	jmp    1029fe <__alltraps>

00102341 <vector107>:
.globl vector107
vector107:
  pushl $0
  102341:	6a 00                	push   $0x0
  pushl $107
  102343:	6a 6b                	push   $0x6b
  jmp __alltraps
  102345:	e9 b4 06 00 00       	jmp    1029fe <__alltraps>

0010234a <vector108>:
.globl vector108
vector108:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $108
  10234c:	6a 6c                	push   $0x6c
  jmp __alltraps
  10234e:	e9 ab 06 00 00       	jmp    1029fe <__alltraps>

00102353 <vector109>:
.globl vector109
vector109:
  pushl $0
  102353:	6a 00                	push   $0x0
  pushl $109
  102355:	6a 6d                	push   $0x6d
  jmp __alltraps
  102357:	e9 a2 06 00 00       	jmp    1029fe <__alltraps>

0010235c <vector110>:
.globl vector110
vector110:
  pushl $0
  10235c:	6a 00                	push   $0x0
  pushl $110
  10235e:	6a 6e                	push   $0x6e
  jmp __alltraps
  102360:	e9 99 06 00 00       	jmp    1029fe <__alltraps>

00102365 <vector111>:
.globl vector111
vector111:
  pushl $0
  102365:	6a 00                	push   $0x0
  pushl $111
  102367:	6a 6f                	push   $0x6f
  jmp __alltraps
  102369:	e9 90 06 00 00       	jmp    1029fe <__alltraps>

0010236e <vector112>:
.globl vector112
vector112:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $112
  102370:	6a 70                	push   $0x70
  jmp __alltraps
  102372:	e9 87 06 00 00       	jmp    1029fe <__alltraps>

00102377 <vector113>:
.globl vector113
vector113:
  pushl $0
  102377:	6a 00                	push   $0x0
  pushl $113
  102379:	6a 71                	push   $0x71
  jmp __alltraps
  10237b:	e9 7e 06 00 00       	jmp    1029fe <__alltraps>

00102380 <vector114>:
.globl vector114
vector114:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $114
  102382:	6a 72                	push   $0x72
  jmp __alltraps
  102384:	e9 75 06 00 00       	jmp    1029fe <__alltraps>

00102389 <vector115>:
.globl vector115
vector115:
  pushl $0
  102389:	6a 00                	push   $0x0
  pushl $115
  10238b:	6a 73                	push   $0x73
  jmp __alltraps
  10238d:	e9 6c 06 00 00       	jmp    1029fe <__alltraps>

00102392 <vector116>:
.globl vector116
vector116:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $116
  102394:	6a 74                	push   $0x74
  jmp __alltraps
  102396:	e9 63 06 00 00       	jmp    1029fe <__alltraps>

0010239b <vector117>:
.globl vector117
vector117:
  pushl $0
  10239b:	6a 00                	push   $0x0
  pushl $117
  10239d:	6a 75                	push   $0x75
  jmp __alltraps
  10239f:	e9 5a 06 00 00       	jmp    1029fe <__alltraps>

001023a4 <vector118>:
.globl vector118
vector118:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $118
  1023a6:	6a 76                	push   $0x76
  jmp __alltraps
  1023a8:	e9 51 06 00 00       	jmp    1029fe <__alltraps>

001023ad <vector119>:
.globl vector119
vector119:
  pushl $0
  1023ad:	6a 00                	push   $0x0
  pushl $119
  1023af:	6a 77                	push   $0x77
  jmp __alltraps
  1023b1:	e9 48 06 00 00       	jmp    1029fe <__alltraps>

001023b6 <vector120>:
.globl vector120
vector120:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $120
  1023b8:	6a 78                	push   $0x78
  jmp __alltraps
  1023ba:	e9 3f 06 00 00       	jmp    1029fe <__alltraps>

001023bf <vector121>:
.globl vector121
vector121:
  pushl $0
  1023bf:	6a 00                	push   $0x0
  pushl $121
  1023c1:	6a 79                	push   $0x79
  jmp __alltraps
  1023c3:	e9 36 06 00 00       	jmp    1029fe <__alltraps>

001023c8 <vector122>:
.globl vector122
vector122:
  pushl $0
  1023c8:	6a 00                	push   $0x0
  pushl $122
  1023ca:	6a 7a                	push   $0x7a
  jmp __alltraps
  1023cc:	e9 2d 06 00 00       	jmp    1029fe <__alltraps>

001023d1 <vector123>:
.globl vector123
vector123:
  pushl $0
  1023d1:	6a 00                	push   $0x0
  pushl $123
  1023d3:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023d5:	e9 24 06 00 00       	jmp    1029fe <__alltraps>

001023da <vector124>:
.globl vector124
vector124:
  pushl $0
  1023da:	6a 00                	push   $0x0
  pushl $124
  1023dc:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023de:	e9 1b 06 00 00       	jmp    1029fe <__alltraps>

001023e3 <vector125>:
.globl vector125
vector125:
  pushl $0
  1023e3:	6a 00                	push   $0x0
  pushl $125
  1023e5:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023e7:	e9 12 06 00 00       	jmp    1029fe <__alltraps>

001023ec <vector126>:
.globl vector126
vector126:
  pushl $0
  1023ec:	6a 00                	push   $0x0
  pushl $126
  1023ee:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023f0:	e9 09 06 00 00       	jmp    1029fe <__alltraps>

001023f5 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023f5:	6a 00                	push   $0x0
  pushl $127
  1023f7:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023f9:	e9 00 06 00 00       	jmp    1029fe <__alltraps>

001023fe <vector128>:
.globl vector128
vector128:
  pushl $0
  1023fe:	6a 00                	push   $0x0
  pushl $128
  102400:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102405:	e9 f4 05 00 00       	jmp    1029fe <__alltraps>

0010240a <vector129>:
.globl vector129
vector129:
  pushl $0
  10240a:	6a 00                	push   $0x0
  pushl $129
  10240c:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102411:	e9 e8 05 00 00       	jmp    1029fe <__alltraps>

00102416 <vector130>:
.globl vector130
vector130:
  pushl $0
  102416:	6a 00                	push   $0x0
  pushl $130
  102418:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10241d:	e9 dc 05 00 00       	jmp    1029fe <__alltraps>

00102422 <vector131>:
.globl vector131
vector131:
  pushl $0
  102422:	6a 00                	push   $0x0
  pushl $131
  102424:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102429:	e9 d0 05 00 00       	jmp    1029fe <__alltraps>

0010242e <vector132>:
.globl vector132
vector132:
  pushl $0
  10242e:	6a 00                	push   $0x0
  pushl $132
  102430:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102435:	e9 c4 05 00 00       	jmp    1029fe <__alltraps>

0010243a <vector133>:
.globl vector133
vector133:
  pushl $0
  10243a:	6a 00                	push   $0x0
  pushl $133
  10243c:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102441:	e9 b8 05 00 00       	jmp    1029fe <__alltraps>

00102446 <vector134>:
.globl vector134
vector134:
  pushl $0
  102446:	6a 00                	push   $0x0
  pushl $134
  102448:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10244d:	e9 ac 05 00 00       	jmp    1029fe <__alltraps>

00102452 <vector135>:
.globl vector135
vector135:
  pushl $0
  102452:	6a 00                	push   $0x0
  pushl $135
  102454:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102459:	e9 a0 05 00 00       	jmp    1029fe <__alltraps>

0010245e <vector136>:
.globl vector136
vector136:
  pushl $0
  10245e:	6a 00                	push   $0x0
  pushl $136
  102460:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102465:	e9 94 05 00 00       	jmp    1029fe <__alltraps>

0010246a <vector137>:
.globl vector137
vector137:
  pushl $0
  10246a:	6a 00                	push   $0x0
  pushl $137
  10246c:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102471:	e9 88 05 00 00       	jmp    1029fe <__alltraps>

00102476 <vector138>:
.globl vector138
vector138:
  pushl $0
  102476:	6a 00                	push   $0x0
  pushl $138
  102478:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10247d:	e9 7c 05 00 00       	jmp    1029fe <__alltraps>

00102482 <vector139>:
.globl vector139
vector139:
  pushl $0
  102482:	6a 00                	push   $0x0
  pushl $139
  102484:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102489:	e9 70 05 00 00       	jmp    1029fe <__alltraps>

0010248e <vector140>:
.globl vector140
vector140:
  pushl $0
  10248e:	6a 00                	push   $0x0
  pushl $140
  102490:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102495:	e9 64 05 00 00       	jmp    1029fe <__alltraps>

0010249a <vector141>:
.globl vector141
vector141:
  pushl $0
  10249a:	6a 00                	push   $0x0
  pushl $141
  10249c:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1024a1:	e9 58 05 00 00       	jmp    1029fe <__alltraps>

001024a6 <vector142>:
.globl vector142
vector142:
  pushl $0
  1024a6:	6a 00                	push   $0x0
  pushl $142
  1024a8:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1024ad:	e9 4c 05 00 00       	jmp    1029fe <__alltraps>

001024b2 <vector143>:
.globl vector143
vector143:
  pushl $0
  1024b2:	6a 00                	push   $0x0
  pushl $143
  1024b4:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1024b9:	e9 40 05 00 00       	jmp    1029fe <__alltraps>

001024be <vector144>:
.globl vector144
vector144:
  pushl $0
  1024be:	6a 00                	push   $0x0
  pushl $144
  1024c0:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1024c5:	e9 34 05 00 00       	jmp    1029fe <__alltraps>

001024ca <vector145>:
.globl vector145
vector145:
  pushl $0
  1024ca:	6a 00                	push   $0x0
  pushl $145
  1024cc:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1024d1:	e9 28 05 00 00       	jmp    1029fe <__alltraps>

001024d6 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024d6:	6a 00                	push   $0x0
  pushl $146
  1024d8:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024dd:	e9 1c 05 00 00       	jmp    1029fe <__alltraps>

001024e2 <vector147>:
.globl vector147
vector147:
  pushl $0
  1024e2:	6a 00                	push   $0x0
  pushl $147
  1024e4:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024e9:	e9 10 05 00 00       	jmp    1029fe <__alltraps>

001024ee <vector148>:
.globl vector148
vector148:
  pushl $0
  1024ee:	6a 00                	push   $0x0
  pushl $148
  1024f0:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024f5:	e9 04 05 00 00       	jmp    1029fe <__alltraps>

001024fa <vector149>:
.globl vector149
vector149:
  pushl $0
  1024fa:	6a 00                	push   $0x0
  pushl $149
  1024fc:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102501:	e9 f8 04 00 00       	jmp    1029fe <__alltraps>

00102506 <vector150>:
.globl vector150
vector150:
  pushl $0
  102506:	6a 00                	push   $0x0
  pushl $150
  102508:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10250d:	e9 ec 04 00 00       	jmp    1029fe <__alltraps>

00102512 <vector151>:
.globl vector151
vector151:
  pushl $0
  102512:	6a 00                	push   $0x0
  pushl $151
  102514:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102519:	e9 e0 04 00 00       	jmp    1029fe <__alltraps>

0010251e <vector152>:
.globl vector152
vector152:
  pushl $0
  10251e:	6a 00                	push   $0x0
  pushl $152
  102520:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102525:	e9 d4 04 00 00       	jmp    1029fe <__alltraps>

0010252a <vector153>:
.globl vector153
vector153:
  pushl $0
  10252a:	6a 00                	push   $0x0
  pushl $153
  10252c:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102531:	e9 c8 04 00 00       	jmp    1029fe <__alltraps>

00102536 <vector154>:
.globl vector154
vector154:
  pushl $0
  102536:	6a 00                	push   $0x0
  pushl $154
  102538:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10253d:	e9 bc 04 00 00       	jmp    1029fe <__alltraps>

00102542 <vector155>:
.globl vector155
vector155:
  pushl $0
  102542:	6a 00                	push   $0x0
  pushl $155
  102544:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102549:	e9 b0 04 00 00       	jmp    1029fe <__alltraps>

0010254e <vector156>:
.globl vector156
vector156:
  pushl $0
  10254e:	6a 00                	push   $0x0
  pushl $156
  102550:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102555:	e9 a4 04 00 00       	jmp    1029fe <__alltraps>

0010255a <vector157>:
.globl vector157
vector157:
  pushl $0
  10255a:	6a 00                	push   $0x0
  pushl $157
  10255c:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102561:	e9 98 04 00 00       	jmp    1029fe <__alltraps>

00102566 <vector158>:
.globl vector158
vector158:
  pushl $0
  102566:	6a 00                	push   $0x0
  pushl $158
  102568:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10256d:	e9 8c 04 00 00       	jmp    1029fe <__alltraps>

00102572 <vector159>:
.globl vector159
vector159:
  pushl $0
  102572:	6a 00                	push   $0x0
  pushl $159
  102574:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102579:	e9 80 04 00 00       	jmp    1029fe <__alltraps>

0010257e <vector160>:
.globl vector160
vector160:
  pushl $0
  10257e:	6a 00                	push   $0x0
  pushl $160
  102580:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102585:	e9 74 04 00 00       	jmp    1029fe <__alltraps>

0010258a <vector161>:
.globl vector161
vector161:
  pushl $0
  10258a:	6a 00                	push   $0x0
  pushl $161
  10258c:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  102591:	e9 68 04 00 00       	jmp    1029fe <__alltraps>

00102596 <vector162>:
.globl vector162
vector162:
  pushl $0
  102596:	6a 00                	push   $0x0
  pushl $162
  102598:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10259d:	e9 5c 04 00 00       	jmp    1029fe <__alltraps>

001025a2 <vector163>:
.globl vector163
vector163:
  pushl $0
  1025a2:	6a 00                	push   $0x0
  pushl $163
  1025a4:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1025a9:	e9 50 04 00 00       	jmp    1029fe <__alltraps>

001025ae <vector164>:
.globl vector164
vector164:
  pushl $0
  1025ae:	6a 00                	push   $0x0
  pushl $164
  1025b0:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1025b5:	e9 44 04 00 00       	jmp    1029fe <__alltraps>

001025ba <vector165>:
.globl vector165
vector165:
  pushl $0
  1025ba:	6a 00                	push   $0x0
  pushl $165
  1025bc:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1025c1:	e9 38 04 00 00       	jmp    1029fe <__alltraps>

001025c6 <vector166>:
.globl vector166
vector166:
  pushl $0
  1025c6:	6a 00                	push   $0x0
  pushl $166
  1025c8:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1025cd:	e9 2c 04 00 00       	jmp    1029fe <__alltraps>

001025d2 <vector167>:
.globl vector167
vector167:
  pushl $0
  1025d2:	6a 00                	push   $0x0
  pushl $167
  1025d4:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025d9:	e9 20 04 00 00       	jmp    1029fe <__alltraps>

001025de <vector168>:
.globl vector168
vector168:
  pushl $0
  1025de:	6a 00                	push   $0x0
  pushl $168
  1025e0:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025e5:	e9 14 04 00 00       	jmp    1029fe <__alltraps>

001025ea <vector169>:
.globl vector169
vector169:
  pushl $0
  1025ea:	6a 00                	push   $0x0
  pushl $169
  1025ec:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025f1:	e9 08 04 00 00       	jmp    1029fe <__alltraps>

001025f6 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025f6:	6a 00                	push   $0x0
  pushl $170
  1025f8:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025fd:	e9 fc 03 00 00       	jmp    1029fe <__alltraps>

00102602 <vector171>:
.globl vector171
vector171:
  pushl $0
  102602:	6a 00                	push   $0x0
  pushl $171
  102604:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102609:	e9 f0 03 00 00       	jmp    1029fe <__alltraps>

0010260e <vector172>:
.globl vector172
vector172:
  pushl $0
  10260e:	6a 00                	push   $0x0
  pushl $172
  102610:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102615:	e9 e4 03 00 00       	jmp    1029fe <__alltraps>

0010261a <vector173>:
.globl vector173
vector173:
  pushl $0
  10261a:	6a 00                	push   $0x0
  pushl $173
  10261c:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102621:	e9 d8 03 00 00       	jmp    1029fe <__alltraps>

00102626 <vector174>:
.globl vector174
vector174:
  pushl $0
  102626:	6a 00                	push   $0x0
  pushl $174
  102628:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10262d:	e9 cc 03 00 00       	jmp    1029fe <__alltraps>

00102632 <vector175>:
.globl vector175
vector175:
  pushl $0
  102632:	6a 00                	push   $0x0
  pushl $175
  102634:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102639:	e9 c0 03 00 00       	jmp    1029fe <__alltraps>

0010263e <vector176>:
.globl vector176
vector176:
  pushl $0
  10263e:	6a 00                	push   $0x0
  pushl $176
  102640:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102645:	e9 b4 03 00 00       	jmp    1029fe <__alltraps>

0010264a <vector177>:
.globl vector177
vector177:
  pushl $0
  10264a:	6a 00                	push   $0x0
  pushl $177
  10264c:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102651:	e9 a8 03 00 00       	jmp    1029fe <__alltraps>

00102656 <vector178>:
.globl vector178
vector178:
  pushl $0
  102656:	6a 00                	push   $0x0
  pushl $178
  102658:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10265d:	e9 9c 03 00 00       	jmp    1029fe <__alltraps>

00102662 <vector179>:
.globl vector179
vector179:
  pushl $0
  102662:	6a 00                	push   $0x0
  pushl $179
  102664:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102669:	e9 90 03 00 00       	jmp    1029fe <__alltraps>

0010266e <vector180>:
.globl vector180
vector180:
  pushl $0
  10266e:	6a 00                	push   $0x0
  pushl $180
  102670:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102675:	e9 84 03 00 00       	jmp    1029fe <__alltraps>

0010267a <vector181>:
.globl vector181
vector181:
  pushl $0
  10267a:	6a 00                	push   $0x0
  pushl $181
  10267c:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  102681:	e9 78 03 00 00       	jmp    1029fe <__alltraps>

00102686 <vector182>:
.globl vector182
vector182:
  pushl $0
  102686:	6a 00                	push   $0x0
  pushl $182
  102688:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10268d:	e9 6c 03 00 00       	jmp    1029fe <__alltraps>

00102692 <vector183>:
.globl vector183
vector183:
  pushl $0
  102692:	6a 00                	push   $0x0
  pushl $183
  102694:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102699:	e9 60 03 00 00       	jmp    1029fe <__alltraps>

0010269e <vector184>:
.globl vector184
vector184:
  pushl $0
  10269e:	6a 00                	push   $0x0
  pushl $184
  1026a0:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1026a5:	e9 54 03 00 00       	jmp    1029fe <__alltraps>

001026aa <vector185>:
.globl vector185
vector185:
  pushl $0
  1026aa:	6a 00                	push   $0x0
  pushl $185
  1026ac:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1026b1:	e9 48 03 00 00       	jmp    1029fe <__alltraps>

001026b6 <vector186>:
.globl vector186
vector186:
  pushl $0
  1026b6:	6a 00                	push   $0x0
  pushl $186
  1026b8:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1026bd:	e9 3c 03 00 00       	jmp    1029fe <__alltraps>

001026c2 <vector187>:
.globl vector187
vector187:
  pushl $0
  1026c2:	6a 00                	push   $0x0
  pushl $187
  1026c4:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1026c9:	e9 30 03 00 00       	jmp    1029fe <__alltraps>

001026ce <vector188>:
.globl vector188
vector188:
  pushl $0
  1026ce:	6a 00                	push   $0x0
  pushl $188
  1026d0:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026d5:	e9 24 03 00 00       	jmp    1029fe <__alltraps>

001026da <vector189>:
.globl vector189
vector189:
  pushl $0
  1026da:	6a 00                	push   $0x0
  pushl $189
  1026dc:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026e1:	e9 18 03 00 00       	jmp    1029fe <__alltraps>

001026e6 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026e6:	6a 00                	push   $0x0
  pushl $190
  1026e8:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026ed:	e9 0c 03 00 00       	jmp    1029fe <__alltraps>

001026f2 <vector191>:
.globl vector191
vector191:
  pushl $0
  1026f2:	6a 00                	push   $0x0
  pushl $191
  1026f4:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026f9:	e9 00 03 00 00       	jmp    1029fe <__alltraps>

001026fe <vector192>:
.globl vector192
vector192:
  pushl $0
  1026fe:	6a 00                	push   $0x0
  pushl $192
  102700:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102705:	e9 f4 02 00 00       	jmp    1029fe <__alltraps>

0010270a <vector193>:
.globl vector193
vector193:
  pushl $0
  10270a:	6a 00                	push   $0x0
  pushl $193
  10270c:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102711:	e9 e8 02 00 00       	jmp    1029fe <__alltraps>

00102716 <vector194>:
.globl vector194
vector194:
  pushl $0
  102716:	6a 00                	push   $0x0
  pushl $194
  102718:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10271d:	e9 dc 02 00 00       	jmp    1029fe <__alltraps>

00102722 <vector195>:
.globl vector195
vector195:
  pushl $0
  102722:	6a 00                	push   $0x0
  pushl $195
  102724:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102729:	e9 d0 02 00 00       	jmp    1029fe <__alltraps>

0010272e <vector196>:
.globl vector196
vector196:
  pushl $0
  10272e:	6a 00                	push   $0x0
  pushl $196
  102730:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102735:	e9 c4 02 00 00       	jmp    1029fe <__alltraps>

0010273a <vector197>:
.globl vector197
vector197:
  pushl $0
  10273a:	6a 00                	push   $0x0
  pushl $197
  10273c:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102741:	e9 b8 02 00 00       	jmp    1029fe <__alltraps>

00102746 <vector198>:
.globl vector198
vector198:
  pushl $0
  102746:	6a 00                	push   $0x0
  pushl $198
  102748:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10274d:	e9 ac 02 00 00       	jmp    1029fe <__alltraps>

00102752 <vector199>:
.globl vector199
vector199:
  pushl $0
  102752:	6a 00                	push   $0x0
  pushl $199
  102754:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102759:	e9 a0 02 00 00       	jmp    1029fe <__alltraps>

0010275e <vector200>:
.globl vector200
vector200:
  pushl $0
  10275e:	6a 00                	push   $0x0
  pushl $200
  102760:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102765:	e9 94 02 00 00       	jmp    1029fe <__alltraps>

0010276a <vector201>:
.globl vector201
vector201:
  pushl $0
  10276a:	6a 00                	push   $0x0
  pushl $201
  10276c:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102771:	e9 88 02 00 00       	jmp    1029fe <__alltraps>

00102776 <vector202>:
.globl vector202
vector202:
  pushl $0
  102776:	6a 00                	push   $0x0
  pushl $202
  102778:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10277d:	e9 7c 02 00 00       	jmp    1029fe <__alltraps>

00102782 <vector203>:
.globl vector203
vector203:
  pushl $0
  102782:	6a 00                	push   $0x0
  pushl $203
  102784:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102789:	e9 70 02 00 00       	jmp    1029fe <__alltraps>

0010278e <vector204>:
.globl vector204
vector204:
  pushl $0
  10278e:	6a 00                	push   $0x0
  pushl $204
  102790:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102795:	e9 64 02 00 00       	jmp    1029fe <__alltraps>

0010279a <vector205>:
.globl vector205
vector205:
  pushl $0
  10279a:	6a 00                	push   $0x0
  pushl $205
  10279c:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1027a1:	e9 58 02 00 00       	jmp    1029fe <__alltraps>

001027a6 <vector206>:
.globl vector206
vector206:
  pushl $0
  1027a6:	6a 00                	push   $0x0
  pushl $206
  1027a8:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1027ad:	e9 4c 02 00 00       	jmp    1029fe <__alltraps>

001027b2 <vector207>:
.globl vector207
vector207:
  pushl $0
  1027b2:	6a 00                	push   $0x0
  pushl $207
  1027b4:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1027b9:	e9 40 02 00 00       	jmp    1029fe <__alltraps>

001027be <vector208>:
.globl vector208
vector208:
  pushl $0
  1027be:	6a 00                	push   $0x0
  pushl $208
  1027c0:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1027c5:	e9 34 02 00 00       	jmp    1029fe <__alltraps>

001027ca <vector209>:
.globl vector209
vector209:
  pushl $0
  1027ca:	6a 00                	push   $0x0
  pushl $209
  1027cc:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1027d1:	e9 28 02 00 00       	jmp    1029fe <__alltraps>

001027d6 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027d6:	6a 00                	push   $0x0
  pushl $210
  1027d8:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027dd:	e9 1c 02 00 00       	jmp    1029fe <__alltraps>

001027e2 <vector211>:
.globl vector211
vector211:
  pushl $0
  1027e2:	6a 00                	push   $0x0
  pushl $211
  1027e4:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027e9:	e9 10 02 00 00       	jmp    1029fe <__alltraps>

001027ee <vector212>:
.globl vector212
vector212:
  pushl $0
  1027ee:	6a 00                	push   $0x0
  pushl $212
  1027f0:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027f5:	e9 04 02 00 00       	jmp    1029fe <__alltraps>

001027fa <vector213>:
.globl vector213
vector213:
  pushl $0
  1027fa:	6a 00                	push   $0x0
  pushl $213
  1027fc:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102801:	e9 f8 01 00 00       	jmp    1029fe <__alltraps>

00102806 <vector214>:
.globl vector214
vector214:
  pushl $0
  102806:	6a 00                	push   $0x0
  pushl $214
  102808:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10280d:	e9 ec 01 00 00       	jmp    1029fe <__alltraps>

00102812 <vector215>:
.globl vector215
vector215:
  pushl $0
  102812:	6a 00                	push   $0x0
  pushl $215
  102814:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102819:	e9 e0 01 00 00       	jmp    1029fe <__alltraps>

0010281e <vector216>:
.globl vector216
vector216:
  pushl $0
  10281e:	6a 00                	push   $0x0
  pushl $216
  102820:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102825:	e9 d4 01 00 00       	jmp    1029fe <__alltraps>

0010282a <vector217>:
.globl vector217
vector217:
  pushl $0
  10282a:	6a 00                	push   $0x0
  pushl $217
  10282c:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102831:	e9 c8 01 00 00       	jmp    1029fe <__alltraps>

00102836 <vector218>:
.globl vector218
vector218:
  pushl $0
  102836:	6a 00                	push   $0x0
  pushl $218
  102838:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10283d:	e9 bc 01 00 00       	jmp    1029fe <__alltraps>

00102842 <vector219>:
.globl vector219
vector219:
  pushl $0
  102842:	6a 00                	push   $0x0
  pushl $219
  102844:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102849:	e9 b0 01 00 00       	jmp    1029fe <__alltraps>

0010284e <vector220>:
.globl vector220
vector220:
  pushl $0
  10284e:	6a 00                	push   $0x0
  pushl $220
  102850:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102855:	e9 a4 01 00 00       	jmp    1029fe <__alltraps>

0010285a <vector221>:
.globl vector221
vector221:
  pushl $0
  10285a:	6a 00                	push   $0x0
  pushl $221
  10285c:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102861:	e9 98 01 00 00       	jmp    1029fe <__alltraps>

00102866 <vector222>:
.globl vector222
vector222:
  pushl $0
  102866:	6a 00                	push   $0x0
  pushl $222
  102868:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10286d:	e9 8c 01 00 00       	jmp    1029fe <__alltraps>

00102872 <vector223>:
.globl vector223
vector223:
  pushl $0
  102872:	6a 00                	push   $0x0
  pushl $223
  102874:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102879:	e9 80 01 00 00       	jmp    1029fe <__alltraps>

0010287e <vector224>:
.globl vector224
vector224:
  pushl $0
  10287e:	6a 00                	push   $0x0
  pushl $224
  102880:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102885:	e9 74 01 00 00       	jmp    1029fe <__alltraps>

0010288a <vector225>:
.globl vector225
vector225:
  pushl $0
  10288a:	6a 00                	push   $0x0
  pushl $225
  10288c:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  102891:	e9 68 01 00 00       	jmp    1029fe <__alltraps>

00102896 <vector226>:
.globl vector226
vector226:
  pushl $0
  102896:	6a 00                	push   $0x0
  pushl $226
  102898:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10289d:	e9 5c 01 00 00       	jmp    1029fe <__alltraps>

001028a2 <vector227>:
.globl vector227
vector227:
  pushl $0
  1028a2:	6a 00                	push   $0x0
  pushl $227
  1028a4:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1028a9:	e9 50 01 00 00       	jmp    1029fe <__alltraps>

001028ae <vector228>:
.globl vector228
vector228:
  pushl $0
  1028ae:	6a 00                	push   $0x0
  pushl $228
  1028b0:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1028b5:	e9 44 01 00 00       	jmp    1029fe <__alltraps>

001028ba <vector229>:
.globl vector229
vector229:
  pushl $0
  1028ba:	6a 00                	push   $0x0
  pushl $229
  1028bc:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1028c1:	e9 38 01 00 00       	jmp    1029fe <__alltraps>

001028c6 <vector230>:
.globl vector230
vector230:
  pushl $0
  1028c6:	6a 00                	push   $0x0
  pushl $230
  1028c8:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1028cd:	e9 2c 01 00 00       	jmp    1029fe <__alltraps>

001028d2 <vector231>:
.globl vector231
vector231:
  pushl $0
  1028d2:	6a 00                	push   $0x0
  pushl $231
  1028d4:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028d9:	e9 20 01 00 00       	jmp    1029fe <__alltraps>

001028de <vector232>:
.globl vector232
vector232:
  pushl $0
  1028de:	6a 00                	push   $0x0
  pushl $232
  1028e0:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028e5:	e9 14 01 00 00       	jmp    1029fe <__alltraps>

001028ea <vector233>:
.globl vector233
vector233:
  pushl $0
  1028ea:	6a 00                	push   $0x0
  pushl $233
  1028ec:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028f1:	e9 08 01 00 00       	jmp    1029fe <__alltraps>

001028f6 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028f6:	6a 00                	push   $0x0
  pushl $234
  1028f8:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028fd:	e9 fc 00 00 00       	jmp    1029fe <__alltraps>

00102902 <vector235>:
.globl vector235
vector235:
  pushl $0
  102902:	6a 00                	push   $0x0
  pushl $235
  102904:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102909:	e9 f0 00 00 00       	jmp    1029fe <__alltraps>

0010290e <vector236>:
.globl vector236
vector236:
  pushl $0
  10290e:	6a 00                	push   $0x0
  pushl $236
  102910:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102915:	e9 e4 00 00 00       	jmp    1029fe <__alltraps>

0010291a <vector237>:
.globl vector237
vector237:
  pushl $0
  10291a:	6a 00                	push   $0x0
  pushl $237
  10291c:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102921:	e9 d8 00 00 00       	jmp    1029fe <__alltraps>

00102926 <vector238>:
.globl vector238
vector238:
  pushl $0
  102926:	6a 00                	push   $0x0
  pushl $238
  102928:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10292d:	e9 cc 00 00 00       	jmp    1029fe <__alltraps>

00102932 <vector239>:
.globl vector239
vector239:
  pushl $0
  102932:	6a 00                	push   $0x0
  pushl $239
  102934:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102939:	e9 c0 00 00 00       	jmp    1029fe <__alltraps>

0010293e <vector240>:
.globl vector240
vector240:
  pushl $0
  10293e:	6a 00                	push   $0x0
  pushl $240
  102940:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102945:	e9 b4 00 00 00       	jmp    1029fe <__alltraps>

0010294a <vector241>:
.globl vector241
vector241:
  pushl $0
  10294a:	6a 00                	push   $0x0
  pushl $241
  10294c:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102951:	e9 a8 00 00 00       	jmp    1029fe <__alltraps>

00102956 <vector242>:
.globl vector242
vector242:
  pushl $0
  102956:	6a 00                	push   $0x0
  pushl $242
  102958:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10295d:	e9 9c 00 00 00       	jmp    1029fe <__alltraps>

00102962 <vector243>:
.globl vector243
vector243:
  pushl $0
  102962:	6a 00                	push   $0x0
  pushl $243
  102964:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102969:	e9 90 00 00 00       	jmp    1029fe <__alltraps>

0010296e <vector244>:
.globl vector244
vector244:
  pushl $0
  10296e:	6a 00                	push   $0x0
  pushl $244
  102970:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102975:	e9 84 00 00 00       	jmp    1029fe <__alltraps>

0010297a <vector245>:
.globl vector245
vector245:
  pushl $0
  10297a:	6a 00                	push   $0x0
  pushl $245
  10297c:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102981:	e9 78 00 00 00       	jmp    1029fe <__alltraps>

00102986 <vector246>:
.globl vector246
vector246:
  pushl $0
  102986:	6a 00                	push   $0x0
  pushl $246
  102988:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10298d:	e9 6c 00 00 00       	jmp    1029fe <__alltraps>

00102992 <vector247>:
.globl vector247
vector247:
  pushl $0
  102992:	6a 00                	push   $0x0
  pushl $247
  102994:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102999:	e9 60 00 00 00       	jmp    1029fe <__alltraps>

0010299e <vector248>:
.globl vector248
vector248:
  pushl $0
  10299e:	6a 00                	push   $0x0
  pushl $248
  1029a0:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1029a5:	e9 54 00 00 00       	jmp    1029fe <__alltraps>

001029aa <vector249>:
.globl vector249
vector249:
  pushl $0
  1029aa:	6a 00                	push   $0x0
  pushl $249
  1029ac:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1029b1:	e9 48 00 00 00       	jmp    1029fe <__alltraps>

001029b6 <vector250>:
.globl vector250
vector250:
  pushl $0
  1029b6:	6a 00                	push   $0x0
  pushl $250
  1029b8:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1029bd:	e9 3c 00 00 00       	jmp    1029fe <__alltraps>

001029c2 <vector251>:
.globl vector251
vector251:
  pushl $0
  1029c2:	6a 00                	push   $0x0
  pushl $251
  1029c4:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1029c9:	e9 30 00 00 00       	jmp    1029fe <__alltraps>

001029ce <vector252>:
.globl vector252
vector252:
  pushl $0
  1029ce:	6a 00                	push   $0x0
  pushl $252
  1029d0:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029d5:	e9 24 00 00 00       	jmp    1029fe <__alltraps>

001029da <vector253>:
.globl vector253
vector253:
  pushl $0
  1029da:	6a 00                	push   $0x0
  pushl $253
  1029dc:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029e1:	e9 18 00 00 00       	jmp    1029fe <__alltraps>

001029e6 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029e6:	6a 00                	push   $0x0
  pushl $254
  1029e8:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029ed:	e9 0c 00 00 00       	jmp    1029fe <__alltraps>

001029f2 <vector255>:
.globl vector255
vector255:
  pushl $0
  1029f2:	6a 00                	push   $0x0
  pushl $255
  1029f4:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029f9:	e9 00 00 00 00       	jmp    1029fe <__alltraps>

001029fe <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  1029fe:	1e                   	push   %ds
    pushl %es
  1029ff:	06                   	push   %es
    pushl %fs
  102a00:	0f a0                	push   %fs
    pushl %gs
  102a02:	0f a8                	push   %gs
    pushal
  102a04:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102a05:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102a0a:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102a0c:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102a0e:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102a0f:	e8 60 f5 ff ff       	call   101f74 <trap>

    # pop the pushed stack pointer
    popl %esp
  102a14:	5c                   	pop    %esp

00102a15 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102a15:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102a16:	0f a9                	pop    %gs
    popl %fs
  102a18:	0f a1                	pop    %fs
    popl %es
  102a1a:	07                   	pop    %es
    popl %ds
  102a1b:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102a1c:	83 c4 08             	add    $0x8,%esp
    iret
  102a1f:	cf                   	iret   

00102a20 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102a20:	55                   	push   %ebp
  102a21:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102a23:	8b 45 08             	mov    0x8(%ebp),%eax
  102a26:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102a29:	b8 23 00 00 00       	mov    $0x23,%eax
  102a2e:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102a30:	b8 23 00 00 00       	mov    $0x23,%eax
  102a35:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102a37:	b8 10 00 00 00       	mov    $0x10,%eax
  102a3c:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102a3e:	b8 10 00 00 00       	mov    $0x10,%eax
  102a43:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102a45:	b8 10 00 00 00       	mov    $0x10,%eax
  102a4a:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102a4c:	ea 53 2a 10 00 08 00 	ljmp   $0x8,$0x102a53
}
  102a53:	90                   	nop
  102a54:	5d                   	pop    %ebp
  102a55:	c3                   	ret    

00102a56 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102a56:	f3 0f 1e fb          	endbr32 
  102a5a:	55                   	push   %ebp
  102a5b:	89 e5                	mov    %esp,%ebp
  102a5d:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102a60:	b8 20 09 11 00       	mov    $0x110920,%eax
  102a65:	05 00 04 00 00       	add    $0x400,%eax
  102a6a:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102a6f:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  102a76:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102a78:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102a7f:	68 00 
  102a81:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a86:	0f b7 c0             	movzwl %ax,%eax
  102a89:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102a8f:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a94:	c1 e8 10             	shr    $0x10,%eax
  102a97:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102a9c:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102aa3:	24 f0                	and    $0xf0,%al
  102aa5:	0c 09                	or     $0x9,%al
  102aa7:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102aac:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ab3:	0c 10                	or     $0x10,%al
  102ab5:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102aba:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ac1:	24 9f                	and    $0x9f,%al
  102ac3:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ac8:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102acf:	0c 80                	or     $0x80,%al
  102ad1:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ad6:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102add:	24 f0                	and    $0xf0,%al
  102adf:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102ae4:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102aeb:	24 ef                	and    $0xef,%al
  102aed:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102af2:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102af9:	24 df                	and    $0xdf,%al
  102afb:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b00:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b07:	0c 40                	or     $0x40,%al
  102b09:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b0e:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b15:	24 7f                	and    $0x7f,%al
  102b17:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b1c:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102b21:	c1 e8 18             	shr    $0x18,%eax
  102b24:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102b29:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b30:	24 ef                	and    $0xef,%al
  102b32:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102b37:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102b3e:	e8 dd fe ff ff       	call   102a20 <lgdt>
  102b43:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102b49:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102b4d:	0f 00 d8             	ltr    %ax
}
  102b50:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102b51:	90                   	nop
  102b52:	c9                   	leave  
  102b53:	c3                   	ret    

00102b54 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102b54:	f3 0f 1e fb          	endbr32 
  102b58:	55                   	push   %ebp
  102b59:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102b5b:	e8 f6 fe ff ff       	call   102a56 <gdt_init>
}
  102b60:	90                   	nop
  102b61:	5d                   	pop    %ebp
  102b62:	c3                   	ret    

00102b63 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102b63:	f3 0f 1e fb          	endbr32 
  102b67:	55                   	push   %ebp
  102b68:	89 e5                	mov    %esp,%ebp
  102b6a:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102b74:	eb 03                	jmp    102b79 <strlen+0x16>
        cnt ++;
  102b76:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102b79:	8b 45 08             	mov    0x8(%ebp),%eax
  102b7c:	8d 50 01             	lea    0x1(%eax),%edx
  102b7f:	89 55 08             	mov    %edx,0x8(%ebp)
  102b82:	0f b6 00             	movzbl (%eax),%eax
  102b85:	84 c0                	test   %al,%al
  102b87:	75 ed                	jne    102b76 <strlen+0x13>
    }
    return cnt;
  102b89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b8c:	c9                   	leave  
  102b8d:	c3                   	ret    

00102b8e <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102b8e:	f3 0f 1e fb          	endbr32 
  102b92:	55                   	push   %ebp
  102b93:	89 e5                	mov    %esp,%ebp
  102b95:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b9f:	eb 03                	jmp    102ba4 <strnlen+0x16>
        cnt ++;
  102ba1:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102ba4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ba7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102baa:	73 10                	jae    102bbc <strnlen+0x2e>
  102bac:	8b 45 08             	mov    0x8(%ebp),%eax
  102baf:	8d 50 01             	lea    0x1(%eax),%edx
  102bb2:	89 55 08             	mov    %edx,0x8(%ebp)
  102bb5:	0f b6 00             	movzbl (%eax),%eax
  102bb8:	84 c0                	test   %al,%al
  102bba:	75 e5                	jne    102ba1 <strnlen+0x13>
    }
    return cnt;
  102bbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102bbf:	c9                   	leave  
  102bc0:	c3                   	ret    

00102bc1 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102bc1:	f3 0f 1e fb          	endbr32 
  102bc5:	55                   	push   %ebp
  102bc6:	89 e5                	mov    %esp,%ebp
  102bc8:	57                   	push   %edi
  102bc9:	56                   	push   %esi
  102bca:	83 ec 20             	sub    $0x20,%esp
  102bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102bd3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102bd9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102bdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bdf:	89 d1                	mov    %edx,%ecx
  102be1:	89 c2                	mov    %eax,%edx
  102be3:	89 ce                	mov    %ecx,%esi
  102be5:	89 d7                	mov    %edx,%edi
  102be7:	ac                   	lods   %ds:(%esi),%al
  102be8:	aa                   	stos   %al,%es:(%edi)
  102be9:	84 c0                	test   %al,%al
  102beb:	75 fa                	jne    102be7 <strcpy+0x26>
  102bed:	89 fa                	mov    %edi,%edx
  102bef:	89 f1                	mov    %esi,%ecx
  102bf1:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102bf4:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102bf7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102bfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102bfd:	83 c4 20             	add    $0x20,%esp
  102c00:	5e                   	pop    %esi
  102c01:	5f                   	pop    %edi
  102c02:	5d                   	pop    %ebp
  102c03:	c3                   	ret    

00102c04 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102c04:	f3 0f 1e fb          	endbr32 
  102c08:	55                   	push   %ebp
  102c09:	89 e5                	mov    %esp,%ebp
  102c0b:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  102c11:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102c14:	eb 1e                	jmp    102c34 <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102c16:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c19:	0f b6 10             	movzbl (%eax),%edx
  102c1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c1f:	88 10                	mov    %dl,(%eax)
  102c21:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c24:	0f b6 00             	movzbl (%eax),%eax
  102c27:	84 c0                	test   %al,%al
  102c29:	74 03                	je     102c2e <strncpy+0x2a>
            src ++;
  102c2b:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102c2e:	ff 45 fc             	incl   -0x4(%ebp)
  102c31:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102c34:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c38:	75 dc                	jne    102c16 <strncpy+0x12>
    }
    return dst;
  102c3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c3d:	c9                   	leave  
  102c3e:	c3                   	ret    

00102c3f <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102c3f:	f3 0f 1e fb          	endbr32 
  102c43:	55                   	push   %ebp
  102c44:	89 e5                	mov    %esp,%ebp
  102c46:	57                   	push   %edi
  102c47:	56                   	push   %esi
  102c48:	83 ec 20             	sub    $0x20,%esp
  102c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c51:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c54:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102c57:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c5d:	89 d1                	mov    %edx,%ecx
  102c5f:	89 c2                	mov    %eax,%edx
  102c61:	89 ce                	mov    %ecx,%esi
  102c63:	89 d7                	mov    %edx,%edi
  102c65:	ac                   	lods   %ds:(%esi),%al
  102c66:	ae                   	scas   %es:(%edi),%al
  102c67:	75 08                	jne    102c71 <strcmp+0x32>
  102c69:	84 c0                	test   %al,%al
  102c6b:	75 f8                	jne    102c65 <strcmp+0x26>
  102c6d:	31 c0                	xor    %eax,%eax
  102c6f:	eb 04                	jmp    102c75 <strcmp+0x36>
  102c71:	19 c0                	sbb    %eax,%eax
  102c73:	0c 01                	or     $0x1,%al
  102c75:	89 fa                	mov    %edi,%edx
  102c77:	89 f1                	mov    %esi,%ecx
  102c79:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102c7c:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102c7f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102c82:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102c85:	83 c4 20             	add    $0x20,%esp
  102c88:	5e                   	pop    %esi
  102c89:	5f                   	pop    %edi
  102c8a:	5d                   	pop    %ebp
  102c8b:	c3                   	ret    

00102c8c <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102c8c:	f3 0f 1e fb          	endbr32 
  102c90:	55                   	push   %ebp
  102c91:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c93:	eb 09                	jmp    102c9e <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102c95:	ff 4d 10             	decl   0x10(%ebp)
  102c98:	ff 45 08             	incl   0x8(%ebp)
  102c9b:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ca2:	74 1a                	je     102cbe <strncmp+0x32>
  102ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca7:	0f b6 00             	movzbl (%eax),%eax
  102caa:	84 c0                	test   %al,%al
  102cac:	74 10                	je     102cbe <strncmp+0x32>
  102cae:	8b 45 08             	mov    0x8(%ebp),%eax
  102cb1:	0f b6 10             	movzbl (%eax),%edx
  102cb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cb7:	0f b6 00             	movzbl (%eax),%eax
  102cba:	38 c2                	cmp    %al,%dl
  102cbc:	74 d7                	je     102c95 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102cbe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102cc2:	74 18                	je     102cdc <strncmp+0x50>
  102cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc7:	0f b6 00             	movzbl (%eax),%eax
  102cca:	0f b6 d0             	movzbl %al,%edx
  102ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cd0:	0f b6 00             	movzbl (%eax),%eax
  102cd3:	0f b6 c0             	movzbl %al,%eax
  102cd6:	29 c2                	sub    %eax,%edx
  102cd8:	89 d0                	mov    %edx,%eax
  102cda:	eb 05                	jmp    102ce1 <strncmp+0x55>
  102cdc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102ce1:	5d                   	pop    %ebp
  102ce2:	c3                   	ret    

00102ce3 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102ce3:	f3 0f 1e fb          	endbr32 
  102ce7:	55                   	push   %ebp
  102ce8:	89 e5                	mov    %esp,%ebp
  102cea:	83 ec 04             	sub    $0x4,%esp
  102ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cf0:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102cf3:	eb 13                	jmp    102d08 <strchr+0x25>
        if (*s == c) {
  102cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  102cf8:	0f b6 00             	movzbl (%eax),%eax
  102cfb:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102cfe:	75 05                	jne    102d05 <strchr+0x22>
            return (char *)s;
  102d00:	8b 45 08             	mov    0x8(%ebp),%eax
  102d03:	eb 12                	jmp    102d17 <strchr+0x34>
        }
        s ++;
  102d05:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d08:	8b 45 08             	mov    0x8(%ebp),%eax
  102d0b:	0f b6 00             	movzbl (%eax),%eax
  102d0e:	84 c0                	test   %al,%al
  102d10:	75 e3                	jne    102cf5 <strchr+0x12>
    }
    return NULL;
  102d12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d17:	c9                   	leave  
  102d18:	c3                   	ret    

00102d19 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102d19:	f3 0f 1e fb          	endbr32 
  102d1d:	55                   	push   %ebp
  102d1e:	89 e5                	mov    %esp,%ebp
  102d20:	83 ec 04             	sub    $0x4,%esp
  102d23:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d26:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d29:	eb 0e                	jmp    102d39 <strfind+0x20>
        if (*s == c) {
  102d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  102d2e:	0f b6 00             	movzbl (%eax),%eax
  102d31:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d34:	74 0f                	je     102d45 <strfind+0x2c>
            break;
        }
        s ++;
  102d36:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d39:	8b 45 08             	mov    0x8(%ebp),%eax
  102d3c:	0f b6 00             	movzbl (%eax),%eax
  102d3f:	84 c0                	test   %al,%al
  102d41:	75 e8                	jne    102d2b <strfind+0x12>
  102d43:	eb 01                	jmp    102d46 <strfind+0x2d>
            break;
  102d45:	90                   	nop
    }
    return (char *)s;
  102d46:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102d49:	c9                   	leave  
  102d4a:	c3                   	ret    

00102d4b <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102d4b:	f3 0f 1e fb          	endbr32 
  102d4f:	55                   	push   %ebp
  102d50:	89 e5                	mov    %esp,%ebp
  102d52:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102d55:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102d5c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102d63:	eb 03                	jmp    102d68 <strtol+0x1d>
        s ++;
  102d65:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102d68:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6b:	0f b6 00             	movzbl (%eax),%eax
  102d6e:	3c 20                	cmp    $0x20,%al
  102d70:	74 f3                	je     102d65 <strtol+0x1a>
  102d72:	8b 45 08             	mov    0x8(%ebp),%eax
  102d75:	0f b6 00             	movzbl (%eax),%eax
  102d78:	3c 09                	cmp    $0x9,%al
  102d7a:	74 e9                	je     102d65 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7f:	0f b6 00             	movzbl (%eax),%eax
  102d82:	3c 2b                	cmp    $0x2b,%al
  102d84:	75 05                	jne    102d8b <strtol+0x40>
        s ++;
  102d86:	ff 45 08             	incl   0x8(%ebp)
  102d89:	eb 14                	jmp    102d9f <strtol+0x54>
    }
    else if (*s == '-') {
  102d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  102d8e:	0f b6 00             	movzbl (%eax),%eax
  102d91:	3c 2d                	cmp    $0x2d,%al
  102d93:	75 0a                	jne    102d9f <strtol+0x54>
        s ++, neg = 1;
  102d95:	ff 45 08             	incl   0x8(%ebp)
  102d98:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102d9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102da3:	74 06                	je     102dab <strtol+0x60>
  102da5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102da9:	75 22                	jne    102dcd <strtol+0x82>
  102dab:	8b 45 08             	mov    0x8(%ebp),%eax
  102dae:	0f b6 00             	movzbl (%eax),%eax
  102db1:	3c 30                	cmp    $0x30,%al
  102db3:	75 18                	jne    102dcd <strtol+0x82>
  102db5:	8b 45 08             	mov    0x8(%ebp),%eax
  102db8:	40                   	inc    %eax
  102db9:	0f b6 00             	movzbl (%eax),%eax
  102dbc:	3c 78                	cmp    $0x78,%al
  102dbe:	75 0d                	jne    102dcd <strtol+0x82>
        s += 2, base = 16;
  102dc0:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102dc4:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102dcb:	eb 29                	jmp    102df6 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102dcd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dd1:	75 16                	jne    102de9 <strtol+0x9e>
  102dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd6:	0f b6 00             	movzbl (%eax),%eax
  102dd9:	3c 30                	cmp    $0x30,%al
  102ddb:	75 0c                	jne    102de9 <strtol+0x9e>
        s ++, base = 8;
  102ddd:	ff 45 08             	incl   0x8(%ebp)
  102de0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102de7:	eb 0d                	jmp    102df6 <strtol+0xab>
    }
    else if (base == 0) {
  102de9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ded:	75 07                	jne    102df6 <strtol+0xab>
        base = 10;
  102def:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102df6:	8b 45 08             	mov    0x8(%ebp),%eax
  102df9:	0f b6 00             	movzbl (%eax),%eax
  102dfc:	3c 2f                	cmp    $0x2f,%al
  102dfe:	7e 1b                	jle    102e1b <strtol+0xd0>
  102e00:	8b 45 08             	mov    0x8(%ebp),%eax
  102e03:	0f b6 00             	movzbl (%eax),%eax
  102e06:	3c 39                	cmp    $0x39,%al
  102e08:	7f 11                	jg     102e1b <strtol+0xd0>
            dig = *s - '0';
  102e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e0d:	0f b6 00             	movzbl (%eax),%eax
  102e10:	0f be c0             	movsbl %al,%eax
  102e13:	83 e8 30             	sub    $0x30,%eax
  102e16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e19:	eb 48                	jmp    102e63 <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e1e:	0f b6 00             	movzbl (%eax),%eax
  102e21:	3c 60                	cmp    $0x60,%al
  102e23:	7e 1b                	jle    102e40 <strtol+0xf5>
  102e25:	8b 45 08             	mov    0x8(%ebp),%eax
  102e28:	0f b6 00             	movzbl (%eax),%eax
  102e2b:	3c 7a                	cmp    $0x7a,%al
  102e2d:	7f 11                	jg     102e40 <strtol+0xf5>
            dig = *s - 'a' + 10;
  102e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e32:	0f b6 00             	movzbl (%eax),%eax
  102e35:	0f be c0             	movsbl %al,%eax
  102e38:	83 e8 57             	sub    $0x57,%eax
  102e3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e3e:	eb 23                	jmp    102e63 <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102e40:	8b 45 08             	mov    0x8(%ebp),%eax
  102e43:	0f b6 00             	movzbl (%eax),%eax
  102e46:	3c 40                	cmp    $0x40,%al
  102e48:	7e 3b                	jle    102e85 <strtol+0x13a>
  102e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e4d:	0f b6 00             	movzbl (%eax),%eax
  102e50:	3c 5a                	cmp    $0x5a,%al
  102e52:	7f 31                	jg     102e85 <strtol+0x13a>
            dig = *s - 'A' + 10;
  102e54:	8b 45 08             	mov    0x8(%ebp),%eax
  102e57:	0f b6 00             	movzbl (%eax),%eax
  102e5a:	0f be c0             	movsbl %al,%eax
  102e5d:	83 e8 37             	sub    $0x37,%eax
  102e60:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102e63:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e66:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e69:	7d 19                	jge    102e84 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102e6b:	ff 45 08             	incl   0x8(%ebp)
  102e6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e71:	0f af 45 10          	imul   0x10(%ebp),%eax
  102e75:	89 c2                	mov    %eax,%edx
  102e77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e7a:	01 d0                	add    %edx,%eax
  102e7c:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102e7f:	e9 72 ff ff ff       	jmp    102df6 <strtol+0xab>
            break;
  102e84:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102e85:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e89:	74 08                	je     102e93 <strtol+0x148>
        *endptr = (char *) s;
  102e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e8e:	8b 55 08             	mov    0x8(%ebp),%edx
  102e91:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102e93:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102e97:	74 07                	je     102ea0 <strtol+0x155>
  102e99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e9c:	f7 d8                	neg    %eax
  102e9e:	eb 03                	jmp    102ea3 <strtol+0x158>
  102ea0:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102ea3:	c9                   	leave  
  102ea4:	c3                   	ret    

00102ea5 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102ea5:	f3 0f 1e fb          	endbr32 
  102ea9:	55                   	push   %ebp
  102eaa:	89 e5                	mov    %esp,%ebp
  102eac:	57                   	push   %edi
  102ead:	83 ec 24             	sub    $0x24,%esp
  102eb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102eb3:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102eb6:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102eba:	8b 45 08             	mov    0x8(%ebp),%eax
  102ebd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102ec0:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  102ec6:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102ec9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102ecc:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102ed0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102ed3:	89 d7                	mov    %edx,%edi
  102ed5:	f3 aa                	rep stos %al,%es:(%edi)
  102ed7:	89 fa                	mov    %edi,%edx
  102ed9:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102edc:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102edf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102ee2:	83 c4 24             	add    $0x24,%esp
  102ee5:	5f                   	pop    %edi
  102ee6:	5d                   	pop    %ebp
  102ee7:	c3                   	ret    

00102ee8 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102ee8:	f3 0f 1e fb          	endbr32 
  102eec:	55                   	push   %ebp
  102eed:	89 e5                	mov    %esp,%ebp
  102eef:	57                   	push   %edi
  102ef0:	56                   	push   %esi
  102ef1:	53                   	push   %ebx
  102ef2:	83 ec 30             	sub    $0x30,%esp
  102ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  102ef8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102efb:	8b 45 0c             	mov    0xc(%ebp),%eax
  102efe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102f01:	8b 45 10             	mov    0x10(%ebp),%eax
  102f04:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102f07:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f0a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102f0d:	73 42                	jae    102f51 <memmove+0x69>
  102f0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102f15:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f18:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102f1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f1e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102f21:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102f24:	c1 e8 02             	shr    $0x2,%eax
  102f27:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f29:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102f2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f2f:	89 d7                	mov    %edx,%edi
  102f31:	89 c6                	mov    %eax,%esi
  102f33:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f35:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102f38:	83 e1 03             	and    $0x3,%ecx
  102f3b:	74 02                	je     102f3f <memmove+0x57>
  102f3d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f3f:	89 f0                	mov    %esi,%eax
  102f41:	89 fa                	mov    %edi,%edx
  102f43:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102f46:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102f49:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102f4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102f4f:	eb 36                	jmp    102f87 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102f51:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f54:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f57:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f5a:	01 c2                	add    %eax,%edx
  102f5c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f5f:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102f62:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f65:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102f68:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f6b:	89 c1                	mov    %eax,%ecx
  102f6d:	89 d8                	mov    %ebx,%eax
  102f6f:	89 d6                	mov    %edx,%esi
  102f71:	89 c7                	mov    %eax,%edi
  102f73:	fd                   	std    
  102f74:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f76:	fc                   	cld    
  102f77:	89 f8                	mov    %edi,%eax
  102f79:	89 f2                	mov    %esi,%edx
  102f7b:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102f7e:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102f81:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102f84:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102f87:	83 c4 30             	add    $0x30,%esp
  102f8a:	5b                   	pop    %ebx
  102f8b:	5e                   	pop    %esi
  102f8c:	5f                   	pop    %edi
  102f8d:	5d                   	pop    %ebp
  102f8e:	c3                   	ret    

00102f8f <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102f8f:	f3 0f 1e fb          	endbr32 
  102f93:	55                   	push   %ebp
  102f94:	89 e5                	mov    %esp,%ebp
  102f96:	57                   	push   %edi
  102f97:	56                   	push   %esi
  102f98:	83 ec 20             	sub    $0x20,%esp
  102f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  102f9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102fa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fa4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fa7:	8b 45 10             	mov    0x10(%ebp),%eax
  102faa:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102fad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102fb0:	c1 e8 02             	shr    $0x2,%eax
  102fb3:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102fb5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fbb:	89 d7                	mov    %edx,%edi
  102fbd:	89 c6                	mov    %eax,%esi
  102fbf:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102fc1:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102fc4:	83 e1 03             	and    $0x3,%ecx
  102fc7:	74 02                	je     102fcb <memcpy+0x3c>
  102fc9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102fcb:	89 f0                	mov    %esi,%eax
  102fcd:	89 fa                	mov    %edi,%edx
  102fcf:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102fd2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102fd5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102fd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102fdb:	83 c4 20             	add    $0x20,%esp
  102fde:	5e                   	pop    %esi
  102fdf:	5f                   	pop    %edi
  102fe0:	5d                   	pop    %ebp
  102fe1:	c3                   	ret    

00102fe2 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102fe2:	f3 0f 1e fb          	endbr32 
  102fe6:	55                   	push   %ebp
  102fe7:	89 e5                	mov    %esp,%ebp
  102fe9:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102fec:	8b 45 08             	mov    0x8(%ebp),%eax
  102fef:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ff5:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102ff8:	eb 2e                	jmp    103028 <memcmp+0x46>
        if (*s1 != *s2) {
  102ffa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ffd:	0f b6 10             	movzbl (%eax),%edx
  103000:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103003:	0f b6 00             	movzbl (%eax),%eax
  103006:	38 c2                	cmp    %al,%dl
  103008:	74 18                	je     103022 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10300a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10300d:	0f b6 00             	movzbl (%eax),%eax
  103010:	0f b6 d0             	movzbl %al,%edx
  103013:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103016:	0f b6 00             	movzbl (%eax),%eax
  103019:	0f b6 c0             	movzbl %al,%eax
  10301c:	29 c2                	sub    %eax,%edx
  10301e:	89 d0                	mov    %edx,%eax
  103020:	eb 18                	jmp    10303a <memcmp+0x58>
        }
        s1 ++, s2 ++;
  103022:	ff 45 fc             	incl   -0x4(%ebp)
  103025:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  103028:	8b 45 10             	mov    0x10(%ebp),%eax
  10302b:	8d 50 ff             	lea    -0x1(%eax),%edx
  10302e:	89 55 10             	mov    %edx,0x10(%ebp)
  103031:	85 c0                	test   %eax,%eax
  103033:	75 c5                	jne    102ffa <memcmp+0x18>
    }
    return 0;
  103035:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10303a:	c9                   	leave  
  10303b:	c3                   	ret    

0010303c <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  10303c:	f3 0f 1e fb          	endbr32 
  103040:	55                   	push   %ebp
  103041:	89 e5                	mov    %esp,%ebp
  103043:	83 ec 58             	sub    $0x58,%esp
  103046:	8b 45 10             	mov    0x10(%ebp),%eax
  103049:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10304c:	8b 45 14             	mov    0x14(%ebp),%eax
  10304f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  103052:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103055:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103058:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10305b:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  10305e:	8b 45 18             	mov    0x18(%ebp),%eax
  103061:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103064:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103067:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10306a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10306d:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103070:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103073:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103076:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10307a:	74 1c                	je     103098 <printnum+0x5c>
  10307c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10307f:	ba 00 00 00 00       	mov    $0x0,%edx
  103084:	f7 75 e4             	divl   -0x1c(%ebp)
  103087:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10308a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10308d:	ba 00 00 00 00       	mov    $0x0,%edx
  103092:	f7 75 e4             	divl   -0x1c(%ebp)
  103095:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103098:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10309b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10309e:	f7 75 e4             	divl   -0x1c(%ebp)
  1030a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1030a4:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1030a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1030aa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1030ad:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1030b0:	89 55 ec             	mov    %edx,-0x14(%ebp)
  1030b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1030b6:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  1030b9:	8b 45 18             	mov    0x18(%ebp),%eax
  1030bc:	ba 00 00 00 00       	mov    $0x0,%edx
  1030c1:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1030c4:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1030c7:	19 d1                	sbb    %edx,%ecx
  1030c9:	72 4c                	jb     103117 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  1030cb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1030ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030d1:	8b 45 20             	mov    0x20(%ebp),%eax
  1030d4:	89 44 24 18          	mov    %eax,0x18(%esp)
  1030d8:	89 54 24 14          	mov    %edx,0x14(%esp)
  1030dc:	8b 45 18             	mov    0x18(%ebp),%eax
  1030df:	89 44 24 10          	mov    %eax,0x10(%esp)
  1030e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030e9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030ed:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1030f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1030fb:	89 04 24             	mov    %eax,(%esp)
  1030fe:	e8 39 ff ff ff       	call   10303c <printnum>
  103103:	eb 1b                	jmp    103120 <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  103105:	8b 45 0c             	mov    0xc(%ebp),%eax
  103108:	89 44 24 04          	mov    %eax,0x4(%esp)
  10310c:	8b 45 20             	mov    0x20(%ebp),%eax
  10310f:	89 04 24             	mov    %eax,(%esp)
  103112:	8b 45 08             	mov    0x8(%ebp),%eax
  103115:	ff d0                	call   *%eax
        while (-- width > 0)
  103117:	ff 4d 1c             	decl   0x1c(%ebp)
  10311a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10311e:	7f e5                	jg     103105 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  103120:	8b 45 d8             	mov    -0x28(%ebp),%eax
  103123:	05 90 3e 10 00       	add    $0x103e90,%eax
  103128:	0f b6 00             	movzbl (%eax),%eax
  10312b:	0f be c0             	movsbl %al,%eax
  10312e:	8b 55 0c             	mov    0xc(%ebp),%edx
  103131:	89 54 24 04          	mov    %edx,0x4(%esp)
  103135:	89 04 24             	mov    %eax,(%esp)
  103138:	8b 45 08             	mov    0x8(%ebp),%eax
  10313b:	ff d0                	call   *%eax
}
  10313d:	90                   	nop
  10313e:	c9                   	leave  
  10313f:	c3                   	ret    

00103140 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  103140:	f3 0f 1e fb          	endbr32 
  103144:	55                   	push   %ebp
  103145:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103147:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10314b:	7e 14                	jle    103161 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  10314d:	8b 45 08             	mov    0x8(%ebp),%eax
  103150:	8b 00                	mov    (%eax),%eax
  103152:	8d 48 08             	lea    0x8(%eax),%ecx
  103155:	8b 55 08             	mov    0x8(%ebp),%edx
  103158:	89 0a                	mov    %ecx,(%edx)
  10315a:	8b 50 04             	mov    0x4(%eax),%edx
  10315d:	8b 00                	mov    (%eax),%eax
  10315f:	eb 30                	jmp    103191 <getuint+0x51>
    }
    else if (lflag) {
  103161:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103165:	74 16                	je     10317d <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  103167:	8b 45 08             	mov    0x8(%ebp),%eax
  10316a:	8b 00                	mov    (%eax),%eax
  10316c:	8d 48 04             	lea    0x4(%eax),%ecx
  10316f:	8b 55 08             	mov    0x8(%ebp),%edx
  103172:	89 0a                	mov    %ecx,(%edx)
  103174:	8b 00                	mov    (%eax),%eax
  103176:	ba 00 00 00 00       	mov    $0x0,%edx
  10317b:	eb 14                	jmp    103191 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  10317d:	8b 45 08             	mov    0x8(%ebp),%eax
  103180:	8b 00                	mov    (%eax),%eax
  103182:	8d 48 04             	lea    0x4(%eax),%ecx
  103185:	8b 55 08             	mov    0x8(%ebp),%edx
  103188:	89 0a                	mov    %ecx,(%edx)
  10318a:	8b 00                	mov    (%eax),%eax
  10318c:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  103191:	5d                   	pop    %ebp
  103192:	c3                   	ret    

00103193 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103193:	f3 0f 1e fb          	endbr32 
  103197:	55                   	push   %ebp
  103198:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  10319a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10319e:	7e 14                	jle    1031b4 <getint+0x21>
        return va_arg(*ap, long long);
  1031a0:	8b 45 08             	mov    0x8(%ebp),%eax
  1031a3:	8b 00                	mov    (%eax),%eax
  1031a5:	8d 48 08             	lea    0x8(%eax),%ecx
  1031a8:	8b 55 08             	mov    0x8(%ebp),%edx
  1031ab:	89 0a                	mov    %ecx,(%edx)
  1031ad:	8b 50 04             	mov    0x4(%eax),%edx
  1031b0:	8b 00                	mov    (%eax),%eax
  1031b2:	eb 28                	jmp    1031dc <getint+0x49>
    }
    else if (lflag) {
  1031b4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1031b8:	74 12                	je     1031cc <getint+0x39>
        return va_arg(*ap, long);
  1031ba:	8b 45 08             	mov    0x8(%ebp),%eax
  1031bd:	8b 00                	mov    (%eax),%eax
  1031bf:	8d 48 04             	lea    0x4(%eax),%ecx
  1031c2:	8b 55 08             	mov    0x8(%ebp),%edx
  1031c5:	89 0a                	mov    %ecx,(%edx)
  1031c7:	8b 00                	mov    (%eax),%eax
  1031c9:	99                   	cltd   
  1031ca:	eb 10                	jmp    1031dc <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  1031cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1031cf:	8b 00                	mov    (%eax),%eax
  1031d1:	8d 48 04             	lea    0x4(%eax),%ecx
  1031d4:	8b 55 08             	mov    0x8(%ebp),%edx
  1031d7:	89 0a                	mov    %ecx,(%edx)
  1031d9:	8b 00                	mov    (%eax),%eax
  1031db:	99                   	cltd   
    }
}
  1031dc:	5d                   	pop    %ebp
  1031dd:	c3                   	ret    

001031de <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1031de:	f3 0f 1e fb          	endbr32 
  1031e2:	55                   	push   %ebp
  1031e3:	89 e5                	mov    %esp,%ebp
  1031e5:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1031e8:	8d 45 14             	lea    0x14(%ebp),%eax
  1031eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1031ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1031f5:	8b 45 10             	mov    0x10(%ebp),%eax
  1031f8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031ff:	89 44 24 04          	mov    %eax,0x4(%esp)
  103203:	8b 45 08             	mov    0x8(%ebp),%eax
  103206:	89 04 24             	mov    %eax,(%esp)
  103209:	e8 03 00 00 00       	call   103211 <vprintfmt>
    va_end(ap);
}
  10320e:	90                   	nop
  10320f:	c9                   	leave  
  103210:	c3                   	ret    

00103211 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103211:	f3 0f 1e fb          	endbr32 
  103215:	55                   	push   %ebp
  103216:	89 e5                	mov    %esp,%ebp
  103218:	56                   	push   %esi
  103219:	53                   	push   %ebx
  10321a:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10321d:	eb 17                	jmp    103236 <vprintfmt+0x25>
            if (ch == '\0') {
  10321f:	85 db                	test   %ebx,%ebx
  103221:	0f 84 c0 03 00 00    	je     1035e7 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  103227:	8b 45 0c             	mov    0xc(%ebp),%eax
  10322a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10322e:	89 1c 24             	mov    %ebx,(%esp)
  103231:	8b 45 08             	mov    0x8(%ebp),%eax
  103234:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103236:	8b 45 10             	mov    0x10(%ebp),%eax
  103239:	8d 50 01             	lea    0x1(%eax),%edx
  10323c:	89 55 10             	mov    %edx,0x10(%ebp)
  10323f:	0f b6 00             	movzbl (%eax),%eax
  103242:	0f b6 d8             	movzbl %al,%ebx
  103245:	83 fb 25             	cmp    $0x25,%ebx
  103248:	75 d5                	jne    10321f <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  10324a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10324e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103255:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103258:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  10325b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  103262:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103265:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103268:	8b 45 10             	mov    0x10(%ebp),%eax
  10326b:	8d 50 01             	lea    0x1(%eax),%edx
  10326e:	89 55 10             	mov    %edx,0x10(%ebp)
  103271:	0f b6 00             	movzbl (%eax),%eax
  103274:	0f b6 d8             	movzbl %al,%ebx
  103277:	8d 43 dd             	lea    -0x23(%ebx),%eax
  10327a:	83 f8 55             	cmp    $0x55,%eax
  10327d:	0f 87 38 03 00 00    	ja     1035bb <vprintfmt+0x3aa>
  103283:	8b 04 85 b4 3e 10 00 	mov    0x103eb4(,%eax,4),%eax
  10328a:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  10328d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  103291:	eb d5                	jmp    103268 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  103293:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  103297:	eb cf                	jmp    103268 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103299:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1032a0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1032a3:	89 d0                	mov    %edx,%eax
  1032a5:	c1 e0 02             	shl    $0x2,%eax
  1032a8:	01 d0                	add    %edx,%eax
  1032aa:	01 c0                	add    %eax,%eax
  1032ac:	01 d8                	add    %ebx,%eax
  1032ae:	83 e8 30             	sub    $0x30,%eax
  1032b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1032b4:	8b 45 10             	mov    0x10(%ebp),%eax
  1032b7:	0f b6 00             	movzbl (%eax),%eax
  1032ba:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1032bd:	83 fb 2f             	cmp    $0x2f,%ebx
  1032c0:	7e 38                	jle    1032fa <vprintfmt+0xe9>
  1032c2:	83 fb 39             	cmp    $0x39,%ebx
  1032c5:	7f 33                	jg     1032fa <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  1032c7:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1032ca:	eb d4                	jmp    1032a0 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1032cc:	8b 45 14             	mov    0x14(%ebp),%eax
  1032cf:	8d 50 04             	lea    0x4(%eax),%edx
  1032d2:	89 55 14             	mov    %edx,0x14(%ebp)
  1032d5:	8b 00                	mov    (%eax),%eax
  1032d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1032da:	eb 1f                	jmp    1032fb <vprintfmt+0xea>

        case '.':
            if (width < 0)
  1032dc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032e0:	79 86                	jns    103268 <vprintfmt+0x57>
                width = 0;
  1032e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  1032e9:	e9 7a ff ff ff       	jmp    103268 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  1032ee:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  1032f5:	e9 6e ff ff ff       	jmp    103268 <vprintfmt+0x57>
            goto process_precision;
  1032fa:	90                   	nop

        process_precision:
            if (width < 0)
  1032fb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032ff:	0f 89 63 ff ff ff    	jns    103268 <vprintfmt+0x57>
                width = precision, precision = -1;
  103305:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103308:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10330b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  103312:	e9 51 ff ff ff       	jmp    103268 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103317:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  10331a:	e9 49 ff ff ff       	jmp    103268 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  10331f:	8b 45 14             	mov    0x14(%ebp),%eax
  103322:	8d 50 04             	lea    0x4(%eax),%edx
  103325:	89 55 14             	mov    %edx,0x14(%ebp)
  103328:	8b 00                	mov    (%eax),%eax
  10332a:	8b 55 0c             	mov    0xc(%ebp),%edx
  10332d:	89 54 24 04          	mov    %edx,0x4(%esp)
  103331:	89 04 24             	mov    %eax,(%esp)
  103334:	8b 45 08             	mov    0x8(%ebp),%eax
  103337:	ff d0                	call   *%eax
            break;
  103339:	e9 a4 02 00 00       	jmp    1035e2 <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  10333e:	8b 45 14             	mov    0x14(%ebp),%eax
  103341:	8d 50 04             	lea    0x4(%eax),%edx
  103344:	89 55 14             	mov    %edx,0x14(%ebp)
  103347:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103349:	85 db                	test   %ebx,%ebx
  10334b:	79 02                	jns    10334f <vprintfmt+0x13e>
                err = -err;
  10334d:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10334f:	83 fb 06             	cmp    $0x6,%ebx
  103352:	7f 0b                	jg     10335f <vprintfmt+0x14e>
  103354:	8b 34 9d 74 3e 10 00 	mov    0x103e74(,%ebx,4),%esi
  10335b:	85 f6                	test   %esi,%esi
  10335d:	75 23                	jne    103382 <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  10335f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  103363:	c7 44 24 08 a1 3e 10 	movl   $0x103ea1,0x8(%esp)
  10336a:	00 
  10336b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10336e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103372:	8b 45 08             	mov    0x8(%ebp),%eax
  103375:	89 04 24             	mov    %eax,(%esp)
  103378:	e8 61 fe ff ff       	call   1031de <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  10337d:	e9 60 02 00 00       	jmp    1035e2 <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  103382:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103386:	c7 44 24 08 aa 3e 10 	movl   $0x103eaa,0x8(%esp)
  10338d:	00 
  10338e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103391:	89 44 24 04          	mov    %eax,0x4(%esp)
  103395:	8b 45 08             	mov    0x8(%ebp),%eax
  103398:	89 04 24             	mov    %eax,(%esp)
  10339b:	e8 3e fe ff ff       	call   1031de <printfmt>
            break;
  1033a0:	e9 3d 02 00 00       	jmp    1035e2 <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1033a5:	8b 45 14             	mov    0x14(%ebp),%eax
  1033a8:	8d 50 04             	lea    0x4(%eax),%edx
  1033ab:	89 55 14             	mov    %edx,0x14(%ebp)
  1033ae:	8b 30                	mov    (%eax),%esi
  1033b0:	85 f6                	test   %esi,%esi
  1033b2:	75 05                	jne    1033b9 <vprintfmt+0x1a8>
                p = "(null)";
  1033b4:	be ad 3e 10 00       	mov    $0x103ead,%esi
            }
            if (width > 0 && padc != '-') {
  1033b9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033bd:	7e 76                	jle    103435 <vprintfmt+0x224>
  1033bf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  1033c3:	74 70                	je     103435 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033cc:	89 34 24             	mov    %esi,(%esp)
  1033cf:	e8 ba f7 ff ff       	call   102b8e <strnlen>
  1033d4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1033d7:	29 c2                	sub    %eax,%edx
  1033d9:	89 d0                	mov    %edx,%eax
  1033db:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1033de:	eb 16                	jmp    1033f6 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  1033e0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1033e4:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033e7:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033eb:	89 04 24             	mov    %eax,(%esp)
  1033ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1033f1:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033f3:	ff 4d e8             	decl   -0x18(%ebp)
  1033f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033fa:	7f e4                	jg     1033e0 <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1033fc:	eb 37                	jmp    103435 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  1033fe:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103402:	74 1f                	je     103423 <vprintfmt+0x212>
  103404:	83 fb 1f             	cmp    $0x1f,%ebx
  103407:	7e 05                	jle    10340e <vprintfmt+0x1fd>
  103409:	83 fb 7e             	cmp    $0x7e,%ebx
  10340c:	7e 15                	jle    103423 <vprintfmt+0x212>
                    putch('?', putdat);
  10340e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103411:	89 44 24 04          	mov    %eax,0x4(%esp)
  103415:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  10341c:	8b 45 08             	mov    0x8(%ebp),%eax
  10341f:	ff d0                	call   *%eax
  103421:	eb 0f                	jmp    103432 <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  103423:	8b 45 0c             	mov    0xc(%ebp),%eax
  103426:	89 44 24 04          	mov    %eax,0x4(%esp)
  10342a:	89 1c 24             	mov    %ebx,(%esp)
  10342d:	8b 45 08             	mov    0x8(%ebp),%eax
  103430:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103432:	ff 4d e8             	decl   -0x18(%ebp)
  103435:	89 f0                	mov    %esi,%eax
  103437:	8d 70 01             	lea    0x1(%eax),%esi
  10343a:	0f b6 00             	movzbl (%eax),%eax
  10343d:	0f be d8             	movsbl %al,%ebx
  103440:	85 db                	test   %ebx,%ebx
  103442:	74 27                	je     10346b <vprintfmt+0x25a>
  103444:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103448:	78 b4                	js     1033fe <vprintfmt+0x1ed>
  10344a:	ff 4d e4             	decl   -0x1c(%ebp)
  10344d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103451:	79 ab                	jns    1033fe <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  103453:	eb 16                	jmp    10346b <vprintfmt+0x25a>
                putch(' ', putdat);
  103455:	8b 45 0c             	mov    0xc(%ebp),%eax
  103458:	89 44 24 04          	mov    %eax,0x4(%esp)
  10345c:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  103463:	8b 45 08             	mov    0x8(%ebp),%eax
  103466:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103468:	ff 4d e8             	decl   -0x18(%ebp)
  10346b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10346f:	7f e4                	jg     103455 <vprintfmt+0x244>
            }
            break;
  103471:	e9 6c 01 00 00       	jmp    1035e2 <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103476:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103479:	89 44 24 04          	mov    %eax,0x4(%esp)
  10347d:	8d 45 14             	lea    0x14(%ebp),%eax
  103480:	89 04 24             	mov    %eax,(%esp)
  103483:	e8 0b fd ff ff       	call   103193 <getint>
  103488:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10348b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  10348e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103491:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103494:	85 d2                	test   %edx,%edx
  103496:	79 26                	jns    1034be <vprintfmt+0x2ad>
                putch('-', putdat);
  103498:	8b 45 0c             	mov    0xc(%ebp),%eax
  10349b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10349f:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  1034a6:	8b 45 08             	mov    0x8(%ebp),%eax
  1034a9:	ff d0                	call   *%eax
                num = -(long long)num;
  1034ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034b1:	f7 d8                	neg    %eax
  1034b3:	83 d2 00             	adc    $0x0,%edx
  1034b6:	f7 da                	neg    %edx
  1034b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  1034be:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034c5:	e9 a8 00 00 00       	jmp    103572 <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1034ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034d1:	8d 45 14             	lea    0x14(%ebp),%eax
  1034d4:	89 04 24             	mov    %eax,(%esp)
  1034d7:	e8 64 fc ff ff       	call   103140 <getuint>
  1034dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034df:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1034e2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034e9:	e9 84 00 00 00       	jmp    103572 <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1034ee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034f1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034f5:	8d 45 14             	lea    0x14(%ebp),%eax
  1034f8:	89 04 24             	mov    %eax,(%esp)
  1034fb:	e8 40 fc ff ff       	call   103140 <getuint>
  103500:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103503:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103506:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  10350d:	eb 63                	jmp    103572 <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  10350f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103512:	89 44 24 04          	mov    %eax,0x4(%esp)
  103516:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  10351d:	8b 45 08             	mov    0x8(%ebp),%eax
  103520:	ff d0                	call   *%eax
            putch('x', putdat);
  103522:	8b 45 0c             	mov    0xc(%ebp),%eax
  103525:	89 44 24 04          	mov    %eax,0x4(%esp)
  103529:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  103530:	8b 45 08             	mov    0x8(%ebp),%eax
  103533:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103535:	8b 45 14             	mov    0x14(%ebp),%eax
  103538:	8d 50 04             	lea    0x4(%eax),%edx
  10353b:	89 55 14             	mov    %edx,0x14(%ebp)
  10353e:	8b 00                	mov    (%eax),%eax
  103540:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103543:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  10354a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103551:	eb 1f                	jmp    103572 <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103553:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103556:	89 44 24 04          	mov    %eax,0x4(%esp)
  10355a:	8d 45 14             	lea    0x14(%ebp),%eax
  10355d:	89 04 24             	mov    %eax,(%esp)
  103560:	e8 db fb ff ff       	call   103140 <getuint>
  103565:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103568:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  10356b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  103572:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103576:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103579:	89 54 24 18          	mov    %edx,0x18(%esp)
  10357d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  103580:	89 54 24 14          	mov    %edx,0x14(%esp)
  103584:	89 44 24 10          	mov    %eax,0x10(%esp)
  103588:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10358b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10358e:	89 44 24 08          	mov    %eax,0x8(%esp)
  103592:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103596:	8b 45 0c             	mov    0xc(%ebp),%eax
  103599:	89 44 24 04          	mov    %eax,0x4(%esp)
  10359d:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a0:	89 04 24             	mov    %eax,(%esp)
  1035a3:	e8 94 fa ff ff       	call   10303c <printnum>
            break;
  1035a8:	eb 38                	jmp    1035e2 <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1035aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035ad:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035b1:	89 1c 24             	mov    %ebx,(%esp)
  1035b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1035b7:	ff d0                	call   *%eax
            break;
  1035b9:	eb 27                	jmp    1035e2 <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1035bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035c2:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1035c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1035cc:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  1035ce:	ff 4d 10             	decl   0x10(%ebp)
  1035d1:	eb 03                	jmp    1035d6 <vprintfmt+0x3c5>
  1035d3:	ff 4d 10             	decl   0x10(%ebp)
  1035d6:	8b 45 10             	mov    0x10(%ebp),%eax
  1035d9:	48                   	dec    %eax
  1035da:	0f b6 00             	movzbl (%eax),%eax
  1035dd:	3c 25                	cmp    $0x25,%al
  1035df:	75 f2                	jne    1035d3 <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  1035e1:	90                   	nop
    while (1) {
  1035e2:	e9 36 fc ff ff       	jmp    10321d <vprintfmt+0xc>
                return;
  1035e7:	90                   	nop
        }
    }
}
  1035e8:	83 c4 40             	add    $0x40,%esp
  1035eb:	5b                   	pop    %ebx
  1035ec:	5e                   	pop    %esi
  1035ed:	5d                   	pop    %ebp
  1035ee:	c3                   	ret    

001035ef <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1035ef:	f3 0f 1e fb          	endbr32 
  1035f3:	55                   	push   %ebp
  1035f4:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1035f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035f9:	8b 40 08             	mov    0x8(%eax),%eax
  1035fc:	8d 50 01             	lea    0x1(%eax),%edx
  1035ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103602:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103605:	8b 45 0c             	mov    0xc(%ebp),%eax
  103608:	8b 10                	mov    (%eax),%edx
  10360a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10360d:	8b 40 04             	mov    0x4(%eax),%eax
  103610:	39 c2                	cmp    %eax,%edx
  103612:	73 12                	jae    103626 <sprintputch+0x37>
        *b->buf ++ = ch;
  103614:	8b 45 0c             	mov    0xc(%ebp),%eax
  103617:	8b 00                	mov    (%eax),%eax
  103619:	8d 48 01             	lea    0x1(%eax),%ecx
  10361c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10361f:	89 0a                	mov    %ecx,(%edx)
  103621:	8b 55 08             	mov    0x8(%ebp),%edx
  103624:	88 10                	mov    %dl,(%eax)
    }
}
  103626:	90                   	nop
  103627:	5d                   	pop    %ebp
  103628:	c3                   	ret    

00103629 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103629:	f3 0f 1e fb          	endbr32 
  10362d:	55                   	push   %ebp
  10362e:	89 e5                	mov    %esp,%ebp
  103630:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103633:	8d 45 14             	lea    0x14(%ebp),%eax
  103636:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103639:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10363c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103640:	8b 45 10             	mov    0x10(%ebp),%eax
  103643:	89 44 24 08          	mov    %eax,0x8(%esp)
  103647:	8b 45 0c             	mov    0xc(%ebp),%eax
  10364a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10364e:	8b 45 08             	mov    0x8(%ebp),%eax
  103651:	89 04 24             	mov    %eax,(%esp)
  103654:	e8 08 00 00 00       	call   103661 <vsnprintf>
  103659:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10365c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10365f:	c9                   	leave  
  103660:	c3                   	ret    

00103661 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103661:	f3 0f 1e fb          	endbr32 
  103665:	55                   	push   %ebp
  103666:	89 e5                	mov    %esp,%ebp
  103668:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  10366b:	8b 45 08             	mov    0x8(%ebp),%eax
  10366e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103671:	8b 45 0c             	mov    0xc(%ebp),%eax
  103674:	8d 50 ff             	lea    -0x1(%eax),%edx
  103677:	8b 45 08             	mov    0x8(%ebp),%eax
  10367a:	01 d0                	add    %edx,%eax
  10367c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10367f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103686:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10368a:	74 0a                	je     103696 <vsnprintf+0x35>
  10368c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10368f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103692:	39 c2                	cmp    %eax,%edx
  103694:	76 07                	jbe    10369d <vsnprintf+0x3c>
        return -E_INVAL;
  103696:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  10369b:	eb 2a                	jmp    1036c7 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  10369d:	8b 45 14             	mov    0x14(%ebp),%eax
  1036a0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1036a4:	8b 45 10             	mov    0x10(%ebp),%eax
  1036a7:	89 44 24 08          	mov    %eax,0x8(%esp)
  1036ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1036ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036b2:	c7 04 24 ef 35 10 00 	movl   $0x1035ef,(%esp)
  1036b9:	e8 53 fb ff ff       	call   103211 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1036be:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036c1:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1036c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1036c7:	c9                   	leave  
  1036c8:	c3                   	ret    
