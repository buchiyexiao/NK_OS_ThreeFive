
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
  100027:	e8 54 2e 00 00       	call   102e80 <memset>

    cons_init();                // init the console
  10002c:	e8 22 16 00 00       	call   101653 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 c0 36 10 00 	movl   $0x1036c0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 dc 36 10 00 	movl   $0x1036dc,(%esp)
  100046:	e8 49 02 00 00       	call   100294 <cprintf>

    print_kerninfo();
  10004b:	e8 07 09 00 00       	call   100957 <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 d5 2a 00 00       	call   102b2f <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 49 17 00 00       	call   1017a8 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 c9 18 00 00       	call   10192d <idt_init>

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
  100145:	c7 04 24 e1 36 10 00 	movl   $0x1036e1,(%esp)
  10014c:	e8 43 01 00 00       	call   100294 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 ef 36 10 00 	movl   $0x1036ef,(%esp)
  10016b:	e8 24 01 00 00       	call   100294 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 fd 36 10 00 	movl   $0x1036fd,(%esp)
  10018a:	e8 05 01 00 00       	call   100294 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 0b 37 10 00 	movl   $0x10370b,(%esp)
  1001a9:	e8 e6 00 00 00       	call   100294 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 19 37 10 00 	movl   $0x103719,(%esp)
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
  100209:	c7 04 24 28 37 10 00 	movl   $0x103728,(%esp)
  100210:	e8 7f 00 00 00       	call   100294 <cprintf>
    lab1_switch_to_user();
  100215:	e8 c1 ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  10021a:	e8 fa fe ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10021f:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
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
  10028a:	e8 5d 2f 00 00       	call   1031ec <vprintfmt>
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
  10035e:	c7 04 24 67 37 10 00 	movl   $0x103767,(%esp)
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
  100431:	c7 04 24 6a 37 10 00 	movl   $0x10376a,(%esp)
  100438:	e8 57 fe ff ff       	call   100294 <cprintf>
    vcprintf(fmt, ap);
  10043d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100440:	89 44 24 04          	mov    %eax,0x4(%esp)
  100444:	8b 45 10             	mov    0x10(%ebp),%eax
  100447:	89 04 24             	mov    %eax,(%esp)
  10044a:	e8 0e fe ff ff       	call   10025d <vcprintf>
    cprintf("\n");
  10044f:	c7 04 24 86 37 10 00 	movl   $0x103786,(%esp)
  100456:	e8 39 fe ff ff       	call   100294 <cprintf>
    
    cprintf("stack trackback:\n");
  10045b:	c7 04 24 88 37 10 00 	movl   $0x103788,(%esp)
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
  1004a0:	c7 04 24 9a 37 10 00 	movl   $0x10379a,(%esp)
  1004a7:	e8 e8 fd ff ff       	call   100294 <cprintf>
    vcprintf(fmt, ap);
  1004ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004af:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004b3:	8b 45 10             	mov    0x10(%ebp),%eax
  1004b6:	89 04 24             	mov    %eax,(%esp)
  1004b9:	e8 9f fd ff ff       	call   10025d <vcprintf>
    cprintf("\n");
  1004be:	c7 04 24 86 37 10 00 	movl   $0x103786,(%esp)
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
  10063a:	c7 00 b8 37 10 00    	movl   $0x1037b8,(%eax)
    info->eip_line = 0;
  100640:	8b 45 0c             	mov    0xc(%ebp),%eax
  100643:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10064a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064d:	c7 40 08 b8 37 10 00 	movl   $0x1037b8,0x8(%eax)
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
  100671:	c7 45 f4 cc 3f 10 00 	movl   $0x103fcc,-0xc(%ebp)
    stab_end = __STAB_END__;
  100678:	c7 45 f0 98 cd 10 00 	movl   $0x10cd98,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10067f:	c7 45 ec 99 cd 10 00 	movl   $0x10cd99,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100686:	c7 45 e8 82 ee 10 00 	movl   $0x10ee82,-0x18(%ebp)

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
  1007d9:	e8 16 25 00 00       	call   102cf4 <strfind>
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
  100961:	c7 04 24 c2 37 10 00 	movl   $0x1037c2,(%esp)
  100968:	e8 27 f9 ff ff       	call   100294 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10096d:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100974:	00 
  100975:	c7 04 24 db 37 10 00 	movl   $0x1037db,(%esp)
  10097c:	e8 13 f9 ff ff       	call   100294 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100981:	c7 44 24 04 a4 36 10 	movl   $0x1036a4,0x4(%esp)
  100988:	00 
  100989:	c7 04 24 f3 37 10 00 	movl   $0x1037f3,(%esp)
  100990:	e8 ff f8 ff ff       	call   100294 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100995:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  10099c:	00 
  10099d:	c7 04 24 0b 38 10 00 	movl   $0x10380b,(%esp)
  1009a4:	e8 eb f8 ff ff       	call   100294 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009a9:	c7 44 24 04 20 0d 11 	movl   $0x110d20,0x4(%esp)
  1009b0:	00 
  1009b1:	c7 04 24 23 38 10 00 	movl   $0x103823,(%esp)
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
  1009de:	c7 04 24 3c 38 10 00 	movl   $0x10383c,(%esp)
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
  100a17:	c7 04 24 66 38 10 00 	movl   $0x103866,(%esp)
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
  100a85:	c7 04 24 82 38 10 00 	movl   $0x103882,(%esp)
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
  100ae0:	c7 04 24 94 38 10 00 	movl   $0x103894,(%esp)
  100ae7:	e8 a8 f7 ff ff       	call   100294 <cprintf>
                uint32_t *arg = (uint32_t *)ebp + 2;
  100aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aef:	83 c0 08             	add    $0x8,%eax
  100af2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                cprintf(" arg:");
  100af5:	c7 04 24 aa 38 10 00 	movl   $0x1038aa,(%esp)
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
  100b1f:	c7 04 24 b0 38 10 00 	movl   $0x1038b0,(%esp)
  100b26:	e8 69 f7 ff ff       	call   100294 <cprintf>
                for(j = 0; j < 4; j++) {
  100b2b:	ff 45 e8             	incl   -0x18(%ebp)
  100b2e:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b32:	7e d6                	jle    100b0a <print_stackframe+0x61>
                }		//(3.2) (uint32_t)calling arguments [0..4] = the contents in address (unit32_t)ebp +2 [0..4]
                cprintf("\n");	//(3.3) cprintf("\n");
  100b34:	c7 04 24 b8 38 10 00 	movl   $0x1038b8,(%esp)
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
  100bab:	c7 04 24 3c 39 10 00 	movl   $0x10393c,(%esp)
  100bb2:	e8 07 21 00 00       	call   102cbe <strchr>
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
  100bd3:	c7 04 24 41 39 10 00 	movl   $0x103941,(%esp)
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
  100c15:	c7 04 24 3c 39 10 00 	movl   $0x10393c,(%esp)
  100c1c:	e8 9d 20 00 00       	call   102cbe <strchr>
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
  100c86:	e8 8f 1f 00 00       	call   102c1a <strcmp>
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
  100cd2:	c7 04 24 5f 39 10 00 	movl   $0x10395f,(%esp)
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
  100cf3:	c7 04 24 78 39 10 00 	movl   $0x103978,(%esp)
  100cfa:	e8 95 f5 ff ff       	call   100294 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cff:	c7 04 24 a0 39 10 00 	movl   $0x1039a0,(%esp)
  100d06:	e8 89 f5 ff ff       	call   100294 <cprintf>

    if (tf != NULL) {
  100d0b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100d0f:	74 0b                	je     100d1c <kmonitor+0x33>
        print_trapframe(tf);
  100d11:	8b 45 08             	mov    0x8(%ebp),%eax
  100d14:	89 04 24             	mov    %eax,(%esp)
  100d17:	e8 dc 0d 00 00       	call   101af8 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d1c:	c7 04 24 c5 39 10 00 	movl   $0x1039c5,(%esp)
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
  100d8e:	c7 04 24 c9 39 10 00 	movl   $0x1039c9,(%esp)
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
  100e28:	c7 04 24 d2 39 10 00 	movl   $0x1039d2,(%esp)
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
  10125a:	e8 64 1c 00 00       	call   102ec3 <memmove>
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
  1015f8:	c7 04 24 ed 39 10 00 	movl   $0x1039ed,(%esp)
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
  101675:	c7 04 24 f9 39 10 00 	movl   $0x1039f9,(%esp)
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
  10191e:	c7 04 24 20 3a 10 00 	movl   $0x103a20,(%esp)
  101925:	e8 6a e9 ff ff       	call   100294 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  10192a:	90                   	nop
  10192b:	c9                   	leave  
  10192c:	c3                   	ret    

0010192d <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10192d:	f3 0f 1e fb          	endbr32 
  101931:	55                   	push   %ebp
  101932:	89 e5                	mov    %esp,%ebp
  101934:	83 ec 10             	sub    $0x10,%esp
    extern uintptr_t __vectors[]; //_vevtors数组保存在vectors.S中的256个中断处理例程的入口地址

    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
  101937:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10193e:	e9 ca 00 00 00       	jmp    101a0d <idt_init+0xe0>
        SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);
  101943:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101946:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  10194d:	0f b7 d0             	movzwl %ax,%edx
  101950:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101953:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  10195a:	00 
  10195b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10195e:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  101965:	00 08 00 
  101968:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196b:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101972:	00 
  101973:	80 e2 e0             	and    $0xe0,%dl
  101976:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10197d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101980:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101987:	00 
  101988:	80 e2 1f             	and    $0x1f,%dl
  10198b:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  101992:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101995:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10199c:	00 
  10199d:	80 e2 f0             	and    $0xf0,%dl
  1019a0:	80 ca 0e             	or     $0xe,%dl
  1019a3:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ad:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019b4:	00 
  1019b5:	80 e2 ef             	and    $0xef,%dl
  1019b8:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c2:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019c9:	00 
  1019ca:	80 e2 9f             	and    $0x9f,%dl
  1019cd:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d7:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019de:	00 
  1019df:	80 ca 80             	or     $0x80,%dl
  1019e2:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ec:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  1019f3:	c1 e8 10             	shr    $0x10,%eax
  1019f6:	0f b7 d0             	movzwl %ax,%edx
  1019f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019fc:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  101a03:	00 
    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
  101a04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a07:	83 c0 08             	add    $0x8,%eax
  101a0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101a0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a10:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  101a15:	0f 86 28 ff ff ff    	jbe    101943 <idt_init+0x16>
 /*循环调用SETGATE函数对中断门idt[i]依次进行初始化
   其中第一个参数为初始化模板idt[i]；第二个参数为0，表示中断门；第三个参数GD_KTEXT为内核代码段的起始地址；第四个参数_vector[i]为中断处理例程的入口地址；第五个参数表示内核权限\*/
    SETGATE(idt[T_SWITCH_TOK],0,GD_KTEXT,__vectors[T_SWITCH_TOK],DPL_USER);
  101a1b:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a20:	0f b7 c0             	movzwl %ax,%eax
  101a23:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a29:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a30:	08 00 
  101a32:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a39:	24 e0                	and    $0xe0,%al
  101a3b:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a40:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a47:	24 1f                	and    $0x1f,%al
  101a49:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a4e:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a55:	24 f0                	and    $0xf0,%al
  101a57:	0c 0e                	or     $0xe,%al
  101a59:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a5e:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a65:	24 ef                	and    $0xef,%al
  101a67:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a6c:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a73:	0c 60                	or     $0x60,%al
  101a75:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a7a:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a81:	0c 80                	or     $0x80,%al
  101a83:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a88:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a8d:	c1 e8 10             	shr    $0x10,%eax
  101a90:	0f b7 c0             	movzwl %ax,%eax
  101a93:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101a99:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101aa0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101aa3:	0f 01 18             	lidtl  (%eax)
}
  101aa6:	90                   	nop

    lidt(&idt_pd);
//加载idt中断描述符表，并将&idt_pd的首地址加载到IDTR中
}
  101aa7:	90                   	nop
  101aa8:	c9                   	leave  
  101aa9:	c3                   	ret    

00101aaa <trapname>:

static const char *
trapname(int trapno) {
  101aaa:	f3 0f 1e fb          	endbr32 
  101aae:	55                   	push   %ebp
  101aaf:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ab4:	83 f8 13             	cmp    $0x13,%eax
  101ab7:	77 0c                	ja     101ac5 <trapname+0x1b>
        return excnames[trapno];
  101ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  101abc:	8b 04 85 80 3d 10 00 	mov    0x103d80(,%eax,4),%eax
  101ac3:	eb 18                	jmp    101add <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101ac5:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101ac9:	7e 0d                	jle    101ad8 <trapname+0x2e>
  101acb:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101acf:	7f 07                	jg     101ad8 <trapname+0x2e>
        return "Hardware Interrupt";
  101ad1:	b8 2a 3a 10 00       	mov    $0x103a2a,%eax
  101ad6:	eb 05                	jmp    101add <trapname+0x33>
    }
    return "(unknown trap)";
  101ad8:	b8 3d 3a 10 00       	mov    $0x103a3d,%eax
}
  101add:	5d                   	pop    %ebp
  101ade:	c3                   	ret    

00101adf <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101adf:	f3 0f 1e fb          	endbr32 
  101ae3:	55                   	push   %ebp
  101ae4:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101aed:	83 f8 08             	cmp    $0x8,%eax
  101af0:	0f 94 c0             	sete   %al
  101af3:	0f b6 c0             	movzbl %al,%eax
}
  101af6:	5d                   	pop    %ebp
  101af7:	c3                   	ret    

00101af8 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101af8:	f3 0f 1e fb          	endbr32 
  101afc:	55                   	push   %ebp
  101afd:	89 e5                	mov    %esp,%ebp
  101aff:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101b02:	8b 45 08             	mov    0x8(%ebp),%eax
  101b05:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b09:	c7 04 24 7e 3a 10 00 	movl   $0x103a7e,(%esp)
  101b10:	e8 7f e7 ff ff       	call   100294 <cprintf>
    print_regs(&tf->tf_regs);
  101b15:	8b 45 08             	mov    0x8(%ebp),%eax
  101b18:	89 04 24             	mov    %eax,(%esp)
  101b1b:	e8 8d 01 00 00       	call   101cad <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b20:	8b 45 08             	mov    0x8(%ebp),%eax
  101b23:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b27:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b2b:	c7 04 24 8f 3a 10 00 	movl   $0x103a8f,(%esp)
  101b32:	e8 5d e7 ff ff       	call   100294 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b37:	8b 45 08             	mov    0x8(%ebp),%eax
  101b3a:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b42:	c7 04 24 a2 3a 10 00 	movl   $0x103aa2,(%esp)
  101b49:	e8 46 e7 ff ff       	call   100294 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b51:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b55:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b59:	c7 04 24 b5 3a 10 00 	movl   $0x103ab5,(%esp)
  101b60:	e8 2f e7 ff ff       	call   100294 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b65:	8b 45 08             	mov    0x8(%ebp),%eax
  101b68:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b6c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b70:	c7 04 24 c8 3a 10 00 	movl   $0x103ac8,(%esp)
  101b77:	e8 18 e7 ff ff       	call   100294 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b7f:	8b 40 30             	mov    0x30(%eax),%eax
  101b82:	89 04 24             	mov    %eax,(%esp)
  101b85:	e8 20 ff ff ff       	call   101aaa <trapname>
  101b8a:	8b 55 08             	mov    0x8(%ebp),%edx
  101b8d:	8b 52 30             	mov    0x30(%edx),%edx
  101b90:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b94:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b98:	c7 04 24 db 3a 10 00 	movl   $0x103adb,(%esp)
  101b9f:	e8 f0 e6 ff ff       	call   100294 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ba7:	8b 40 34             	mov    0x34(%eax),%eax
  101baa:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bae:	c7 04 24 ed 3a 10 00 	movl   $0x103aed,(%esp)
  101bb5:	e8 da e6 ff ff       	call   100294 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bba:	8b 45 08             	mov    0x8(%ebp),%eax
  101bbd:	8b 40 38             	mov    0x38(%eax),%eax
  101bc0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc4:	c7 04 24 fc 3a 10 00 	movl   $0x103afc,(%esp)
  101bcb:	e8 c4 e6 ff ff       	call   100294 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bd7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bdb:	c7 04 24 0b 3b 10 00 	movl   $0x103b0b,(%esp)
  101be2:	e8 ad e6 ff ff       	call   100294 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101be7:	8b 45 08             	mov    0x8(%ebp),%eax
  101bea:	8b 40 40             	mov    0x40(%eax),%eax
  101bed:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf1:	c7 04 24 1e 3b 10 00 	movl   $0x103b1e,(%esp)
  101bf8:	e8 97 e6 ff ff       	call   100294 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101bfd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c04:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c0b:	eb 3d                	jmp    101c4a <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101c10:	8b 50 40             	mov    0x40(%eax),%edx
  101c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c16:	21 d0                	and    %edx,%eax
  101c18:	85 c0                	test   %eax,%eax
  101c1a:	74 28                	je     101c44 <print_trapframe+0x14c>
  101c1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c1f:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c26:	85 c0                	test   %eax,%eax
  101c28:	74 1a                	je     101c44 <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c2d:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c34:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c38:	c7 04 24 2d 3b 10 00 	movl   $0x103b2d,(%esp)
  101c3f:	e8 50 e6 ff ff       	call   100294 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c44:	ff 45 f4             	incl   -0xc(%ebp)
  101c47:	d1 65 f0             	shll   -0x10(%ebp)
  101c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c4d:	83 f8 17             	cmp    $0x17,%eax
  101c50:	76 bb                	jbe    101c0d <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c52:	8b 45 08             	mov    0x8(%ebp),%eax
  101c55:	8b 40 40             	mov    0x40(%eax),%eax
  101c58:	c1 e8 0c             	shr    $0xc,%eax
  101c5b:	83 e0 03             	and    $0x3,%eax
  101c5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c62:	c7 04 24 31 3b 10 00 	movl   $0x103b31,(%esp)
  101c69:	e8 26 e6 ff ff       	call   100294 <cprintf>

    if (!trap_in_kernel(tf)) {
  101c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c71:	89 04 24             	mov    %eax,(%esp)
  101c74:	e8 66 fe ff ff       	call   101adf <trap_in_kernel>
  101c79:	85 c0                	test   %eax,%eax
  101c7b:	75 2d                	jne    101caa <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  101c80:	8b 40 44             	mov    0x44(%eax),%eax
  101c83:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c87:	c7 04 24 3a 3b 10 00 	movl   $0x103b3a,(%esp)
  101c8e:	e8 01 e6 ff ff       	call   100294 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c93:	8b 45 08             	mov    0x8(%ebp),%eax
  101c96:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101c9a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c9e:	c7 04 24 49 3b 10 00 	movl   $0x103b49,(%esp)
  101ca5:	e8 ea e5 ff ff       	call   100294 <cprintf>
    }
}
  101caa:	90                   	nop
  101cab:	c9                   	leave  
  101cac:	c3                   	ret    

00101cad <print_regs>:

void
print_regs(struct pushregs *regs) {
  101cad:	f3 0f 1e fb          	endbr32 
  101cb1:	55                   	push   %ebp
  101cb2:	89 e5                	mov    %esp,%ebp
  101cb4:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  101cba:	8b 00                	mov    (%eax),%eax
  101cbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cc0:	c7 04 24 5c 3b 10 00 	movl   $0x103b5c,(%esp)
  101cc7:	e8 c8 e5 ff ff       	call   100294 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ccf:	8b 40 04             	mov    0x4(%eax),%eax
  101cd2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cd6:	c7 04 24 6b 3b 10 00 	movl   $0x103b6b,(%esp)
  101cdd:	e8 b2 e5 ff ff       	call   100294 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ce5:	8b 40 08             	mov    0x8(%eax),%eax
  101ce8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cec:	c7 04 24 7a 3b 10 00 	movl   $0x103b7a,(%esp)
  101cf3:	e8 9c e5 ff ff       	call   100294 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  101cfb:	8b 40 0c             	mov    0xc(%eax),%eax
  101cfe:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d02:	c7 04 24 89 3b 10 00 	movl   $0x103b89,(%esp)
  101d09:	e8 86 e5 ff ff       	call   100294 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d0e:	8b 45 08             	mov    0x8(%ebp),%eax
  101d11:	8b 40 10             	mov    0x10(%eax),%eax
  101d14:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d18:	c7 04 24 98 3b 10 00 	movl   $0x103b98,(%esp)
  101d1f:	e8 70 e5 ff ff       	call   100294 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d24:	8b 45 08             	mov    0x8(%ebp),%eax
  101d27:	8b 40 14             	mov    0x14(%eax),%eax
  101d2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d2e:	c7 04 24 a7 3b 10 00 	movl   $0x103ba7,(%esp)
  101d35:	e8 5a e5 ff ff       	call   100294 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d3d:	8b 40 18             	mov    0x18(%eax),%eax
  101d40:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d44:	c7 04 24 b6 3b 10 00 	movl   $0x103bb6,(%esp)
  101d4b:	e8 44 e5 ff ff       	call   100294 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d50:	8b 45 08             	mov    0x8(%ebp),%eax
  101d53:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d56:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d5a:	c7 04 24 c5 3b 10 00 	movl   $0x103bc5,(%esp)
  101d61:	e8 2e e5 ff ff       	call   100294 <cprintf>
}
  101d66:	90                   	nop
  101d67:	c9                   	leave  
  101d68:	c3                   	ret    

00101d69 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d69:	f3 0f 1e fb          	endbr32 
  101d6d:	55                   	push   %ebp
  101d6e:	89 e5                	mov    %esp,%ebp
  101d70:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101d73:	8b 45 08             	mov    0x8(%ebp),%eax
  101d76:	8b 40 30             	mov    0x30(%eax),%eax
  101d79:	83 f8 79             	cmp    $0x79,%eax
  101d7c:	0f 84 4a 01 00 00    	je     101ecc <trap_dispatch+0x163>
  101d82:	83 f8 79             	cmp    $0x79,%eax
  101d85:	0f 87 82 01 00 00    	ja     101f0d <trap_dispatch+0x1a4>
  101d8b:	83 f8 78             	cmp    $0x78,%eax
  101d8e:	0f 84 da 00 00 00    	je     101e6e <trap_dispatch+0x105>
  101d94:	83 f8 78             	cmp    $0x78,%eax
  101d97:	0f 87 70 01 00 00    	ja     101f0d <trap_dispatch+0x1a4>
  101d9d:	83 f8 2f             	cmp    $0x2f,%eax
  101da0:	0f 87 67 01 00 00    	ja     101f0d <trap_dispatch+0x1a4>
  101da6:	83 f8 2e             	cmp    $0x2e,%eax
  101da9:	0f 83 93 01 00 00    	jae    101f42 <trap_dispatch+0x1d9>
  101daf:	83 f8 24             	cmp    $0x24,%eax
  101db2:	74 68                	je     101e1c <trap_dispatch+0xb3>
  101db4:	83 f8 24             	cmp    $0x24,%eax
  101db7:	0f 87 50 01 00 00    	ja     101f0d <trap_dispatch+0x1a4>
  101dbd:	83 f8 20             	cmp    $0x20,%eax
  101dc0:	74 0a                	je     101dcc <trap_dispatch+0x63>
  101dc2:	83 f8 21             	cmp    $0x21,%eax
  101dc5:	74 7e                	je     101e45 <trap_dispatch+0xdc>
  101dc7:	e9 41 01 00 00       	jmp    101f0d <trap_dispatch+0x1a4>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
 ticks ++;
  101dcc:	a1 08 09 11 00       	mov    0x110908,%eax
  101dd1:	40                   	inc    %eax
  101dd2:	a3 08 09 11 00       	mov    %eax,0x110908
        if (ticks % TICK_NUM == 0) {
  101dd7:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101ddd:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101de2:	89 c8                	mov    %ecx,%eax
  101de4:	f7 e2                	mul    %edx
  101de6:	c1 ea 05             	shr    $0x5,%edx
  101de9:	89 d0                	mov    %edx,%eax
  101deb:	c1 e0 02             	shl    $0x2,%eax
  101dee:	01 d0                	add    %edx,%eax
  101df0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101df7:	01 d0                	add    %edx,%eax
  101df9:	c1 e0 02             	shl    $0x2,%eax
  101dfc:	29 c1                	sub    %eax,%ecx
  101dfe:	89 ca                	mov    %ecx,%edx
  101e00:	85 d2                	test   %edx,%edx
  101e02:	0f 85 3d 01 00 00    	jne    101f45 <trap_dispatch+0x1dc>
            print_ticks();
  101e08:	e8 ff fa ff ff       	call   10190c <print_ticks>
ticks=0;
  101e0d:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  101e14:	00 00 00 
        }
        break;
  101e17:	e9 29 01 00 00       	jmp    101f45 <trap_dispatch+0x1dc>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e1c:	e8 91 f8 ff ff       	call   1016b2 <cons_getc>
  101e21:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e24:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e28:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e2c:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e30:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e34:	c7 04 24 d4 3b 10 00 	movl   $0x103bd4,(%esp)
  101e3b:	e8 54 e4 ff ff       	call   100294 <cprintf>
        break;
  101e40:	e9 07 01 00 00       	jmp    101f4c <trap_dispatch+0x1e3>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e45:	e8 68 f8 ff ff       	call   1016b2 <cons_getc>
  101e4a:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e4d:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e51:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e55:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e59:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e5d:	c7 04 24 e6 3b 10 00 	movl   $0x103be6,(%esp)
  101e64:	e8 2b e4 ff ff       	call   100294 <cprintf>
        break;
  101e69:	e9 de 00 00 00       	jmp    101f4c <trap_dispatch+0x1e3>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) { //要保证自己再对应的模式中
  101e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e71:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e75:	83 f8 1b             	cmp    $0x1b,%eax
  101e78:	0f 84 ca 00 00 00    	je     101f48 <trap_dispatch+0x1df>
            tf->tf_cs = USER_CS;
  101e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e81:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
  101e87:	8b 45 08             	mov    0x8(%ebp),%eax
  101e8a:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101e90:	8b 45 08             	mov    0x8(%ebp),%eax
  101e93:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101e97:	8b 45 08             	mov    0x8(%ebp),%eax
  101e9a:	66 89 50 28          	mov    %dx,0x28(%eax)
  101e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea1:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea8:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags |= FL_IOPL_MASK;
  101eac:	8b 45 08             	mov    0x8(%ebp),%eax
  101eaf:	8b 40 40             	mov    0x40(%eax),%eax
  101eb2:	0d 00 30 00 00       	or     $0x3000,%eax
  101eb7:	89 c2                	mov    %eax,%edx
  101eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebc:	89 50 40             	mov    %edx,0x40(%eax)
            print_trapframe(tf);
  101ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  101ec2:	89 04 24             	mov    %eax,(%esp)
  101ec5:	e8 2e fc ff ff       	call   101af8 <print_trapframe>
        }
        break;
  101eca:	eb 7c                	jmp    101f48 <trap_dispatch+0x1df>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ecf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ed3:	83 f8 08             	cmp    $0x8,%eax
  101ed6:	74 73                	je     101f4b <trap_dispatch+0x1e2>
            tf->tf_cs = KERNEL_CS;
  101ed8:	8b 45 08             	mov    0x8(%ebp),%eax
  101edb:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee4:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101eea:	8b 45 08             	mov    0x8(%ebp),%eax
  101eed:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef4:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  101efb:	8b 40 40             	mov    0x40(%eax),%eax
  101efe:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101f03:	89 c2                	mov    %eax,%edx
  101f05:	8b 45 08             	mov    0x8(%ebp),%eax
  101f08:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101f0b:	eb 3e                	jmp    101f4b <trap_dispatch+0x1e2>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101f10:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f14:	83 e0 03             	and    $0x3,%eax
  101f17:	85 c0                	test   %eax,%eax
  101f19:	75 31                	jne    101f4c <trap_dispatch+0x1e3>
            print_trapframe(tf);
  101f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f1e:	89 04 24             	mov    %eax,(%esp)
  101f21:	e8 d2 fb ff ff       	call   101af8 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f26:	c7 44 24 08 f5 3b 10 	movl   $0x103bf5,0x8(%esp)
  101f2d:	00 
  101f2e:	c7 44 24 04 bb 00 00 	movl   $0xbb,0x4(%esp)
  101f35:	00 
  101f36:	c7 04 24 11 3c 10 00 	movl   $0x103c11,(%esp)
  101f3d:	e8 be e4 ff ff       	call   100400 <__panic>
        break;
  101f42:	90                   	nop
  101f43:	eb 07                	jmp    101f4c <trap_dispatch+0x1e3>
        break;
  101f45:	90                   	nop
  101f46:	eb 04                	jmp    101f4c <trap_dispatch+0x1e3>
        break;
  101f48:	90                   	nop
  101f49:	eb 01                	jmp    101f4c <trap_dispatch+0x1e3>
        break;
  101f4b:	90                   	nop
        }
    }
}
  101f4c:	90                   	nop
  101f4d:	c9                   	leave  
  101f4e:	c3                   	ret    

00101f4f <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f4f:	f3 0f 1e fb          	endbr32 
  101f53:	55                   	push   %ebp
  101f54:	89 e5                	mov    %esp,%ebp
  101f56:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f59:	8b 45 08             	mov    0x8(%ebp),%eax
  101f5c:	89 04 24             	mov    %eax,(%esp)
  101f5f:	e8 05 fe ff ff       	call   101d69 <trap_dispatch>
}
  101f64:	90                   	nop
  101f65:	c9                   	leave  
  101f66:	c3                   	ret    

00101f67 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f67:	6a 00                	push   $0x0
  pushl $0
  101f69:	6a 00                	push   $0x0
  jmp __alltraps
  101f6b:	e9 69 0a 00 00       	jmp    1029d9 <__alltraps>

00101f70 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f70:	6a 00                	push   $0x0
  pushl $1
  101f72:	6a 01                	push   $0x1
  jmp __alltraps
  101f74:	e9 60 0a 00 00       	jmp    1029d9 <__alltraps>

00101f79 <vector2>:
.globl vector2
vector2:
  pushl $0
  101f79:	6a 00                	push   $0x0
  pushl $2
  101f7b:	6a 02                	push   $0x2
  jmp __alltraps
  101f7d:	e9 57 0a 00 00       	jmp    1029d9 <__alltraps>

00101f82 <vector3>:
.globl vector3
vector3:
  pushl $0
  101f82:	6a 00                	push   $0x0
  pushl $3
  101f84:	6a 03                	push   $0x3
  jmp __alltraps
  101f86:	e9 4e 0a 00 00       	jmp    1029d9 <__alltraps>

00101f8b <vector4>:
.globl vector4
vector4:
  pushl $0
  101f8b:	6a 00                	push   $0x0
  pushl $4
  101f8d:	6a 04                	push   $0x4
  jmp __alltraps
  101f8f:	e9 45 0a 00 00       	jmp    1029d9 <__alltraps>

00101f94 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f94:	6a 00                	push   $0x0
  pushl $5
  101f96:	6a 05                	push   $0x5
  jmp __alltraps
  101f98:	e9 3c 0a 00 00       	jmp    1029d9 <__alltraps>

00101f9d <vector6>:
.globl vector6
vector6:
  pushl $0
  101f9d:	6a 00                	push   $0x0
  pushl $6
  101f9f:	6a 06                	push   $0x6
  jmp __alltraps
  101fa1:	e9 33 0a 00 00       	jmp    1029d9 <__alltraps>

00101fa6 <vector7>:
.globl vector7
vector7:
  pushl $0
  101fa6:	6a 00                	push   $0x0
  pushl $7
  101fa8:	6a 07                	push   $0x7
  jmp __alltraps
  101faa:	e9 2a 0a 00 00       	jmp    1029d9 <__alltraps>

00101faf <vector8>:
.globl vector8
vector8:
  pushl $8
  101faf:	6a 08                	push   $0x8
  jmp __alltraps
  101fb1:	e9 23 0a 00 00       	jmp    1029d9 <__alltraps>

00101fb6 <vector9>:
.globl vector9
vector9:
  pushl $0
  101fb6:	6a 00                	push   $0x0
  pushl $9
  101fb8:	6a 09                	push   $0x9
  jmp __alltraps
  101fba:	e9 1a 0a 00 00       	jmp    1029d9 <__alltraps>

00101fbf <vector10>:
.globl vector10
vector10:
  pushl $10
  101fbf:	6a 0a                	push   $0xa
  jmp __alltraps
  101fc1:	e9 13 0a 00 00       	jmp    1029d9 <__alltraps>

00101fc6 <vector11>:
.globl vector11
vector11:
  pushl $11
  101fc6:	6a 0b                	push   $0xb
  jmp __alltraps
  101fc8:	e9 0c 0a 00 00       	jmp    1029d9 <__alltraps>

00101fcd <vector12>:
.globl vector12
vector12:
  pushl $12
  101fcd:	6a 0c                	push   $0xc
  jmp __alltraps
  101fcf:	e9 05 0a 00 00       	jmp    1029d9 <__alltraps>

00101fd4 <vector13>:
.globl vector13
vector13:
  pushl $13
  101fd4:	6a 0d                	push   $0xd
  jmp __alltraps
  101fd6:	e9 fe 09 00 00       	jmp    1029d9 <__alltraps>

00101fdb <vector14>:
.globl vector14
vector14:
  pushl $14
  101fdb:	6a 0e                	push   $0xe
  jmp __alltraps
  101fdd:	e9 f7 09 00 00       	jmp    1029d9 <__alltraps>

00101fe2 <vector15>:
.globl vector15
vector15:
  pushl $0
  101fe2:	6a 00                	push   $0x0
  pushl $15
  101fe4:	6a 0f                	push   $0xf
  jmp __alltraps
  101fe6:	e9 ee 09 00 00       	jmp    1029d9 <__alltraps>

00101feb <vector16>:
.globl vector16
vector16:
  pushl $0
  101feb:	6a 00                	push   $0x0
  pushl $16
  101fed:	6a 10                	push   $0x10
  jmp __alltraps
  101fef:	e9 e5 09 00 00       	jmp    1029d9 <__alltraps>

00101ff4 <vector17>:
.globl vector17
vector17:
  pushl $17
  101ff4:	6a 11                	push   $0x11
  jmp __alltraps
  101ff6:	e9 de 09 00 00       	jmp    1029d9 <__alltraps>

00101ffb <vector18>:
.globl vector18
vector18:
  pushl $0
  101ffb:	6a 00                	push   $0x0
  pushl $18
  101ffd:	6a 12                	push   $0x12
  jmp __alltraps
  101fff:	e9 d5 09 00 00       	jmp    1029d9 <__alltraps>

00102004 <vector19>:
.globl vector19
vector19:
  pushl $0
  102004:	6a 00                	push   $0x0
  pushl $19
  102006:	6a 13                	push   $0x13
  jmp __alltraps
  102008:	e9 cc 09 00 00       	jmp    1029d9 <__alltraps>

0010200d <vector20>:
.globl vector20
vector20:
  pushl $0
  10200d:	6a 00                	push   $0x0
  pushl $20
  10200f:	6a 14                	push   $0x14
  jmp __alltraps
  102011:	e9 c3 09 00 00       	jmp    1029d9 <__alltraps>

00102016 <vector21>:
.globl vector21
vector21:
  pushl $0
  102016:	6a 00                	push   $0x0
  pushl $21
  102018:	6a 15                	push   $0x15
  jmp __alltraps
  10201a:	e9 ba 09 00 00       	jmp    1029d9 <__alltraps>

0010201f <vector22>:
.globl vector22
vector22:
  pushl $0
  10201f:	6a 00                	push   $0x0
  pushl $22
  102021:	6a 16                	push   $0x16
  jmp __alltraps
  102023:	e9 b1 09 00 00       	jmp    1029d9 <__alltraps>

00102028 <vector23>:
.globl vector23
vector23:
  pushl $0
  102028:	6a 00                	push   $0x0
  pushl $23
  10202a:	6a 17                	push   $0x17
  jmp __alltraps
  10202c:	e9 a8 09 00 00       	jmp    1029d9 <__alltraps>

00102031 <vector24>:
.globl vector24
vector24:
  pushl $0
  102031:	6a 00                	push   $0x0
  pushl $24
  102033:	6a 18                	push   $0x18
  jmp __alltraps
  102035:	e9 9f 09 00 00       	jmp    1029d9 <__alltraps>

0010203a <vector25>:
.globl vector25
vector25:
  pushl $0
  10203a:	6a 00                	push   $0x0
  pushl $25
  10203c:	6a 19                	push   $0x19
  jmp __alltraps
  10203e:	e9 96 09 00 00       	jmp    1029d9 <__alltraps>

00102043 <vector26>:
.globl vector26
vector26:
  pushl $0
  102043:	6a 00                	push   $0x0
  pushl $26
  102045:	6a 1a                	push   $0x1a
  jmp __alltraps
  102047:	e9 8d 09 00 00       	jmp    1029d9 <__alltraps>

0010204c <vector27>:
.globl vector27
vector27:
  pushl $0
  10204c:	6a 00                	push   $0x0
  pushl $27
  10204e:	6a 1b                	push   $0x1b
  jmp __alltraps
  102050:	e9 84 09 00 00       	jmp    1029d9 <__alltraps>

00102055 <vector28>:
.globl vector28
vector28:
  pushl $0
  102055:	6a 00                	push   $0x0
  pushl $28
  102057:	6a 1c                	push   $0x1c
  jmp __alltraps
  102059:	e9 7b 09 00 00       	jmp    1029d9 <__alltraps>

0010205e <vector29>:
.globl vector29
vector29:
  pushl $0
  10205e:	6a 00                	push   $0x0
  pushl $29
  102060:	6a 1d                	push   $0x1d
  jmp __alltraps
  102062:	e9 72 09 00 00       	jmp    1029d9 <__alltraps>

00102067 <vector30>:
.globl vector30
vector30:
  pushl $0
  102067:	6a 00                	push   $0x0
  pushl $30
  102069:	6a 1e                	push   $0x1e
  jmp __alltraps
  10206b:	e9 69 09 00 00       	jmp    1029d9 <__alltraps>

00102070 <vector31>:
.globl vector31
vector31:
  pushl $0
  102070:	6a 00                	push   $0x0
  pushl $31
  102072:	6a 1f                	push   $0x1f
  jmp __alltraps
  102074:	e9 60 09 00 00       	jmp    1029d9 <__alltraps>

00102079 <vector32>:
.globl vector32
vector32:
  pushl $0
  102079:	6a 00                	push   $0x0
  pushl $32
  10207b:	6a 20                	push   $0x20
  jmp __alltraps
  10207d:	e9 57 09 00 00       	jmp    1029d9 <__alltraps>

00102082 <vector33>:
.globl vector33
vector33:
  pushl $0
  102082:	6a 00                	push   $0x0
  pushl $33
  102084:	6a 21                	push   $0x21
  jmp __alltraps
  102086:	e9 4e 09 00 00       	jmp    1029d9 <__alltraps>

0010208b <vector34>:
.globl vector34
vector34:
  pushl $0
  10208b:	6a 00                	push   $0x0
  pushl $34
  10208d:	6a 22                	push   $0x22
  jmp __alltraps
  10208f:	e9 45 09 00 00       	jmp    1029d9 <__alltraps>

00102094 <vector35>:
.globl vector35
vector35:
  pushl $0
  102094:	6a 00                	push   $0x0
  pushl $35
  102096:	6a 23                	push   $0x23
  jmp __alltraps
  102098:	e9 3c 09 00 00       	jmp    1029d9 <__alltraps>

0010209d <vector36>:
.globl vector36
vector36:
  pushl $0
  10209d:	6a 00                	push   $0x0
  pushl $36
  10209f:	6a 24                	push   $0x24
  jmp __alltraps
  1020a1:	e9 33 09 00 00       	jmp    1029d9 <__alltraps>

001020a6 <vector37>:
.globl vector37
vector37:
  pushl $0
  1020a6:	6a 00                	push   $0x0
  pushl $37
  1020a8:	6a 25                	push   $0x25
  jmp __alltraps
  1020aa:	e9 2a 09 00 00       	jmp    1029d9 <__alltraps>

001020af <vector38>:
.globl vector38
vector38:
  pushl $0
  1020af:	6a 00                	push   $0x0
  pushl $38
  1020b1:	6a 26                	push   $0x26
  jmp __alltraps
  1020b3:	e9 21 09 00 00       	jmp    1029d9 <__alltraps>

001020b8 <vector39>:
.globl vector39
vector39:
  pushl $0
  1020b8:	6a 00                	push   $0x0
  pushl $39
  1020ba:	6a 27                	push   $0x27
  jmp __alltraps
  1020bc:	e9 18 09 00 00       	jmp    1029d9 <__alltraps>

001020c1 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020c1:	6a 00                	push   $0x0
  pushl $40
  1020c3:	6a 28                	push   $0x28
  jmp __alltraps
  1020c5:	e9 0f 09 00 00       	jmp    1029d9 <__alltraps>

001020ca <vector41>:
.globl vector41
vector41:
  pushl $0
  1020ca:	6a 00                	push   $0x0
  pushl $41
  1020cc:	6a 29                	push   $0x29
  jmp __alltraps
  1020ce:	e9 06 09 00 00       	jmp    1029d9 <__alltraps>

001020d3 <vector42>:
.globl vector42
vector42:
  pushl $0
  1020d3:	6a 00                	push   $0x0
  pushl $42
  1020d5:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020d7:	e9 fd 08 00 00       	jmp    1029d9 <__alltraps>

001020dc <vector43>:
.globl vector43
vector43:
  pushl $0
  1020dc:	6a 00                	push   $0x0
  pushl $43
  1020de:	6a 2b                	push   $0x2b
  jmp __alltraps
  1020e0:	e9 f4 08 00 00       	jmp    1029d9 <__alltraps>

001020e5 <vector44>:
.globl vector44
vector44:
  pushl $0
  1020e5:	6a 00                	push   $0x0
  pushl $44
  1020e7:	6a 2c                	push   $0x2c
  jmp __alltraps
  1020e9:	e9 eb 08 00 00       	jmp    1029d9 <__alltraps>

001020ee <vector45>:
.globl vector45
vector45:
  pushl $0
  1020ee:	6a 00                	push   $0x0
  pushl $45
  1020f0:	6a 2d                	push   $0x2d
  jmp __alltraps
  1020f2:	e9 e2 08 00 00       	jmp    1029d9 <__alltraps>

001020f7 <vector46>:
.globl vector46
vector46:
  pushl $0
  1020f7:	6a 00                	push   $0x0
  pushl $46
  1020f9:	6a 2e                	push   $0x2e
  jmp __alltraps
  1020fb:	e9 d9 08 00 00       	jmp    1029d9 <__alltraps>

00102100 <vector47>:
.globl vector47
vector47:
  pushl $0
  102100:	6a 00                	push   $0x0
  pushl $47
  102102:	6a 2f                	push   $0x2f
  jmp __alltraps
  102104:	e9 d0 08 00 00       	jmp    1029d9 <__alltraps>

00102109 <vector48>:
.globl vector48
vector48:
  pushl $0
  102109:	6a 00                	push   $0x0
  pushl $48
  10210b:	6a 30                	push   $0x30
  jmp __alltraps
  10210d:	e9 c7 08 00 00       	jmp    1029d9 <__alltraps>

00102112 <vector49>:
.globl vector49
vector49:
  pushl $0
  102112:	6a 00                	push   $0x0
  pushl $49
  102114:	6a 31                	push   $0x31
  jmp __alltraps
  102116:	e9 be 08 00 00       	jmp    1029d9 <__alltraps>

0010211b <vector50>:
.globl vector50
vector50:
  pushl $0
  10211b:	6a 00                	push   $0x0
  pushl $50
  10211d:	6a 32                	push   $0x32
  jmp __alltraps
  10211f:	e9 b5 08 00 00       	jmp    1029d9 <__alltraps>

00102124 <vector51>:
.globl vector51
vector51:
  pushl $0
  102124:	6a 00                	push   $0x0
  pushl $51
  102126:	6a 33                	push   $0x33
  jmp __alltraps
  102128:	e9 ac 08 00 00       	jmp    1029d9 <__alltraps>

0010212d <vector52>:
.globl vector52
vector52:
  pushl $0
  10212d:	6a 00                	push   $0x0
  pushl $52
  10212f:	6a 34                	push   $0x34
  jmp __alltraps
  102131:	e9 a3 08 00 00       	jmp    1029d9 <__alltraps>

00102136 <vector53>:
.globl vector53
vector53:
  pushl $0
  102136:	6a 00                	push   $0x0
  pushl $53
  102138:	6a 35                	push   $0x35
  jmp __alltraps
  10213a:	e9 9a 08 00 00       	jmp    1029d9 <__alltraps>

0010213f <vector54>:
.globl vector54
vector54:
  pushl $0
  10213f:	6a 00                	push   $0x0
  pushl $54
  102141:	6a 36                	push   $0x36
  jmp __alltraps
  102143:	e9 91 08 00 00       	jmp    1029d9 <__alltraps>

00102148 <vector55>:
.globl vector55
vector55:
  pushl $0
  102148:	6a 00                	push   $0x0
  pushl $55
  10214a:	6a 37                	push   $0x37
  jmp __alltraps
  10214c:	e9 88 08 00 00       	jmp    1029d9 <__alltraps>

00102151 <vector56>:
.globl vector56
vector56:
  pushl $0
  102151:	6a 00                	push   $0x0
  pushl $56
  102153:	6a 38                	push   $0x38
  jmp __alltraps
  102155:	e9 7f 08 00 00       	jmp    1029d9 <__alltraps>

0010215a <vector57>:
.globl vector57
vector57:
  pushl $0
  10215a:	6a 00                	push   $0x0
  pushl $57
  10215c:	6a 39                	push   $0x39
  jmp __alltraps
  10215e:	e9 76 08 00 00       	jmp    1029d9 <__alltraps>

00102163 <vector58>:
.globl vector58
vector58:
  pushl $0
  102163:	6a 00                	push   $0x0
  pushl $58
  102165:	6a 3a                	push   $0x3a
  jmp __alltraps
  102167:	e9 6d 08 00 00       	jmp    1029d9 <__alltraps>

0010216c <vector59>:
.globl vector59
vector59:
  pushl $0
  10216c:	6a 00                	push   $0x0
  pushl $59
  10216e:	6a 3b                	push   $0x3b
  jmp __alltraps
  102170:	e9 64 08 00 00       	jmp    1029d9 <__alltraps>

00102175 <vector60>:
.globl vector60
vector60:
  pushl $0
  102175:	6a 00                	push   $0x0
  pushl $60
  102177:	6a 3c                	push   $0x3c
  jmp __alltraps
  102179:	e9 5b 08 00 00       	jmp    1029d9 <__alltraps>

0010217e <vector61>:
.globl vector61
vector61:
  pushl $0
  10217e:	6a 00                	push   $0x0
  pushl $61
  102180:	6a 3d                	push   $0x3d
  jmp __alltraps
  102182:	e9 52 08 00 00       	jmp    1029d9 <__alltraps>

00102187 <vector62>:
.globl vector62
vector62:
  pushl $0
  102187:	6a 00                	push   $0x0
  pushl $62
  102189:	6a 3e                	push   $0x3e
  jmp __alltraps
  10218b:	e9 49 08 00 00       	jmp    1029d9 <__alltraps>

00102190 <vector63>:
.globl vector63
vector63:
  pushl $0
  102190:	6a 00                	push   $0x0
  pushl $63
  102192:	6a 3f                	push   $0x3f
  jmp __alltraps
  102194:	e9 40 08 00 00       	jmp    1029d9 <__alltraps>

00102199 <vector64>:
.globl vector64
vector64:
  pushl $0
  102199:	6a 00                	push   $0x0
  pushl $64
  10219b:	6a 40                	push   $0x40
  jmp __alltraps
  10219d:	e9 37 08 00 00       	jmp    1029d9 <__alltraps>

001021a2 <vector65>:
.globl vector65
vector65:
  pushl $0
  1021a2:	6a 00                	push   $0x0
  pushl $65
  1021a4:	6a 41                	push   $0x41
  jmp __alltraps
  1021a6:	e9 2e 08 00 00       	jmp    1029d9 <__alltraps>

001021ab <vector66>:
.globl vector66
vector66:
  pushl $0
  1021ab:	6a 00                	push   $0x0
  pushl $66
  1021ad:	6a 42                	push   $0x42
  jmp __alltraps
  1021af:	e9 25 08 00 00       	jmp    1029d9 <__alltraps>

001021b4 <vector67>:
.globl vector67
vector67:
  pushl $0
  1021b4:	6a 00                	push   $0x0
  pushl $67
  1021b6:	6a 43                	push   $0x43
  jmp __alltraps
  1021b8:	e9 1c 08 00 00       	jmp    1029d9 <__alltraps>

001021bd <vector68>:
.globl vector68
vector68:
  pushl $0
  1021bd:	6a 00                	push   $0x0
  pushl $68
  1021bf:	6a 44                	push   $0x44
  jmp __alltraps
  1021c1:	e9 13 08 00 00       	jmp    1029d9 <__alltraps>

001021c6 <vector69>:
.globl vector69
vector69:
  pushl $0
  1021c6:	6a 00                	push   $0x0
  pushl $69
  1021c8:	6a 45                	push   $0x45
  jmp __alltraps
  1021ca:	e9 0a 08 00 00       	jmp    1029d9 <__alltraps>

001021cf <vector70>:
.globl vector70
vector70:
  pushl $0
  1021cf:	6a 00                	push   $0x0
  pushl $70
  1021d1:	6a 46                	push   $0x46
  jmp __alltraps
  1021d3:	e9 01 08 00 00       	jmp    1029d9 <__alltraps>

001021d8 <vector71>:
.globl vector71
vector71:
  pushl $0
  1021d8:	6a 00                	push   $0x0
  pushl $71
  1021da:	6a 47                	push   $0x47
  jmp __alltraps
  1021dc:	e9 f8 07 00 00       	jmp    1029d9 <__alltraps>

001021e1 <vector72>:
.globl vector72
vector72:
  pushl $0
  1021e1:	6a 00                	push   $0x0
  pushl $72
  1021e3:	6a 48                	push   $0x48
  jmp __alltraps
  1021e5:	e9 ef 07 00 00       	jmp    1029d9 <__alltraps>

001021ea <vector73>:
.globl vector73
vector73:
  pushl $0
  1021ea:	6a 00                	push   $0x0
  pushl $73
  1021ec:	6a 49                	push   $0x49
  jmp __alltraps
  1021ee:	e9 e6 07 00 00       	jmp    1029d9 <__alltraps>

001021f3 <vector74>:
.globl vector74
vector74:
  pushl $0
  1021f3:	6a 00                	push   $0x0
  pushl $74
  1021f5:	6a 4a                	push   $0x4a
  jmp __alltraps
  1021f7:	e9 dd 07 00 00       	jmp    1029d9 <__alltraps>

001021fc <vector75>:
.globl vector75
vector75:
  pushl $0
  1021fc:	6a 00                	push   $0x0
  pushl $75
  1021fe:	6a 4b                	push   $0x4b
  jmp __alltraps
  102200:	e9 d4 07 00 00       	jmp    1029d9 <__alltraps>

00102205 <vector76>:
.globl vector76
vector76:
  pushl $0
  102205:	6a 00                	push   $0x0
  pushl $76
  102207:	6a 4c                	push   $0x4c
  jmp __alltraps
  102209:	e9 cb 07 00 00       	jmp    1029d9 <__alltraps>

0010220e <vector77>:
.globl vector77
vector77:
  pushl $0
  10220e:	6a 00                	push   $0x0
  pushl $77
  102210:	6a 4d                	push   $0x4d
  jmp __alltraps
  102212:	e9 c2 07 00 00       	jmp    1029d9 <__alltraps>

00102217 <vector78>:
.globl vector78
vector78:
  pushl $0
  102217:	6a 00                	push   $0x0
  pushl $78
  102219:	6a 4e                	push   $0x4e
  jmp __alltraps
  10221b:	e9 b9 07 00 00       	jmp    1029d9 <__alltraps>

00102220 <vector79>:
.globl vector79
vector79:
  pushl $0
  102220:	6a 00                	push   $0x0
  pushl $79
  102222:	6a 4f                	push   $0x4f
  jmp __alltraps
  102224:	e9 b0 07 00 00       	jmp    1029d9 <__alltraps>

00102229 <vector80>:
.globl vector80
vector80:
  pushl $0
  102229:	6a 00                	push   $0x0
  pushl $80
  10222b:	6a 50                	push   $0x50
  jmp __alltraps
  10222d:	e9 a7 07 00 00       	jmp    1029d9 <__alltraps>

00102232 <vector81>:
.globl vector81
vector81:
  pushl $0
  102232:	6a 00                	push   $0x0
  pushl $81
  102234:	6a 51                	push   $0x51
  jmp __alltraps
  102236:	e9 9e 07 00 00       	jmp    1029d9 <__alltraps>

0010223b <vector82>:
.globl vector82
vector82:
  pushl $0
  10223b:	6a 00                	push   $0x0
  pushl $82
  10223d:	6a 52                	push   $0x52
  jmp __alltraps
  10223f:	e9 95 07 00 00       	jmp    1029d9 <__alltraps>

00102244 <vector83>:
.globl vector83
vector83:
  pushl $0
  102244:	6a 00                	push   $0x0
  pushl $83
  102246:	6a 53                	push   $0x53
  jmp __alltraps
  102248:	e9 8c 07 00 00       	jmp    1029d9 <__alltraps>

0010224d <vector84>:
.globl vector84
vector84:
  pushl $0
  10224d:	6a 00                	push   $0x0
  pushl $84
  10224f:	6a 54                	push   $0x54
  jmp __alltraps
  102251:	e9 83 07 00 00       	jmp    1029d9 <__alltraps>

00102256 <vector85>:
.globl vector85
vector85:
  pushl $0
  102256:	6a 00                	push   $0x0
  pushl $85
  102258:	6a 55                	push   $0x55
  jmp __alltraps
  10225a:	e9 7a 07 00 00       	jmp    1029d9 <__alltraps>

0010225f <vector86>:
.globl vector86
vector86:
  pushl $0
  10225f:	6a 00                	push   $0x0
  pushl $86
  102261:	6a 56                	push   $0x56
  jmp __alltraps
  102263:	e9 71 07 00 00       	jmp    1029d9 <__alltraps>

00102268 <vector87>:
.globl vector87
vector87:
  pushl $0
  102268:	6a 00                	push   $0x0
  pushl $87
  10226a:	6a 57                	push   $0x57
  jmp __alltraps
  10226c:	e9 68 07 00 00       	jmp    1029d9 <__alltraps>

00102271 <vector88>:
.globl vector88
vector88:
  pushl $0
  102271:	6a 00                	push   $0x0
  pushl $88
  102273:	6a 58                	push   $0x58
  jmp __alltraps
  102275:	e9 5f 07 00 00       	jmp    1029d9 <__alltraps>

0010227a <vector89>:
.globl vector89
vector89:
  pushl $0
  10227a:	6a 00                	push   $0x0
  pushl $89
  10227c:	6a 59                	push   $0x59
  jmp __alltraps
  10227e:	e9 56 07 00 00       	jmp    1029d9 <__alltraps>

00102283 <vector90>:
.globl vector90
vector90:
  pushl $0
  102283:	6a 00                	push   $0x0
  pushl $90
  102285:	6a 5a                	push   $0x5a
  jmp __alltraps
  102287:	e9 4d 07 00 00       	jmp    1029d9 <__alltraps>

0010228c <vector91>:
.globl vector91
vector91:
  pushl $0
  10228c:	6a 00                	push   $0x0
  pushl $91
  10228e:	6a 5b                	push   $0x5b
  jmp __alltraps
  102290:	e9 44 07 00 00       	jmp    1029d9 <__alltraps>

00102295 <vector92>:
.globl vector92
vector92:
  pushl $0
  102295:	6a 00                	push   $0x0
  pushl $92
  102297:	6a 5c                	push   $0x5c
  jmp __alltraps
  102299:	e9 3b 07 00 00       	jmp    1029d9 <__alltraps>

0010229e <vector93>:
.globl vector93
vector93:
  pushl $0
  10229e:	6a 00                	push   $0x0
  pushl $93
  1022a0:	6a 5d                	push   $0x5d
  jmp __alltraps
  1022a2:	e9 32 07 00 00       	jmp    1029d9 <__alltraps>

001022a7 <vector94>:
.globl vector94
vector94:
  pushl $0
  1022a7:	6a 00                	push   $0x0
  pushl $94
  1022a9:	6a 5e                	push   $0x5e
  jmp __alltraps
  1022ab:	e9 29 07 00 00       	jmp    1029d9 <__alltraps>

001022b0 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022b0:	6a 00                	push   $0x0
  pushl $95
  1022b2:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022b4:	e9 20 07 00 00       	jmp    1029d9 <__alltraps>

001022b9 <vector96>:
.globl vector96
vector96:
  pushl $0
  1022b9:	6a 00                	push   $0x0
  pushl $96
  1022bb:	6a 60                	push   $0x60
  jmp __alltraps
  1022bd:	e9 17 07 00 00       	jmp    1029d9 <__alltraps>

001022c2 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022c2:	6a 00                	push   $0x0
  pushl $97
  1022c4:	6a 61                	push   $0x61
  jmp __alltraps
  1022c6:	e9 0e 07 00 00       	jmp    1029d9 <__alltraps>

001022cb <vector98>:
.globl vector98
vector98:
  pushl $0
  1022cb:	6a 00                	push   $0x0
  pushl $98
  1022cd:	6a 62                	push   $0x62
  jmp __alltraps
  1022cf:	e9 05 07 00 00       	jmp    1029d9 <__alltraps>

001022d4 <vector99>:
.globl vector99
vector99:
  pushl $0
  1022d4:	6a 00                	push   $0x0
  pushl $99
  1022d6:	6a 63                	push   $0x63
  jmp __alltraps
  1022d8:	e9 fc 06 00 00       	jmp    1029d9 <__alltraps>

001022dd <vector100>:
.globl vector100
vector100:
  pushl $0
  1022dd:	6a 00                	push   $0x0
  pushl $100
  1022df:	6a 64                	push   $0x64
  jmp __alltraps
  1022e1:	e9 f3 06 00 00       	jmp    1029d9 <__alltraps>

001022e6 <vector101>:
.globl vector101
vector101:
  pushl $0
  1022e6:	6a 00                	push   $0x0
  pushl $101
  1022e8:	6a 65                	push   $0x65
  jmp __alltraps
  1022ea:	e9 ea 06 00 00       	jmp    1029d9 <__alltraps>

001022ef <vector102>:
.globl vector102
vector102:
  pushl $0
  1022ef:	6a 00                	push   $0x0
  pushl $102
  1022f1:	6a 66                	push   $0x66
  jmp __alltraps
  1022f3:	e9 e1 06 00 00       	jmp    1029d9 <__alltraps>

001022f8 <vector103>:
.globl vector103
vector103:
  pushl $0
  1022f8:	6a 00                	push   $0x0
  pushl $103
  1022fa:	6a 67                	push   $0x67
  jmp __alltraps
  1022fc:	e9 d8 06 00 00       	jmp    1029d9 <__alltraps>

00102301 <vector104>:
.globl vector104
vector104:
  pushl $0
  102301:	6a 00                	push   $0x0
  pushl $104
  102303:	6a 68                	push   $0x68
  jmp __alltraps
  102305:	e9 cf 06 00 00       	jmp    1029d9 <__alltraps>

0010230a <vector105>:
.globl vector105
vector105:
  pushl $0
  10230a:	6a 00                	push   $0x0
  pushl $105
  10230c:	6a 69                	push   $0x69
  jmp __alltraps
  10230e:	e9 c6 06 00 00       	jmp    1029d9 <__alltraps>

00102313 <vector106>:
.globl vector106
vector106:
  pushl $0
  102313:	6a 00                	push   $0x0
  pushl $106
  102315:	6a 6a                	push   $0x6a
  jmp __alltraps
  102317:	e9 bd 06 00 00       	jmp    1029d9 <__alltraps>

0010231c <vector107>:
.globl vector107
vector107:
  pushl $0
  10231c:	6a 00                	push   $0x0
  pushl $107
  10231e:	6a 6b                	push   $0x6b
  jmp __alltraps
  102320:	e9 b4 06 00 00       	jmp    1029d9 <__alltraps>

00102325 <vector108>:
.globl vector108
vector108:
  pushl $0
  102325:	6a 00                	push   $0x0
  pushl $108
  102327:	6a 6c                	push   $0x6c
  jmp __alltraps
  102329:	e9 ab 06 00 00       	jmp    1029d9 <__alltraps>

0010232e <vector109>:
.globl vector109
vector109:
  pushl $0
  10232e:	6a 00                	push   $0x0
  pushl $109
  102330:	6a 6d                	push   $0x6d
  jmp __alltraps
  102332:	e9 a2 06 00 00       	jmp    1029d9 <__alltraps>

00102337 <vector110>:
.globl vector110
vector110:
  pushl $0
  102337:	6a 00                	push   $0x0
  pushl $110
  102339:	6a 6e                	push   $0x6e
  jmp __alltraps
  10233b:	e9 99 06 00 00       	jmp    1029d9 <__alltraps>

00102340 <vector111>:
.globl vector111
vector111:
  pushl $0
  102340:	6a 00                	push   $0x0
  pushl $111
  102342:	6a 6f                	push   $0x6f
  jmp __alltraps
  102344:	e9 90 06 00 00       	jmp    1029d9 <__alltraps>

00102349 <vector112>:
.globl vector112
vector112:
  pushl $0
  102349:	6a 00                	push   $0x0
  pushl $112
  10234b:	6a 70                	push   $0x70
  jmp __alltraps
  10234d:	e9 87 06 00 00       	jmp    1029d9 <__alltraps>

00102352 <vector113>:
.globl vector113
vector113:
  pushl $0
  102352:	6a 00                	push   $0x0
  pushl $113
  102354:	6a 71                	push   $0x71
  jmp __alltraps
  102356:	e9 7e 06 00 00       	jmp    1029d9 <__alltraps>

0010235b <vector114>:
.globl vector114
vector114:
  pushl $0
  10235b:	6a 00                	push   $0x0
  pushl $114
  10235d:	6a 72                	push   $0x72
  jmp __alltraps
  10235f:	e9 75 06 00 00       	jmp    1029d9 <__alltraps>

00102364 <vector115>:
.globl vector115
vector115:
  pushl $0
  102364:	6a 00                	push   $0x0
  pushl $115
  102366:	6a 73                	push   $0x73
  jmp __alltraps
  102368:	e9 6c 06 00 00       	jmp    1029d9 <__alltraps>

0010236d <vector116>:
.globl vector116
vector116:
  pushl $0
  10236d:	6a 00                	push   $0x0
  pushl $116
  10236f:	6a 74                	push   $0x74
  jmp __alltraps
  102371:	e9 63 06 00 00       	jmp    1029d9 <__alltraps>

00102376 <vector117>:
.globl vector117
vector117:
  pushl $0
  102376:	6a 00                	push   $0x0
  pushl $117
  102378:	6a 75                	push   $0x75
  jmp __alltraps
  10237a:	e9 5a 06 00 00       	jmp    1029d9 <__alltraps>

0010237f <vector118>:
.globl vector118
vector118:
  pushl $0
  10237f:	6a 00                	push   $0x0
  pushl $118
  102381:	6a 76                	push   $0x76
  jmp __alltraps
  102383:	e9 51 06 00 00       	jmp    1029d9 <__alltraps>

00102388 <vector119>:
.globl vector119
vector119:
  pushl $0
  102388:	6a 00                	push   $0x0
  pushl $119
  10238a:	6a 77                	push   $0x77
  jmp __alltraps
  10238c:	e9 48 06 00 00       	jmp    1029d9 <__alltraps>

00102391 <vector120>:
.globl vector120
vector120:
  pushl $0
  102391:	6a 00                	push   $0x0
  pushl $120
  102393:	6a 78                	push   $0x78
  jmp __alltraps
  102395:	e9 3f 06 00 00       	jmp    1029d9 <__alltraps>

0010239a <vector121>:
.globl vector121
vector121:
  pushl $0
  10239a:	6a 00                	push   $0x0
  pushl $121
  10239c:	6a 79                	push   $0x79
  jmp __alltraps
  10239e:	e9 36 06 00 00       	jmp    1029d9 <__alltraps>

001023a3 <vector122>:
.globl vector122
vector122:
  pushl $0
  1023a3:	6a 00                	push   $0x0
  pushl $122
  1023a5:	6a 7a                	push   $0x7a
  jmp __alltraps
  1023a7:	e9 2d 06 00 00       	jmp    1029d9 <__alltraps>

001023ac <vector123>:
.globl vector123
vector123:
  pushl $0
  1023ac:	6a 00                	push   $0x0
  pushl $123
  1023ae:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023b0:	e9 24 06 00 00       	jmp    1029d9 <__alltraps>

001023b5 <vector124>:
.globl vector124
vector124:
  pushl $0
  1023b5:	6a 00                	push   $0x0
  pushl $124
  1023b7:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023b9:	e9 1b 06 00 00       	jmp    1029d9 <__alltraps>

001023be <vector125>:
.globl vector125
vector125:
  pushl $0
  1023be:	6a 00                	push   $0x0
  pushl $125
  1023c0:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023c2:	e9 12 06 00 00       	jmp    1029d9 <__alltraps>

001023c7 <vector126>:
.globl vector126
vector126:
  pushl $0
  1023c7:	6a 00                	push   $0x0
  pushl $126
  1023c9:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023cb:	e9 09 06 00 00       	jmp    1029d9 <__alltraps>

001023d0 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023d0:	6a 00                	push   $0x0
  pushl $127
  1023d2:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023d4:	e9 00 06 00 00       	jmp    1029d9 <__alltraps>

001023d9 <vector128>:
.globl vector128
vector128:
  pushl $0
  1023d9:	6a 00                	push   $0x0
  pushl $128
  1023db:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1023e0:	e9 f4 05 00 00       	jmp    1029d9 <__alltraps>

001023e5 <vector129>:
.globl vector129
vector129:
  pushl $0
  1023e5:	6a 00                	push   $0x0
  pushl $129
  1023e7:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1023ec:	e9 e8 05 00 00       	jmp    1029d9 <__alltraps>

001023f1 <vector130>:
.globl vector130
vector130:
  pushl $0
  1023f1:	6a 00                	push   $0x0
  pushl $130
  1023f3:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1023f8:	e9 dc 05 00 00       	jmp    1029d9 <__alltraps>

001023fd <vector131>:
.globl vector131
vector131:
  pushl $0
  1023fd:	6a 00                	push   $0x0
  pushl $131
  1023ff:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102404:	e9 d0 05 00 00       	jmp    1029d9 <__alltraps>

00102409 <vector132>:
.globl vector132
vector132:
  pushl $0
  102409:	6a 00                	push   $0x0
  pushl $132
  10240b:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102410:	e9 c4 05 00 00       	jmp    1029d9 <__alltraps>

00102415 <vector133>:
.globl vector133
vector133:
  pushl $0
  102415:	6a 00                	push   $0x0
  pushl $133
  102417:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10241c:	e9 b8 05 00 00       	jmp    1029d9 <__alltraps>

00102421 <vector134>:
.globl vector134
vector134:
  pushl $0
  102421:	6a 00                	push   $0x0
  pushl $134
  102423:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102428:	e9 ac 05 00 00       	jmp    1029d9 <__alltraps>

0010242d <vector135>:
.globl vector135
vector135:
  pushl $0
  10242d:	6a 00                	push   $0x0
  pushl $135
  10242f:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102434:	e9 a0 05 00 00       	jmp    1029d9 <__alltraps>

00102439 <vector136>:
.globl vector136
vector136:
  pushl $0
  102439:	6a 00                	push   $0x0
  pushl $136
  10243b:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102440:	e9 94 05 00 00       	jmp    1029d9 <__alltraps>

00102445 <vector137>:
.globl vector137
vector137:
  pushl $0
  102445:	6a 00                	push   $0x0
  pushl $137
  102447:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10244c:	e9 88 05 00 00       	jmp    1029d9 <__alltraps>

00102451 <vector138>:
.globl vector138
vector138:
  pushl $0
  102451:	6a 00                	push   $0x0
  pushl $138
  102453:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102458:	e9 7c 05 00 00       	jmp    1029d9 <__alltraps>

0010245d <vector139>:
.globl vector139
vector139:
  pushl $0
  10245d:	6a 00                	push   $0x0
  pushl $139
  10245f:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102464:	e9 70 05 00 00       	jmp    1029d9 <__alltraps>

00102469 <vector140>:
.globl vector140
vector140:
  pushl $0
  102469:	6a 00                	push   $0x0
  pushl $140
  10246b:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102470:	e9 64 05 00 00       	jmp    1029d9 <__alltraps>

00102475 <vector141>:
.globl vector141
vector141:
  pushl $0
  102475:	6a 00                	push   $0x0
  pushl $141
  102477:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10247c:	e9 58 05 00 00       	jmp    1029d9 <__alltraps>

00102481 <vector142>:
.globl vector142
vector142:
  pushl $0
  102481:	6a 00                	push   $0x0
  pushl $142
  102483:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102488:	e9 4c 05 00 00       	jmp    1029d9 <__alltraps>

0010248d <vector143>:
.globl vector143
vector143:
  pushl $0
  10248d:	6a 00                	push   $0x0
  pushl $143
  10248f:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102494:	e9 40 05 00 00       	jmp    1029d9 <__alltraps>

00102499 <vector144>:
.globl vector144
vector144:
  pushl $0
  102499:	6a 00                	push   $0x0
  pushl $144
  10249b:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1024a0:	e9 34 05 00 00       	jmp    1029d9 <__alltraps>

001024a5 <vector145>:
.globl vector145
vector145:
  pushl $0
  1024a5:	6a 00                	push   $0x0
  pushl $145
  1024a7:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1024ac:	e9 28 05 00 00       	jmp    1029d9 <__alltraps>

001024b1 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024b1:	6a 00                	push   $0x0
  pushl $146
  1024b3:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024b8:	e9 1c 05 00 00       	jmp    1029d9 <__alltraps>

001024bd <vector147>:
.globl vector147
vector147:
  pushl $0
  1024bd:	6a 00                	push   $0x0
  pushl $147
  1024bf:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024c4:	e9 10 05 00 00       	jmp    1029d9 <__alltraps>

001024c9 <vector148>:
.globl vector148
vector148:
  pushl $0
  1024c9:	6a 00                	push   $0x0
  pushl $148
  1024cb:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024d0:	e9 04 05 00 00       	jmp    1029d9 <__alltraps>

001024d5 <vector149>:
.globl vector149
vector149:
  pushl $0
  1024d5:	6a 00                	push   $0x0
  pushl $149
  1024d7:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1024dc:	e9 f8 04 00 00       	jmp    1029d9 <__alltraps>

001024e1 <vector150>:
.globl vector150
vector150:
  pushl $0
  1024e1:	6a 00                	push   $0x0
  pushl $150
  1024e3:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1024e8:	e9 ec 04 00 00       	jmp    1029d9 <__alltraps>

001024ed <vector151>:
.globl vector151
vector151:
  pushl $0
  1024ed:	6a 00                	push   $0x0
  pushl $151
  1024ef:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1024f4:	e9 e0 04 00 00       	jmp    1029d9 <__alltraps>

001024f9 <vector152>:
.globl vector152
vector152:
  pushl $0
  1024f9:	6a 00                	push   $0x0
  pushl $152
  1024fb:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102500:	e9 d4 04 00 00       	jmp    1029d9 <__alltraps>

00102505 <vector153>:
.globl vector153
vector153:
  pushl $0
  102505:	6a 00                	push   $0x0
  pushl $153
  102507:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10250c:	e9 c8 04 00 00       	jmp    1029d9 <__alltraps>

00102511 <vector154>:
.globl vector154
vector154:
  pushl $0
  102511:	6a 00                	push   $0x0
  pushl $154
  102513:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102518:	e9 bc 04 00 00       	jmp    1029d9 <__alltraps>

0010251d <vector155>:
.globl vector155
vector155:
  pushl $0
  10251d:	6a 00                	push   $0x0
  pushl $155
  10251f:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102524:	e9 b0 04 00 00       	jmp    1029d9 <__alltraps>

00102529 <vector156>:
.globl vector156
vector156:
  pushl $0
  102529:	6a 00                	push   $0x0
  pushl $156
  10252b:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102530:	e9 a4 04 00 00       	jmp    1029d9 <__alltraps>

00102535 <vector157>:
.globl vector157
vector157:
  pushl $0
  102535:	6a 00                	push   $0x0
  pushl $157
  102537:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10253c:	e9 98 04 00 00       	jmp    1029d9 <__alltraps>

00102541 <vector158>:
.globl vector158
vector158:
  pushl $0
  102541:	6a 00                	push   $0x0
  pushl $158
  102543:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102548:	e9 8c 04 00 00       	jmp    1029d9 <__alltraps>

0010254d <vector159>:
.globl vector159
vector159:
  pushl $0
  10254d:	6a 00                	push   $0x0
  pushl $159
  10254f:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102554:	e9 80 04 00 00       	jmp    1029d9 <__alltraps>

00102559 <vector160>:
.globl vector160
vector160:
  pushl $0
  102559:	6a 00                	push   $0x0
  pushl $160
  10255b:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102560:	e9 74 04 00 00       	jmp    1029d9 <__alltraps>

00102565 <vector161>:
.globl vector161
vector161:
  pushl $0
  102565:	6a 00                	push   $0x0
  pushl $161
  102567:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10256c:	e9 68 04 00 00       	jmp    1029d9 <__alltraps>

00102571 <vector162>:
.globl vector162
vector162:
  pushl $0
  102571:	6a 00                	push   $0x0
  pushl $162
  102573:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102578:	e9 5c 04 00 00       	jmp    1029d9 <__alltraps>

0010257d <vector163>:
.globl vector163
vector163:
  pushl $0
  10257d:	6a 00                	push   $0x0
  pushl $163
  10257f:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102584:	e9 50 04 00 00       	jmp    1029d9 <__alltraps>

00102589 <vector164>:
.globl vector164
vector164:
  pushl $0
  102589:	6a 00                	push   $0x0
  pushl $164
  10258b:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102590:	e9 44 04 00 00       	jmp    1029d9 <__alltraps>

00102595 <vector165>:
.globl vector165
vector165:
  pushl $0
  102595:	6a 00                	push   $0x0
  pushl $165
  102597:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10259c:	e9 38 04 00 00       	jmp    1029d9 <__alltraps>

001025a1 <vector166>:
.globl vector166
vector166:
  pushl $0
  1025a1:	6a 00                	push   $0x0
  pushl $166
  1025a3:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1025a8:	e9 2c 04 00 00       	jmp    1029d9 <__alltraps>

001025ad <vector167>:
.globl vector167
vector167:
  pushl $0
  1025ad:	6a 00                	push   $0x0
  pushl $167
  1025af:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025b4:	e9 20 04 00 00       	jmp    1029d9 <__alltraps>

001025b9 <vector168>:
.globl vector168
vector168:
  pushl $0
  1025b9:	6a 00                	push   $0x0
  pushl $168
  1025bb:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025c0:	e9 14 04 00 00       	jmp    1029d9 <__alltraps>

001025c5 <vector169>:
.globl vector169
vector169:
  pushl $0
  1025c5:	6a 00                	push   $0x0
  pushl $169
  1025c7:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025cc:	e9 08 04 00 00       	jmp    1029d9 <__alltraps>

001025d1 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025d1:	6a 00                	push   $0x0
  pushl $170
  1025d3:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025d8:	e9 fc 03 00 00       	jmp    1029d9 <__alltraps>

001025dd <vector171>:
.globl vector171
vector171:
  pushl $0
  1025dd:	6a 00                	push   $0x0
  pushl $171
  1025df:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1025e4:	e9 f0 03 00 00       	jmp    1029d9 <__alltraps>

001025e9 <vector172>:
.globl vector172
vector172:
  pushl $0
  1025e9:	6a 00                	push   $0x0
  pushl $172
  1025eb:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1025f0:	e9 e4 03 00 00       	jmp    1029d9 <__alltraps>

001025f5 <vector173>:
.globl vector173
vector173:
  pushl $0
  1025f5:	6a 00                	push   $0x0
  pushl $173
  1025f7:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1025fc:	e9 d8 03 00 00       	jmp    1029d9 <__alltraps>

00102601 <vector174>:
.globl vector174
vector174:
  pushl $0
  102601:	6a 00                	push   $0x0
  pushl $174
  102603:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102608:	e9 cc 03 00 00       	jmp    1029d9 <__alltraps>

0010260d <vector175>:
.globl vector175
vector175:
  pushl $0
  10260d:	6a 00                	push   $0x0
  pushl $175
  10260f:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102614:	e9 c0 03 00 00       	jmp    1029d9 <__alltraps>

00102619 <vector176>:
.globl vector176
vector176:
  pushl $0
  102619:	6a 00                	push   $0x0
  pushl $176
  10261b:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102620:	e9 b4 03 00 00       	jmp    1029d9 <__alltraps>

00102625 <vector177>:
.globl vector177
vector177:
  pushl $0
  102625:	6a 00                	push   $0x0
  pushl $177
  102627:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10262c:	e9 a8 03 00 00       	jmp    1029d9 <__alltraps>

00102631 <vector178>:
.globl vector178
vector178:
  pushl $0
  102631:	6a 00                	push   $0x0
  pushl $178
  102633:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102638:	e9 9c 03 00 00       	jmp    1029d9 <__alltraps>

0010263d <vector179>:
.globl vector179
vector179:
  pushl $0
  10263d:	6a 00                	push   $0x0
  pushl $179
  10263f:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102644:	e9 90 03 00 00       	jmp    1029d9 <__alltraps>

00102649 <vector180>:
.globl vector180
vector180:
  pushl $0
  102649:	6a 00                	push   $0x0
  pushl $180
  10264b:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102650:	e9 84 03 00 00       	jmp    1029d9 <__alltraps>

00102655 <vector181>:
.globl vector181
vector181:
  pushl $0
  102655:	6a 00                	push   $0x0
  pushl $181
  102657:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10265c:	e9 78 03 00 00       	jmp    1029d9 <__alltraps>

00102661 <vector182>:
.globl vector182
vector182:
  pushl $0
  102661:	6a 00                	push   $0x0
  pushl $182
  102663:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102668:	e9 6c 03 00 00       	jmp    1029d9 <__alltraps>

0010266d <vector183>:
.globl vector183
vector183:
  pushl $0
  10266d:	6a 00                	push   $0x0
  pushl $183
  10266f:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102674:	e9 60 03 00 00       	jmp    1029d9 <__alltraps>

00102679 <vector184>:
.globl vector184
vector184:
  pushl $0
  102679:	6a 00                	push   $0x0
  pushl $184
  10267b:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102680:	e9 54 03 00 00       	jmp    1029d9 <__alltraps>

00102685 <vector185>:
.globl vector185
vector185:
  pushl $0
  102685:	6a 00                	push   $0x0
  pushl $185
  102687:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10268c:	e9 48 03 00 00       	jmp    1029d9 <__alltraps>

00102691 <vector186>:
.globl vector186
vector186:
  pushl $0
  102691:	6a 00                	push   $0x0
  pushl $186
  102693:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102698:	e9 3c 03 00 00       	jmp    1029d9 <__alltraps>

0010269d <vector187>:
.globl vector187
vector187:
  pushl $0
  10269d:	6a 00                	push   $0x0
  pushl $187
  10269f:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1026a4:	e9 30 03 00 00       	jmp    1029d9 <__alltraps>

001026a9 <vector188>:
.globl vector188
vector188:
  pushl $0
  1026a9:	6a 00                	push   $0x0
  pushl $188
  1026ab:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026b0:	e9 24 03 00 00       	jmp    1029d9 <__alltraps>

001026b5 <vector189>:
.globl vector189
vector189:
  pushl $0
  1026b5:	6a 00                	push   $0x0
  pushl $189
  1026b7:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026bc:	e9 18 03 00 00       	jmp    1029d9 <__alltraps>

001026c1 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026c1:	6a 00                	push   $0x0
  pushl $190
  1026c3:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026c8:	e9 0c 03 00 00       	jmp    1029d9 <__alltraps>

001026cd <vector191>:
.globl vector191
vector191:
  pushl $0
  1026cd:	6a 00                	push   $0x0
  pushl $191
  1026cf:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026d4:	e9 00 03 00 00       	jmp    1029d9 <__alltraps>

001026d9 <vector192>:
.globl vector192
vector192:
  pushl $0
  1026d9:	6a 00                	push   $0x0
  pushl $192
  1026db:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1026e0:	e9 f4 02 00 00       	jmp    1029d9 <__alltraps>

001026e5 <vector193>:
.globl vector193
vector193:
  pushl $0
  1026e5:	6a 00                	push   $0x0
  pushl $193
  1026e7:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1026ec:	e9 e8 02 00 00       	jmp    1029d9 <__alltraps>

001026f1 <vector194>:
.globl vector194
vector194:
  pushl $0
  1026f1:	6a 00                	push   $0x0
  pushl $194
  1026f3:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1026f8:	e9 dc 02 00 00       	jmp    1029d9 <__alltraps>

001026fd <vector195>:
.globl vector195
vector195:
  pushl $0
  1026fd:	6a 00                	push   $0x0
  pushl $195
  1026ff:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102704:	e9 d0 02 00 00       	jmp    1029d9 <__alltraps>

00102709 <vector196>:
.globl vector196
vector196:
  pushl $0
  102709:	6a 00                	push   $0x0
  pushl $196
  10270b:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102710:	e9 c4 02 00 00       	jmp    1029d9 <__alltraps>

00102715 <vector197>:
.globl vector197
vector197:
  pushl $0
  102715:	6a 00                	push   $0x0
  pushl $197
  102717:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10271c:	e9 b8 02 00 00       	jmp    1029d9 <__alltraps>

00102721 <vector198>:
.globl vector198
vector198:
  pushl $0
  102721:	6a 00                	push   $0x0
  pushl $198
  102723:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102728:	e9 ac 02 00 00       	jmp    1029d9 <__alltraps>

0010272d <vector199>:
.globl vector199
vector199:
  pushl $0
  10272d:	6a 00                	push   $0x0
  pushl $199
  10272f:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102734:	e9 a0 02 00 00       	jmp    1029d9 <__alltraps>

00102739 <vector200>:
.globl vector200
vector200:
  pushl $0
  102739:	6a 00                	push   $0x0
  pushl $200
  10273b:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102740:	e9 94 02 00 00       	jmp    1029d9 <__alltraps>

00102745 <vector201>:
.globl vector201
vector201:
  pushl $0
  102745:	6a 00                	push   $0x0
  pushl $201
  102747:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10274c:	e9 88 02 00 00       	jmp    1029d9 <__alltraps>

00102751 <vector202>:
.globl vector202
vector202:
  pushl $0
  102751:	6a 00                	push   $0x0
  pushl $202
  102753:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102758:	e9 7c 02 00 00       	jmp    1029d9 <__alltraps>

0010275d <vector203>:
.globl vector203
vector203:
  pushl $0
  10275d:	6a 00                	push   $0x0
  pushl $203
  10275f:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102764:	e9 70 02 00 00       	jmp    1029d9 <__alltraps>

00102769 <vector204>:
.globl vector204
vector204:
  pushl $0
  102769:	6a 00                	push   $0x0
  pushl $204
  10276b:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102770:	e9 64 02 00 00       	jmp    1029d9 <__alltraps>

00102775 <vector205>:
.globl vector205
vector205:
  pushl $0
  102775:	6a 00                	push   $0x0
  pushl $205
  102777:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10277c:	e9 58 02 00 00       	jmp    1029d9 <__alltraps>

00102781 <vector206>:
.globl vector206
vector206:
  pushl $0
  102781:	6a 00                	push   $0x0
  pushl $206
  102783:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102788:	e9 4c 02 00 00       	jmp    1029d9 <__alltraps>

0010278d <vector207>:
.globl vector207
vector207:
  pushl $0
  10278d:	6a 00                	push   $0x0
  pushl $207
  10278f:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102794:	e9 40 02 00 00       	jmp    1029d9 <__alltraps>

00102799 <vector208>:
.globl vector208
vector208:
  pushl $0
  102799:	6a 00                	push   $0x0
  pushl $208
  10279b:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1027a0:	e9 34 02 00 00       	jmp    1029d9 <__alltraps>

001027a5 <vector209>:
.globl vector209
vector209:
  pushl $0
  1027a5:	6a 00                	push   $0x0
  pushl $209
  1027a7:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1027ac:	e9 28 02 00 00       	jmp    1029d9 <__alltraps>

001027b1 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027b1:	6a 00                	push   $0x0
  pushl $210
  1027b3:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027b8:	e9 1c 02 00 00       	jmp    1029d9 <__alltraps>

001027bd <vector211>:
.globl vector211
vector211:
  pushl $0
  1027bd:	6a 00                	push   $0x0
  pushl $211
  1027bf:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027c4:	e9 10 02 00 00       	jmp    1029d9 <__alltraps>

001027c9 <vector212>:
.globl vector212
vector212:
  pushl $0
  1027c9:	6a 00                	push   $0x0
  pushl $212
  1027cb:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027d0:	e9 04 02 00 00       	jmp    1029d9 <__alltraps>

001027d5 <vector213>:
.globl vector213
vector213:
  pushl $0
  1027d5:	6a 00                	push   $0x0
  pushl $213
  1027d7:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1027dc:	e9 f8 01 00 00       	jmp    1029d9 <__alltraps>

001027e1 <vector214>:
.globl vector214
vector214:
  pushl $0
  1027e1:	6a 00                	push   $0x0
  pushl $214
  1027e3:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1027e8:	e9 ec 01 00 00       	jmp    1029d9 <__alltraps>

001027ed <vector215>:
.globl vector215
vector215:
  pushl $0
  1027ed:	6a 00                	push   $0x0
  pushl $215
  1027ef:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1027f4:	e9 e0 01 00 00       	jmp    1029d9 <__alltraps>

001027f9 <vector216>:
.globl vector216
vector216:
  pushl $0
  1027f9:	6a 00                	push   $0x0
  pushl $216
  1027fb:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102800:	e9 d4 01 00 00       	jmp    1029d9 <__alltraps>

00102805 <vector217>:
.globl vector217
vector217:
  pushl $0
  102805:	6a 00                	push   $0x0
  pushl $217
  102807:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10280c:	e9 c8 01 00 00       	jmp    1029d9 <__alltraps>

00102811 <vector218>:
.globl vector218
vector218:
  pushl $0
  102811:	6a 00                	push   $0x0
  pushl $218
  102813:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102818:	e9 bc 01 00 00       	jmp    1029d9 <__alltraps>

0010281d <vector219>:
.globl vector219
vector219:
  pushl $0
  10281d:	6a 00                	push   $0x0
  pushl $219
  10281f:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102824:	e9 b0 01 00 00       	jmp    1029d9 <__alltraps>

00102829 <vector220>:
.globl vector220
vector220:
  pushl $0
  102829:	6a 00                	push   $0x0
  pushl $220
  10282b:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102830:	e9 a4 01 00 00       	jmp    1029d9 <__alltraps>

00102835 <vector221>:
.globl vector221
vector221:
  pushl $0
  102835:	6a 00                	push   $0x0
  pushl $221
  102837:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10283c:	e9 98 01 00 00       	jmp    1029d9 <__alltraps>

00102841 <vector222>:
.globl vector222
vector222:
  pushl $0
  102841:	6a 00                	push   $0x0
  pushl $222
  102843:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102848:	e9 8c 01 00 00       	jmp    1029d9 <__alltraps>

0010284d <vector223>:
.globl vector223
vector223:
  pushl $0
  10284d:	6a 00                	push   $0x0
  pushl $223
  10284f:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102854:	e9 80 01 00 00       	jmp    1029d9 <__alltraps>

00102859 <vector224>:
.globl vector224
vector224:
  pushl $0
  102859:	6a 00                	push   $0x0
  pushl $224
  10285b:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102860:	e9 74 01 00 00       	jmp    1029d9 <__alltraps>

00102865 <vector225>:
.globl vector225
vector225:
  pushl $0
  102865:	6a 00                	push   $0x0
  pushl $225
  102867:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10286c:	e9 68 01 00 00       	jmp    1029d9 <__alltraps>

00102871 <vector226>:
.globl vector226
vector226:
  pushl $0
  102871:	6a 00                	push   $0x0
  pushl $226
  102873:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102878:	e9 5c 01 00 00       	jmp    1029d9 <__alltraps>

0010287d <vector227>:
.globl vector227
vector227:
  pushl $0
  10287d:	6a 00                	push   $0x0
  pushl $227
  10287f:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102884:	e9 50 01 00 00       	jmp    1029d9 <__alltraps>

00102889 <vector228>:
.globl vector228
vector228:
  pushl $0
  102889:	6a 00                	push   $0x0
  pushl $228
  10288b:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102890:	e9 44 01 00 00       	jmp    1029d9 <__alltraps>

00102895 <vector229>:
.globl vector229
vector229:
  pushl $0
  102895:	6a 00                	push   $0x0
  pushl $229
  102897:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10289c:	e9 38 01 00 00       	jmp    1029d9 <__alltraps>

001028a1 <vector230>:
.globl vector230
vector230:
  pushl $0
  1028a1:	6a 00                	push   $0x0
  pushl $230
  1028a3:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1028a8:	e9 2c 01 00 00       	jmp    1029d9 <__alltraps>

001028ad <vector231>:
.globl vector231
vector231:
  pushl $0
  1028ad:	6a 00                	push   $0x0
  pushl $231
  1028af:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028b4:	e9 20 01 00 00       	jmp    1029d9 <__alltraps>

001028b9 <vector232>:
.globl vector232
vector232:
  pushl $0
  1028b9:	6a 00                	push   $0x0
  pushl $232
  1028bb:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028c0:	e9 14 01 00 00       	jmp    1029d9 <__alltraps>

001028c5 <vector233>:
.globl vector233
vector233:
  pushl $0
  1028c5:	6a 00                	push   $0x0
  pushl $233
  1028c7:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028cc:	e9 08 01 00 00       	jmp    1029d9 <__alltraps>

001028d1 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028d1:	6a 00                	push   $0x0
  pushl $234
  1028d3:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028d8:	e9 fc 00 00 00       	jmp    1029d9 <__alltraps>

001028dd <vector235>:
.globl vector235
vector235:
  pushl $0
  1028dd:	6a 00                	push   $0x0
  pushl $235
  1028df:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1028e4:	e9 f0 00 00 00       	jmp    1029d9 <__alltraps>

001028e9 <vector236>:
.globl vector236
vector236:
  pushl $0
  1028e9:	6a 00                	push   $0x0
  pushl $236
  1028eb:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1028f0:	e9 e4 00 00 00       	jmp    1029d9 <__alltraps>

001028f5 <vector237>:
.globl vector237
vector237:
  pushl $0
  1028f5:	6a 00                	push   $0x0
  pushl $237
  1028f7:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1028fc:	e9 d8 00 00 00       	jmp    1029d9 <__alltraps>

00102901 <vector238>:
.globl vector238
vector238:
  pushl $0
  102901:	6a 00                	push   $0x0
  pushl $238
  102903:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102908:	e9 cc 00 00 00       	jmp    1029d9 <__alltraps>

0010290d <vector239>:
.globl vector239
vector239:
  pushl $0
  10290d:	6a 00                	push   $0x0
  pushl $239
  10290f:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102914:	e9 c0 00 00 00       	jmp    1029d9 <__alltraps>

00102919 <vector240>:
.globl vector240
vector240:
  pushl $0
  102919:	6a 00                	push   $0x0
  pushl $240
  10291b:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102920:	e9 b4 00 00 00       	jmp    1029d9 <__alltraps>

00102925 <vector241>:
.globl vector241
vector241:
  pushl $0
  102925:	6a 00                	push   $0x0
  pushl $241
  102927:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10292c:	e9 a8 00 00 00       	jmp    1029d9 <__alltraps>

00102931 <vector242>:
.globl vector242
vector242:
  pushl $0
  102931:	6a 00                	push   $0x0
  pushl $242
  102933:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102938:	e9 9c 00 00 00       	jmp    1029d9 <__alltraps>

0010293d <vector243>:
.globl vector243
vector243:
  pushl $0
  10293d:	6a 00                	push   $0x0
  pushl $243
  10293f:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102944:	e9 90 00 00 00       	jmp    1029d9 <__alltraps>

00102949 <vector244>:
.globl vector244
vector244:
  pushl $0
  102949:	6a 00                	push   $0x0
  pushl $244
  10294b:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102950:	e9 84 00 00 00       	jmp    1029d9 <__alltraps>

00102955 <vector245>:
.globl vector245
vector245:
  pushl $0
  102955:	6a 00                	push   $0x0
  pushl $245
  102957:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10295c:	e9 78 00 00 00       	jmp    1029d9 <__alltraps>

00102961 <vector246>:
.globl vector246
vector246:
  pushl $0
  102961:	6a 00                	push   $0x0
  pushl $246
  102963:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102968:	e9 6c 00 00 00       	jmp    1029d9 <__alltraps>

0010296d <vector247>:
.globl vector247
vector247:
  pushl $0
  10296d:	6a 00                	push   $0x0
  pushl $247
  10296f:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102974:	e9 60 00 00 00       	jmp    1029d9 <__alltraps>

00102979 <vector248>:
.globl vector248
vector248:
  pushl $0
  102979:	6a 00                	push   $0x0
  pushl $248
  10297b:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102980:	e9 54 00 00 00       	jmp    1029d9 <__alltraps>

00102985 <vector249>:
.globl vector249
vector249:
  pushl $0
  102985:	6a 00                	push   $0x0
  pushl $249
  102987:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10298c:	e9 48 00 00 00       	jmp    1029d9 <__alltraps>

00102991 <vector250>:
.globl vector250
vector250:
  pushl $0
  102991:	6a 00                	push   $0x0
  pushl $250
  102993:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102998:	e9 3c 00 00 00       	jmp    1029d9 <__alltraps>

0010299d <vector251>:
.globl vector251
vector251:
  pushl $0
  10299d:	6a 00                	push   $0x0
  pushl $251
  10299f:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1029a4:	e9 30 00 00 00       	jmp    1029d9 <__alltraps>

001029a9 <vector252>:
.globl vector252
vector252:
  pushl $0
  1029a9:	6a 00                	push   $0x0
  pushl $252
  1029ab:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029b0:	e9 24 00 00 00       	jmp    1029d9 <__alltraps>

001029b5 <vector253>:
.globl vector253
vector253:
  pushl $0
  1029b5:	6a 00                	push   $0x0
  pushl $253
  1029b7:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029bc:	e9 18 00 00 00       	jmp    1029d9 <__alltraps>

001029c1 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029c1:	6a 00                	push   $0x0
  pushl $254
  1029c3:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029c8:	e9 0c 00 00 00       	jmp    1029d9 <__alltraps>

001029cd <vector255>:
.globl vector255
vector255:
  pushl $0
  1029cd:	6a 00                	push   $0x0
  pushl $255
  1029cf:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029d4:	e9 00 00 00 00       	jmp    1029d9 <__alltraps>

001029d9 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  1029d9:	1e                   	push   %ds
    pushl %es
  1029da:	06                   	push   %es
    pushl %fs
  1029db:	0f a0                	push   %fs
    pushl %gs
  1029dd:	0f a8                	push   %gs
    pushal
  1029df:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  1029e0:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  1029e5:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  1029e7:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  1029e9:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  1029ea:	e8 60 f5 ff ff       	call   101f4f <trap>

    # pop the pushed stack pointer
    popl %esp
  1029ef:	5c                   	pop    %esp

001029f0 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  1029f0:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1029f1:	0f a9                	pop    %gs
    popl %fs
  1029f3:	0f a1                	pop    %fs
    popl %es
  1029f5:	07                   	pop    %es
    popl %ds
  1029f6:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1029f7:	83 c4 08             	add    $0x8,%esp
    iret
  1029fa:	cf                   	iret   

001029fb <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1029fb:	55                   	push   %ebp
  1029fc:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  1029fe:	8b 45 08             	mov    0x8(%ebp),%eax
  102a01:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102a04:	b8 23 00 00 00       	mov    $0x23,%eax
  102a09:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102a0b:	b8 23 00 00 00       	mov    $0x23,%eax
  102a10:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102a12:	b8 10 00 00 00       	mov    $0x10,%eax
  102a17:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102a19:	b8 10 00 00 00       	mov    $0x10,%eax
  102a1e:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102a20:	b8 10 00 00 00       	mov    $0x10,%eax
  102a25:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102a27:	ea 2e 2a 10 00 08 00 	ljmp   $0x8,$0x102a2e
}
  102a2e:	90                   	nop
  102a2f:	5d                   	pop    %ebp
  102a30:	c3                   	ret    

00102a31 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102a31:	f3 0f 1e fb          	endbr32 
  102a35:	55                   	push   %ebp
  102a36:	89 e5                	mov    %esp,%ebp
  102a38:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102a3b:	b8 20 09 11 00       	mov    $0x110920,%eax
  102a40:	05 00 04 00 00       	add    $0x400,%eax
  102a45:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102a4a:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  102a51:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102a53:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102a5a:	68 00 
  102a5c:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a61:	0f b7 c0             	movzwl %ax,%eax
  102a64:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102a6a:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a6f:	c1 e8 10             	shr    $0x10,%eax
  102a72:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102a77:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a7e:	24 f0                	and    $0xf0,%al
  102a80:	0c 09                	or     $0x9,%al
  102a82:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a87:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a8e:	0c 10                	or     $0x10,%al
  102a90:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a95:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a9c:	24 9f                	and    $0x9f,%al
  102a9e:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102aa3:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102aaa:	0c 80                	or     $0x80,%al
  102aac:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ab1:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ab8:	24 f0                	and    $0xf0,%al
  102aba:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102abf:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ac6:	24 ef                	and    $0xef,%al
  102ac8:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102acd:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ad4:	24 df                	and    $0xdf,%al
  102ad6:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102adb:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ae2:	0c 40                	or     $0x40,%al
  102ae4:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102ae9:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102af0:	24 7f                	and    $0x7f,%al
  102af2:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102af7:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102afc:	c1 e8 18             	shr    $0x18,%eax
  102aff:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102b04:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b0b:	24 ef                	and    $0xef,%al
  102b0d:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102b12:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102b19:	e8 dd fe ff ff       	call   1029fb <lgdt>
  102b1e:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102b24:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102b28:	0f 00 d8             	ltr    %ax
}
  102b2b:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102b2c:	90                   	nop
  102b2d:	c9                   	leave  
  102b2e:	c3                   	ret    

00102b2f <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102b2f:	f3 0f 1e fb          	endbr32 
  102b33:	55                   	push   %ebp
  102b34:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102b36:	e8 f6 fe ff ff       	call   102a31 <gdt_init>
}
  102b3b:	90                   	nop
  102b3c:	5d                   	pop    %ebp
  102b3d:	c3                   	ret    

00102b3e <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102b3e:	f3 0f 1e fb          	endbr32 
  102b42:	55                   	push   %ebp
  102b43:	89 e5                	mov    %esp,%ebp
  102b45:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102b4f:	eb 03                	jmp    102b54 <strlen+0x16>
        cnt ++;
  102b51:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102b54:	8b 45 08             	mov    0x8(%ebp),%eax
  102b57:	8d 50 01             	lea    0x1(%eax),%edx
  102b5a:	89 55 08             	mov    %edx,0x8(%ebp)
  102b5d:	0f b6 00             	movzbl (%eax),%eax
  102b60:	84 c0                	test   %al,%al
  102b62:	75 ed                	jne    102b51 <strlen+0x13>
    }
    return cnt;
  102b64:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b67:	c9                   	leave  
  102b68:	c3                   	ret    

00102b69 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102b69:	f3 0f 1e fb          	endbr32 
  102b6d:	55                   	push   %ebp
  102b6e:	89 e5                	mov    %esp,%ebp
  102b70:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b7a:	eb 03                	jmp    102b7f <strnlen+0x16>
        cnt ++;
  102b7c:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b82:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102b85:	73 10                	jae    102b97 <strnlen+0x2e>
  102b87:	8b 45 08             	mov    0x8(%ebp),%eax
  102b8a:	8d 50 01             	lea    0x1(%eax),%edx
  102b8d:	89 55 08             	mov    %edx,0x8(%ebp)
  102b90:	0f b6 00             	movzbl (%eax),%eax
  102b93:	84 c0                	test   %al,%al
  102b95:	75 e5                	jne    102b7c <strnlen+0x13>
    }
    return cnt;
  102b97:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b9a:	c9                   	leave  
  102b9b:	c3                   	ret    

00102b9c <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102b9c:	f3 0f 1e fb          	endbr32 
  102ba0:	55                   	push   %ebp
  102ba1:	89 e5                	mov    %esp,%ebp
  102ba3:	57                   	push   %edi
  102ba4:	56                   	push   %esi
  102ba5:	83 ec 20             	sub    $0x20,%esp
  102ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  102bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102bae:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102bb4:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102bb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bba:	89 d1                	mov    %edx,%ecx
  102bbc:	89 c2                	mov    %eax,%edx
  102bbe:	89 ce                	mov    %ecx,%esi
  102bc0:	89 d7                	mov    %edx,%edi
  102bc2:	ac                   	lods   %ds:(%esi),%al
  102bc3:	aa                   	stos   %al,%es:(%edi)
  102bc4:	84 c0                	test   %al,%al
  102bc6:	75 fa                	jne    102bc2 <strcpy+0x26>
  102bc8:	89 fa                	mov    %edi,%edx
  102bca:	89 f1                	mov    %esi,%ecx
  102bcc:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102bcf:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102bd2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102bd8:	83 c4 20             	add    $0x20,%esp
  102bdb:	5e                   	pop    %esi
  102bdc:	5f                   	pop    %edi
  102bdd:	5d                   	pop    %ebp
  102bde:	c3                   	ret    

00102bdf <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102bdf:	f3 0f 1e fb          	endbr32 
  102be3:	55                   	push   %ebp
  102be4:	89 e5                	mov    %esp,%ebp
  102be6:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102be9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bec:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102bef:	eb 1e                	jmp    102c0f <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bf4:	0f b6 10             	movzbl (%eax),%edx
  102bf7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102bfa:	88 10                	mov    %dl,(%eax)
  102bfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102bff:	0f b6 00             	movzbl (%eax),%eax
  102c02:	84 c0                	test   %al,%al
  102c04:	74 03                	je     102c09 <strncpy+0x2a>
            src ++;
  102c06:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102c09:	ff 45 fc             	incl   -0x4(%ebp)
  102c0c:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102c0f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c13:	75 dc                	jne    102bf1 <strncpy+0x12>
    }
    return dst;
  102c15:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c18:	c9                   	leave  
  102c19:	c3                   	ret    

00102c1a <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102c1a:	f3 0f 1e fb          	endbr32 
  102c1e:	55                   	push   %ebp
  102c1f:	89 e5                	mov    %esp,%ebp
  102c21:	57                   	push   %edi
  102c22:	56                   	push   %esi
  102c23:	83 ec 20             	sub    $0x20,%esp
  102c26:	8b 45 08             	mov    0x8(%ebp),%eax
  102c29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102c32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c38:	89 d1                	mov    %edx,%ecx
  102c3a:	89 c2                	mov    %eax,%edx
  102c3c:	89 ce                	mov    %ecx,%esi
  102c3e:	89 d7                	mov    %edx,%edi
  102c40:	ac                   	lods   %ds:(%esi),%al
  102c41:	ae                   	scas   %es:(%edi),%al
  102c42:	75 08                	jne    102c4c <strcmp+0x32>
  102c44:	84 c0                	test   %al,%al
  102c46:	75 f8                	jne    102c40 <strcmp+0x26>
  102c48:	31 c0                	xor    %eax,%eax
  102c4a:	eb 04                	jmp    102c50 <strcmp+0x36>
  102c4c:	19 c0                	sbb    %eax,%eax
  102c4e:	0c 01                	or     $0x1,%al
  102c50:	89 fa                	mov    %edi,%edx
  102c52:	89 f1                	mov    %esi,%ecx
  102c54:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102c57:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102c5a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102c5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102c60:	83 c4 20             	add    $0x20,%esp
  102c63:	5e                   	pop    %esi
  102c64:	5f                   	pop    %edi
  102c65:	5d                   	pop    %ebp
  102c66:	c3                   	ret    

00102c67 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102c67:	f3 0f 1e fb          	endbr32 
  102c6b:	55                   	push   %ebp
  102c6c:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c6e:	eb 09                	jmp    102c79 <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102c70:	ff 4d 10             	decl   0x10(%ebp)
  102c73:	ff 45 08             	incl   0x8(%ebp)
  102c76:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c79:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c7d:	74 1a                	je     102c99 <strncmp+0x32>
  102c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  102c82:	0f b6 00             	movzbl (%eax),%eax
  102c85:	84 c0                	test   %al,%al
  102c87:	74 10                	je     102c99 <strncmp+0x32>
  102c89:	8b 45 08             	mov    0x8(%ebp),%eax
  102c8c:	0f b6 10             	movzbl (%eax),%edx
  102c8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c92:	0f b6 00             	movzbl (%eax),%eax
  102c95:	38 c2                	cmp    %al,%dl
  102c97:	74 d7                	je     102c70 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102c99:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c9d:	74 18                	je     102cb7 <strncmp+0x50>
  102c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca2:	0f b6 00             	movzbl (%eax),%eax
  102ca5:	0f b6 d0             	movzbl %al,%edx
  102ca8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cab:	0f b6 00             	movzbl (%eax),%eax
  102cae:	0f b6 c0             	movzbl %al,%eax
  102cb1:	29 c2                	sub    %eax,%edx
  102cb3:	89 d0                	mov    %edx,%eax
  102cb5:	eb 05                	jmp    102cbc <strncmp+0x55>
  102cb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102cbc:	5d                   	pop    %ebp
  102cbd:	c3                   	ret    

00102cbe <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102cbe:	f3 0f 1e fb          	endbr32 
  102cc2:	55                   	push   %ebp
  102cc3:	89 e5                	mov    %esp,%ebp
  102cc5:	83 ec 04             	sub    $0x4,%esp
  102cc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ccb:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102cce:	eb 13                	jmp    102ce3 <strchr+0x25>
        if (*s == c) {
  102cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd3:	0f b6 00             	movzbl (%eax),%eax
  102cd6:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102cd9:	75 05                	jne    102ce0 <strchr+0x22>
            return (char *)s;
  102cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  102cde:	eb 12                	jmp    102cf2 <strchr+0x34>
        }
        s ++;
  102ce0:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  102ce6:	0f b6 00             	movzbl (%eax),%eax
  102ce9:	84 c0                	test   %al,%al
  102ceb:	75 e3                	jne    102cd0 <strchr+0x12>
    }
    return NULL;
  102ced:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102cf2:	c9                   	leave  
  102cf3:	c3                   	ret    

00102cf4 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102cf4:	f3 0f 1e fb          	endbr32 
  102cf8:	55                   	push   %ebp
  102cf9:	89 e5                	mov    %esp,%ebp
  102cfb:	83 ec 04             	sub    $0x4,%esp
  102cfe:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d01:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d04:	eb 0e                	jmp    102d14 <strfind+0x20>
        if (*s == c) {
  102d06:	8b 45 08             	mov    0x8(%ebp),%eax
  102d09:	0f b6 00             	movzbl (%eax),%eax
  102d0c:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d0f:	74 0f                	je     102d20 <strfind+0x2c>
            break;
        }
        s ++;
  102d11:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d14:	8b 45 08             	mov    0x8(%ebp),%eax
  102d17:	0f b6 00             	movzbl (%eax),%eax
  102d1a:	84 c0                	test   %al,%al
  102d1c:	75 e8                	jne    102d06 <strfind+0x12>
  102d1e:	eb 01                	jmp    102d21 <strfind+0x2d>
            break;
  102d20:	90                   	nop
    }
    return (char *)s;
  102d21:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102d24:	c9                   	leave  
  102d25:	c3                   	ret    

00102d26 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102d26:	f3 0f 1e fb          	endbr32 
  102d2a:	55                   	push   %ebp
  102d2b:	89 e5                	mov    %esp,%ebp
  102d2d:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102d30:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102d37:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102d3e:	eb 03                	jmp    102d43 <strtol+0x1d>
        s ++;
  102d40:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102d43:	8b 45 08             	mov    0x8(%ebp),%eax
  102d46:	0f b6 00             	movzbl (%eax),%eax
  102d49:	3c 20                	cmp    $0x20,%al
  102d4b:	74 f3                	je     102d40 <strtol+0x1a>
  102d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d50:	0f b6 00             	movzbl (%eax),%eax
  102d53:	3c 09                	cmp    $0x9,%al
  102d55:	74 e9                	je     102d40 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102d57:	8b 45 08             	mov    0x8(%ebp),%eax
  102d5a:	0f b6 00             	movzbl (%eax),%eax
  102d5d:	3c 2b                	cmp    $0x2b,%al
  102d5f:	75 05                	jne    102d66 <strtol+0x40>
        s ++;
  102d61:	ff 45 08             	incl   0x8(%ebp)
  102d64:	eb 14                	jmp    102d7a <strtol+0x54>
    }
    else if (*s == '-') {
  102d66:	8b 45 08             	mov    0x8(%ebp),%eax
  102d69:	0f b6 00             	movzbl (%eax),%eax
  102d6c:	3c 2d                	cmp    $0x2d,%al
  102d6e:	75 0a                	jne    102d7a <strtol+0x54>
        s ++, neg = 1;
  102d70:	ff 45 08             	incl   0x8(%ebp)
  102d73:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102d7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d7e:	74 06                	je     102d86 <strtol+0x60>
  102d80:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102d84:	75 22                	jne    102da8 <strtol+0x82>
  102d86:	8b 45 08             	mov    0x8(%ebp),%eax
  102d89:	0f b6 00             	movzbl (%eax),%eax
  102d8c:	3c 30                	cmp    $0x30,%al
  102d8e:	75 18                	jne    102da8 <strtol+0x82>
  102d90:	8b 45 08             	mov    0x8(%ebp),%eax
  102d93:	40                   	inc    %eax
  102d94:	0f b6 00             	movzbl (%eax),%eax
  102d97:	3c 78                	cmp    $0x78,%al
  102d99:	75 0d                	jne    102da8 <strtol+0x82>
        s += 2, base = 16;
  102d9b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102d9f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102da6:	eb 29                	jmp    102dd1 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102da8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dac:	75 16                	jne    102dc4 <strtol+0x9e>
  102dae:	8b 45 08             	mov    0x8(%ebp),%eax
  102db1:	0f b6 00             	movzbl (%eax),%eax
  102db4:	3c 30                	cmp    $0x30,%al
  102db6:	75 0c                	jne    102dc4 <strtol+0x9e>
        s ++, base = 8;
  102db8:	ff 45 08             	incl   0x8(%ebp)
  102dbb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102dc2:	eb 0d                	jmp    102dd1 <strtol+0xab>
    }
    else if (base == 0) {
  102dc4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dc8:	75 07                	jne    102dd1 <strtol+0xab>
        base = 10;
  102dca:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd4:	0f b6 00             	movzbl (%eax),%eax
  102dd7:	3c 2f                	cmp    $0x2f,%al
  102dd9:	7e 1b                	jle    102df6 <strtol+0xd0>
  102ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  102dde:	0f b6 00             	movzbl (%eax),%eax
  102de1:	3c 39                	cmp    $0x39,%al
  102de3:	7f 11                	jg     102df6 <strtol+0xd0>
            dig = *s - '0';
  102de5:	8b 45 08             	mov    0x8(%ebp),%eax
  102de8:	0f b6 00             	movzbl (%eax),%eax
  102deb:	0f be c0             	movsbl %al,%eax
  102dee:	83 e8 30             	sub    $0x30,%eax
  102df1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102df4:	eb 48                	jmp    102e3e <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102df6:	8b 45 08             	mov    0x8(%ebp),%eax
  102df9:	0f b6 00             	movzbl (%eax),%eax
  102dfc:	3c 60                	cmp    $0x60,%al
  102dfe:	7e 1b                	jle    102e1b <strtol+0xf5>
  102e00:	8b 45 08             	mov    0x8(%ebp),%eax
  102e03:	0f b6 00             	movzbl (%eax),%eax
  102e06:	3c 7a                	cmp    $0x7a,%al
  102e08:	7f 11                	jg     102e1b <strtol+0xf5>
            dig = *s - 'a' + 10;
  102e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e0d:	0f b6 00             	movzbl (%eax),%eax
  102e10:	0f be c0             	movsbl %al,%eax
  102e13:	83 e8 57             	sub    $0x57,%eax
  102e16:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e19:	eb 23                	jmp    102e3e <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e1e:	0f b6 00             	movzbl (%eax),%eax
  102e21:	3c 40                	cmp    $0x40,%al
  102e23:	7e 3b                	jle    102e60 <strtol+0x13a>
  102e25:	8b 45 08             	mov    0x8(%ebp),%eax
  102e28:	0f b6 00             	movzbl (%eax),%eax
  102e2b:	3c 5a                	cmp    $0x5a,%al
  102e2d:	7f 31                	jg     102e60 <strtol+0x13a>
            dig = *s - 'A' + 10;
  102e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e32:	0f b6 00             	movzbl (%eax),%eax
  102e35:	0f be c0             	movsbl %al,%eax
  102e38:	83 e8 37             	sub    $0x37,%eax
  102e3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e41:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e44:	7d 19                	jge    102e5f <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102e46:	ff 45 08             	incl   0x8(%ebp)
  102e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e4c:	0f af 45 10          	imul   0x10(%ebp),%eax
  102e50:	89 c2                	mov    %eax,%edx
  102e52:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e55:	01 d0                	add    %edx,%eax
  102e57:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102e5a:	e9 72 ff ff ff       	jmp    102dd1 <strtol+0xab>
            break;
  102e5f:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102e60:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e64:	74 08                	je     102e6e <strtol+0x148>
        *endptr = (char *) s;
  102e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e69:	8b 55 08             	mov    0x8(%ebp),%edx
  102e6c:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102e6e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102e72:	74 07                	je     102e7b <strtol+0x155>
  102e74:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e77:	f7 d8                	neg    %eax
  102e79:	eb 03                	jmp    102e7e <strtol+0x158>
  102e7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102e7e:	c9                   	leave  
  102e7f:	c3                   	ret    

00102e80 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102e80:	f3 0f 1e fb          	endbr32 
  102e84:	55                   	push   %ebp
  102e85:	89 e5                	mov    %esp,%ebp
  102e87:	57                   	push   %edi
  102e88:	83 ec 24             	sub    $0x24,%esp
  102e8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e8e:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102e91:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102e95:	8b 45 08             	mov    0x8(%ebp),%eax
  102e98:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102e9b:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102e9e:	8b 45 10             	mov    0x10(%ebp),%eax
  102ea1:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102ea4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102ea7:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102eab:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102eae:	89 d7                	mov    %edx,%edi
  102eb0:	f3 aa                	rep stos %al,%es:(%edi)
  102eb2:	89 fa                	mov    %edi,%edx
  102eb4:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102eb7:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102eba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102ebd:	83 c4 24             	add    $0x24,%esp
  102ec0:	5f                   	pop    %edi
  102ec1:	5d                   	pop    %ebp
  102ec2:	c3                   	ret    

00102ec3 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102ec3:	f3 0f 1e fb          	endbr32 
  102ec7:	55                   	push   %ebp
  102ec8:	89 e5                	mov    %esp,%ebp
  102eca:	57                   	push   %edi
  102ecb:	56                   	push   %esi
  102ecc:	53                   	push   %ebx
  102ecd:	83 ec 30             	sub    $0x30,%esp
  102ed0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ed9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102edc:	8b 45 10             	mov    0x10(%ebp),%eax
  102edf:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102ee2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ee5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102ee8:	73 42                	jae    102f2c <memmove+0x69>
  102eea:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102eed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102ef0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ef3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ef6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ef9:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102efc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102eff:	c1 e8 02             	shr    $0x2,%eax
  102f02:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f04:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102f07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f0a:	89 d7                	mov    %edx,%edi
  102f0c:	89 c6                	mov    %eax,%esi
  102f0e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f10:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102f13:	83 e1 03             	and    $0x3,%ecx
  102f16:	74 02                	je     102f1a <memmove+0x57>
  102f18:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f1a:	89 f0                	mov    %esi,%eax
  102f1c:	89 fa                	mov    %edi,%edx
  102f1e:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102f21:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102f24:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102f27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102f2a:	eb 36                	jmp    102f62 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102f2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f2f:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f35:	01 c2                	add    %eax,%edx
  102f37:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f3a:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102f3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f40:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102f43:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f46:	89 c1                	mov    %eax,%ecx
  102f48:	89 d8                	mov    %ebx,%eax
  102f4a:	89 d6                	mov    %edx,%esi
  102f4c:	89 c7                	mov    %eax,%edi
  102f4e:	fd                   	std    
  102f4f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f51:	fc                   	cld    
  102f52:	89 f8                	mov    %edi,%eax
  102f54:	89 f2                	mov    %esi,%edx
  102f56:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102f59:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102f5c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102f5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102f62:	83 c4 30             	add    $0x30,%esp
  102f65:	5b                   	pop    %ebx
  102f66:	5e                   	pop    %esi
  102f67:	5f                   	pop    %edi
  102f68:	5d                   	pop    %ebp
  102f69:	c3                   	ret    

00102f6a <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102f6a:	f3 0f 1e fb          	endbr32 
  102f6e:	55                   	push   %ebp
  102f6f:	89 e5                	mov    %esp,%ebp
  102f71:	57                   	push   %edi
  102f72:	56                   	push   %esi
  102f73:	83 ec 20             	sub    $0x20,%esp
  102f76:	8b 45 08             	mov    0x8(%ebp),%eax
  102f79:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f7f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f82:	8b 45 10             	mov    0x10(%ebp),%eax
  102f85:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102f88:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f8b:	c1 e8 02             	shr    $0x2,%eax
  102f8e:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f90:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f96:	89 d7                	mov    %edx,%edi
  102f98:	89 c6                	mov    %eax,%esi
  102f9a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f9c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102f9f:	83 e1 03             	and    $0x3,%ecx
  102fa2:	74 02                	je     102fa6 <memcpy+0x3c>
  102fa4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102fa6:	89 f0                	mov    %esi,%eax
  102fa8:	89 fa                	mov    %edi,%edx
  102faa:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102fad:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102fb0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102fb3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102fb6:	83 c4 20             	add    $0x20,%esp
  102fb9:	5e                   	pop    %esi
  102fba:	5f                   	pop    %edi
  102fbb:	5d                   	pop    %ebp
  102fbc:	c3                   	ret    

00102fbd <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102fbd:	f3 0f 1e fb          	endbr32 
  102fc1:	55                   	push   %ebp
  102fc2:	89 e5                	mov    %esp,%ebp
  102fc4:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  102fca:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102fcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102fd3:	eb 2e                	jmp    103003 <memcmp+0x46>
        if (*s1 != *s2) {
  102fd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fd8:	0f b6 10             	movzbl (%eax),%edx
  102fdb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102fde:	0f b6 00             	movzbl (%eax),%eax
  102fe1:	38 c2                	cmp    %al,%dl
  102fe3:	74 18                	je     102ffd <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102fe5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fe8:	0f b6 00             	movzbl (%eax),%eax
  102feb:	0f b6 d0             	movzbl %al,%edx
  102fee:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102ff1:	0f b6 00             	movzbl (%eax),%eax
  102ff4:	0f b6 c0             	movzbl %al,%eax
  102ff7:	29 c2                	sub    %eax,%edx
  102ff9:	89 d0                	mov    %edx,%eax
  102ffb:	eb 18                	jmp    103015 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  102ffd:	ff 45 fc             	incl   -0x4(%ebp)
  103000:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  103003:	8b 45 10             	mov    0x10(%ebp),%eax
  103006:	8d 50 ff             	lea    -0x1(%eax),%edx
  103009:	89 55 10             	mov    %edx,0x10(%ebp)
  10300c:	85 c0                	test   %eax,%eax
  10300e:	75 c5                	jne    102fd5 <memcmp+0x18>
    }
    return 0;
  103010:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103015:	c9                   	leave  
  103016:	c3                   	ret    

00103017 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  103017:	f3 0f 1e fb          	endbr32 
  10301b:	55                   	push   %ebp
  10301c:	89 e5                	mov    %esp,%ebp
  10301e:	83 ec 58             	sub    $0x58,%esp
  103021:	8b 45 10             	mov    0x10(%ebp),%eax
  103024:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103027:	8b 45 14             	mov    0x14(%ebp),%eax
  10302a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10302d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103030:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103033:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103036:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  103039:	8b 45 18             	mov    0x18(%ebp),%eax
  10303c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10303f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103042:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103045:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103048:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10304b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10304e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103051:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103055:	74 1c                	je     103073 <printnum+0x5c>
  103057:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10305a:	ba 00 00 00 00       	mov    $0x0,%edx
  10305f:	f7 75 e4             	divl   -0x1c(%ebp)
  103062:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103065:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103068:	ba 00 00 00 00       	mov    $0x0,%edx
  10306d:	f7 75 e4             	divl   -0x1c(%ebp)
  103070:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103073:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103076:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103079:	f7 75 e4             	divl   -0x1c(%ebp)
  10307c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10307f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103082:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103085:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103088:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10308b:	89 55 ec             	mov    %edx,-0x14(%ebp)
  10308e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103091:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  103094:	8b 45 18             	mov    0x18(%ebp),%eax
  103097:	ba 00 00 00 00       	mov    $0x0,%edx
  10309c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  10309f:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1030a2:	19 d1                	sbb    %edx,%ecx
  1030a4:	72 4c                	jb     1030f2 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  1030a6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1030a9:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030ac:	8b 45 20             	mov    0x20(%ebp),%eax
  1030af:	89 44 24 18          	mov    %eax,0x18(%esp)
  1030b3:	89 54 24 14          	mov    %edx,0x14(%esp)
  1030b7:	8b 45 18             	mov    0x18(%ebp),%eax
  1030ba:	89 44 24 10          	mov    %eax,0x10(%esp)
  1030be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030c1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030c4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030c8:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1030cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d6:	89 04 24             	mov    %eax,(%esp)
  1030d9:	e8 39 ff ff ff       	call   103017 <printnum>
  1030de:	eb 1b                	jmp    1030fb <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1030e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030e3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030e7:	8b 45 20             	mov    0x20(%ebp),%eax
  1030ea:	89 04 24             	mov    %eax,(%esp)
  1030ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f0:	ff d0                	call   *%eax
        while (-- width > 0)
  1030f2:	ff 4d 1c             	decl   0x1c(%ebp)
  1030f5:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1030f9:	7f e5                	jg     1030e0 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1030fb:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1030fe:	05 50 3e 10 00       	add    $0x103e50,%eax
  103103:	0f b6 00             	movzbl (%eax),%eax
  103106:	0f be c0             	movsbl %al,%eax
  103109:	8b 55 0c             	mov    0xc(%ebp),%edx
  10310c:	89 54 24 04          	mov    %edx,0x4(%esp)
  103110:	89 04 24             	mov    %eax,(%esp)
  103113:	8b 45 08             	mov    0x8(%ebp),%eax
  103116:	ff d0                	call   *%eax
}
  103118:	90                   	nop
  103119:	c9                   	leave  
  10311a:	c3                   	ret    

0010311b <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10311b:	f3 0f 1e fb          	endbr32 
  10311f:	55                   	push   %ebp
  103120:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103122:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103126:	7e 14                	jle    10313c <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  103128:	8b 45 08             	mov    0x8(%ebp),%eax
  10312b:	8b 00                	mov    (%eax),%eax
  10312d:	8d 48 08             	lea    0x8(%eax),%ecx
  103130:	8b 55 08             	mov    0x8(%ebp),%edx
  103133:	89 0a                	mov    %ecx,(%edx)
  103135:	8b 50 04             	mov    0x4(%eax),%edx
  103138:	8b 00                	mov    (%eax),%eax
  10313a:	eb 30                	jmp    10316c <getuint+0x51>
    }
    else if (lflag) {
  10313c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103140:	74 16                	je     103158 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  103142:	8b 45 08             	mov    0x8(%ebp),%eax
  103145:	8b 00                	mov    (%eax),%eax
  103147:	8d 48 04             	lea    0x4(%eax),%ecx
  10314a:	8b 55 08             	mov    0x8(%ebp),%edx
  10314d:	89 0a                	mov    %ecx,(%edx)
  10314f:	8b 00                	mov    (%eax),%eax
  103151:	ba 00 00 00 00       	mov    $0x0,%edx
  103156:	eb 14                	jmp    10316c <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  103158:	8b 45 08             	mov    0x8(%ebp),%eax
  10315b:	8b 00                	mov    (%eax),%eax
  10315d:	8d 48 04             	lea    0x4(%eax),%ecx
  103160:	8b 55 08             	mov    0x8(%ebp),%edx
  103163:	89 0a                	mov    %ecx,(%edx)
  103165:	8b 00                	mov    (%eax),%eax
  103167:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10316c:	5d                   	pop    %ebp
  10316d:	c3                   	ret    

0010316e <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  10316e:	f3 0f 1e fb          	endbr32 
  103172:	55                   	push   %ebp
  103173:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103175:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103179:	7e 14                	jle    10318f <getint+0x21>
        return va_arg(*ap, long long);
  10317b:	8b 45 08             	mov    0x8(%ebp),%eax
  10317e:	8b 00                	mov    (%eax),%eax
  103180:	8d 48 08             	lea    0x8(%eax),%ecx
  103183:	8b 55 08             	mov    0x8(%ebp),%edx
  103186:	89 0a                	mov    %ecx,(%edx)
  103188:	8b 50 04             	mov    0x4(%eax),%edx
  10318b:	8b 00                	mov    (%eax),%eax
  10318d:	eb 28                	jmp    1031b7 <getint+0x49>
    }
    else if (lflag) {
  10318f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103193:	74 12                	je     1031a7 <getint+0x39>
        return va_arg(*ap, long);
  103195:	8b 45 08             	mov    0x8(%ebp),%eax
  103198:	8b 00                	mov    (%eax),%eax
  10319a:	8d 48 04             	lea    0x4(%eax),%ecx
  10319d:	8b 55 08             	mov    0x8(%ebp),%edx
  1031a0:	89 0a                	mov    %ecx,(%edx)
  1031a2:	8b 00                	mov    (%eax),%eax
  1031a4:	99                   	cltd   
  1031a5:	eb 10                	jmp    1031b7 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  1031a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1031aa:	8b 00                	mov    (%eax),%eax
  1031ac:	8d 48 04             	lea    0x4(%eax),%ecx
  1031af:	8b 55 08             	mov    0x8(%ebp),%edx
  1031b2:	89 0a                	mov    %ecx,(%edx)
  1031b4:	8b 00                	mov    (%eax),%eax
  1031b6:	99                   	cltd   
    }
}
  1031b7:	5d                   	pop    %ebp
  1031b8:	c3                   	ret    

001031b9 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1031b9:	f3 0f 1e fb          	endbr32 
  1031bd:	55                   	push   %ebp
  1031be:	89 e5                	mov    %esp,%ebp
  1031c0:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1031c3:	8d 45 14             	lea    0x14(%ebp),%eax
  1031c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1031c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031cc:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1031d0:	8b 45 10             	mov    0x10(%ebp),%eax
  1031d3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031de:	8b 45 08             	mov    0x8(%ebp),%eax
  1031e1:	89 04 24             	mov    %eax,(%esp)
  1031e4:	e8 03 00 00 00       	call   1031ec <vprintfmt>
    va_end(ap);
}
  1031e9:	90                   	nop
  1031ea:	c9                   	leave  
  1031eb:	c3                   	ret    

001031ec <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1031ec:	f3 0f 1e fb          	endbr32 
  1031f0:	55                   	push   %ebp
  1031f1:	89 e5                	mov    %esp,%ebp
  1031f3:	56                   	push   %esi
  1031f4:	53                   	push   %ebx
  1031f5:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1031f8:	eb 17                	jmp    103211 <vprintfmt+0x25>
            if (ch == '\0') {
  1031fa:	85 db                	test   %ebx,%ebx
  1031fc:	0f 84 c0 03 00 00    	je     1035c2 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  103202:	8b 45 0c             	mov    0xc(%ebp),%eax
  103205:	89 44 24 04          	mov    %eax,0x4(%esp)
  103209:	89 1c 24             	mov    %ebx,(%esp)
  10320c:	8b 45 08             	mov    0x8(%ebp),%eax
  10320f:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103211:	8b 45 10             	mov    0x10(%ebp),%eax
  103214:	8d 50 01             	lea    0x1(%eax),%edx
  103217:	89 55 10             	mov    %edx,0x10(%ebp)
  10321a:	0f b6 00             	movzbl (%eax),%eax
  10321d:	0f b6 d8             	movzbl %al,%ebx
  103220:	83 fb 25             	cmp    $0x25,%ebx
  103223:	75 d5                	jne    1031fa <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103225:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  103229:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103230:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103233:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103236:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10323d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103240:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103243:	8b 45 10             	mov    0x10(%ebp),%eax
  103246:	8d 50 01             	lea    0x1(%eax),%edx
  103249:	89 55 10             	mov    %edx,0x10(%ebp)
  10324c:	0f b6 00             	movzbl (%eax),%eax
  10324f:	0f b6 d8             	movzbl %al,%ebx
  103252:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103255:	83 f8 55             	cmp    $0x55,%eax
  103258:	0f 87 38 03 00 00    	ja     103596 <vprintfmt+0x3aa>
  10325e:	8b 04 85 74 3e 10 00 	mov    0x103e74(,%eax,4),%eax
  103265:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  103268:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  10326c:	eb d5                	jmp    103243 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  10326e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  103272:	eb cf                	jmp    103243 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103274:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  10327b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10327e:	89 d0                	mov    %edx,%eax
  103280:	c1 e0 02             	shl    $0x2,%eax
  103283:	01 d0                	add    %edx,%eax
  103285:	01 c0                	add    %eax,%eax
  103287:	01 d8                	add    %ebx,%eax
  103289:	83 e8 30             	sub    $0x30,%eax
  10328c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  10328f:	8b 45 10             	mov    0x10(%ebp),%eax
  103292:	0f b6 00             	movzbl (%eax),%eax
  103295:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  103298:	83 fb 2f             	cmp    $0x2f,%ebx
  10329b:	7e 38                	jle    1032d5 <vprintfmt+0xe9>
  10329d:	83 fb 39             	cmp    $0x39,%ebx
  1032a0:	7f 33                	jg     1032d5 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  1032a2:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1032a5:	eb d4                	jmp    10327b <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1032a7:	8b 45 14             	mov    0x14(%ebp),%eax
  1032aa:	8d 50 04             	lea    0x4(%eax),%edx
  1032ad:	89 55 14             	mov    %edx,0x14(%ebp)
  1032b0:	8b 00                	mov    (%eax),%eax
  1032b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1032b5:	eb 1f                	jmp    1032d6 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  1032b7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032bb:	79 86                	jns    103243 <vprintfmt+0x57>
                width = 0;
  1032bd:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  1032c4:	e9 7a ff ff ff       	jmp    103243 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  1032c9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  1032d0:	e9 6e ff ff ff       	jmp    103243 <vprintfmt+0x57>
            goto process_precision;
  1032d5:	90                   	nop

        process_precision:
            if (width < 0)
  1032d6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032da:	0f 89 63 ff ff ff    	jns    103243 <vprintfmt+0x57>
                width = precision, precision = -1;
  1032e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032e3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1032e6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  1032ed:	e9 51 ff ff ff       	jmp    103243 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  1032f2:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  1032f5:	e9 49 ff ff ff       	jmp    103243 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1032fa:	8b 45 14             	mov    0x14(%ebp),%eax
  1032fd:	8d 50 04             	lea    0x4(%eax),%edx
  103300:	89 55 14             	mov    %edx,0x14(%ebp)
  103303:	8b 00                	mov    (%eax),%eax
  103305:	8b 55 0c             	mov    0xc(%ebp),%edx
  103308:	89 54 24 04          	mov    %edx,0x4(%esp)
  10330c:	89 04 24             	mov    %eax,(%esp)
  10330f:	8b 45 08             	mov    0x8(%ebp),%eax
  103312:	ff d0                	call   *%eax
            break;
  103314:	e9 a4 02 00 00       	jmp    1035bd <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  103319:	8b 45 14             	mov    0x14(%ebp),%eax
  10331c:	8d 50 04             	lea    0x4(%eax),%edx
  10331f:	89 55 14             	mov    %edx,0x14(%ebp)
  103322:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103324:	85 db                	test   %ebx,%ebx
  103326:	79 02                	jns    10332a <vprintfmt+0x13e>
                err = -err;
  103328:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10332a:	83 fb 06             	cmp    $0x6,%ebx
  10332d:	7f 0b                	jg     10333a <vprintfmt+0x14e>
  10332f:	8b 34 9d 34 3e 10 00 	mov    0x103e34(,%ebx,4),%esi
  103336:	85 f6                	test   %esi,%esi
  103338:	75 23                	jne    10335d <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  10333a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10333e:	c7 44 24 08 61 3e 10 	movl   $0x103e61,0x8(%esp)
  103345:	00 
  103346:	8b 45 0c             	mov    0xc(%ebp),%eax
  103349:	89 44 24 04          	mov    %eax,0x4(%esp)
  10334d:	8b 45 08             	mov    0x8(%ebp),%eax
  103350:	89 04 24             	mov    %eax,(%esp)
  103353:	e8 61 fe ff ff       	call   1031b9 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103358:	e9 60 02 00 00       	jmp    1035bd <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  10335d:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103361:	c7 44 24 08 6a 3e 10 	movl   $0x103e6a,0x8(%esp)
  103368:	00 
  103369:	8b 45 0c             	mov    0xc(%ebp),%eax
  10336c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103370:	8b 45 08             	mov    0x8(%ebp),%eax
  103373:	89 04 24             	mov    %eax,(%esp)
  103376:	e8 3e fe ff ff       	call   1031b9 <printfmt>
            break;
  10337b:	e9 3d 02 00 00       	jmp    1035bd <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  103380:	8b 45 14             	mov    0x14(%ebp),%eax
  103383:	8d 50 04             	lea    0x4(%eax),%edx
  103386:	89 55 14             	mov    %edx,0x14(%ebp)
  103389:	8b 30                	mov    (%eax),%esi
  10338b:	85 f6                	test   %esi,%esi
  10338d:	75 05                	jne    103394 <vprintfmt+0x1a8>
                p = "(null)";
  10338f:	be 6d 3e 10 00       	mov    $0x103e6d,%esi
            }
            if (width > 0 && padc != '-') {
  103394:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103398:	7e 76                	jle    103410 <vprintfmt+0x224>
  10339a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  10339e:	74 70                	je     103410 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033a3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033a7:	89 34 24             	mov    %esi,(%esp)
  1033aa:	e8 ba f7 ff ff       	call   102b69 <strnlen>
  1033af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1033b2:	29 c2                	sub    %eax,%edx
  1033b4:	89 d0                	mov    %edx,%eax
  1033b6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1033b9:	eb 16                	jmp    1033d1 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  1033bb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1033bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033c2:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033c6:	89 04 24             	mov    %eax,(%esp)
  1033c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1033cc:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033ce:	ff 4d e8             	decl   -0x18(%ebp)
  1033d1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033d5:	7f e4                	jg     1033bb <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1033d7:	eb 37                	jmp    103410 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  1033d9:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  1033dd:	74 1f                	je     1033fe <vprintfmt+0x212>
  1033df:	83 fb 1f             	cmp    $0x1f,%ebx
  1033e2:	7e 05                	jle    1033e9 <vprintfmt+0x1fd>
  1033e4:	83 fb 7e             	cmp    $0x7e,%ebx
  1033e7:	7e 15                	jle    1033fe <vprintfmt+0x212>
                    putch('?', putdat);
  1033e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033f0:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  1033f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fa:	ff d0                	call   *%eax
  1033fc:	eb 0f                	jmp    10340d <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  1033fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  103401:	89 44 24 04          	mov    %eax,0x4(%esp)
  103405:	89 1c 24             	mov    %ebx,(%esp)
  103408:	8b 45 08             	mov    0x8(%ebp),%eax
  10340b:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10340d:	ff 4d e8             	decl   -0x18(%ebp)
  103410:	89 f0                	mov    %esi,%eax
  103412:	8d 70 01             	lea    0x1(%eax),%esi
  103415:	0f b6 00             	movzbl (%eax),%eax
  103418:	0f be d8             	movsbl %al,%ebx
  10341b:	85 db                	test   %ebx,%ebx
  10341d:	74 27                	je     103446 <vprintfmt+0x25a>
  10341f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103423:	78 b4                	js     1033d9 <vprintfmt+0x1ed>
  103425:	ff 4d e4             	decl   -0x1c(%ebp)
  103428:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10342c:	79 ab                	jns    1033d9 <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  10342e:	eb 16                	jmp    103446 <vprintfmt+0x25a>
                putch(' ', putdat);
  103430:	8b 45 0c             	mov    0xc(%ebp),%eax
  103433:	89 44 24 04          	mov    %eax,0x4(%esp)
  103437:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10343e:	8b 45 08             	mov    0x8(%ebp),%eax
  103441:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103443:	ff 4d e8             	decl   -0x18(%ebp)
  103446:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10344a:	7f e4                	jg     103430 <vprintfmt+0x244>
            }
            break;
  10344c:	e9 6c 01 00 00       	jmp    1035bd <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103451:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103454:	89 44 24 04          	mov    %eax,0x4(%esp)
  103458:	8d 45 14             	lea    0x14(%ebp),%eax
  10345b:	89 04 24             	mov    %eax,(%esp)
  10345e:	e8 0b fd ff ff       	call   10316e <getint>
  103463:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103466:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  103469:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10346c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10346f:	85 d2                	test   %edx,%edx
  103471:	79 26                	jns    103499 <vprintfmt+0x2ad>
                putch('-', putdat);
  103473:	8b 45 0c             	mov    0xc(%ebp),%eax
  103476:	89 44 24 04          	mov    %eax,0x4(%esp)
  10347a:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  103481:	8b 45 08             	mov    0x8(%ebp),%eax
  103484:	ff d0                	call   *%eax
                num = -(long long)num;
  103486:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103489:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10348c:	f7 d8                	neg    %eax
  10348e:	83 d2 00             	adc    $0x0,%edx
  103491:	f7 da                	neg    %edx
  103493:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103496:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  103499:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034a0:	e9 a8 00 00 00       	jmp    10354d <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1034a5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034ac:	8d 45 14             	lea    0x14(%ebp),%eax
  1034af:	89 04 24             	mov    %eax,(%esp)
  1034b2:	e8 64 fc ff ff       	call   10311b <getuint>
  1034b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034ba:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1034bd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034c4:	e9 84 00 00 00       	jmp    10354d <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1034c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034d0:	8d 45 14             	lea    0x14(%ebp),%eax
  1034d3:	89 04 24             	mov    %eax,(%esp)
  1034d6:	e8 40 fc ff ff       	call   10311b <getuint>
  1034db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034de:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  1034e1:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  1034e8:	eb 63                	jmp    10354d <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  1034ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034f1:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  1034f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1034fb:	ff d0                	call   *%eax
            putch('x', putdat);
  1034fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  103500:	89 44 24 04          	mov    %eax,0x4(%esp)
  103504:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  10350b:	8b 45 08             	mov    0x8(%ebp),%eax
  10350e:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103510:	8b 45 14             	mov    0x14(%ebp),%eax
  103513:	8d 50 04             	lea    0x4(%eax),%edx
  103516:	89 55 14             	mov    %edx,0x14(%ebp)
  103519:	8b 00                	mov    (%eax),%eax
  10351b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10351e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103525:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10352c:	eb 1f                	jmp    10354d <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10352e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103531:	89 44 24 04          	mov    %eax,0x4(%esp)
  103535:	8d 45 14             	lea    0x14(%ebp),%eax
  103538:	89 04 24             	mov    %eax,(%esp)
  10353b:	e8 db fb ff ff       	call   10311b <getuint>
  103540:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103543:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103546:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10354d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103551:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103554:	89 54 24 18          	mov    %edx,0x18(%esp)
  103558:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10355b:	89 54 24 14          	mov    %edx,0x14(%esp)
  10355f:	89 44 24 10          	mov    %eax,0x10(%esp)
  103563:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103566:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103569:	89 44 24 08          	mov    %eax,0x8(%esp)
  10356d:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103571:	8b 45 0c             	mov    0xc(%ebp),%eax
  103574:	89 44 24 04          	mov    %eax,0x4(%esp)
  103578:	8b 45 08             	mov    0x8(%ebp),%eax
  10357b:	89 04 24             	mov    %eax,(%esp)
  10357e:	e8 94 fa ff ff       	call   103017 <printnum>
            break;
  103583:	eb 38                	jmp    1035bd <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103585:	8b 45 0c             	mov    0xc(%ebp),%eax
  103588:	89 44 24 04          	mov    %eax,0x4(%esp)
  10358c:	89 1c 24             	mov    %ebx,(%esp)
  10358f:	8b 45 08             	mov    0x8(%ebp),%eax
  103592:	ff d0                	call   *%eax
            break;
  103594:	eb 27                	jmp    1035bd <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103596:	8b 45 0c             	mov    0xc(%ebp),%eax
  103599:	89 44 24 04          	mov    %eax,0x4(%esp)
  10359d:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1035a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a7:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  1035a9:	ff 4d 10             	decl   0x10(%ebp)
  1035ac:	eb 03                	jmp    1035b1 <vprintfmt+0x3c5>
  1035ae:	ff 4d 10             	decl   0x10(%ebp)
  1035b1:	8b 45 10             	mov    0x10(%ebp),%eax
  1035b4:	48                   	dec    %eax
  1035b5:	0f b6 00             	movzbl (%eax),%eax
  1035b8:	3c 25                	cmp    $0x25,%al
  1035ba:	75 f2                	jne    1035ae <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  1035bc:	90                   	nop
    while (1) {
  1035bd:	e9 36 fc ff ff       	jmp    1031f8 <vprintfmt+0xc>
                return;
  1035c2:	90                   	nop
        }
    }
}
  1035c3:	83 c4 40             	add    $0x40,%esp
  1035c6:	5b                   	pop    %ebx
  1035c7:	5e                   	pop    %esi
  1035c8:	5d                   	pop    %ebp
  1035c9:	c3                   	ret    

001035ca <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1035ca:	f3 0f 1e fb          	endbr32 
  1035ce:	55                   	push   %ebp
  1035cf:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1035d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035d4:	8b 40 08             	mov    0x8(%eax),%eax
  1035d7:	8d 50 01             	lea    0x1(%eax),%edx
  1035da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035dd:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1035e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035e3:	8b 10                	mov    (%eax),%edx
  1035e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035e8:	8b 40 04             	mov    0x4(%eax),%eax
  1035eb:	39 c2                	cmp    %eax,%edx
  1035ed:	73 12                	jae    103601 <sprintputch+0x37>
        *b->buf ++ = ch;
  1035ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035f2:	8b 00                	mov    (%eax),%eax
  1035f4:	8d 48 01             	lea    0x1(%eax),%ecx
  1035f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1035fa:	89 0a                	mov    %ecx,(%edx)
  1035fc:	8b 55 08             	mov    0x8(%ebp),%edx
  1035ff:	88 10                	mov    %dl,(%eax)
    }
}
  103601:	90                   	nop
  103602:	5d                   	pop    %ebp
  103603:	c3                   	ret    

00103604 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103604:	f3 0f 1e fb          	endbr32 
  103608:	55                   	push   %ebp
  103609:	89 e5                	mov    %esp,%ebp
  10360b:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10360e:	8d 45 14             	lea    0x14(%ebp),%eax
  103611:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103614:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103617:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10361b:	8b 45 10             	mov    0x10(%ebp),%eax
  10361e:	89 44 24 08          	mov    %eax,0x8(%esp)
  103622:	8b 45 0c             	mov    0xc(%ebp),%eax
  103625:	89 44 24 04          	mov    %eax,0x4(%esp)
  103629:	8b 45 08             	mov    0x8(%ebp),%eax
  10362c:	89 04 24             	mov    %eax,(%esp)
  10362f:	e8 08 00 00 00       	call   10363c <vsnprintf>
  103634:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103637:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10363a:	c9                   	leave  
  10363b:	c3                   	ret    

0010363c <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10363c:	f3 0f 1e fb          	endbr32 
  103640:	55                   	push   %ebp
  103641:	89 e5                	mov    %esp,%ebp
  103643:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103646:	8b 45 08             	mov    0x8(%ebp),%eax
  103649:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10364c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10364f:	8d 50 ff             	lea    -0x1(%eax),%edx
  103652:	8b 45 08             	mov    0x8(%ebp),%eax
  103655:	01 d0                	add    %edx,%eax
  103657:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10365a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103661:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103665:	74 0a                	je     103671 <vsnprintf+0x35>
  103667:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10366a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10366d:	39 c2                	cmp    %eax,%edx
  10366f:	76 07                	jbe    103678 <vsnprintf+0x3c>
        return -E_INVAL;
  103671:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103676:	eb 2a                	jmp    1036a2 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103678:	8b 45 14             	mov    0x14(%ebp),%eax
  10367b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10367f:	8b 45 10             	mov    0x10(%ebp),%eax
  103682:	89 44 24 08          	mov    %eax,0x8(%esp)
  103686:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103689:	89 44 24 04          	mov    %eax,0x4(%esp)
  10368d:	c7 04 24 ca 35 10 00 	movl   $0x1035ca,(%esp)
  103694:	e8 53 fb ff ff       	call   1031ec <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  103699:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10369c:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  10369f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1036a2:	c9                   	leave  
  1036a3:	c3                   	ret    
