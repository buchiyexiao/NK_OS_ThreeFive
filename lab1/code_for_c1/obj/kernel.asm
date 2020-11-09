
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
  10000a:	b8 20 1d 11 00       	mov    $0x111d20,%eax
  10000f:	2d 16 0a 11 00       	sub    $0x110a16,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 0a 11 00 	movl   $0x110a16,(%esp)
  100027:	e8 42 2f 00 00       	call   102f6e <memset>

    cons_init();                // init the console
  10002c:	e8 1b 16 00 00       	call   10164c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 a0 37 10 00 	movl   $0x1037a0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 bc 37 10 00 	movl   $0x1037bc,(%esp)
  100046:	e8 42 02 00 00       	call   10028d <cprintf>

    print_kerninfo();
  10004b:	e8 00 09 00 00       	call   100950 <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 c3 2b 00 00       	call   102c1d <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 42 17 00 00       	call   1017a1 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 e7 18 00 00       	call   10194b <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 68 0d 00 00       	call   100dd1 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 7f 18 00 00       	call   1018ed <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 80 01 00 00       	call   1001f3 <lab1_switch_test>

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
  100096:	e8 20 0d 00 00       	call   100dbb <mon_backtrace>
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
  100138:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10013d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100141:	89 44 24 04          	mov    %eax,0x4(%esp)
  100145:	c7 04 24 c1 37 10 00 	movl   $0x1037c1,(%esp)
  10014c:	e8 3c 01 00 00       	call   10028d <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 cf 37 10 00 	movl   $0x1037cf,(%esp)
  10016b:	e8 1d 01 00 00       	call   10028d <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 dd 37 10 00 	movl   $0x1037dd,(%esp)
  10018a:	e8 fe 00 00 00       	call   10028d <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 0a 11 00       	mov    0x110a20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 eb 37 10 00 	movl   $0x1037eb,(%esp)
  1001a9:	e8 df 00 00 00       	call   10028d <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 0a 11 00       	mov    0x110a20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 f9 37 10 00 	movl   $0x1037f9,(%esp)
  1001c8:	e8 c0 00 00 00       	call   10028d <cprintf>
    round ++;
  1001cd:	a1 20 0a 11 00       	mov    0x110a20,%eax
  1001d2:	40                   	inc    %eax
  1001d3:	a3 20 0a 11 00       	mov    %eax,0x110a20
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
  1001e2:	cd 78                	int    $0x78
	    "int %0 \n" //%0 为 T_SWITCH_TOU 参数
	    :
	    : "i"(T_SWITCH_TOU)
	);
}
  1001e4:	90                   	nop
  1001e5:	5d                   	pop    %ebp
  1001e6:	c3                   	ret    

001001e7 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001e7:	f3 0f 1e fb          	endbr32 
  1001eb:	55                   	push   %ebp
  1001ec:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    //引发对应的中断（T_SWITCH_TOK）
    asm volatile (
  1001ee:	cd 79                	int    $0x79
        "int %0 \n"
        :
        : "i"(T_SWITCH_TOK)
    );
}
  1001f0:	90                   	nop
  1001f1:	5d                   	pop    %ebp
  1001f2:	c3                   	ret    

001001f3 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001f3:	f3 0f 1e fb          	endbr32 
  1001f7:	55                   	push   %ebp
  1001f8:	89 e5                	mov    %esp,%ebp
  1001fa:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001fd:	e8 17 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100202:	c7 04 24 08 38 10 00 	movl   $0x103808,(%esp)
  100209:	e8 7f 00 00 00       	call   10028d <cprintf>
    lab1_switch_to_user();
  10020e:	e8 c8 ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  100213:	e8 01 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100218:	c7 04 24 28 38 10 00 	movl   $0x103828,(%esp)
  10021f:	e8 69 00 00 00       	call   10028d <cprintf>
    lab1_switch_to_kernel();
  100224:	e8 be ff ff ff       	call   1001e7 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100229:	e8 eb fe ff ff       	call   100119 <lab1_print_cur_status>
}
  10022e:	90                   	nop
  10022f:	c9                   	leave  
  100230:	c3                   	ret    

00100231 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100231:	f3 0f 1e fb          	endbr32 
  100235:	55                   	push   %ebp
  100236:	89 e5                	mov    %esp,%ebp
  100238:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10023b:	8b 45 08             	mov    0x8(%ebp),%eax
  10023e:	89 04 24             	mov    %eax,(%esp)
  100241:	e8 37 14 00 00       	call   10167d <cons_putc>
    (*cnt) ++;
  100246:	8b 45 0c             	mov    0xc(%ebp),%eax
  100249:	8b 00                	mov    (%eax),%eax
  10024b:	8d 50 01             	lea    0x1(%eax),%edx
  10024e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100251:	89 10                	mov    %edx,(%eax)
}
  100253:	90                   	nop
  100254:	c9                   	leave  
  100255:	c3                   	ret    

00100256 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100256:	f3 0f 1e fb          	endbr32 
  10025a:	55                   	push   %ebp
  10025b:	89 e5                	mov    %esp,%ebp
  10025d:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100260:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100267:	8b 45 0c             	mov    0xc(%ebp),%eax
  10026a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10026e:	8b 45 08             	mov    0x8(%ebp),%eax
  100271:	89 44 24 08          	mov    %eax,0x8(%esp)
  100275:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100278:	89 44 24 04          	mov    %eax,0x4(%esp)
  10027c:	c7 04 24 31 02 10 00 	movl   $0x100231,(%esp)
  100283:	e8 52 30 00 00       	call   1032da <vprintfmt>
    return cnt;
  100288:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10028b:	c9                   	leave  
  10028c:	c3                   	ret    

0010028d <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10028d:	f3 0f 1e fb          	endbr32 
  100291:	55                   	push   %ebp
  100292:	89 e5                	mov    %esp,%ebp
  100294:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100297:	8d 45 0c             	lea    0xc(%ebp),%eax
  10029a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10029d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1002a7:	89 04 24             	mov    %eax,(%esp)
  1002aa:	e8 a7 ff ff ff       	call   100256 <vcprintf>
  1002af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002b5:	c9                   	leave  
  1002b6:	c3                   	ret    

001002b7 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002b7:	f3 0f 1e fb          	endbr32 
  1002bb:	55                   	push   %ebp
  1002bc:	89 e5                	mov    %esp,%ebp
  1002be:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c4:	89 04 24             	mov    %eax,(%esp)
  1002c7:	e8 b1 13 00 00       	call   10167d <cons_putc>
}
  1002cc:	90                   	nop
  1002cd:	c9                   	leave  
  1002ce:	c3                   	ret    

001002cf <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002cf:	f3 0f 1e fb          	endbr32 
  1002d3:	55                   	push   %ebp
  1002d4:	89 e5                	mov    %esp,%ebp
  1002d6:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002e0:	eb 13                	jmp    1002f5 <cputs+0x26>
        cputch(c, &cnt);
  1002e2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002e6:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002e9:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002ed:	89 04 24             	mov    %eax,(%esp)
  1002f0:	e8 3c ff ff ff       	call   100231 <cputch>
    while ((c = *str ++) != '\0') {
  1002f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002f8:	8d 50 01             	lea    0x1(%eax),%edx
  1002fb:	89 55 08             	mov    %edx,0x8(%ebp)
  1002fe:	0f b6 00             	movzbl (%eax),%eax
  100301:	88 45 f7             	mov    %al,-0x9(%ebp)
  100304:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100308:	75 d8                	jne    1002e2 <cputs+0x13>
    }
    cputch('\n', &cnt);
  10030a:	8d 45 f0             	lea    -0x10(%ebp),%eax
  10030d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100311:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100318:	e8 14 ff ff ff       	call   100231 <cputch>
    return cnt;
  10031d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100320:	c9                   	leave  
  100321:	c3                   	ret    

00100322 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100322:	f3 0f 1e fb          	endbr32 
  100326:	55                   	push   %ebp
  100327:	89 e5                	mov    %esp,%ebp
  100329:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  10032c:	90                   	nop
  10032d:	e8 79 13 00 00       	call   1016ab <cons_getc>
  100332:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100335:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100339:	74 f2                	je     10032d <getchar+0xb>
        /* do nothing */;
    return c;
  10033b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10033e:	c9                   	leave  
  10033f:	c3                   	ret    

00100340 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100340:	f3 0f 1e fb          	endbr32 
  100344:	55                   	push   %ebp
  100345:	89 e5                	mov    %esp,%ebp
  100347:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10034a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10034e:	74 13                	je     100363 <readline+0x23>
        cprintf("%s", prompt);
  100350:	8b 45 08             	mov    0x8(%ebp),%eax
  100353:	89 44 24 04          	mov    %eax,0x4(%esp)
  100357:	c7 04 24 47 38 10 00 	movl   $0x103847,(%esp)
  10035e:	e8 2a ff ff ff       	call   10028d <cprintf>
    }
    int i = 0, c;
  100363:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10036a:	e8 b3 ff ff ff       	call   100322 <getchar>
  10036f:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100372:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100376:	79 07                	jns    10037f <readline+0x3f>
            return NULL;
  100378:	b8 00 00 00 00       	mov    $0x0,%eax
  10037d:	eb 78                	jmp    1003f7 <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10037f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100383:	7e 28                	jle    1003ad <readline+0x6d>
  100385:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  10038c:	7f 1f                	jg     1003ad <readline+0x6d>
            cputchar(c);
  10038e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100391:	89 04 24             	mov    %eax,(%esp)
  100394:	e8 1e ff ff ff       	call   1002b7 <cputchar>
            buf[i ++] = c;
  100399:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10039c:	8d 50 01             	lea    0x1(%eax),%edx
  10039f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1003a2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003a5:	88 90 40 0a 11 00    	mov    %dl,0x110a40(%eax)
  1003ab:	eb 45                	jmp    1003f2 <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003ad:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003b1:	75 16                	jne    1003c9 <readline+0x89>
  1003b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003b7:	7e 10                	jle    1003c9 <readline+0x89>
            cputchar(c);
  1003b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003bc:	89 04 24             	mov    %eax,(%esp)
  1003bf:	e8 f3 fe ff ff       	call   1002b7 <cputchar>
            i --;
  1003c4:	ff 4d f4             	decl   -0xc(%ebp)
  1003c7:	eb 29                	jmp    1003f2 <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  1003c9:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003cd:	74 06                	je     1003d5 <readline+0x95>
  1003cf:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003d3:	75 95                	jne    10036a <readline+0x2a>
            cputchar(c);
  1003d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003d8:	89 04 24             	mov    %eax,(%esp)
  1003db:	e8 d7 fe ff ff       	call   1002b7 <cputchar>
            buf[i] = '\0';
  1003e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003e3:	05 40 0a 11 00       	add    $0x110a40,%eax
  1003e8:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003eb:	b8 40 0a 11 00       	mov    $0x110a40,%eax
  1003f0:	eb 05                	jmp    1003f7 <readline+0xb7>
        c = getchar();
  1003f2:	e9 73 ff ff ff       	jmp    10036a <readline+0x2a>
        }
    }
}
  1003f7:	c9                   	leave  
  1003f8:	c3                   	ret    

001003f9 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003f9:	f3 0f 1e fb          	endbr32 
  1003fd:	55                   	push   %ebp
  1003fe:	89 e5                	mov    %esp,%ebp
  100400:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100403:	a1 40 0e 11 00       	mov    0x110e40,%eax
  100408:	85 c0                	test   %eax,%eax
  10040a:	75 5b                	jne    100467 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  10040c:	c7 05 40 0e 11 00 01 	movl   $0x1,0x110e40
  100413:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100416:	8d 45 14             	lea    0x14(%ebp),%eax
  100419:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  10041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10041f:	89 44 24 08          	mov    %eax,0x8(%esp)
  100423:	8b 45 08             	mov    0x8(%ebp),%eax
  100426:	89 44 24 04          	mov    %eax,0x4(%esp)
  10042a:	c7 04 24 4a 38 10 00 	movl   $0x10384a,(%esp)
  100431:	e8 57 fe ff ff       	call   10028d <cprintf>
    vcprintf(fmt, ap);
  100436:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100439:	89 44 24 04          	mov    %eax,0x4(%esp)
  10043d:	8b 45 10             	mov    0x10(%ebp),%eax
  100440:	89 04 24             	mov    %eax,(%esp)
  100443:	e8 0e fe ff ff       	call   100256 <vcprintf>
    cprintf("\n");
  100448:	c7 04 24 66 38 10 00 	movl   $0x103866,(%esp)
  10044f:	e8 39 fe ff ff       	call   10028d <cprintf>
    
    cprintf("stack trackback:\n");
  100454:	c7 04 24 68 38 10 00 	movl   $0x103868,(%esp)
  10045b:	e8 2d fe ff ff       	call   10028d <cprintf>
    print_stackframe();
  100460:	e8 3d 06 00 00       	call   100aa2 <print_stackframe>
  100465:	eb 01                	jmp    100468 <__panic+0x6f>
        goto panic_dead;
  100467:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100468:	e8 8c 14 00 00       	call   1018f9 <intr_disable>
    while (1) {
        kmonitor(NULL);
  10046d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100474:	e8 69 08 00 00       	call   100ce2 <kmonitor>
  100479:	eb f2                	jmp    10046d <__panic+0x74>

0010047b <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  10047b:	f3 0f 1e fb          	endbr32 
  10047f:	55                   	push   %ebp
  100480:	89 e5                	mov    %esp,%ebp
  100482:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100485:	8d 45 14             	lea    0x14(%ebp),%eax
  100488:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  10048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10048e:	89 44 24 08          	mov    %eax,0x8(%esp)
  100492:	8b 45 08             	mov    0x8(%ebp),%eax
  100495:	89 44 24 04          	mov    %eax,0x4(%esp)
  100499:	c7 04 24 7a 38 10 00 	movl   $0x10387a,(%esp)
  1004a0:	e8 e8 fd ff ff       	call   10028d <cprintf>
    vcprintf(fmt, ap);
  1004a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004ac:	8b 45 10             	mov    0x10(%ebp),%eax
  1004af:	89 04 24             	mov    %eax,(%esp)
  1004b2:	e8 9f fd ff ff       	call   100256 <vcprintf>
    cprintf("\n");
  1004b7:	c7 04 24 66 38 10 00 	movl   $0x103866,(%esp)
  1004be:	e8 ca fd ff ff       	call   10028d <cprintf>
    va_end(ap);
}
  1004c3:	90                   	nop
  1004c4:	c9                   	leave  
  1004c5:	c3                   	ret    

001004c6 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004c6:	f3 0f 1e fb          	endbr32 
  1004ca:	55                   	push   %ebp
  1004cb:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004cd:	a1 40 0e 11 00       	mov    0x110e40,%eax
}
  1004d2:	5d                   	pop    %ebp
  1004d3:	c3                   	ret    

001004d4 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004d4:	f3 0f 1e fb          	endbr32 
  1004d8:	55                   	push   %ebp
  1004d9:	89 e5                	mov    %esp,%ebp
  1004db:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004de:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e1:	8b 00                	mov    (%eax),%eax
  1004e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004e6:	8b 45 10             	mov    0x10(%ebp),%eax
  1004e9:	8b 00                	mov    (%eax),%eax
  1004eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004f5:	e9 ca 00 00 00       	jmp    1005c4 <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  1004fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100500:	01 d0                	add    %edx,%eax
  100502:	89 c2                	mov    %eax,%edx
  100504:	c1 ea 1f             	shr    $0x1f,%edx
  100507:	01 d0                	add    %edx,%eax
  100509:	d1 f8                	sar    %eax
  10050b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10050e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100511:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100514:	eb 03                	jmp    100519 <stab_binsearch+0x45>
            m --;
  100516:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100519:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10051c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10051f:	7c 1f                	jl     100540 <stab_binsearch+0x6c>
  100521:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100524:	89 d0                	mov    %edx,%eax
  100526:	01 c0                	add    %eax,%eax
  100528:	01 d0                	add    %edx,%eax
  10052a:	c1 e0 02             	shl    $0x2,%eax
  10052d:	89 c2                	mov    %eax,%edx
  10052f:	8b 45 08             	mov    0x8(%ebp),%eax
  100532:	01 d0                	add    %edx,%eax
  100534:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100538:	0f b6 c0             	movzbl %al,%eax
  10053b:	39 45 14             	cmp    %eax,0x14(%ebp)
  10053e:	75 d6                	jne    100516 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100540:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100543:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100546:	7d 09                	jge    100551 <stab_binsearch+0x7d>
            l = true_m + 1;
  100548:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10054b:	40                   	inc    %eax
  10054c:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10054f:	eb 73                	jmp    1005c4 <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  100551:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100558:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10055b:	89 d0                	mov    %edx,%eax
  10055d:	01 c0                	add    %eax,%eax
  10055f:	01 d0                	add    %edx,%eax
  100561:	c1 e0 02             	shl    $0x2,%eax
  100564:	89 c2                	mov    %eax,%edx
  100566:	8b 45 08             	mov    0x8(%ebp),%eax
  100569:	01 d0                	add    %edx,%eax
  10056b:	8b 40 08             	mov    0x8(%eax),%eax
  10056e:	39 45 18             	cmp    %eax,0x18(%ebp)
  100571:	76 11                	jbe    100584 <stab_binsearch+0xb0>
            *region_left = m;
  100573:	8b 45 0c             	mov    0xc(%ebp),%eax
  100576:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100579:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10057b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10057e:	40                   	inc    %eax
  10057f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100582:	eb 40                	jmp    1005c4 <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  100584:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100587:	89 d0                	mov    %edx,%eax
  100589:	01 c0                	add    %eax,%eax
  10058b:	01 d0                	add    %edx,%eax
  10058d:	c1 e0 02             	shl    $0x2,%eax
  100590:	89 c2                	mov    %eax,%edx
  100592:	8b 45 08             	mov    0x8(%ebp),%eax
  100595:	01 d0                	add    %edx,%eax
  100597:	8b 40 08             	mov    0x8(%eax),%eax
  10059a:	39 45 18             	cmp    %eax,0x18(%ebp)
  10059d:	73 14                	jae    1005b3 <stab_binsearch+0xdf>
            *region_right = m - 1;
  10059f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a2:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005a5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005a8:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005ad:	48                   	dec    %eax
  1005ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005b1:	eb 11                	jmp    1005c4 <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005b9:	89 10                	mov    %edx,(%eax)
            l = m;
  1005bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005be:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005c1:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1005c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005ca:	0f 8e 2a ff ff ff    	jle    1004fa <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005d4:	75 0f                	jne    1005e5 <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  1005d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d9:	8b 00                	mov    (%eax),%eax
  1005db:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005de:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e1:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005e3:	eb 3e                	jmp    100623 <stab_binsearch+0x14f>
        l = *region_right;
  1005e5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e8:	8b 00                	mov    (%eax),%eax
  1005ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005ed:	eb 03                	jmp    1005f2 <stab_binsearch+0x11e>
  1005ef:	ff 4d fc             	decl   -0x4(%ebp)
  1005f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f5:	8b 00                	mov    (%eax),%eax
  1005f7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005fa:	7e 1f                	jle    10061b <stab_binsearch+0x147>
  1005fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005ff:	89 d0                	mov    %edx,%eax
  100601:	01 c0                	add    %eax,%eax
  100603:	01 d0                	add    %edx,%eax
  100605:	c1 e0 02             	shl    $0x2,%eax
  100608:	89 c2                	mov    %eax,%edx
  10060a:	8b 45 08             	mov    0x8(%ebp),%eax
  10060d:	01 d0                	add    %edx,%eax
  10060f:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100613:	0f b6 c0             	movzbl %al,%eax
  100616:	39 45 14             	cmp    %eax,0x14(%ebp)
  100619:	75 d4                	jne    1005ef <stab_binsearch+0x11b>
        *region_left = l;
  10061b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10061e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100621:	89 10                	mov    %edx,(%eax)
}
  100623:	90                   	nop
  100624:	c9                   	leave  
  100625:	c3                   	ret    

00100626 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100626:	f3 0f 1e fb          	endbr32 
  10062a:	55                   	push   %ebp
  10062b:	89 e5                	mov    %esp,%ebp
  10062d:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100630:	8b 45 0c             	mov    0xc(%ebp),%eax
  100633:	c7 00 98 38 10 00    	movl   $0x103898,(%eax)
    info->eip_line = 0;
  100639:	8b 45 0c             	mov    0xc(%ebp),%eax
  10063c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100643:	8b 45 0c             	mov    0xc(%ebp),%eax
  100646:	c7 40 08 98 38 10 00 	movl   $0x103898,0x8(%eax)
    info->eip_fn_namelen = 9;
  10064d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100650:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100657:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065a:	8b 55 08             	mov    0x8(%ebp),%edx
  10065d:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100660:	8b 45 0c             	mov    0xc(%ebp),%eax
  100663:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10066a:	c7 45 f4 cc 40 10 00 	movl   $0x1040cc,-0xc(%ebp)
    stab_end = __STAB_END__;
  100671:	c7 45 f0 e8 cf 10 00 	movl   $0x10cfe8,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100678:	c7 45 ec e9 cf 10 00 	movl   $0x10cfe9,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10067f:	c7 45 e8 ef f0 10 00 	movl   $0x10f0ef,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100686:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100689:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10068c:	76 0b                	jbe    100699 <debuginfo_eip+0x73>
  10068e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100691:	48                   	dec    %eax
  100692:	0f b6 00             	movzbl (%eax),%eax
  100695:	84 c0                	test   %al,%al
  100697:	74 0a                	je     1006a3 <debuginfo_eip+0x7d>
        return -1;
  100699:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10069e:	e9 ab 02 00 00       	jmp    10094e <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006a3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006ad:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006b0:	c1 f8 02             	sar    $0x2,%eax
  1006b3:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006b9:	48                   	dec    %eax
  1006ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c0:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006c4:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1006cb:	00 
  1006cc:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006cf:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006d3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006d6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006dd:	89 04 24             	mov    %eax,(%esp)
  1006e0:	e8 ef fd ff ff       	call   1004d4 <stab_binsearch>
    if (lfile == 0)
  1006e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006e8:	85 c0                	test   %eax,%eax
  1006ea:	75 0a                	jne    1006f6 <debuginfo_eip+0xd0>
        return -1;
  1006ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006f1:	e9 58 02 00 00       	jmp    10094e <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006f9:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100702:	8b 45 08             	mov    0x8(%ebp),%eax
  100705:	89 44 24 10          	mov    %eax,0x10(%esp)
  100709:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100710:	00 
  100711:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100714:	89 44 24 08          	mov    %eax,0x8(%esp)
  100718:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10071b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10071f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100722:	89 04 24             	mov    %eax,(%esp)
  100725:	e8 aa fd ff ff       	call   1004d4 <stab_binsearch>

    if (lfun <= rfun) {
  10072a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10072d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100730:	39 c2                	cmp    %eax,%edx
  100732:	7f 78                	jg     1007ac <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100734:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100737:	89 c2                	mov    %eax,%edx
  100739:	89 d0                	mov    %edx,%eax
  10073b:	01 c0                	add    %eax,%eax
  10073d:	01 d0                	add    %edx,%eax
  10073f:	c1 e0 02             	shl    $0x2,%eax
  100742:	89 c2                	mov    %eax,%edx
  100744:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100747:	01 d0                	add    %edx,%eax
  100749:	8b 10                	mov    (%eax),%edx
  10074b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10074e:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100751:	39 c2                	cmp    %eax,%edx
  100753:	73 22                	jae    100777 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100755:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100758:	89 c2                	mov    %eax,%edx
  10075a:	89 d0                	mov    %edx,%eax
  10075c:	01 c0                	add    %eax,%eax
  10075e:	01 d0                	add    %edx,%eax
  100760:	c1 e0 02             	shl    $0x2,%eax
  100763:	89 c2                	mov    %eax,%edx
  100765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100768:	01 d0                	add    %edx,%eax
  10076a:	8b 10                	mov    (%eax),%edx
  10076c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10076f:	01 c2                	add    %eax,%edx
  100771:	8b 45 0c             	mov    0xc(%ebp),%eax
  100774:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100777:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10077a:	89 c2                	mov    %eax,%edx
  10077c:	89 d0                	mov    %edx,%eax
  10077e:	01 c0                	add    %eax,%eax
  100780:	01 d0                	add    %edx,%eax
  100782:	c1 e0 02             	shl    $0x2,%eax
  100785:	89 c2                	mov    %eax,%edx
  100787:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10078a:	01 d0                	add    %edx,%eax
  10078c:	8b 50 08             	mov    0x8(%eax),%edx
  10078f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100792:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100795:	8b 45 0c             	mov    0xc(%ebp),%eax
  100798:	8b 40 10             	mov    0x10(%eax),%eax
  10079b:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10079e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1007a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007a7:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007aa:	eb 15                	jmp    1007c1 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007af:	8b 55 08             	mov    0x8(%ebp),%edx
  1007b2:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007be:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007c4:	8b 40 08             	mov    0x8(%eax),%eax
  1007c7:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1007ce:	00 
  1007cf:	89 04 24             	mov    %eax,(%esp)
  1007d2:	e8 0b 26 00 00       	call   102de2 <strfind>
  1007d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007da:	8b 52 08             	mov    0x8(%edx),%edx
  1007dd:	29 d0                	sub    %edx,%eax
  1007df:	89 c2                	mov    %eax,%edx
  1007e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e4:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1007ea:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007ee:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007f5:	00 
  1007f6:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007f9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1007fd:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100800:	89 44 24 04          	mov    %eax,0x4(%esp)
  100804:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100807:	89 04 24             	mov    %eax,(%esp)
  10080a:	e8 c5 fc ff ff       	call   1004d4 <stab_binsearch>
    if (lline <= rline) {
  10080f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100812:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100815:	39 c2                	cmp    %eax,%edx
  100817:	7f 23                	jg     10083c <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  100819:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10081c:	89 c2                	mov    %eax,%edx
  10081e:	89 d0                	mov    %edx,%eax
  100820:	01 c0                	add    %eax,%eax
  100822:	01 d0                	add    %edx,%eax
  100824:	c1 e0 02             	shl    $0x2,%eax
  100827:	89 c2                	mov    %eax,%edx
  100829:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10082c:	01 d0                	add    %edx,%eax
  10082e:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100832:	89 c2                	mov    %eax,%edx
  100834:	8b 45 0c             	mov    0xc(%ebp),%eax
  100837:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10083a:	eb 11                	jmp    10084d <debuginfo_eip+0x227>
        return -1;
  10083c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100841:	e9 08 01 00 00       	jmp    10094e <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100846:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100849:	48                   	dec    %eax
  10084a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10084d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100850:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100853:	39 c2                	cmp    %eax,%edx
  100855:	7c 56                	jl     1008ad <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  100857:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10085a:	89 c2                	mov    %eax,%edx
  10085c:	89 d0                	mov    %edx,%eax
  10085e:	01 c0                	add    %eax,%eax
  100860:	01 d0                	add    %edx,%eax
  100862:	c1 e0 02             	shl    $0x2,%eax
  100865:	89 c2                	mov    %eax,%edx
  100867:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10086a:	01 d0                	add    %edx,%eax
  10086c:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100870:	3c 84                	cmp    $0x84,%al
  100872:	74 39                	je     1008ad <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100874:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100877:	89 c2                	mov    %eax,%edx
  100879:	89 d0                	mov    %edx,%eax
  10087b:	01 c0                	add    %eax,%eax
  10087d:	01 d0                	add    %edx,%eax
  10087f:	c1 e0 02             	shl    $0x2,%eax
  100882:	89 c2                	mov    %eax,%edx
  100884:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100887:	01 d0                	add    %edx,%eax
  100889:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10088d:	3c 64                	cmp    $0x64,%al
  10088f:	75 b5                	jne    100846 <debuginfo_eip+0x220>
  100891:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100894:	89 c2                	mov    %eax,%edx
  100896:	89 d0                	mov    %edx,%eax
  100898:	01 c0                	add    %eax,%eax
  10089a:	01 d0                	add    %edx,%eax
  10089c:	c1 e0 02             	shl    $0x2,%eax
  10089f:	89 c2                	mov    %eax,%edx
  1008a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a4:	01 d0                	add    %edx,%eax
  1008a6:	8b 40 08             	mov    0x8(%eax),%eax
  1008a9:	85 c0                	test   %eax,%eax
  1008ab:	74 99                	je     100846 <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008ad:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008b3:	39 c2                	cmp    %eax,%edx
  1008b5:	7c 42                	jl     1008f9 <debuginfo_eip+0x2d3>
  1008b7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008ba:	89 c2                	mov    %eax,%edx
  1008bc:	89 d0                	mov    %edx,%eax
  1008be:	01 c0                	add    %eax,%eax
  1008c0:	01 d0                	add    %edx,%eax
  1008c2:	c1 e0 02             	shl    $0x2,%eax
  1008c5:	89 c2                	mov    %eax,%edx
  1008c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008ca:	01 d0                	add    %edx,%eax
  1008cc:	8b 10                	mov    (%eax),%edx
  1008ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008d1:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008d4:	39 c2                	cmp    %eax,%edx
  1008d6:	73 21                	jae    1008f9 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008db:	89 c2                	mov    %eax,%edx
  1008dd:	89 d0                	mov    %edx,%eax
  1008df:	01 c0                	add    %eax,%eax
  1008e1:	01 d0                	add    %edx,%eax
  1008e3:	c1 e0 02             	shl    $0x2,%eax
  1008e6:	89 c2                	mov    %eax,%edx
  1008e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008eb:	01 d0                	add    %edx,%eax
  1008ed:	8b 10                	mov    (%eax),%edx
  1008ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008f2:	01 c2                	add    %eax,%edx
  1008f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008f7:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008f9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008ff:	39 c2                	cmp    %eax,%edx
  100901:	7d 46                	jge    100949 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  100903:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100906:	40                   	inc    %eax
  100907:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  10090a:	eb 16                	jmp    100922 <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  10090c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10090f:	8b 40 14             	mov    0x14(%eax),%eax
  100912:	8d 50 01             	lea    0x1(%eax),%edx
  100915:	8b 45 0c             	mov    0xc(%ebp),%eax
  100918:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  10091b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10091e:	40                   	inc    %eax
  10091f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100922:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100925:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100928:	39 c2                	cmp    %eax,%edx
  10092a:	7d 1d                	jge    100949 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10092c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10092f:	89 c2                	mov    %eax,%edx
  100931:	89 d0                	mov    %edx,%eax
  100933:	01 c0                	add    %eax,%eax
  100935:	01 d0                	add    %edx,%eax
  100937:	c1 e0 02             	shl    $0x2,%eax
  10093a:	89 c2                	mov    %eax,%edx
  10093c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10093f:	01 d0                	add    %edx,%eax
  100941:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100945:	3c a0                	cmp    $0xa0,%al
  100947:	74 c3                	je     10090c <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  100949:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10094e:	c9                   	leave  
  10094f:	c3                   	ret    

00100950 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100950:	f3 0f 1e fb          	endbr32 
  100954:	55                   	push   %ebp
  100955:	89 e5                	mov    %esp,%ebp
  100957:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10095a:	c7 04 24 a2 38 10 00 	movl   $0x1038a2,(%esp)
  100961:	e8 27 f9 ff ff       	call   10028d <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100966:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10096d:	00 
  10096e:	c7 04 24 bb 38 10 00 	movl   $0x1038bb,(%esp)
  100975:	e8 13 f9 ff ff       	call   10028d <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10097a:	c7 44 24 04 92 37 10 	movl   $0x103792,0x4(%esp)
  100981:	00 
  100982:	c7 04 24 d3 38 10 00 	movl   $0x1038d3,(%esp)
  100989:	e8 ff f8 ff ff       	call   10028d <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  10098e:	c7 44 24 04 16 0a 11 	movl   $0x110a16,0x4(%esp)
  100995:	00 
  100996:	c7 04 24 eb 38 10 00 	movl   $0x1038eb,(%esp)
  10099d:	e8 eb f8 ff ff       	call   10028d <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009a2:	c7 44 24 04 20 1d 11 	movl   $0x111d20,0x4(%esp)
  1009a9:	00 
  1009aa:	c7 04 24 03 39 10 00 	movl   $0x103903,(%esp)
  1009b1:	e8 d7 f8 ff ff       	call   10028d <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009b6:	b8 20 1d 11 00       	mov    $0x111d20,%eax
  1009bb:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009c0:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009c5:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009cb:	85 c0                	test   %eax,%eax
  1009cd:	0f 48 c2             	cmovs  %edx,%eax
  1009d0:	c1 f8 0a             	sar    $0xa,%eax
  1009d3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d7:	c7 04 24 1c 39 10 00 	movl   $0x10391c,(%esp)
  1009de:	e8 aa f8 ff ff       	call   10028d <cprintf>
}
  1009e3:	90                   	nop
  1009e4:	c9                   	leave  
  1009e5:	c3                   	ret    

001009e6 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009e6:	f3 0f 1e fb          	endbr32 
  1009ea:	55                   	push   %ebp
  1009eb:	89 e5                	mov    %esp,%ebp
  1009ed:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009f3:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1009fd:	89 04 24             	mov    %eax,(%esp)
  100a00:	e8 21 fc ff ff       	call   100626 <debuginfo_eip>
  100a05:	85 c0                	test   %eax,%eax
  100a07:	74 15                	je     100a1e <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a09:	8b 45 08             	mov    0x8(%ebp),%eax
  100a0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a10:	c7 04 24 46 39 10 00 	movl   $0x103946,(%esp)
  100a17:	e8 71 f8 ff ff       	call   10028d <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a1c:	eb 6c                	jmp    100a8a <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a25:	eb 1b                	jmp    100a42 <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a27:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a2d:	01 d0                	add    %edx,%eax
  100a2f:	0f b6 10             	movzbl (%eax),%edx
  100a32:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a3b:	01 c8                	add    %ecx,%eax
  100a3d:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a3f:	ff 45 f4             	incl   -0xc(%ebp)
  100a42:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a45:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a48:	7c dd                	jl     100a27 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a4a:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a53:	01 d0                	add    %edx,%eax
  100a55:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a58:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a5b:	8b 55 08             	mov    0x8(%ebp),%edx
  100a5e:	89 d1                	mov    %edx,%ecx
  100a60:	29 c1                	sub    %eax,%ecx
  100a62:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a65:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a68:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a6c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a72:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a76:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a7e:	c7 04 24 62 39 10 00 	movl   $0x103962,(%esp)
  100a85:	e8 03 f8 ff ff       	call   10028d <cprintf>
}
  100a8a:	90                   	nop
  100a8b:	c9                   	leave  
  100a8c:	c3                   	ret    

00100a8d <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a8d:	f3 0f 1e fb          	endbr32 
  100a91:	55                   	push   %ebp
  100a92:	89 e5                	mov    %esp,%ebp
  100a94:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a97:	8b 45 04             	mov    0x4(%ebp),%eax
  100a9a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100aa0:	c9                   	leave  
  100aa1:	c3                   	ret    

00100aa2 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100aa2:	f3 0f 1e fb          	endbr32 
  100aa6:	55                   	push   %ebp
  100aa7:	89 e5                	mov    %esp,%ebp
  100aa9:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100aac:	89 e8                	mov    %ebp,%eax
  100aae:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  100ab1:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
	    uint32_t ebp = read_ebp();   //(1) call read_ebp() to get the value of ebp. the type is (uint32_t);
  100ab4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        uint32_t eip = read_eip();   //(2) call read_eip() to get the value of eip. the type is (uint32_t);
  100ab7:	e8 d1 ff ff ff       	call   100a8d <read_eip>
  100abc:	89 45 f0             	mov    %eax,-0x10(%ebp)
        int i, j;
        for(i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++) { 
  100abf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100ac6:	e9 90 00 00 00       	jmp    100b5b <print_stackframe+0xb9>
            //(3) from 0 .. STACKFRAME_DEPTH
                cprintf("ebp:0x%08x eip:0x%08x", ebp, eip);//(3.1) printf value of ebp, eip
  100acb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ace:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ad5:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ad9:	c7 04 24 74 39 10 00 	movl   $0x103974,(%esp)
  100ae0:	e8 a8 f7 ff ff       	call   10028d <cprintf>
                uint32_t *arg = (uint32_t *)ebp + 2;
  100ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ae8:	83 c0 08             	add    $0x8,%eax
  100aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                cprintf(" arg:");
  100aee:	c7 04 24 8a 39 10 00 	movl   $0x10398a,(%esp)
  100af5:	e8 93 f7 ff ff       	call   10028d <cprintf>
                for(j = 0; j < 4; j++) {
  100afa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100b01:	eb 24                	jmp    100b27 <print_stackframe+0x85>
                        cprintf("0x%08x ", arg[j]);
  100b03:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100b06:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100b10:	01 d0                	add    %edx,%eax
  100b12:	8b 00                	mov    (%eax),%eax
  100b14:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b18:	c7 04 24 90 39 10 00 	movl   $0x103990,(%esp)
  100b1f:	e8 69 f7 ff ff       	call   10028d <cprintf>
                for(j = 0; j < 4; j++) {
  100b24:	ff 45 e8             	incl   -0x18(%ebp)
  100b27:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b2b:	7e d6                	jle    100b03 <print_stackframe+0x61>
                }		//(3.2) (uint32_t)calling arguments [0..4] = the contents in address (unit32_t)ebp +2 [0..4]
                cprintf("\n");	//(3.3) cprintf("\n");
  100b2d:	c7 04 24 98 39 10 00 	movl   $0x103998,(%esp)
  100b34:	e8 54 f7 ff ff       	call   10028d <cprintf>
                print_debuginfo(eip - 1);//(3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
  100b39:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b3c:	48                   	dec    %eax
  100b3d:	89 04 24             	mov    %eax,(%esp)
  100b40:	e8 a1 fe ff ff       	call   1009e6 <print_debuginfo>
                eip = ((uint32_t *)ebp)[1];//(3.5) popup a calling stackframe
  100b45:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b48:	83 c0 04             	add    $0x4,%eax
  100b4b:	8b 00                	mov    (%eax),%eax
  100b4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
                ebp = ((uint32_t*)ebp)[0];//eip  = ss:[ebp+4]   ebp = ss:[ebp]
  100b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b53:	8b 00                	mov    (%eax),%eax
  100b55:	89 45 f4             	mov    %eax,-0xc(%ebp)
        for(i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++) { 
  100b58:	ff 45 ec             	incl   -0x14(%ebp)
  100b5b:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b5f:	7f 0a                	jg     100b6b <print_stackframe+0xc9>
  100b61:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b65:	0f 85 60 ff ff ff    	jne    100acb <print_stackframe+0x29>
        }
}
  100b6b:	90                   	nop
  100b6c:	c9                   	leave  
  100b6d:	c3                   	ret    

00100b6e <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b6e:	f3 0f 1e fb          	endbr32 
  100b72:	55                   	push   %ebp
  100b73:	89 e5                	mov    %esp,%ebp
  100b75:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b78:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b7f:	eb 0c                	jmp    100b8d <parse+0x1f>
            *buf ++ = '\0';
  100b81:	8b 45 08             	mov    0x8(%ebp),%eax
  100b84:	8d 50 01             	lea    0x1(%eax),%edx
  100b87:	89 55 08             	mov    %edx,0x8(%ebp)
  100b8a:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  100b90:	0f b6 00             	movzbl (%eax),%eax
  100b93:	84 c0                	test   %al,%al
  100b95:	74 1d                	je     100bb4 <parse+0x46>
  100b97:	8b 45 08             	mov    0x8(%ebp),%eax
  100b9a:	0f b6 00             	movzbl (%eax),%eax
  100b9d:	0f be c0             	movsbl %al,%eax
  100ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ba4:	c7 04 24 1c 3a 10 00 	movl   $0x103a1c,(%esp)
  100bab:	e8 fc 21 00 00       	call   102dac <strchr>
  100bb0:	85 c0                	test   %eax,%eax
  100bb2:	75 cd                	jne    100b81 <parse+0x13>
        }
        if (*buf == '\0') {
  100bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  100bb7:	0f b6 00             	movzbl (%eax),%eax
  100bba:	84 c0                	test   %al,%al
  100bbc:	74 65                	je     100c23 <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100bbe:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100bc2:	75 14                	jne    100bd8 <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100bc4:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100bcb:	00 
  100bcc:	c7 04 24 21 3a 10 00 	movl   $0x103a21,(%esp)
  100bd3:	e8 b5 f6 ff ff       	call   10028d <cprintf>
        }
        argv[argc ++] = buf;
  100bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bdb:	8d 50 01             	lea    0x1(%eax),%edx
  100bde:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100be1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100be8:	8b 45 0c             	mov    0xc(%ebp),%eax
  100beb:	01 c2                	add    %eax,%edx
  100bed:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf0:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bf2:	eb 03                	jmp    100bf7 <parse+0x89>
            buf ++;
  100bf4:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  100bfa:	0f b6 00             	movzbl (%eax),%eax
  100bfd:	84 c0                	test   %al,%al
  100bff:	74 8c                	je     100b8d <parse+0x1f>
  100c01:	8b 45 08             	mov    0x8(%ebp),%eax
  100c04:	0f b6 00             	movzbl (%eax),%eax
  100c07:	0f be c0             	movsbl %al,%eax
  100c0a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c0e:	c7 04 24 1c 3a 10 00 	movl   $0x103a1c,(%esp)
  100c15:	e8 92 21 00 00       	call   102dac <strchr>
  100c1a:	85 c0                	test   %eax,%eax
  100c1c:	74 d6                	je     100bf4 <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c1e:	e9 6a ff ff ff       	jmp    100b8d <parse+0x1f>
            break;
  100c23:	90                   	nop
        }
    }
    return argc;
  100c24:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c27:	c9                   	leave  
  100c28:	c3                   	ret    

00100c29 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c29:	f3 0f 1e fb          	endbr32 
  100c2d:	55                   	push   %ebp
  100c2e:	89 e5                	mov    %esp,%ebp
  100c30:	53                   	push   %ebx
  100c31:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c34:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c37:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  100c3e:	89 04 24             	mov    %eax,(%esp)
  100c41:	e8 28 ff ff ff       	call   100b6e <parse>
  100c46:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c49:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c4d:	75 0a                	jne    100c59 <runcmd+0x30>
        return 0;
  100c4f:	b8 00 00 00 00       	mov    $0x0,%eax
  100c54:	e9 83 00 00 00       	jmp    100cdc <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c59:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c60:	eb 5a                	jmp    100cbc <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c62:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c65:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c68:	89 d0                	mov    %edx,%eax
  100c6a:	01 c0                	add    %eax,%eax
  100c6c:	01 d0                	add    %edx,%eax
  100c6e:	c1 e0 02             	shl    $0x2,%eax
  100c71:	05 00 00 11 00       	add    $0x110000,%eax
  100c76:	8b 00                	mov    (%eax),%eax
  100c78:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c7c:	89 04 24             	mov    %eax,(%esp)
  100c7f:	e8 84 20 00 00       	call   102d08 <strcmp>
  100c84:	85 c0                	test   %eax,%eax
  100c86:	75 31                	jne    100cb9 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c88:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c8b:	89 d0                	mov    %edx,%eax
  100c8d:	01 c0                	add    %eax,%eax
  100c8f:	01 d0                	add    %edx,%eax
  100c91:	c1 e0 02             	shl    $0x2,%eax
  100c94:	05 08 00 11 00       	add    $0x110008,%eax
  100c99:	8b 10                	mov    (%eax),%edx
  100c9b:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c9e:	83 c0 04             	add    $0x4,%eax
  100ca1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100ca4:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100ca7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100caa:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100cae:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cb2:	89 1c 24             	mov    %ebx,(%esp)
  100cb5:	ff d2                	call   *%edx
  100cb7:	eb 23                	jmp    100cdc <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100cb9:	ff 45 f4             	incl   -0xc(%ebp)
  100cbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cbf:	83 f8 02             	cmp    $0x2,%eax
  100cc2:	76 9e                	jbe    100c62 <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100cc4:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100cc7:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ccb:	c7 04 24 3f 3a 10 00 	movl   $0x103a3f,(%esp)
  100cd2:	e8 b6 f5 ff ff       	call   10028d <cprintf>
    return 0;
  100cd7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cdc:	83 c4 64             	add    $0x64,%esp
  100cdf:	5b                   	pop    %ebx
  100ce0:	5d                   	pop    %ebp
  100ce1:	c3                   	ret    

00100ce2 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100ce2:	f3 0f 1e fb          	endbr32 
  100ce6:	55                   	push   %ebp
  100ce7:	89 e5                	mov    %esp,%ebp
  100ce9:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100cec:	c7 04 24 58 3a 10 00 	movl   $0x103a58,(%esp)
  100cf3:	e8 95 f5 ff ff       	call   10028d <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cf8:	c7 04 24 80 3a 10 00 	movl   $0x103a80,(%esp)
  100cff:	e8 89 f5 ff ff       	call   10028d <cprintf>

    if (tf != NULL) {
  100d04:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100d08:	74 0b                	je     100d15 <kmonitor+0x33>
        print_trapframe(tf);
  100d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  100d0d:	89 04 24             	mov    %eax,(%esp)
  100d10:	e8 01 0e 00 00       	call   101b16 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d15:	c7 04 24 a5 3a 10 00 	movl   $0x103aa5,(%esp)
  100d1c:	e8 1f f6 ff ff       	call   100340 <readline>
  100d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d24:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d28:	74 eb                	je     100d15 <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  100d2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d34:	89 04 24             	mov    %eax,(%esp)
  100d37:	e8 ed fe ff ff       	call   100c29 <runcmd>
  100d3c:	85 c0                	test   %eax,%eax
  100d3e:	78 02                	js     100d42 <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100d40:	eb d3                	jmp    100d15 <kmonitor+0x33>
                break;
  100d42:	90                   	nop
            }
        }
    }
}
  100d43:	90                   	nop
  100d44:	c9                   	leave  
  100d45:	c3                   	ret    

00100d46 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d46:	f3 0f 1e fb          	endbr32 
  100d4a:	55                   	push   %ebp
  100d4b:	89 e5                	mov    %esp,%ebp
  100d4d:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d57:	eb 3d                	jmp    100d96 <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d59:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d5c:	89 d0                	mov    %edx,%eax
  100d5e:	01 c0                	add    %eax,%eax
  100d60:	01 d0                	add    %edx,%eax
  100d62:	c1 e0 02             	shl    $0x2,%eax
  100d65:	05 04 00 11 00       	add    $0x110004,%eax
  100d6a:	8b 08                	mov    (%eax),%ecx
  100d6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d6f:	89 d0                	mov    %edx,%eax
  100d71:	01 c0                	add    %eax,%eax
  100d73:	01 d0                	add    %edx,%eax
  100d75:	c1 e0 02             	shl    $0x2,%eax
  100d78:	05 00 00 11 00       	add    $0x110000,%eax
  100d7d:	8b 00                	mov    (%eax),%eax
  100d7f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d83:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d87:	c7 04 24 a9 3a 10 00 	movl   $0x103aa9,(%esp)
  100d8e:	e8 fa f4 ff ff       	call   10028d <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d93:	ff 45 f4             	incl   -0xc(%ebp)
  100d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d99:	83 f8 02             	cmp    $0x2,%eax
  100d9c:	76 bb                	jbe    100d59 <mon_help+0x13>
    }
    return 0;
  100d9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100da3:	c9                   	leave  
  100da4:	c3                   	ret    

00100da5 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100da5:	f3 0f 1e fb          	endbr32 
  100da9:	55                   	push   %ebp
  100daa:	89 e5                	mov    %esp,%ebp
  100dac:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100daf:	e8 9c fb ff ff       	call   100950 <print_kerninfo>
    return 0;
  100db4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100db9:	c9                   	leave  
  100dba:	c3                   	ret    

00100dbb <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100dbb:	f3 0f 1e fb          	endbr32 
  100dbf:	55                   	push   %ebp
  100dc0:	89 e5                	mov    %esp,%ebp
  100dc2:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100dc5:	e8 d8 fc ff ff       	call   100aa2 <print_stackframe>
    return 0;
  100dca:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dcf:	c9                   	leave  
  100dd0:	c3                   	ret    

00100dd1 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dd1:	f3 0f 1e fb          	endbr32 
  100dd5:	55                   	push   %ebp
  100dd6:	89 e5                	mov    %esp,%ebp
  100dd8:	83 ec 28             	sub    $0x28,%esp
  100ddb:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100de1:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100de5:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100de9:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100ded:	ee                   	out    %al,(%dx)
}
  100dee:	90                   	nop
  100def:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100df5:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100df9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dfd:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e01:	ee                   	out    %al,(%dx)
}
  100e02:	90                   	nop
  100e03:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100e09:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e0d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e11:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e15:	ee                   	out    %al,(%dx)
}
  100e16:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e17:	c7 05 08 19 11 00 00 	movl   $0x0,0x111908
  100e1e:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e21:	c7 04 24 b2 3a 10 00 	movl   $0x103ab2,(%esp)
  100e28:	e8 60 f4 ff ff       	call   10028d <cprintf>
    pic_enable(IRQ_TIMER);
  100e2d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e34:	e8 31 09 00 00       	call   10176a <pic_enable>
}
  100e39:	90                   	nop
  100e3a:	c9                   	leave  
  100e3b:	c3                   	ret    

00100e3c <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e3c:	f3 0f 1e fb          	endbr32 
  100e40:	55                   	push   %ebp
  100e41:	89 e5                	mov    %esp,%ebp
  100e43:	83 ec 10             	sub    $0x10,%esp
  100e46:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e4c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e50:	89 c2                	mov    %eax,%edx
  100e52:	ec                   	in     (%dx),%al
  100e53:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e56:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e5c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e60:	89 c2                	mov    %eax,%edx
  100e62:	ec                   	in     (%dx),%al
  100e63:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e66:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e6c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e70:	89 c2                	mov    %eax,%edx
  100e72:	ec                   	in     (%dx),%al
  100e73:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e76:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e7c:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e80:	89 c2                	mov    %eax,%edx
  100e82:	ec                   	in     (%dx),%al
  100e83:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e86:	90                   	nop
  100e87:	c9                   	leave  
  100e88:	c3                   	ret    

00100e89 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e89:	f3 0f 1e fb          	endbr32 
  100e8d:	55                   	push   %ebp
  100e8e:	89 e5                	mov    %esp,%ebp
  100e90:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e93:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e9d:	0f b7 00             	movzwl (%eax),%eax
  100ea0:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea7:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100eac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eaf:	0f b7 00             	movzwl (%eax),%eax
  100eb2:	0f b7 c0             	movzwl %ax,%eax
  100eb5:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100eba:	74 12                	je     100ece <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100ebc:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100ec3:	66 c7 05 66 0e 11 00 	movw   $0x3b4,0x110e66
  100eca:	b4 03 
  100ecc:	eb 13                	jmp    100ee1 <cga_init+0x58>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100ece:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ed1:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ed5:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100ed8:	66 c7 05 66 0e 11 00 	movw   $0x3d4,0x110e66
  100edf:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100ee1:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100ee8:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100eec:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ef0:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ef4:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ef8:	ee                   	out    %al,(%dx)
}
  100ef9:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100efa:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100f01:	40                   	inc    %eax
  100f02:	0f b7 c0             	movzwl %ax,%eax
  100f05:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f09:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100f0d:	89 c2                	mov    %eax,%edx
  100f0f:	ec                   	in     (%dx),%al
  100f10:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f13:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f17:	0f b6 c0             	movzbl %al,%eax
  100f1a:	c1 e0 08             	shl    $0x8,%eax
  100f1d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f20:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100f27:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f2b:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f2f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f33:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f37:	ee                   	out    %al,(%dx)
}
  100f38:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f39:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  100f40:	40                   	inc    %eax
  100f41:	0f b7 c0             	movzwl %ax,%eax
  100f44:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f48:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f4c:	89 c2                	mov    %eax,%edx
  100f4e:	ec                   	in     (%dx),%al
  100f4f:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f52:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f56:	0f b6 c0             	movzbl %al,%eax
  100f59:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f5f:	a3 60 0e 11 00       	mov    %eax,0x110e60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f67:	0f b7 c0             	movzwl %ax,%eax
  100f6a:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
}
  100f70:	90                   	nop
  100f71:	c9                   	leave  
  100f72:	c3                   	ret    

00100f73 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f73:	f3 0f 1e fb          	endbr32 
  100f77:	55                   	push   %ebp
  100f78:	89 e5                	mov    %esp,%ebp
  100f7a:	83 ec 48             	sub    $0x48,%esp
  100f7d:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f83:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f87:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f8b:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f8f:	ee                   	out    %al,(%dx)
}
  100f90:	90                   	nop
  100f91:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f97:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f9b:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f9f:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100fa3:	ee                   	out    %al,(%dx)
}
  100fa4:	90                   	nop
  100fa5:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100fab:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100faf:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100fb3:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fb7:	ee                   	out    %al,(%dx)
}
  100fb8:	90                   	nop
  100fb9:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fbf:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fc3:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fc7:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fcb:	ee                   	out    %al,(%dx)
}
  100fcc:	90                   	nop
  100fcd:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fd3:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fd7:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fdb:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fdf:	ee                   	out    %al,(%dx)
}
  100fe0:	90                   	nop
  100fe1:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fe7:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100feb:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fef:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ff3:	ee                   	out    %al,(%dx)
}
  100ff4:	90                   	nop
  100ff5:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100ffb:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fff:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101003:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101007:	ee                   	out    %al,(%dx)
}
  101008:	90                   	nop
  101009:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10100f:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  101013:	89 c2                	mov    %eax,%edx
  101015:	ec                   	in     (%dx),%al
  101016:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  101019:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  10101d:	3c ff                	cmp    $0xff,%al
  10101f:	0f 95 c0             	setne  %al
  101022:	0f b6 c0             	movzbl %al,%eax
  101025:	a3 68 0e 11 00       	mov    %eax,0x110e68
  10102a:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101030:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101034:	89 c2                	mov    %eax,%edx
  101036:	ec                   	in     (%dx),%al
  101037:	88 45 f1             	mov    %al,-0xf(%ebp)
  10103a:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101040:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101044:	89 c2                	mov    %eax,%edx
  101046:	ec                   	in     (%dx),%al
  101047:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  10104a:	a1 68 0e 11 00       	mov    0x110e68,%eax
  10104f:	85 c0                	test   %eax,%eax
  101051:	74 0c                	je     10105f <serial_init+0xec>
        pic_enable(IRQ_COM1);
  101053:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10105a:	e8 0b 07 00 00       	call   10176a <pic_enable>
    }
}
  10105f:	90                   	nop
  101060:	c9                   	leave  
  101061:	c3                   	ret    

00101062 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101062:	f3 0f 1e fb          	endbr32 
  101066:	55                   	push   %ebp
  101067:	89 e5                	mov    %esp,%ebp
  101069:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10106c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101073:	eb 08                	jmp    10107d <lpt_putc_sub+0x1b>
        delay();
  101075:	e8 c2 fd ff ff       	call   100e3c <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10107a:	ff 45 fc             	incl   -0x4(%ebp)
  10107d:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101083:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101087:	89 c2                	mov    %eax,%edx
  101089:	ec                   	in     (%dx),%al
  10108a:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10108d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101091:	84 c0                	test   %al,%al
  101093:	78 09                	js     10109e <lpt_putc_sub+0x3c>
  101095:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10109c:	7e d7                	jle    101075 <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  10109e:	8b 45 08             	mov    0x8(%ebp),%eax
  1010a1:	0f b6 c0             	movzbl %al,%eax
  1010a4:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  1010aa:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010ad:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010b1:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010b5:	ee                   	out    %al,(%dx)
}
  1010b6:	90                   	nop
  1010b7:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010bd:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010c1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010c5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010c9:	ee                   	out    %al,(%dx)
}
  1010ca:	90                   	nop
  1010cb:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010d1:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010d5:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010d9:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010dd:	ee                   	out    %al,(%dx)
}
  1010de:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010df:	90                   	nop
  1010e0:	c9                   	leave  
  1010e1:	c3                   	ret    

001010e2 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010e2:	f3 0f 1e fb          	endbr32 
  1010e6:	55                   	push   %ebp
  1010e7:	89 e5                	mov    %esp,%ebp
  1010e9:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010ec:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010f0:	74 0d                	je     1010ff <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010f2:	8b 45 08             	mov    0x8(%ebp),%eax
  1010f5:	89 04 24             	mov    %eax,(%esp)
  1010f8:	e8 65 ff ff ff       	call   101062 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010fd:	eb 24                	jmp    101123 <lpt_putc+0x41>
        lpt_putc_sub('\b');
  1010ff:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101106:	e8 57 ff ff ff       	call   101062 <lpt_putc_sub>
        lpt_putc_sub(' ');
  10110b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101112:	e8 4b ff ff ff       	call   101062 <lpt_putc_sub>
        lpt_putc_sub('\b');
  101117:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10111e:	e8 3f ff ff ff       	call   101062 <lpt_putc_sub>
}
  101123:	90                   	nop
  101124:	c9                   	leave  
  101125:	c3                   	ret    

00101126 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101126:	f3 0f 1e fb          	endbr32 
  10112a:	55                   	push   %ebp
  10112b:	89 e5                	mov    %esp,%ebp
  10112d:	53                   	push   %ebx
  10112e:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101131:	8b 45 08             	mov    0x8(%ebp),%eax
  101134:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101139:	85 c0                	test   %eax,%eax
  10113b:	75 07                	jne    101144 <cga_putc+0x1e>
        c |= 0x0700;
  10113d:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101144:	8b 45 08             	mov    0x8(%ebp),%eax
  101147:	0f b6 c0             	movzbl %al,%eax
  10114a:	83 f8 0d             	cmp    $0xd,%eax
  10114d:	74 72                	je     1011c1 <cga_putc+0x9b>
  10114f:	83 f8 0d             	cmp    $0xd,%eax
  101152:	0f 8f a3 00 00 00    	jg     1011fb <cga_putc+0xd5>
  101158:	83 f8 08             	cmp    $0x8,%eax
  10115b:	74 0a                	je     101167 <cga_putc+0x41>
  10115d:	83 f8 0a             	cmp    $0xa,%eax
  101160:	74 4c                	je     1011ae <cga_putc+0x88>
  101162:	e9 94 00 00 00       	jmp    1011fb <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  101167:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  10116e:	85 c0                	test   %eax,%eax
  101170:	0f 84 af 00 00 00    	je     101225 <cga_putc+0xff>
            crt_pos --;
  101176:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  10117d:	48                   	dec    %eax
  10117e:	0f b7 c0             	movzwl %ax,%eax
  101181:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101187:	8b 45 08             	mov    0x8(%ebp),%eax
  10118a:	98                   	cwtl   
  10118b:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101190:	98                   	cwtl   
  101191:	83 c8 20             	or     $0x20,%eax
  101194:	98                   	cwtl   
  101195:	8b 15 60 0e 11 00    	mov    0x110e60,%edx
  10119b:	0f b7 0d 64 0e 11 00 	movzwl 0x110e64,%ecx
  1011a2:	01 c9                	add    %ecx,%ecx
  1011a4:	01 ca                	add    %ecx,%edx
  1011a6:	0f b7 c0             	movzwl %ax,%eax
  1011a9:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1011ac:	eb 77                	jmp    101225 <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  1011ae:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1011b5:	83 c0 50             	add    $0x50,%eax
  1011b8:	0f b7 c0             	movzwl %ax,%eax
  1011bb:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011c1:	0f b7 1d 64 0e 11 00 	movzwl 0x110e64,%ebx
  1011c8:	0f b7 0d 64 0e 11 00 	movzwl 0x110e64,%ecx
  1011cf:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011d4:	89 c8                	mov    %ecx,%eax
  1011d6:	f7 e2                	mul    %edx
  1011d8:	c1 ea 06             	shr    $0x6,%edx
  1011db:	89 d0                	mov    %edx,%eax
  1011dd:	c1 e0 02             	shl    $0x2,%eax
  1011e0:	01 d0                	add    %edx,%eax
  1011e2:	c1 e0 04             	shl    $0x4,%eax
  1011e5:	29 c1                	sub    %eax,%ecx
  1011e7:	89 c8                	mov    %ecx,%eax
  1011e9:	0f b7 c0             	movzwl %ax,%eax
  1011ec:	29 c3                	sub    %eax,%ebx
  1011ee:	89 d8                	mov    %ebx,%eax
  1011f0:	0f b7 c0             	movzwl %ax,%eax
  1011f3:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
        break;
  1011f9:	eb 2b                	jmp    101226 <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011fb:	8b 0d 60 0e 11 00    	mov    0x110e60,%ecx
  101201:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  101208:	8d 50 01             	lea    0x1(%eax),%edx
  10120b:	0f b7 d2             	movzwl %dx,%edx
  10120e:	66 89 15 64 0e 11 00 	mov    %dx,0x110e64
  101215:	01 c0                	add    %eax,%eax
  101217:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  10121a:	8b 45 08             	mov    0x8(%ebp),%eax
  10121d:	0f b7 c0             	movzwl %ax,%eax
  101220:	66 89 02             	mov    %ax,(%edx)
        break;
  101223:	eb 01                	jmp    101226 <cga_putc+0x100>
        break;
  101225:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101226:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  10122d:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101232:	76 5d                	jbe    101291 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101234:	a1 60 0e 11 00       	mov    0x110e60,%eax
  101239:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10123f:	a1 60 0e 11 00       	mov    0x110e60,%eax
  101244:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10124b:	00 
  10124c:	89 54 24 04          	mov    %edx,0x4(%esp)
  101250:	89 04 24             	mov    %eax,(%esp)
  101253:	e8 59 1d 00 00       	call   102fb1 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101258:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10125f:	eb 14                	jmp    101275 <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  101261:	a1 60 0e 11 00       	mov    0x110e60,%eax
  101266:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101269:	01 d2                	add    %edx,%edx
  10126b:	01 d0                	add    %edx,%eax
  10126d:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101272:	ff 45 f4             	incl   -0xc(%ebp)
  101275:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10127c:	7e e3                	jle    101261 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  10127e:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  101285:	83 e8 50             	sub    $0x50,%eax
  101288:	0f b7 c0             	movzwl %ax,%eax
  10128b:	66 a3 64 0e 11 00    	mov    %ax,0x110e64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101291:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  101298:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10129c:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012a0:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  1012a4:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  1012a8:	ee                   	out    %al,(%dx)
}
  1012a9:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  1012aa:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1012b1:	c1 e8 08             	shr    $0x8,%eax
  1012b4:	0f b7 c0             	movzwl %ax,%eax
  1012b7:	0f b6 c0             	movzbl %al,%eax
  1012ba:	0f b7 15 66 0e 11 00 	movzwl 0x110e66,%edx
  1012c1:	42                   	inc    %edx
  1012c2:	0f b7 d2             	movzwl %dx,%edx
  1012c5:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012c9:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012cc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012d0:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012d4:	ee                   	out    %al,(%dx)
}
  1012d5:	90                   	nop
    outb(addr_6845, 15);
  1012d6:	0f b7 05 66 0e 11 00 	movzwl 0x110e66,%eax
  1012dd:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012e1:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012e5:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012e9:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012ed:	ee                   	out    %al,(%dx)
}
  1012ee:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012ef:	0f b7 05 64 0e 11 00 	movzwl 0x110e64,%eax
  1012f6:	0f b6 c0             	movzbl %al,%eax
  1012f9:	0f b7 15 66 0e 11 00 	movzwl 0x110e66,%edx
  101300:	42                   	inc    %edx
  101301:	0f b7 d2             	movzwl %dx,%edx
  101304:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  101308:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10130b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10130f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101313:	ee                   	out    %al,(%dx)
}
  101314:	90                   	nop
}
  101315:	90                   	nop
  101316:	83 c4 34             	add    $0x34,%esp
  101319:	5b                   	pop    %ebx
  10131a:	5d                   	pop    %ebp
  10131b:	c3                   	ret    

0010131c <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10131c:	f3 0f 1e fb          	endbr32 
  101320:	55                   	push   %ebp
  101321:	89 e5                	mov    %esp,%ebp
  101323:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101326:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10132d:	eb 08                	jmp    101337 <serial_putc_sub+0x1b>
        delay();
  10132f:	e8 08 fb ff ff       	call   100e3c <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101334:	ff 45 fc             	incl   -0x4(%ebp)
  101337:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10133d:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101341:	89 c2                	mov    %eax,%edx
  101343:	ec                   	in     (%dx),%al
  101344:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101347:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10134b:	0f b6 c0             	movzbl %al,%eax
  10134e:	83 e0 20             	and    $0x20,%eax
  101351:	85 c0                	test   %eax,%eax
  101353:	75 09                	jne    10135e <serial_putc_sub+0x42>
  101355:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10135c:	7e d1                	jle    10132f <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  10135e:	8b 45 08             	mov    0x8(%ebp),%eax
  101361:	0f b6 c0             	movzbl %al,%eax
  101364:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10136a:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10136d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101371:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101375:	ee                   	out    %al,(%dx)
}
  101376:	90                   	nop
}
  101377:	90                   	nop
  101378:	c9                   	leave  
  101379:	c3                   	ret    

0010137a <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10137a:	f3 0f 1e fb          	endbr32 
  10137e:	55                   	push   %ebp
  10137f:	89 e5                	mov    %esp,%ebp
  101381:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101384:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101388:	74 0d                	je     101397 <serial_putc+0x1d>
        serial_putc_sub(c);
  10138a:	8b 45 08             	mov    0x8(%ebp),%eax
  10138d:	89 04 24             	mov    %eax,(%esp)
  101390:	e8 87 ff ff ff       	call   10131c <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101395:	eb 24                	jmp    1013bb <serial_putc+0x41>
        serial_putc_sub('\b');
  101397:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10139e:	e8 79 ff ff ff       	call   10131c <serial_putc_sub>
        serial_putc_sub(' ');
  1013a3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1013aa:	e8 6d ff ff ff       	call   10131c <serial_putc_sub>
        serial_putc_sub('\b');
  1013af:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1013b6:	e8 61 ff ff ff       	call   10131c <serial_putc_sub>
}
  1013bb:	90                   	nop
  1013bc:	c9                   	leave  
  1013bd:	c3                   	ret    

001013be <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013be:	f3 0f 1e fb          	endbr32 
  1013c2:	55                   	push   %ebp
  1013c3:	89 e5                	mov    %esp,%ebp
  1013c5:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013c8:	eb 33                	jmp    1013fd <cons_intr+0x3f>
        if (c != 0) {
  1013ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013ce:	74 2d                	je     1013fd <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013d0:	a1 84 10 11 00       	mov    0x111084,%eax
  1013d5:	8d 50 01             	lea    0x1(%eax),%edx
  1013d8:	89 15 84 10 11 00    	mov    %edx,0x111084
  1013de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013e1:	88 90 80 0e 11 00    	mov    %dl,0x110e80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013e7:	a1 84 10 11 00       	mov    0x111084,%eax
  1013ec:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013f1:	75 0a                	jne    1013fd <cons_intr+0x3f>
                cons.wpos = 0;
  1013f3:	c7 05 84 10 11 00 00 	movl   $0x0,0x111084
  1013fa:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  101400:	ff d0                	call   *%eax
  101402:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101405:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101409:	75 bf                	jne    1013ca <cons_intr+0xc>
            }
        }
    }
}
  10140b:	90                   	nop
  10140c:	90                   	nop
  10140d:	c9                   	leave  
  10140e:	c3                   	ret    

0010140f <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  10140f:	f3 0f 1e fb          	endbr32 
  101413:	55                   	push   %ebp
  101414:	89 e5                	mov    %esp,%ebp
  101416:	83 ec 10             	sub    $0x10,%esp
  101419:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10141f:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101423:	89 c2                	mov    %eax,%edx
  101425:	ec                   	in     (%dx),%al
  101426:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101429:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10142d:	0f b6 c0             	movzbl %al,%eax
  101430:	83 e0 01             	and    $0x1,%eax
  101433:	85 c0                	test   %eax,%eax
  101435:	75 07                	jne    10143e <serial_proc_data+0x2f>
        return -1;
  101437:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10143c:	eb 2a                	jmp    101468 <serial_proc_data+0x59>
  10143e:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101444:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101448:	89 c2                	mov    %eax,%edx
  10144a:	ec                   	in     (%dx),%al
  10144b:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10144e:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101452:	0f b6 c0             	movzbl %al,%eax
  101455:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101458:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10145c:	75 07                	jne    101465 <serial_proc_data+0x56>
        c = '\b';
  10145e:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101465:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101468:	c9                   	leave  
  101469:	c3                   	ret    

0010146a <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10146a:	f3 0f 1e fb          	endbr32 
  10146e:	55                   	push   %ebp
  10146f:	89 e5                	mov    %esp,%ebp
  101471:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101474:	a1 68 0e 11 00       	mov    0x110e68,%eax
  101479:	85 c0                	test   %eax,%eax
  10147b:	74 0c                	je     101489 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  10147d:	c7 04 24 0f 14 10 00 	movl   $0x10140f,(%esp)
  101484:	e8 35 ff ff ff       	call   1013be <cons_intr>
    }
}
  101489:	90                   	nop
  10148a:	c9                   	leave  
  10148b:	c3                   	ret    

0010148c <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10148c:	f3 0f 1e fb          	endbr32 
  101490:	55                   	push   %ebp
  101491:	89 e5                	mov    %esp,%ebp
  101493:	83 ec 38             	sub    $0x38,%esp
  101496:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10149c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10149f:	89 c2                	mov    %eax,%edx
  1014a1:	ec                   	in     (%dx),%al
  1014a2:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1014a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1014a9:	0f b6 c0             	movzbl %al,%eax
  1014ac:	83 e0 01             	and    $0x1,%eax
  1014af:	85 c0                	test   %eax,%eax
  1014b1:	75 0a                	jne    1014bd <kbd_proc_data+0x31>
        return -1;
  1014b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1014b8:	e9 56 01 00 00       	jmp    101613 <kbd_proc_data+0x187>
  1014bd:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1014c6:	89 c2                	mov    %eax,%edx
  1014c8:	ec                   	in     (%dx),%al
  1014c9:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014cc:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014d0:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014d3:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014d7:	75 17                	jne    1014f0 <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  1014d9:	a1 88 10 11 00       	mov    0x111088,%eax
  1014de:	83 c8 40             	or     $0x40,%eax
  1014e1:	a3 88 10 11 00       	mov    %eax,0x111088
        return 0;
  1014e6:	b8 00 00 00 00       	mov    $0x0,%eax
  1014eb:	e9 23 01 00 00       	jmp    101613 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014f0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f4:	84 c0                	test   %al,%al
  1014f6:	79 45                	jns    10153d <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014f8:	a1 88 10 11 00       	mov    0x111088,%eax
  1014fd:	83 e0 40             	and    $0x40,%eax
  101500:	85 c0                	test   %eax,%eax
  101502:	75 08                	jne    10150c <kbd_proc_data+0x80>
  101504:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101508:	24 7f                	and    $0x7f,%al
  10150a:	eb 04                	jmp    101510 <kbd_proc_data+0x84>
  10150c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101510:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101513:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101517:	0f b6 80 40 00 11 00 	movzbl 0x110040(%eax),%eax
  10151e:	0c 40                	or     $0x40,%al
  101520:	0f b6 c0             	movzbl %al,%eax
  101523:	f7 d0                	not    %eax
  101525:	89 c2                	mov    %eax,%edx
  101527:	a1 88 10 11 00       	mov    0x111088,%eax
  10152c:	21 d0                	and    %edx,%eax
  10152e:	a3 88 10 11 00       	mov    %eax,0x111088
        return 0;
  101533:	b8 00 00 00 00       	mov    $0x0,%eax
  101538:	e9 d6 00 00 00       	jmp    101613 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  10153d:	a1 88 10 11 00       	mov    0x111088,%eax
  101542:	83 e0 40             	and    $0x40,%eax
  101545:	85 c0                	test   %eax,%eax
  101547:	74 11                	je     10155a <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101549:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10154d:	a1 88 10 11 00       	mov    0x111088,%eax
  101552:	83 e0 bf             	and    $0xffffffbf,%eax
  101555:	a3 88 10 11 00       	mov    %eax,0x111088
    }

    shift |= shiftcode[data];
  10155a:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10155e:	0f b6 80 40 00 11 00 	movzbl 0x110040(%eax),%eax
  101565:	0f b6 d0             	movzbl %al,%edx
  101568:	a1 88 10 11 00       	mov    0x111088,%eax
  10156d:	09 d0                	or     %edx,%eax
  10156f:	a3 88 10 11 00       	mov    %eax,0x111088
    shift ^= togglecode[data];
  101574:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101578:	0f b6 80 40 01 11 00 	movzbl 0x110140(%eax),%eax
  10157f:	0f b6 d0             	movzbl %al,%edx
  101582:	a1 88 10 11 00       	mov    0x111088,%eax
  101587:	31 d0                	xor    %edx,%eax
  101589:	a3 88 10 11 00       	mov    %eax,0x111088

    c = charcode[shift & (CTL | SHIFT)][data];
  10158e:	a1 88 10 11 00       	mov    0x111088,%eax
  101593:	83 e0 03             	and    $0x3,%eax
  101596:	8b 14 85 40 05 11 00 	mov    0x110540(,%eax,4),%edx
  10159d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1015a1:	01 d0                	add    %edx,%eax
  1015a3:	0f b6 00             	movzbl (%eax),%eax
  1015a6:	0f b6 c0             	movzbl %al,%eax
  1015a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1015ac:	a1 88 10 11 00       	mov    0x111088,%eax
  1015b1:	83 e0 08             	and    $0x8,%eax
  1015b4:	85 c0                	test   %eax,%eax
  1015b6:	74 22                	je     1015da <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1015b8:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015bc:	7e 0c                	jle    1015ca <kbd_proc_data+0x13e>
  1015be:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015c2:	7f 06                	jg     1015ca <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1015c4:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015c8:	eb 10                	jmp    1015da <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015ca:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015ce:	7e 0a                	jle    1015da <kbd_proc_data+0x14e>
  1015d0:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015d4:	7f 04                	jg     1015da <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015d6:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015da:	a1 88 10 11 00       	mov    0x111088,%eax
  1015df:	f7 d0                	not    %eax
  1015e1:	83 e0 06             	and    $0x6,%eax
  1015e4:	85 c0                	test   %eax,%eax
  1015e6:	75 28                	jne    101610 <kbd_proc_data+0x184>
  1015e8:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015ef:	75 1f                	jne    101610 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015f1:	c7 04 24 cd 3a 10 00 	movl   $0x103acd,(%esp)
  1015f8:	e8 90 ec ff ff       	call   10028d <cprintf>
  1015fd:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101603:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101607:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  10160b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10160e:	ee                   	out    %al,(%dx)
}
  10160f:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101610:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101613:	c9                   	leave  
  101614:	c3                   	ret    

00101615 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101615:	f3 0f 1e fb          	endbr32 
  101619:	55                   	push   %ebp
  10161a:	89 e5                	mov    %esp,%ebp
  10161c:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10161f:	c7 04 24 8c 14 10 00 	movl   $0x10148c,(%esp)
  101626:	e8 93 fd ff ff       	call   1013be <cons_intr>
}
  10162b:	90                   	nop
  10162c:	c9                   	leave  
  10162d:	c3                   	ret    

0010162e <kbd_init>:

static void
kbd_init(void) {
  10162e:	f3 0f 1e fb          	endbr32 
  101632:	55                   	push   %ebp
  101633:	89 e5                	mov    %esp,%ebp
  101635:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101638:	e8 d8 ff ff ff       	call   101615 <kbd_intr>
    pic_enable(IRQ_KBD);
  10163d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101644:	e8 21 01 00 00       	call   10176a <pic_enable>
}
  101649:	90                   	nop
  10164a:	c9                   	leave  
  10164b:	c3                   	ret    

0010164c <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10164c:	f3 0f 1e fb          	endbr32 
  101650:	55                   	push   %ebp
  101651:	89 e5                	mov    %esp,%ebp
  101653:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101656:	e8 2e f8 ff ff       	call   100e89 <cga_init>
    serial_init();
  10165b:	e8 13 f9 ff ff       	call   100f73 <serial_init>
    kbd_init();
  101660:	e8 c9 ff ff ff       	call   10162e <kbd_init>
    if (!serial_exists) {
  101665:	a1 68 0e 11 00       	mov    0x110e68,%eax
  10166a:	85 c0                	test   %eax,%eax
  10166c:	75 0c                	jne    10167a <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  10166e:	c7 04 24 d9 3a 10 00 	movl   $0x103ad9,(%esp)
  101675:	e8 13 ec ff ff       	call   10028d <cprintf>
    }
}
  10167a:	90                   	nop
  10167b:	c9                   	leave  
  10167c:	c3                   	ret    

0010167d <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  10167d:	f3 0f 1e fb          	endbr32 
  101681:	55                   	push   %ebp
  101682:	89 e5                	mov    %esp,%ebp
  101684:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101687:	8b 45 08             	mov    0x8(%ebp),%eax
  10168a:	89 04 24             	mov    %eax,(%esp)
  10168d:	e8 50 fa ff ff       	call   1010e2 <lpt_putc>
    cga_putc(c);
  101692:	8b 45 08             	mov    0x8(%ebp),%eax
  101695:	89 04 24             	mov    %eax,(%esp)
  101698:	e8 89 fa ff ff       	call   101126 <cga_putc>
    serial_putc(c);
  10169d:	8b 45 08             	mov    0x8(%ebp),%eax
  1016a0:	89 04 24             	mov    %eax,(%esp)
  1016a3:	e8 d2 fc ff ff       	call   10137a <serial_putc>
}
  1016a8:	90                   	nop
  1016a9:	c9                   	leave  
  1016aa:	c3                   	ret    

001016ab <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1016ab:	f3 0f 1e fb          	endbr32 
  1016af:	55                   	push   %ebp
  1016b0:	89 e5                	mov    %esp,%ebp
  1016b2:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016b5:	e8 b0 fd ff ff       	call   10146a <serial_intr>
    kbd_intr();
  1016ba:	e8 56 ff ff ff       	call   101615 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016bf:	8b 15 80 10 11 00    	mov    0x111080,%edx
  1016c5:	a1 84 10 11 00       	mov    0x111084,%eax
  1016ca:	39 c2                	cmp    %eax,%edx
  1016cc:	74 36                	je     101704 <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016ce:	a1 80 10 11 00       	mov    0x111080,%eax
  1016d3:	8d 50 01             	lea    0x1(%eax),%edx
  1016d6:	89 15 80 10 11 00    	mov    %edx,0x111080
  1016dc:	0f b6 80 80 0e 11 00 	movzbl 0x110e80(%eax),%eax
  1016e3:	0f b6 c0             	movzbl %al,%eax
  1016e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016e9:	a1 80 10 11 00       	mov    0x111080,%eax
  1016ee:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016f3:	75 0a                	jne    1016ff <cons_getc+0x54>
            cons.rpos = 0;
  1016f5:	c7 05 80 10 11 00 00 	movl   $0x0,0x111080
  1016fc:	00 00 00 
        }
        return c;
  1016ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101702:	eb 05                	jmp    101709 <cons_getc+0x5e>
    }
    return 0;
  101704:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101709:	c9                   	leave  
  10170a:	c3                   	ret    

0010170b <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  10170b:	f3 0f 1e fb          	endbr32 
  10170f:	55                   	push   %ebp
  101710:	89 e5                	mov    %esp,%ebp
  101712:	83 ec 14             	sub    $0x14,%esp
  101715:	8b 45 08             	mov    0x8(%ebp),%eax
  101718:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10171c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10171f:	66 a3 50 05 11 00    	mov    %ax,0x110550
    if (did_init) {
  101725:	a1 8c 10 11 00       	mov    0x11108c,%eax
  10172a:	85 c0                	test   %eax,%eax
  10172c:	74 39                	je     101767 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  10172e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101731:	0f b6 c0             	movzbl %al,%eax
  101734:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  10173a:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10173d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101741:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101745:	ee                   	out    %al,(%dx)
}
  101746:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101747:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10174b:	c1 e8 08             	shr    $0x8,%eax
  10174e:	0f b7 c0             	movzwl %ax,%eax
  101751:	0f b6 c0             	movzbl %al,%eax
  101754:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  10175a:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10175d:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101761:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101765:	ee                   	out    %al,(%dx)
}
  101766:	90                   	nop
    }
}
  101767:	90                   	nop
  101768:	c9                   	leave  
  101769:	c3                   	ret    

0010176a <pic_enable>:

void
pic_enable(unsigned int irq) {
  10176a:	f3 0f 1e fb          	endbr32 
  10176e:	55                   	push   %ebp
  10176f:	89 e5                	mov    %esp,%ebp
  101771:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101774:	8b 45 08             	mov    0x8(%ebp),%eax
  101777:	ba 01 00 00 00       	mov    $0x1,%edx
  10177c:	88 c1                	mov    %al,%cl
  10177e:	d3 e2                	shl    %cl,%edx
  101780:	89 d0                	mov    %edx,%eax
  101782:	98                   	cwtl   
  101783:	f7 d0                	not    %eax
  101785:	0f bf d0             	movswl %ax,%edx
  101788:	0f b7 05 50 05 11 00 	movzwl 0x110550,%eax
  10178f:	98                   	cwtl   
  101790:	21 d0                	and    %edx,%eax
  101792:	98                   	cwtl   
  101793:	0f b7 c0             	movzwl %ax,%eax
  101796:	89 04 24             	mov    %eax,(%esp)
  101799:	e8 6d ff ff ff       	call   10170b <pic_setmask>
}
  10179e:	90                   	nop
  10179f:	c9                   	leave  
  1017a0:	c3                   	ret    

001017a1 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1017a1:	f3 0f 1e fb          	endbr32 
  1017a5:	55                   	push   %ebp
  1017a6:	89 e5                	mov    %esp,%ebp
  1017a8:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1017ab:	c7 05 8c 10 11 00 01 	movl   $0x1,0x11108c
  1017b2:	00 00 00 
  1017b5:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017bb:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017bf:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017c3:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017c7:	ee                   	out    %al,(%dx)
}
  1017c8:	90                   	nop
  1017c9:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017cf:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017d3:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017d7:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017db:	ee                   	out    %al,(%dx)
}
  1017dc:	90                   	nop
  1017dd:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017e3:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017e7:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017eb:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017ef:	ee                   	out    %al,(%dx)
}
  1017f0:	90                   	nop
  1017f1:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017f7:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017fb:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017ff:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101803:	ee                   	out    %al,(%dx)
}
  101804:	90                   	nop
  101805:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  10180b:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10180f:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101813:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101817:	ee                   	out    %al,(%dx)
}
  101818:	90                   	nop
  101819:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  10181f:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101823:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101827:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10182b:	ee                   	out    %al,(%dx)
}
  10182c:	90                   	nop
  10182d:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101833:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101837:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10183b:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10183f:	ee                   	out    %al,(%dx)
}
  101840:	90                   	nop
  101841:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101847:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10184b:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10184f:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101853:	ee                   	out    %al,(%dx)
}
  101854:	90                   	nop
  101855:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  10185b:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10185f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101863:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101867:	ee                   	out    %al,(%dx)
}
  101868:	90                   	nop
  101869:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  10186f:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101873:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101877:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10187b:	ee                   	out    %al,(%dx)
}
  10187c:	90                   	nop
  10187d:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101883:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101887:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10188b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10188f:	ee                   	out    %al,(%dx)
}
  101890:	90                   	nop
  101891:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101897:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10189b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10189f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1018a3:	ee                   	out    %al,(%dx)
}
  1018a4:	90                   	nop
  1018a5:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  1018ab:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018af:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1018b3:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1018b7:	ee                   	out    %al,(%dx)
}
  1018b8:	90                   	nop
  1018b9:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018bf:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018c3:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018c7:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018cb:	ee                   	out    %al,(%dx)
}
  1018cc:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018cd:	0f b7 05 50 05 11 00 	movzwl 0x110550,%eax
  1018d4:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018d9:	74 0f                	je     1018ea <pic_init+0x149>
        pic_setmask(irq_mask);
  1018db:	0f b7 05 50 05 11 00 	movzwl 0x110550,%eax
  1018e2:	89 04 24             	mov    %eax,(%esp)
  1018e5:	e8 21 fe ff ff       	call   10170b <pic_setmask>
    }
}
  1018ea:	90                   	nop
  1018eb:	c9                   	leave  
  1018ec:	c3                   	ret    

001018ed <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018ed:	f3 0f 1e fb          	endbr32 
  1018f1:	55                   	push   %ebp
  1018f2:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018f4:	fb                   	sti    
}
  1018f5:	90                   	nop
    sti();
}
  1018f6:	90                   	nop
  1018f7:	5d                   	pop    %ebp
  1018f8:	c3                   	ret    

001018f9 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018f9:	f3 0f 1e fb          	endbr32 
  1018fd:	55                   	push   %ebp
  1018fe:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  101900:	fa                   	cli    
}
  101901:	90                   	nop
    cli();
}
  101902:	90                   	nop
  101903:	5d                   	pop    %ebp
  101904:	c3                   	ret    

00101905 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101905:	f3 0f 1e fb          	endbr32 
  101909:	55                   	push   %ebp
  10190a:	89 e5                	mov    %esp,%ebp
  10190c:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  10190f:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101916:	00 
  101917:	c7 04 24 00 3b 10 00 	movl   $0x103b00,(%esp)
  10191e:	e8 6a e9 ff ff       	call   10028d <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101923:	c7 04 24 0a 3b 10 00 	movl   $0x103b0a,(%esp)
  10192a:	e8 5e e9 ff ff       	call   10028d <cprintf>
    panic("EOT: kernel seems ok.");
  10192f:	c7 44 24 08 18 3b 10 	movl   $0x103b18,0x8(%esp)
  101936:	00 
  101937:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  10193e:	00 
  10193f:	c7 04 24 2e 3b 10 00 	movl   $0x103b2e,(%esp)
  101946:	e8 ae ea ff ff       	call   1003f9 <__panic>

0010194b <idt_init>:
static struct pseudodesc idt_pd = {
    sizeof(idt) - 1, (uintptr_t)idt
};
/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10194b:	f3 0f 1e fb          	endbr32 
  10194f:	55                   	push   %ebp
  101950:	89 e5                	mov    %esp,%ebp
  101952:	83 ec 10             	sub    $0x10,%esp
    extern uintptr_t __vectors[]; //_vevtors数组保存在vectors.S中的256个中断处理例程的入口地址

    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
  101955:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10195c:	e9 ca 00 00 00       	jmp    101a2b <idt_init+0xe0>
        SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);
  101961:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101964:	8b 04 85 e0 05 11 00 	mov    0x1105e0(,%eax,4),%eax
  10196b:	0f b7 d0             	movzwl %ax,%edx
  10196e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101971:	66 89 14 c5 a0 10 11 	mov    %dx,0x1110a0(,%eax,8)
  101978:	00 
  101979:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10197c:	66 c7 04 c5 a2 10 11 	movw   $0x8,0x1110a2(,%eax,8)
  101983:	00 08 00 
  101986:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101989:	0f b6 14 c5 a4 10 11 	movzbl 0x1110a4(,%eax,8),%edx
  101990:	00 
  101991:	80 e2 e0             	and    $0xe0,%dl
  101994:	88 14 c5 a4 10 11 00 	mov    %dl,0x1110a4(,%eax,8)
  10199b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10199e:	0f b6 14 c5 a4 10 11 	movzbl 0x1110a4(,%eax,8),%edx
  1019a5:	00 
  1019a6:	80 e2 1f             	and    $0x1f,%dl
  1019a9:	88 14 c5 a4 10 11 00 	mov    %dl,0x1110a4(,%eax,8)
  1019b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019b3:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019ba:	00 
  1019bb:	80 e2 f0             	and    $0xf0,%dl
  1019be:	80 ca 0e             	or     $0xe,%dl
  1019c1:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  1019c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019cb:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019d2:	00 
  1019d3:	80 e2 ef             	and    $0xef,%dl
  1019d6:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  1019dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e0:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019e7:	00 
  1019e8:	80 e2 9f             	and    $0x9f,%dl
  1019eb:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  1019f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019f5:	0f b6 14 c5 a5 10 11 	movzbl 0x1110a5(,%eax,8),%edx
  1019fc:	00 
  1019fd:	80 ca 80             	or     $0x80,%dl
  101a00:	88 14 c5 a5 10 11 00 	mov    %dl,0x1110a5(,%eax,8)
  101a07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a0a:	8b 04 85 e0 05 11 00 	mov    0x1105e0(,%eax,4),%eax
  101a11:	c1 e8 10             	shr    $0x10,%eax
  101a14:	0f b7 d0             	movzwl %ax,%edx
  101a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a1a:	66 89 14 c5 a6 10 11 	mov    %dx,0x1110a6(,%eax,8)
  101a21:	00 
    for (int i=0;i<sizeof(idt);i+=sizeof(struct gatedesc))
  101a22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a25:	83 c0 08             	add    $0x8,%eax
  101a28:	89 45 fc             	mov    %eax,-0x4(%ebp)
  101a2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a2e:	3d ff 07 00 00       	cmp    $0x7ff,%eax
  101a33:	0f 86 28 ff ff ff    	jbe    101961 <idt_init+0x16>
 /*循环调用SETGATE函数对中断门idt[i]依次进行初始化
   其中第一个参数为初始化模板idt[i]；第二个参数为0，表示中断门；第三个参数GD_KTEXT为内核代码段的起始地址；第四个参数_vector[i]为中断处理例程的入口地址；第五个参数表示内核权限\*/
    SETGATE(idt[T_SWITCH_TOK],0,GD_KTEXT,__vectors[T_SWITCH_TOK],DPL_USER);
  101a39:	a1 c4 07 11 00       	mov    0x1107c4,%eax
  101a3e:	0f b7 c0             	movzwl %ax,%eax
  101a41:	66 a3 68 14 11 00    	mov    %ax,0x111468
  101a47:	66 c7 05 6a 14 11 00 	movw   $0x8,0x11146a
  101a4e:	08 00 
  101a50:	0f b6 05 6c 14 11 00 	movzbl 0x11146c,%eax
  101a57:	24 e0                	and    $0xe0,%al
  101a59:	a2 6c 14 11 00       	mov    %al,0x11146c
  101a5e:	0f b6 05 6c 14 11 00 	movzbl 0x11146c,%eax
  101a65:	24 1f                	and    $0x1f,%al
  101a67:	a2 6c 14 11 00       	mov    %al,0x11146c
  101a6c:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a73:	24 f0                	and    $0xf0,%al
  101a75:	0c 0e                	or     $0xe,%al
  101a77:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a7c:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a83:	24 ef                	and    $0xef,%al
  101a85:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a8a:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a91:	0c 60                	or     $0x60,%al
  101a93:	a2 6d 14 11 00       	mov    %al,0x11146d
  101a98:	0f b6 05 6d 14 11 00 	movzbl 0x11146d,%eax
  101a9f:	0c 80                	or     $0x80,%al
  101aa1:	a2 6d 14 11 00       	mov    %al,0x11146d
  101aa6:	a1 c4 07 11 00       	mov    0x1107c4,%eax
  101aab:	c1 e8 10             	shr    $0x10,%eax
  101aae:	0f b7 c0             	movzwl %ax,%eax
  101ab1:	66 a3 6e 14 11 00    	mov    %ax,0x11146e
  101ab7:	c7 45 f8 60 05 11 00 	movl   $0x110560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101abe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101ac1:	0f 01 18             	lidtl  (%eax)
}
  101ac4:	90                   	nop

    lidt(&idt_pd);
//加载idt中断描述符表，并将&idt_pd的首地址加载到IDTR中
}
  101ac5:	90                   	nop
  101ac6:	c9                   	leave  
  101ac7:	c3                   	ret    

00101ac8 <trapname>:

static const char *
trapname(int trapno) {
  101ac8:	f3 0f 1e fb          	endbr32 
  101acc:	55                   	push   %ebp
  101acd:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101acf:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad2:	83 f8 13             	cmp    $0x13,%eax
  101ad5:	77 0c                	ja     101ae3 <trapname+0x1b>
        return excnames[trapno];
  101ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  101ada:	8b 04 85 80 3e 10 00 	mov    0x103e80(,%eax,4),%eax
  101ae1:	eb 18                	jmp    101afb <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101ae3:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101ae7:	7e 0d                	jle    101af6 <trapname+0x2e>
  101ae9:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101aed:	7f 07                	jg     101af6 <trapname+0x2e>
        return "Hardware Interrupt";
  101aef:	b8 3f 3b 10 00       	mov    $0x103b3f,%eax
  101af4:	eb 05                	jmp    101afb <trapname+0x33>
    }
    return "(unknown trap)";
  101af6:	b8 52 3b 10 00       	mov    $0x103b52,%eax
}
  101afb:	5d                   	pop    %ebp
  101afc:	c3                   	ret    

00101afd <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101afd:	f3 0f 1e fb          	endbr32 
  101b01:	55                   	push   %ebp
  101b02:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101b04:	8b 45 08             	mov    0x8(%ebp),%eax
  101b07:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b0b:	83 f8 08             	cmp    $0x8,%eax
  101b0e:	0f 94 c0             	sete   %al
  101b11:	0f b6 c0             	movzbl %al,%eax
}
  101b14:	5d                   	pop    %ebp
  101b15:	c3                   	ret    

00101b16 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101b16:	f3 0f 1e fb          	endbr32 
  101b1a:	55                   	push   %ebp
  101b1b:	89 e5                	mov    %esp,%ebp
  101b1d:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101b20:	8b 45 08             	mov    0x8(%ebp),%eax
  101b23:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b27:	c7 04 24 93 3b 10 00 	movl   $0x103b93,(%esp)
  101b2e:	e8 5a e7 ff ff       	call   10028d <cprintf>
    print_regs(&tf->tf_regs);
  101b33:	8b 45 08             	mov    0x8(%ebp),%eax
  101b36:	89 04 24             	mov    %eax,(%esp)
  101b39:	e8 8d 01 00 00       	call   101ccb <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b41:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b45:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b49:	c7 04 24 a4 3b 10 00 	movl   $0x103ba4,(%esp)
  101b50:	e8 38 e7 ff ff       	call   10028d <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b55:	8b 45 08             	mov    0x8(%ebp),%eax
  101b58:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b60:	c7 04 24 b7 3b 10 00 	movl   $0x103bb7,(%esp)
  101b67:	e8 21 e7 ff ff       	call   10028d <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b6f:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b73:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b77:	c7 04 24 ca 3b 10 00 	movl   $0x103bca,(%esp)
  101b7e:	e8 0a e7 ff ff       	call   10028d <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b83:	8b 45 08             	mov    0x8(%ebp),%eax
  101b86:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b8e:	c7 04 24 dd 3b 10 00 	movl   $0x103bdd,(%esp)
  101b95:	e8 f3 e6 ff ff       	call   10028d <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9d:	8b 40 30             	mov    0x30(%eax),%eax
  101ba0:	89 04 24             	mov    %eax,(%esp)
  101ba3:	e8 20 ff ff ff       	call   101ac8 <trapname>
  101ba8:	8b 55 08             	mov    0x8(%ebp),%edx
  101bab:	8b 52 30             	mov    0x30(%edx),%edx
  101bae:	89 44 24 08          	mov    %eax,0x8(%esp)
  101bb2:	89 54 24 04          	mov    %edx,0x4(%esp)
  101bb6:	c7 04 24 f0 3b 10 00 	movl   $0x103bf0,(%esp)
  101bbd:	e8 cb e6 ff ff       	call   10028d <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  101bc5:	8b 40 34             	mov    0x34(%eax),%eax
  101bc8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bcc:	c7 04 24 02 3c 10 00 	movl   $0x103c02,(%esp)
  101bd3:	e8 b5 e6 ff ff       	call   10028d <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  101bdb:	8b 40 38             	mov    0x38(%eax),%eax
  101bde:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be2:	c7 04 24 11 3c 10 00 	movl   $0x103c11,(%esp)
  101be9:	e8 9f e6 ff ff       	call   10028d <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bee:	8b 45 08             	mov    0x8(%ebp),%eax
  101bf1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bf5:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf9:	c7 04 24 20 3c 10 00 	movl   $0x103c20,(%esp)
  101c00:	e8 88 e6 ff ff       	call   10028d <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101c05:	8b 45 08             	mov    0x8(%ebp),%eax
  101c08:	8b 40 40             	mov    0x40(%eax),%eax
  101c0b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c0f:	c7 04 24 33 3c 10 00 	movl   $0x103c33,(%esp)
  101c16:	e8 72 e6 ff ff       	call   10028d <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c22:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c29:	eb 3d                	jmp    101c68 <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c2e:	8b 50 40             	mov    0x40(%eax),%edx
  101c31:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c34:	21 d0                	and    %edx,%eax
  101c36:	85 c0                	test   %eax,%eax
  101c38:	74 28                	je     101c62 <print_trapframe+0x14c>
  101c3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c3d:	8b 04 85 80 05 11 00 	mov    0x110580(,%eax,4),%eax
  101c44:	85 c0                	test   %eax,%eax
  101c46:	74 1a                	je     101c62 <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c48:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c4b:	8b 04 85 80 05 11 00 	mov    0x110580(,%eax,4),%eax
  101c52:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c56:	c7 04 24 42 3c 10 00 	movl   $0x103c42,(%esp)
  101c5d:	e8 2b e6 ff ff       	call   10028d <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c62:	ff 45 f4             	incl   -0xc(%ebp)
  101c65:	d1 65 f0             	shll   -0x10(%ebp)
  101c68:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c6b:	83 f8 17             	cmp    $0x17,%eax
  101c6e:	76 bb                	jbe    101c2b <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c70:	8b 45 08             	mov    0x8(%ebp),%eax
  101c73:	8b 40 40             	mov    0x40(%eax),%eax
  101c76:	c1 e8 0c             	shr    $0xc,%eax
  101c79:	83 e0 03             	and    $0x3,%eax
  101c7c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c80:	c7 04 24 46 3c 10 00 	movl   $0x103c46,(%esp)
  101c87:	e8 01 e6 ff ff       	call   10028d <cprintf>

    if (!trap_in_kernel(tf)) {
  101c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c8f:	89 04 24             	mov    %eax,(%esp)
  101c92:	e8 66 fe ff ff       	call   101afd <trap_in_kernel>
  101c97:	85 c0                	test   %eax,%eax
  101c99:	75 2d                	jne    101cc8 <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9e:	8b 40 44             	mov    0x44(%eax),%eax
  101ca1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca5:	c7 04 24 4f 3c 10 00 	movl   $0x103c4f,(%esp)
  101cac:	e8 dc e5 ff ff       	call   10028d <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb4:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101cb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cbc:	c7 04 24 5e 3c 10 00 	movl   $0x103c5e,(%esp)
  101cc3:	e8 c5 e5 ff ff       	call   10028d <cprintf>
    }
}
  101cc8:	90                   	nop
  101cc9:	c9                   	leave  
  101cca:	c3                   	ret    

00101ccb <print_regs>:

void
print_regs(struct pushregs *regs) {
  101ccb:	f3 0f 1e fb          	endbr32 
  101ccf:	55                   	push   %ebp
  101cd0:	89 e5                	mov    %esp,%ebp
  101cd2:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  101cd8:	8b 00                	mov    (%eax),%eax
  101cda:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cde:	c7 04 24 71 3c 10 00 	movl   $0x103c71,(%esp)
  101ce5:	e8 a3 e5 ff ff       	call   10028d <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cea:	8b 45 08             	mov    0x8(%ebp),%eax
  101ced:	8b 40 04             	mov    0x4(%eax),%eax
  101cf0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cf4:	c7 04 24 80 3c 10 00 	movl   $0x103c80,(%esp)
  101cfb:	e8 8d e5 ff ff       	call   10028d <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101d00:	8b 45 08             	mov    0x8(%ebp),%eax
  101d03:	8b 40 08             	mov    0x8(%eax),%eax
  101d06:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d0a:	c7 04 24 8f 3c 10 00 	movl   $0x103c8f,(%esp)
  101d11:	e8 77 e5 ff ff       	call   10028d <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101d16:	8b 45 08             	mov    0x8(%ebp),%eax
  101d19:	8b 40 0c             	mov    0xc(%eax),%eax
  101d1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d20:	c7 04 24 9e 3c 10 00 	movl   $0x103c9e,(%esp)
  101d27:	e8 61 e5 ff ff       	call   10028d <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d2f:	8b 40 10             	mov    0x10(%eax),%eax
  101d32:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d36:	c7 04 24 ad 3c 10 00 	movl   $0x103cad,(%esp)
  101d3d:	e8 4b e5 ff ff       	call   10028d <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d42:	8b 45 08             	mov    0x8(%ebp),%eax
  101d45:	8b 40 14             	mov    0x14(%eax),%eax
  101d48:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d4c:	c7 04 24 bc 3c 10 00 	movl   $0x103cbc,(%esp)
  101d53:	e8 35 e5 ff ff       	call   10028d <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d58:	8b 45 08             	mov    0x8(%ebp),%eax
  101d5b:	8b 40 18             	mov    0x18(%eax),%eax
  101d5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d62:	c7 04 24 cb 3c 10 00 	movl   $0x103ccb,(%esp)
  101d69:	e8 1f e5 ff ff       	call   10028d <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101d71:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d78:	c7 04 24 da 3c 10 00 	movl   $0x103cda,(%esp)
  101d7f:	e8 09 e5 ff ff       	call   10028d <cprintf>
}
  101d84:	90                   	nop
  101d85:	c9                   	leave  
  101d86:	c3                   	ret    

00101d87 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d87:	f3 0f 1e fb          	endbr32 
  101d8b:	55                   	push   %ebp
  101d8c:	89 e5                	mov    %esp,%ebp
  101d8e:	57                   	push   %edi
  101d8f:	56                   	push   %esi
  101d90:	53                   	push   %ebx
  101d91:	81 ec ac 00 00 00    	sub    $0xac,%esp
    char c;

    switch (tf->tf_trapno) {
  101d97:	8b 45 08             	mov    0x8(%ebp),%eax
  101d9a:	8b 40 30             	mov    0x30(%eax),%eax
  101d9d:	83 f8 79             	cmp    $0x79,%eax
  101da0:	0f 84 62 01 00 00    	je     101f08 <trap_dispatch+0x181>
  101da6:	83 f8 79             	cmp    $0x79,%eax
  101da9:	0f 87 43 02 00 00    	ja     101ff2 <trap_dispatch+0x26b>
  101daf:	83 f8 78             	cmp    $0x78,%eax
  101db2:	0f 84 da 00 00 00    	je     101e92 <trap_dispatch+0x10b>
  101db8:	83 f8 78             	cmp    $0x78,%eax
  101dbb:	0f 87 31 02 00 00    	ja     101ff2 <trap_dispatch+0x26b>
  101dc1:	83 f8 2f             	cmp    $0x2f,%eax
  101dc4:	0f 87 28 02 00 00    	ja     101ff2 <trap_dispatch+0x26b>
  101dca:	83 f8 2e             	cmp    $0x2e,%eax
  101dcd:	0f 83 54 02 00 00    	jae    102027 <trap_dispatch+0x2a0>
  101dd3:	83 f8 24             	cmp    $0x24,%eax
  101dd6:	74 68                	je     101e40 <trap_dispatch+0xb9>
  101dd8:	83 f8 24             	cmp    $0x24,%eax
  101ddb:	0f 87 11 02 00 00    	ja     101ff2 <trap_dispatch+0x26b>
  101de1:	83 f8 20             	cmp    $0x20,%eax
  101de4:	74 0a                	je     101df0 <trap_dispatch+0x69>
  101de6:	83 f8 21             	cmp    $0x21,%eax
  101de9:	74 7e                	je     101e69 <trap_dispatch+0xe2>
  101deb:	e9 02 02 00 00       	jmp    101ff2 <trap_dispatch+0x26b>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
 ticks ++;
  101df0:	a1 08 19 11 00       	mov    0x111908,%eax
  101df5:	40                   	inc    %eax
  101df6:	a3 08 19 11 00       	mov    %eax,0x111908
        if (ticks % TICK_NUM == 0) {
  101dfb:	8b 0d 08 19 11 00    	mov    0x111908,%ecx
  101e01:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101e06:	89 c8                	mov    %ecx,%eax
  101e08:	f7 e2                	mul    %edx
  101e0a:	c1 ea 05             	shr    $0x5,%edx
  101e0d:	89 d0                	mov    %edx,%eax
  101e0f:	c1 e0 02             	shl    $0x2,%eax
  101e12:	01 d0                	add    %edx,%eax
  101e14:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101e1b:	01 d0                	add    %edx,%eax
  101e1d:	c1 e0 02             	shl    $0x2,%eax
  101e20:	29 c1                	sub    %eax,%ecx
  101e22:	89 ca                	mov    %ecx,%edx
  101e24:	85 d2                	test   %edx,%edx
  101e26:	0f 85 fe 01 00 00    	jne    10202a <trap_dispatch+0x2a3>
            print_ticks();
  101e2c:	e8 d4 fa ff ff       	call   101905 <print_ticks>
ticks=0;
  101e31:	c7 05 08 19 11 00 00 	movl   $0x0,0x111908
  101e38:	00 00 00 
        }
        break;
  101e3b:	e9 ea 01 00 00       	jmp    10202a <trap_dispatch+0x2a3>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e40:	e8 66 f8 ff ff       	call   1016ab <cons_getc>
  101e45:	88 45 e3             	mov    %al,-0x1d(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e48:	0f be 55 e3          	movsbl -0x1d(%ebp),%edx
  101e4c:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  101e50:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e54:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e58:	c7 04 24 e9 3c 10 00 	movl   $0x103ce9,(%esp)
  101e5f:	e8 29 e4 ff ff       	call   10028d <cprintf>
        break;
  101e64:	e9 c8 01 00 00       	jmp    102031 <trap_dispatch+0x2aa>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e69:	e8 3d f8 ff ff       	call   1016ab <cons_getc>
  101e6e:	88 45 e3             	mov    %al,-0x1d(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e71:	0f be 55 e3          	movsbl -0x1d(%ebp),%edx
  101e75:	0f be 45 e3          	movsbl -0x1d(%ebp),%eax
  101e79:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e7d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e81:	c7 04 24 fb 3c 10 00 	movl   $0x103cfb,(%esp)
  101e88:	e8 00 e4 ff ff       	call   10028d <cprintf>
        break;
  101e8d:	e9 9f 01 00 00       	jmp    102031 <trap_dispatch+0x2aa>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) { //要保证自己再对应的模式中
  101e92:	8b 45 08             	mov    0x8(%ebp),%eax
  101e95:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e99:	83 f8 1b             	cmp    $0x1b,%eax
  101e9c:	0f 84 8b 01 00 00    	je     10202d <trap_dispatch+0x2a6>
            struct trapframe trap_temp = *tf; //临时栈
  101ea2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  101ea5:	b8 4c 00 00 00       	mov    $0x4c,%eax
  101eaa:	83 e0 fc             	and    $0xfffffffc,%eax
  101ead:	89 c3                	mov    %eax,%ebx
  101eaf:	b8 00 00 00 00       	mov    $0x0,%eax
  101eb4:	8b 14 01             	mov    (%ecx,%eax,1),%edx
  101eb7:	89 94 05 64 ff ff ff 	mov    %edx,-0x9c(%ebp,%eax,1)
  101ebe:	83 c0 04             	add    $0x4,%eax
  101ec1:	39 d8                	cmp    %ebx,%eax
  101ec3:	72 ef                	jb     101eb4 <trap_dispatch+0x12d>
            trap_temp.tf_cs=USER_CS;//更改代码段
  101ec5:	66 c7 45 a0 1b 00    	movw   $0x1b,-0x60(%ebp)
            trap_temp.tf_ds=trap_temp.tf_es=trap_temp.tf_ss=USER_DS;//更改数据段
  101ecb:	66 c7 45 ac 23 00    	movw   $0x23,-0x54(%ebp)
  101ed1:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
  101ed5:	66 89 45 8c          	mov    %ax,-0x74(%ebp)
  101ed9:	0f b7 45 8c          	movzwl -0x74(%ebp),%eax
  101edd:	66 89 45 90          	mov    %ax,-0x70(%ebp)
            trap_temp.tf_esp=(uint32_t)tf+sizeof(struct trapframe)-8;//更改ESP
  101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee4:	83 c0 44             	add    $0x44,%eax
  101ee7:	89 45 a8             	mov    %eax,-0x58(%ebp)
            trap_temp.tf_eflags|=FL_IOPL_MASK;//更改EFLAGS,不然在转换时会发生IO权限异常
  101eea:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  101eed:	0d 00 30 00 00       	or     $0x3000,%eax
  101ef2:	89 45 a4             	mov    %eax,-0x5c(%ebp)
            *((uint32_t*)tf-1)=&trap_temp;//因为从内核栈切换到用户栈,所以修改栈顶地址
  101ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef8:	8d 50 fc             	lea    -0x4(%eax),%edx
  101efb:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
  101f01:	89 02                	mov    %eax,(%edx)
        }
        break;
  101f03:	e9 25 01 00 00       	jmp    10202d <trap_dispatch+0x2a6>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101f08:	8b 45 08             	mov    0x8(%ebp),%eax
  101f0b:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f0f:	83 f8 08             	cmp    $0x8,%eax
  101f12:	0f 84 18 01 00 00    	je     102030 <trap_dispatch+0x2a9>
            tf->tf_cs = KERNEL_CS;
  101f18:	8b 45 08             	mov    0x8(%ebp),%eax
  101f1b:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101f21:	8b 45 08             	mov    0x8(%ebp),%eax
  101f24:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f2d:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101f31:	8b 45 08             	mov    0x8(%ebp),%eax
  101f34:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101f38:	8b 45 08             	mov    0x8(%ebp),%eax
  101f3b:	8b 40 40             	mov    0x40(%eax),%eax
  101f3e:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101f43:	89 c2                	mov    %eax,%edx
  101f45:	8b 45 08             	mov    0x8(%ebp),%eax
  101f48:	89 50 40             	mov    %edx,0x40(%eax)
            int offset = tf->tf_esp - (sizeof(struct trapframe)-8); //修改后少了esp和ss需要进行偏移
  101f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f4e:	8b 40 44             	mov    0x44(%eax),%eax
  101f51:	83 e8 44             	sub    $0x44,%eax
  101f54:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            __memmove(offset,tf,sizeof(struct trapframe)-8);
  101f57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101f5a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  101f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  101f60:	89 45 d8             	mov    %eax,-0x28(%ebp)
  101f63:	c7 45 d4 44 00 00 00 	movl   $0x44,-0x2c(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  101f6a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101f6d:	3b 45 d8             	cmp    -0x28(%ebp),%eax
  101f70:	73 3f                	jae    101fb1 <trap_dispatch+0x22a>
  101f72:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101f75:	89 45 d0             	mov    %eax,-0x30(%ebp)
  101f78:	8b 45 d8             	mov    -0x28(%ebp),%eax
  101f7b:	89 45 cc             	mov    %eax,-0x34(%ebp)
  101f7e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101f81:	89 45 c8             	mov    %eax,-0x38(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  101f84:	8b 45 c8             	mov    -0x38(%ebp),%eax
  101f87:	c1 e8 02             	shr    $0x2,%eax
  101f8a:	89 c1                	mov    %eax,%ecx
    asm volatile (
  101f8c:	8b 55 d0             	mov    -0x30(%ebp),%edx
  101f8f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  101f92:	89 d7                	mov    %edx,%edi
  101f94:	89 c6                	mov    %eax,%esi
  101f96:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  101f98:	8b 4d c8             	mov    -0x38(%ebp),%ecx
  101f9b:	83 e1 03             	and    $0x3,%ecx
  101f9e:	74 02                	je     101fa2 <trap_dispatch+0x21b>
  101fa0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  101fa2:	89 f0                	mov    %esi,%eax
  101fa4:	89 fa                	mov    %edi,%edx
  101fa6:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  101fa9:	89 55 c0             	mov    %edx,-0x40(%ebp)
  101fac:	89 45 bc             	mov    %eax,-0x44(%ebp)
        return __memcpy(dst, src, n);
  101faf:	eb 34                	jmp    101fe5 <trap_dispatch+0x25e>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  101fb1:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101fb4:	8d 50 ff             	lea    -0x1(%eax),%edx
  101fb7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  101fba:	01 c2                	add    %eax,%edx
  101fbc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101fbf:	8d 48 ff             	lea    -0x1(%eax),%ecx
  101fc2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  101fc5:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  101fc8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  101fcb:	89 c1                	mov    %eax,%ecx
  101fcd:	89 d8                	mov    %ebx,%eax
  101fcf:	89 d6                	mov    %edx,%esi
  101fd1:	89 c7                	mov    %eax,%edi
  101fd3:	fd                   	std    
  101fd4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  101fd6:	fc                   	cld    
  101fd7:	89 f8                	mov    %edi,%eax
  101fd9:	89 f2                	mov    %esi,%edx
  101fdb:	89 4d b8             	mov    %ecx,-0x48(%ebp)
  101fde:	89 55 b4             	mov    %edx,-0x4c(%ebp)
  101fe1:	89 45 b0             	mov    %eax,-0x50(%ebp)
    return dst;
  101fe4:	90                   	nop
            *((uint32_t*)tf-1)=offset; //重新设置栈帧地址
  101fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  101fe8:	8d 50 fc             	lea    -0x4(%eax),%edx
  101feb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  101fee:	89 02                	mov    %eax,(%edx)
        }
        break;
  101ff0:	eb 3e                	jmp    102030 <trap_dispatch+0x2a9>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101ff2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ff5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ff9:	83 e0 03             	and    $0x3,%eax
  101ffc:	85 c0                	test   %eax,%eax
  101ffe:	75 31                	jne    102031 <trap_dispatch+0x2aa>
            print_trapframe(tf);
  102000:	8b 45 08             	mov    0x8(%ebp),%eax
  102003:	89 04 24             	mov    %eax,(%esp)
  102006:	e8 0b fb ff ff       	call   101b16 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  10200b:	c7 44 24 08 0a 3d 10 	movl   $0x103d0a,0x8(%esp)
  102012:	00 
  102013:	c7 44 24 04 bf 00 00 	movl   $0xbf,0x4(%esp)
  10201a:	00 
  10201b:	c7 04 24 2e 3b 10 00 	movl   $0x103b2e,(%esp)
  102022:	e8 d2 e3 ff ff       	call   1003f9 <__panic>
        break;
  102027:	90                   	nop
  102028:	eb 07                	jmp    102031 <trap_dispatch+0x2aa>
        break;
  10202a:	90                   	nop
  10202b:	eb 04                	jmp    102031 <trap_dispatch+0x2aa>
        break;
  10202d:	90                   	nop
  10202e:	eb 01                	jmp    102031 <trap_dispatch+0x2aa>
        break;
  102030:	90                   	nop
        }
    }
}
  102031:	90                   	nop
  102032:	81 c4 ac 00 00 00    	add    $0xac,%esp
  102038:	5b                   	pop    %ebx
  102039:	5e                   	pop    %esi
  10203a:	5f                   	pop    %edi
  10203b:	5d                   	pop    %ebp
  10203c:	c3                   	ret    

0010203d <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  10203d:	f3 0f 1e fb          	endbr32 
  102041:	55                   	push   %ebp
  102042:	89 e5                	mov    %esp,%ebp
  102044:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  102047:	8b 45 08             	mov    0x8(%ebp),%eax
  10204a:	89 04 24             	mov    %eax,(%esp)
  10204d:	e8 35 fd ff ff       	call   101d87 <trap_dispatch>
}
  102052:	90                   	nop
  102053:	c9                   	leave  
  102054:	c3                   	ret    

00102055 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  102055:	6a 00                	push   $0x0
  pushl $0
  102057:	6a 00                	push   $0x0
  jmp __alltraps
  102059:	e9 69 0a 00 00       	jmp    102ac7 <__alltraps>

0010205e <vector1>:
.globl vector1
vector1:
  pushl $0
  10205e:	6a 00                	push   $0x0
  pushl $1
  102060:	6a 01                	push   $0x1
  jmp __alltraps
  102062:	e9 60 0a 00 00       	jmp    102ac7 <__alltraps>

00102067 <vector2>:
.globl vector2
vector2:
  pushl $0
  102067:	6a 00                	push   $0x0
  pushl $2
  102069:	6a 02                	push   $0x2
  jmp __alltraps
  10206b:	e9 57 0a 00 00       	jmp    102ac7 <__alltraps>

00102070 <vector3>:
.globl vector3
vector3:
  pushl $0
  102070:	6a 00                	push   $0x0
  pushl $3
  102072:	6a 03                	push   $0x3
  jmp __alltraps
  102074:	e9 4e 0a 00 00       	jmp    102ac7 <__alltraps>

00102079 <vector4>:
.globl vector4
vector4:
  pushl $0
  102079:	6a 00                	push   $0x0
  pushl $4
  10207b:	6a 04                	push   $0x4
  jmp __alltraps
  10207d:	e9 45 0a 00 00       	jmp    102ac7 <__alltraps>

00102082 <vector5>:
.globl vector5
vector5:
  pushl $0
  102082:	6a 00                	push   $0x0
  pushl $5
  102084:	6a 05                	push   $0x5
  jmp __alltraps
  102086:	e9 3c 0a 00 00       	jmp    102ac7 <__alltraps>

0010208b <vector6>:
.globl vector6
vector6:
  pushl $0
  10208b:	6a 00                	push   $0x0
  pushl $6
  10208d:	6a 06                	push   $0x6
  jmp __alltraps
  10208f:	e9 33 0a 00 00       	jmp    102ac7 <__alltraps>

00102094 <vector7>:
.globl vector7
vector7:
  pushl $0
  102094:	6a 00                	push   $0x0
  pushl $7
  102096:	6a 07                	push   $0x7
  jmp __alltraps
  102098:	e9 2a 0a 00 00       	jmp    102ac7 <__alltraps>

0010209d <vector8>:
.globl vector8
vector8:
  pushl $8
  10209d:	6a 08                	push   $0x8
  jmp __alltraps
  10209f:	e9 23 0a 00 00       	jmp    102ac7 <__alltraps>

001020a4 <vector9>:
.globl vector9
vector9:
  pushl $0
  1020a4:	6a 00                	push   $0x0
  pushl $9
  1020a6:	6a 09                	push   $0x9
  jmp __alltraps
  1020a8:	e9 1a 0a 00 00       	jmp    102ac7 <__alltraps>

001020ad <vector10>:
.globl vector10
vector10:
  pushl $10
  1020ad:	6a 0a                	push   $0xa
  jmp __alltraps
  1020af:	e9 13 0a 00 00       	jmp    102ac7 <__alltraps>

001020b4 <vector11>:
.globl vector11
vector11:
  pushl $11
  1020b4:	6a 0b                	push   $0xb
  jmp __alltraps
  1020b6:	e9 0c 0a 00 00       	jmp    102ac7 <__alltraps>

001020bb <vector12>:
.globl vector12
vector12:
  pushl $12
  1020bb:	6a 0c                	push   $0xc
  jmp __alltraps
  1020bd:	e9 05 0a 00 00       	jmp    102ac7 <__alltraps>

001020c2 <vector13>:
.globl vector13
vector13:
  pushl $13
  1020c2:	6a 0d                	push   $0xd
  jmp __alltraps
  1020c4:	e9 fe 09 00 00       	jmp    102ac7 <__alltraps>

001020c9 <vector14>:
.globl vector14
vector14:
  pushl $14
  1020c9:	6a 0e                	push   $0xe
  jmp __alltraps
  1020cb:	e9 f7 09 00 00       	jmp    102ac7 <__alltraps>

001020d0 <vector15>:
.globl vector15
vector15:
  pushl $0
  1020d0:	6a 00                	push   $0x0
  pushl $15
  1020d2:	6a 0f                	push   $0xf
  jmp __alltraps
  1020d4:	e9 ee 09 00 00       	jmp    102ac7 <__alltraps>

001020d9 <vector16>:
.globl vector16
vector16:
  pushl $0
  1020d9:	6a 00                	push   $0x0
  pushl $16
  1020db:	6a 10                	push   $0x10
  jmp __alltraps
  1020dd:	e9 e5 09 00 00       	jmp    102ac7 <__alltraps>

001020e2 <vector17>:
.globl vector17
vector17:
  pushl $17
  1020e2:	6a 11                	push   $0x11
  jmp __alltraps
  1020e4:	e9 de 09 00 00       	jmp    102ac7 <__alltraps>

001020e9 <vector18>:
.globl vector18
vector18:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $18
  1020eb:	6a 12                	push   $0x12
  jmp __alltraps
  1020ed:	e9 d5 09 00 00       	jmp    102ac7 <__alltraps>

001020f2 <vector19>:
.globl vector19
vector19:
  pushl $0
  1020f2:	6a 00                	push   $0x0
  pushl $19
  1020f4:	6a 13                	push   $0x13
  jmp __alltraps
  1020f6:	e9 cc 09 00 00       	jmp    102ac7 <__alltraps>

001020fb <vector20>:
.globl vector20
vector20:
  pushl $0
  1020fb:	6a 00                	push   $0x0
  pushl $20
  1020fd:	6a 14                	push   $0x14
  jmp __alltraps
  1020ff:	e9 c3 09 00 00       	jmp    102ac7 <__alltraps>

00102104 <vector21>:
.globl vector21
vector21:
  pushl $0
  102104:	6a 00                	push   $0x0
  pushl $21
  102106:	6a 15                	push   $0x15
  jmp __alltraps
  102108:	e9 ba 09 00 00       	jmp    102ac7 <__alltraps>

0010210d <vector22>:
.globl vector22
vector22:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $22
  10210f:	6a 16                	push   $0x16
  jmp __alltraps
  102111:	e9 b1 09 00 00       	jmp    102ac7 <__alltraps>

00102116 <vector23>:
.globl vector23
vector23:
  pushl $0
  102116:	6a 00                	push   $0x0
  pushl $23
  102118:	6a 17                	push   $0x17
  jmp __alltraps
  10211a:	e9 a8 09 00 00       	jmp    102ac7 <__alltraps>

0010211f <vector24>:
.globl vector24
vector24:
  pushl $0
  10211f:	6a 00                	push   $0x0
  pushl $24
  102121:	6a 18                	push   $0x18
  jmp __alltraps
  102123:	e9 9f 09 00 00       	jmp    102ac7 <__alltraps>

00102128 <vector25>:
.globl vector25
vector25:
  pushl $0
  102128:	6a 00                	push   $0x0
  pushl $25
  10212a:	6a 19                	push   $0x19
  jmp __alltraps
  10212c:	e9 96 09 00 00       	jmp    102ac7 <__alltraps>

00102131 <vector26>:
.globl vector26
vector26:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $26
  102133:	6a 1a                	push   $0x1a
  jmp __alltraps
  102135:	e9 8d 09 00 00       	jmp    102ac7 <__alltraps>

0010213a <vector27>:
.globl vector27
vector27:
  pushl $0
  10213a:	6a 00                	push   $0x0
  pushl $27
  10213c:	6a 1b                	push   $0x1b
  jmp __alltraps
  10213e:	e9 84 09 00 00       	jmp    102ac7 <__alltraps>

00102143 <vector28>:
.globl vector28
vector28:
  pushl $0
  102143:	6a 00                	push   $0x0
  pushl $28
  102145:	6a 1c                	push   $0x1c
  jmp __alltraps
  102147:	e9 7b 09 00 00       	jmp    102ac7 <__alltraps>

0010214c <vector29>:
.globl vector29
vector29:
  pushl $0
  10214c:	6a 00                	push   $0x0
  pushl $29
  10214e:	6a 1d                	push   $0x1d
  jmp __alltraps
  102150:	e9 72 09 00 00       	jmp    102ac7 <__alltraps>

00102155 <vector30>:
.globl vector30
vector30:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $30
  102157:	6a 1e                	push   $0x1e
  jmp __alltraps
  102159:	e9 69 09 00 00       	jmp    102ac7 <__alltraps>

0010215e <vector31>:
.globl vector31
vector31:
  pushl $0
  10215e:	6a 00                	push   $0x0
  pushl $31
  102160:	6a 1f                	push   $0x1f
  jmp __alltraps
  102162:	e9 60 09 00 00       	jmp    102ac7 <__alltraps>

00102167 <vector32>:
.globl vector32
vector32:
  pushl $0
  102167:	6a 00                	push   $0x0
  pushl $32
  102169:	6a 20                	push   $0x20
  jmp __alltraps
  10216b:	e9 57 09 00 00       	jmp    102ac7 <__alltraps>

00102170 <vector33>:
.globl vector33
vector33:
  pushl $0
  102170:	6a 00                	push   $0x0
  pushl $33
  102172:	6a 21                	push   $0x21
  jmp __alltraps
  102174:	e9 4e 09 00 00       	jmp    102ac7 <__alltraps>

00102179 <vector34>:
.globl vector34
vector34:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $34
  10217b:	6a 22                	push   $0x22
  jmp __alltraps
  10217d:	e9 45 09 00 00       	jmp    102ac7 <__alltraps>

00102182 <vector35>:
.globl vector35
vector35:
  pushl $0
  102182:	6a 00                	push   $0x0
  pushl $35
  102184:	6a 23                	push   $0x23
  jmp __alltraps
  102186:	e9 3c 09 00 00       	jmp    102ac7 <__alltraps>

0010218b <vector36>:
.globl vector36
vector36:
  pushl $0
  10218b:	6a 00                	push   $0x0
  pushl $36
  10218d:	6a 24                	push   $0x24
  jmp __alltraps
  10218f:	e9 33 09 00 00       	jmp    102ac7 <__alltraps>

00102194 <vector37>:
.globl vector37
vector37:
  pushl $0
  102194:	6a 00                	push   $0x0
  pushl $37
  102196:	6a 25                	push   $0x25
  jmp __alltraps
  102198:	e9 2a 09 00 00       	jmp    102ac7 <__alltraps>

0010219d <vector38>:
.globl vector38
vector38:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $38
  10219f:	6a 26                	push   $0x26
  jmp __alltraps
  1021a1:	e9 21 09 00 00       	jmp    102ac7 <__alltraps>

001021a6 <vector39>:
.globl vector39
vector39:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $39
  1021a8:	6a 27                	push   $0x27
  jmp __alltraps
  1021aa:	e9 18 09 00 00       	jmp    102ac7 <__alltraps>

001021af <vector40>:
.globl vector40
vector40:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $40
  1021b1:	6a 28                	push   $0x28
  jmp __alltraps
  1021b3:	e9 0f 09 00 00       	jmp    102ac7 <__alltraps>

001021b8 <vector41>:
.globl vector41
vector41:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $41
  1021ba:	6a 29                	push   $0x29
  jmp __alltraps
  1021bc:	e9 06 09 00 00       	jmp    102ac7 <__alltraps>

001021c1 <vector42>:
.globl vector42
vector42:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $42
  1021c3:	6a 2a                	push   $0x2a
  jmp __alltraps
  1021c5:	e9 fd 08 00 00       	jmp    102ac7 <__alltraps>

001021ca <vector43>:
.globl vector43
vector43:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $43
  1021cc:	6a 2b                	push   $0x2b
  jmp __alltraps
  1021ce:	e9 f4 08 00 00       	jmp    102ac7 <__alltraps>

001021d3 <vector44>:
.globl vector44
vector44:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $44
  1021d5:	6a 2c                	push   $0x2c
  jmp __alltraps
  1021d7:	e9 eb 08 00 00       	jmp    102ac7 <__alltraps>

001021dc <vector45>:
.globl vector45
vector45:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $45
  1021de:	6a 2d                	push   $0x2d
  jmp __alltraps
  1021e0:	e9 e2 08 00 00       	jmp    102ac7 <__alltraps>

001021e5 <vector46>:
.globl vector46
vector46:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $46
  1021e7:	6a 2e                	push   $0x2e
  jmp __alltraps
  1021e9:	e9 d9 08 00 00       	jmp    102ac7 <__alltraps>

001021ee <vector47>:
.globl vector47
vector47:
  pushl $0
  1021ee:	6a 00                	push   $0x0
  pushl $47
  1021f0:	6a 2f                	push   $0x2f
  jmp __alltraps
  1021f2:	e9 d0 08 00 00       	jmp    102ac7 <__alltraps>

001021f7 <vector48>:
.globl vector48
vector48:
  pushl $0
  1021f7:	6a 00                	push   $0x0
  pushl $48
  1021f9:	6a 30                	push   $0x30
  jmp __alltraps
  1021fb:	e9 c7 08 00 00       	jmp    102ac7 <__alltraps>

00102200 <vector49>:
.globl vector49
vector49:
  pushl $0
  102200:	6a 00                	push   $0x0
  pushl $49
  102202:	6a 31                	push   $0x31
  jmp __alltraps
  102204:	e9 be 08 00 00       	jmp    102ac7 <__alltraps>

00102209 <vector50>:
.globl vector50
vector50:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $50
  10220b:	6a 32                	push   $0x32
  jmp __alltraps
  10220d:	e9 b5 08 00 00       	jmp    102ac7 <__alltraps>

00102212 <vector51>:
.globl vector51
vector51:
  pushl $0
  102212:	6a 00                	push   $0x0
  pushl $51
  102214:	6a 33                	push   $0x33
  jmp __alltraps
  102216:	e9 ac 08 00 00       	jmp    102ac7 <__alltraps>

0010221b <vector52>:
.globl vector52
vector52:
  pushl $0
  10221b:	6a 00                	push   $0x0
  pushl $52
  10221d:	6a 34                	push   $0x34
  jmp __alltraps
  10221f:	e9 a3 08 00 00       	jmp    102ac7 <__alltraps>

00102224 <vector53>:
.globl vector53
vector53:
  pushl $0
  102224:	6a 00                	push   $0x0
  pushl $53
  102226:	6a 35                	push   $0x35
  jmp __alltraps
  102228:	e9 9a 08 00 00       	jmp    102ac7 <__alltraps>

0010222d <vector54>:
.globl vector54
vector54:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $54
  10222f:	6a 36                	push   $0x36
  jmp __alltraps
  102231:	e9 91 08 00 00       	jmp    102ac7 <__alltraps>

00102236 <vector55>:
.globl vector55
vector55:
  pushl $0
  102236:	6a 00                	push   $0x0
  pushl $55
  102238:	6a 37                	push   $0x37
  jmp __alltraps
  10223a:	e9 88 08 00 00       	jmp    102ac7 <__alltraps>

0010223f <vector56>:
.globl vector56
vector56:
  pushl $0
  10223f:	6a 00                	push   $0x0
  pushl $56
  102241:	6a 38                	push   $0x38
  jmp __alltraps
  102243:	e9 7f 08 00 00       	jmp    102ac7 <__alltraps>

00102248 <vector57>:
.globl vector57
vector57:
  pushl $0
  102248:	6a 00                	push   $0x0
  pushl $57
  10224a:	6a 39                	push   $0x39
  jmp __alltraps
  10224c:	e9 76 08 00 00       	jmp    102ac7 <__alltraps>

00102251 <vector58>:
.globl vector58
vector58:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $58
  102253:	6a 3a                	push   $0x3a
  jmp __alltraps
  102255:	e9 6d 08 00 00       	jmp    102ac7 <__alltraps>

0010225a <vector59>:
.globl vector59
vector59:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $59
  10225c:	6a 3b                	push   $0x3b
  jmp __alltraps
  10225e:	e9 64 08 00 00       	jmp    102ac7 <__alltraps>

00102263 <vector60>:
.globl vector60
vector60:
  pushl $0
  102263:	6a 00                	push   $0x0
  pushl $60
  102265:	6a 3c                	push   $0x3c
  jmp __alltraps
  102267:	e9 5b 08 00 00       	jmp    102ac7 <__alltraps>

0010226c <vector61>:
.globl vector61
vector61:
  pushl $0
  10226c:	6a 00                	push   $0x0
  pushl $61
  10226e:	6a 3d                	push   $0x3d
  jmp __alltraps
  102270:	e9 52 08 00 00       	jmp    102ac7 <__alltraps>

00102275 <vector62>:
.globl vector62
vector62:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $62
  102277:	6a 3e                	push   $0x3e
  jmp __alltraps
  102279:	e9 49 08 00 00       	jmp    102ac7 <__alltraps>

0010227e <vector63>:
.globl vector63
vector63:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $63
  102280:	6a 3f                	push   $0x3f
  jmp __alltraps
  102282:	e9 40 08 00 00       	jmp    102ac7 <__alltraps>

00102287 <vector64>:
.globl vector64
vector64:
  pushl $0
  102287:	6a 00                	push   $0x0
  pushl $64
  102289:	6a 40                	push   $0x40
  jmp __alltraps
  10228b:	e9 37 08 00 00       	jmp    102ac7 <__alltraps>

00102290 <vector65>:
.globl vector65
vector65:
  pushl $0
  102290:	6a 00                	push   $0x0
  pushl $65
  102292:	6a 41                	push   $0x41
  jmp __alltraps
  102294:	e9 2e 08 00 00       	jmp    102ac7 <__alltraps>

00102299 <vector66>:
.globl vector66
vector66:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $66
  10229b:	6a 42                	push   $0x42
  jmp __alltraps
  10229d:	e9 25 08 00 00       	jmp    102ac7 <__alltraps>

001022a2 <vector67>:
.globl vector67
vector67:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $67
  1022a4:	6a 43                	push   $0x43
  jmp __alltraps
  1022a6:	e9 1c 08 00 00       	jmp    102ac7 <__alltraps>

001022ab <vector68>:
.globl vector68
vector68:
  pushl $0
  1022ab:	6a 00                	push   $0x0
  pushl $68
  1022ad:	6a 44                	push   $0x44
  jmp __alltraps
  1022af:	e9 13 08 00 00       	jmp    102ac7 <__alltraps>

001022b4 <vector69>:
.globl vector69
vector69:
  pushl $0
  1022b4:	6a 00                	push   $0x0
  pushl $69
  1022b6:	6a 45                	push   $0x45
  jmp __alltraps
  1022b8:	e9 0a 08 00 00       	jmp    102ac7 <__alltraps>

001022bd <vector70>:
.globl vector70
vector70:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $70
  1022bf:	6a 46                	push   $0x46
  jmp __alltraps
  1022c1:	e9 01 08 00 00       	jmp    102ac7 <__alltraps>

001022c6 <vector71>:
.globl vector71
vector71:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $71
  1022c8:	6a 47                	push   $0x47
  jmp __alltraps
  1022ca:	e9 f8 07 00 00       	jmp    102ac7 <__alltraps>

001022cf <vector72>:
.globl vector72
vector72:
  pushl $0
  1022cf:	6a 00                	push   $0x0
  pushl $72
  1022d1:	6a 48                	push   $0x48
  jmp __alltraps
  1022d3:	e9 ef 07 00 00       	jmp    102ac7 <__alltraps>

001022d8 <vector73>:
.globl vector73
vector73:
  pushl $0
  1022d8:	6a 00                	push   $0x0
  pushl $73
  1022da:	6a 49                	push   $0x49
  jmp __alltraps
  1022dc:	e9 e6 07 00 00       	jmp    102ac7 <__alltraps>

001022e1 <vector74>:
.globl vector74
vector74:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $74
  1022e3:	6a 4a                	push   $0x4a
  jmp __alltraps
  1022e5:	e9 dd 07 00 00       	jmp    102ac7 <__alltraps>

001022ea <vector75>:
.globl vector75
vector75:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $75
  1022ec:	6a 4b                	push   $0x4b
  jmp __alltraps
  1022ee:	e9 d4 07 00 00       	jmp    102ac7 <__alltraps>

001022f3 <vector76>:
.globl vector76
vector76:
  pushl $0
  1022f3:	6a 00                	push   $0x0
  pushl $76
  1022f5:	6a 4c                	push   $0x4c
  jmp __alltraps
  1022f7:	e9 cb 07 00 00       	jmp    102ac7 <__alltraps>

001022fc <vector77>:
.globl vector77
vector77:
  pushl $0
  1022fc:	6a 00                	push   $0x0
  pushl $77
  1022fe:	6a 4d                	push   $0x4d
  jmp __alltraps
  102300:	e9 c2 07 00 00       	jmp    102ac7 <__alltraps>

00102305 <vector78>:
.globl vector78
vector78:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $78
  102307:	6a 4e                	push   $0x4e
  jmp __alltraps
  102309:	e9 b9 07 00 00       	jmp    102ac7 <__alltraps>

0010230e <vector79>:
.globl vector79
vector79:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $79
  102310:	6a 4f                	push   $0x4f
  jmp __alltraps
  102312:	e9 b0 07 00 00       	jmp    102ac7 <__alltraps>

00102317 <vector80>:
.globl vector80
vector80:
  pushl $0
  102317:	6a 00                	push   $0x0
  pushl $80
  102319:	6a 50                	push   $0x50
  jmp __alltraps
  10231b:	e9 a7 07 00 00       	jmp    102ac7 <__alltraps>

00102320 <vector81>:
.globl vector81
vector81:
  pushl $0
  102320:	6a 00                	push   $0x0
  pushl $81
  102322:	6a 51                	push   $0x51
  jmp __alltraps
  102324:	e9 9e 07 00 00       	jmp    102ac7 <__alltraps>

00102329 <vector82>:
.globl vector82
vector82:
  pushl $0
  102329:	6a 00                	push   $0x0
  pushl $82
  10232b:	6a 52                	push   $0x52
  jmp __alltraps
  10232d:	e9 95 07 00 00       	jmp    102ac7 <__alltraps>

00102332 <vector83>:
.globl vector83
vector83:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $83
  102334:	6a 53                	push   $0x53
  jmp __alltraps
  102336:	e9 8c 07 00 00       	jmp    102ac7 <__alltraps>

0010233b <vector84>:
.globl vector84
vector84:
  pushl $0
  10233b:	6a 00                	push   $0x0
  pushl $84
  10233d:	6a 54                	push   $0x54
  jmp __alltraps
  10233f:	e9 83 07 00 00       	jmp    102ac7 <__alltraps>

00102344 <vector85>:
.globl vector85
vector85:
  pushl $0
  102344:	6a 00                	push   $0x0
  pushl $85
  102346:	6a 55                	push   $0x55
  jmp __alltraps
  102348:	e9 7a 07 00 00       	jmp    102ac7 <__alltraps>

0010234d <vector86>:
.globl vector86
vector86:
  pushl $0
  10234d:	6a 00                	push   $0x0
  pushl $86
  10234f:	6a 56                	push   $0x56
  jmp __alltraps
  102351:	e9 71 07 00 00       	jmp    102ac7 <__alltraps>

00102356 <vector87>:
.globl vector87
vector87:
  pushl $0
  102356:	6a 00                	push   $0x0
  pushl $87
  102358:	6a 57                	push   $0x57
  jmp __alltraps
  10235a:	e9 68 07 00 00       	jmp    102ac7 <__alltraps>

0010235f <vector88>:
.globl vector88
vector88:
  pushl $0
  10235f:	6a 00                	push   $0x0
  pushl $88
  102361:	6a 58                	push   $0x58
  jmp __alltraps
  102363:	e9 5f 07 00 00       	jmp    102ac7 <__alltraps>

00102368 <vector89>:
.globl vector89
vector89:
  pushl $0
  102368:	6a 00                	push   $0x0
  pushl $89
  10236a:	6a 59                	push   $0x59
  jmp __alltraps
  10236c:	e9 56 07 00 00       	jmp    102ac7 <__alltraps>

00102371 <vector90>:
.globl vector90
vector90:
  pushl $0
  102371:	6a 00                	push   $0x0
  pushl $90
  102373:	6a 5a                	push   $0x5a
  jmp __alltraps
  102375:	e9 4d 07 00 00       	jmp    102ac7 <__alltraps>

0010237a <vector91>:
.globl vector91
vector91:
  pushl $0
  10237a:	6a 00                	push   $0x0
  pushl $91
  10237c:	6a 5b                	push   $0x5b
  jmp __alltraps
  10237e:	e9 44 07 00 00       	jmp    102ac7 <__alltraps>

00102383 <vector92>:
.globl vector92
vector92:
  pushl $0
  102383:	6a 00                	push   $0x0
  pushl $92
  102385:	6a 5c                	push   $0x5c
  jmp __alltraps
  102387:	e9 3b 07 00 00       	jmp    102ac7 <__alltraps>

0010238c <vector93>:
.globl vector93
vector93:
  pushl $0
  10238c:	6a 00                	push   $0x0
  pushl $93
  10238e:	6a 5d                	push   $0x5d
  jmp __alltraps
  102390:	e9 32 07 00 00       	jmp    102ac7 <__alltraps>

00102395 <vector94>:
.globl vector94
vector94:
  pushl $0
  102395:	6a 00                	push   $0x0
  pushl $94
  102397:	6a 5e                	push   $0x5e
  jmp __alltraps
  102399:	e9 29 07 00 00       	jmp    102ac7 <__alltraps>

0010239e <vector95>:
.globl vector95
vector95:
  pushl $0
  10239e:	6a 00                	push   $0x0
  pushl $95
  1023a0:	6a 5f                	push   $0x5f
  jmp __alltraps
  1023a2:	e9 20 07 00 00       	jmp    102ac7 <__alltraps>

001023a7 <vector96>:
.globl vector96
vector96:
  pushl $0
  1023a7:	6a 00                	push   $0x0
  pushl $96
  1023a9:	6a 60                	push   $0x60
  jmp __alltraps
  1023ab:	e9 17 07 00 00       	jmp    102ac7 <__alltraps>

001023b0 <vector97>:
.globl vector97
vector97:
  pushl $0
  1023b0:	6a 00                	push   $0x0
  pushl $97
  1023b2:	6a 61                	push   $0x61
  jmp __alltraps
  1023b4:	e9 0e 07 00 00       	jmp    102ac7 <__alltraps>

001023b9 <vector98>:
.globl vector98
vector98:
  pushl $0
  1023b9:	6a 00                	push   $0x0
  pushl $98
  1023bb:	6a 62                	push   $0x62
  jmp __alltraps
  1023bd:	e9 05 07 00 00       	jmp    102ac7 <__alltraps>

001023c2 <vector99>:
.globl vector99
vector99:
  pushl $0
  1023c2:	6a 00                	push   $0x0
  pushl $99
  1023c4:	6a 63                	push   $0x63
  jmp __alltraps
  1023c6:	e9 fc 06 00 00       	jmp    102ac7 <__alltraps>

001023cb <vector100>:
.globl vector100
vector100:
  pushl $0
  1023cb:	6a 00                	push   $0x0
  pushl $100
  1023cd:	6a 64                	push   $0x64
  jmp __alltraps
  1023cf:	e9 f3 06 00 00       	jmp    102ac7 <__alltraps>

001023d4 <vector101>:
.globl vector101
vector101:
  pushl $0
  1023d4:	6a 00                	push   $0x0
  pushl $101
  1023d6:	6a 65                	push   $0x65
  jmp __alltraps
  1023d8:	e9 ea 06 00 00       	jmp    102ac7 <__alltraps>

001023dd <vector102>:
.globl vector102
vector102:
  pushl $0
  1023dd:	6a 00                	push   $0x0
  pushl $102
  1023df:	6a 66                	push   $0x66
  jmp __alltraps
  1023e1:	e9 e1 06 00 00       	jmp    102ac7 <__alltraps>

001023e6 <vector103>:
.globl vector103
vector103:
  pushl $0
  1023e6:	6a 00                	push   $0x0
  pushl $103
  1023e8:	6a 67                	push   $0x67
  jmp __alltraps
  1023ea:	e9 d8 06 00 00       	jmp    102ac7 <__alltraps>

001023ef <vector104>:
.globl vector104
vector104:
  pushl $0
  1023ef:	6a 00                	push   $0x0
  pushl $104
  1023f1:	6a 68                	push   $0x68
  jmp __alltraps
  1023f3:	e9 cf 06 00 00       	jmp    102ac7 <__alltraps>

001023f8 <vector105>:
.globl vector105
vector105:
  pushl $0
  1023f8:	6a 00                	push   $0x0
  pushl $105
  1023fa:	6a 69                	push   $0x69
  jmp __alltraps
  1023fc:	e9 c6 06 00 00       	jmp    102ac7 <__alltraps>

00102401 <vector106>:
.globl vector106
vector106:
  pushl $0
  102401:	6a 00                	push   $0x0
  pushl $106
  102403:	6a 6a                	push   $0x6a
  jmp __alltraps
  102405:	e9 bd 06 00 00       	jmp    102ac7 <__alltraps>

0010240a <vector107>:
.globl vector107
vector107:
  pushl $0
  10240a:	6a 00                	push   $0x0
  pushl $107
  10240c:	6a 6b                	push   $0x6b
  jmp __alltraps
  10240e:	e9 b4 06 00 00       	jmp    102ac7 <__alltraps>

00102413 <vector108>:
.globl vector108
vector108:
  pushl $0
  102413:	6a 00                	push   $0x0
  pushl $108
  102415:	6a 6c                	push   $0x6c
  jmp __alltraps
  102417:	e9 ab 06 00 00       	jmp    102ac7 <__alltraps>

0010241c <vector109>:
.globl vector109
vector109:
  pushl $0
  10241c:	6a 00                	push   $0x0
  pushl $109
  10241e:	6a 6d                	push   $0x6d
  jmp __alltraps
  102420:	e9 a2 06 00 00       	jmp    102ac7 <__alltraps>

00102425 <vector110>:
.globl vector110
vector110:
  pushl $0
  102425:	6a 00                	push   $0x0
  pushl $110
  102427:	6a 6e                	push   $0x6e
  jmp __alltraps
  102429:	e9 99 06 00 00       	jmp    102ac7 <__alltraps>

0010242e <vector111>:
.globl vector111
vector111:
  pushl $0
  10242e:	6a 00                	push   $0x0
  pushl $111
  102430:	6a 6f                	push   $0x6f
  jmp __alltraps
  102432:	e9 90 06 00 00       	jmp    102ac7 <__alltraps>

00102437 <vector112>:
.globl vector112
vector112:
  pushl $0
  102437:	6a 00                	push   $0x0
  pushl $112
  102439:	6a 70                	push   $0x70
  jmp __alltraps
  10243b:	e9 87 06 00 00       	jmp    102ac7 <__alltraps>

00102440 <vector113>:
.globl vector113
vector113:
  pushl $0
  102440:	6a 00                	push   $0x0
  pushl $113
  102442:	6a 71                	push   $0x71
  jmp __alltraps
  102444:	e9 7e 06 00 00       	jmp    102ac7 <__alltraps>

00102449 <vector114>:
.globl vector114
vector114:
  pushl $0
  102449:	6a 00                	push   $0x0
  pushl $114
  10244b:	6a 72                	push   $0x72
  jmp __alltraps
  10244d:	e9 75 06 00 00       	jmp    102ac7 <__alltraps>

00102452 <vector115>:
.globl vector115
vector115:
  pushl $0
  102452:	6a 00                	push   $0x0
  pushl $115
  102454:	6a 73                	push   $0x73
  jmp __alltraps
  102456:	e9 6c 06 00 00       	jmp    102ac7 <__alltraps>

0010245b <vector116>:
.globl vector116
vector116:
  pushl $0
  10245b:	6a 00                	push   $0x0
  pushl $116
  10245d:	6a 74                	push   $0x74
  jmp __alltraps
  10245f:	e9 63 06 00 00       	jmp    102ac7 <__alltraps>

00102464 <vector117>:
.globl vector117
vector117:
  pushl $0
  102464:	6a 00                	push   $0x0
  pushl $117
  102466:	6a 75                	push   $0x75
  jmp __alltraps
  102468:	e9 5a 06 00 00       	jmp    102ac7 <__alltraps>

0010246d <vector118>:
.globl vector118
vector118:
  pushl $0
  10246d:	6a 00                	push   $0x0
  pushl $118
  10246f:	6a 76                	push   $0x76
  jmp __alltraps
  102471:	e9 51 06 00 00       	jmp    102ac7 <__alltraps>

00102476 <vector119>:
.globl vector119
vector119:
  pushl $0
  102476:	6a 00                	push   $0x0
  pushl $119
  102478:	6a 77                	push   $0x77
  jmp __alltraps
  10247a:	e9 48 06 00 00       	jmp    102ac7 <__alltraps>

0010247f <vector120>:
.globl vector120
vector120:
  pushl $0
  10247f:	6a 00                	push   $0x0
  pushl $120
  102481:	6a 78                	push   $0x78
  jmp __alltraps
  102483:	e9 3f 06 00 00       	jmp    102ac7 <__alltraps>

00102488 <vector121>:
.globl vector121
vector121:
  pushl $0
  102488:	6a 00                	push   $0x0
  pushl $121
  10248a:	6a 79                	push   $0x79
  jmp __alltraps
  10248c:	e9 36 06 00 00       	jmp    102ac7 <__alltraps>

00102491 <vector122>:
.globl vector122
vector122:
  pushl $0
  102491:	6a 00                	push   $0x0
  pushl $122
  102493:	6a 7a                	push   $0x7a
  jmp __alltraps
  102495:	e9 2d 06 00 00       	jmp    102ac7 <__alltraps>

0010249a <vector123>:
.globl vector123
vector123:
  pushl $0
  10249a:	6a 00                	push   $0x0
  pushl $123
  10249c:	6a 7b                	push   $0x7b
  jmp __alltraps
  10249e:	e9 24 06 00 00       	jmp    102ac7 <__alltraps>

001024a3 <vector124>:
.globl vector124
vector124:
  pushl $0
  1024a3:	6a 00                	push   $0x0
  pushl $124
  1024a5:	6a 7c                	push   $0x7c
  jmp __alltraps
  1024a7:	e9 1b 06 00 00       	jmp    102ac7 <__alltraps>

001024ac <vector125>:
.globl vector125
vector125:
  pushl $0
  1024ac:	6a 00                	push   $0x0
  pushl $125
  1024ae:	6a 7d                	push   $0x7d
  jmp __alltraps
  1024b0:	e9 12 06 00 00       	jmp    102ac7 <__alltraps>

001024b5 <vector126>:
.globl vector126
vector126:
  pushl $0
  1024b5:	6a 00                	push   $0x0
  pushl $126
  1024b7:	6a 7e                	push   $0x7e
  jmp __alltraps
  1024b9:	e9 09 06 00 00       	jmp    102ac7 <__alltraps>

001024be <vector127>:
.globl vector127
vector127:
  pushl $0
  1024be:	6a 00                	push   $0x0
  pushl $127
  1024c0:	6a 7f                	push   $0x7f
  jmp __alltraps
  1024c2:	e9 00 06 00 00       	jmp    102ac7 <__alltraps>

001024c7 <vector128>:
.globl vector128
vector128:
  pushl $0
  1024c7:	6a 00                	push   $0x0
  pushl $128
  1024c9:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1024ce:	e9 f4 05 00 00       	jmp    102ac7 <__alltraps>

001024d3 <vector129>:
.globl vector129
vector129:
  pushl $0
  1024d3:	6a 00                	push   $0x0
  pushl $129
  1024d5:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1024da:	e9 e8 05 00 00       	jmp    102ac7 <__alltraps>

001024df <vector130>:
.globl vector130
vector130:
  pushl $0
  1024df:	6a 00                	push   $0x0
  pushl $130
  1024e1:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1024e6:	e9 dc 05 00 00       	jmp    102ac7 <__alltraps>

001024eb <vector131>:
.globl vector131
vector131:
  pushl $0
  1024eb:	6a 00                	push   $0x0
  pushl $131
  1024ed:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1024f2:	e9 d0 05 00 00       	jmp    102ac7 <__alltraps>

001024f7 <vector132>:
.globl vector132
vector132:
  pushl $0
  1024f7:	6a 00                	push   $0x0
  pushl $132
  1024f9:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  1024fe:	e9 c4 05 00 00       	jmp    102ac7 <__alltraps>

00102503 <vector133>:
.globl vector133
vector133:
  pushl $0
  102503:	6a 00                	push   $0x0
  pushl $133
  102505:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10250a:	e9 b8 05 00 00       	jmp    102ac7 <__alltraps>

0010250f <vector134>:
.globl vector134
vector134:
  pushl $0
  10250f:	6a 00                	push   $0x0
  pushl $134
  102511:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102516:	e9 ac 05 00 00       	jmp    102ac7 <__alltraps>

0010251b <vector135>:
.globl vector135
vector135:
  pushl $0
  10251b:	6a 00                	push   $0x0
  pushl $135
  10251d:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102522:	e9 a0 05 00 00       	jmp    102ac7 <__alltraps>

00102527 <vector136>:
.globl vector136
vector136:
  pushl $0
  102527:	6a 00                	push   $0x0
  pushl $136
  102529:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  10252e:	e9 94 05 00 00       	jmp    102ac7 <__alltraps>

00102533 <vector137>:
.globl vector137
vector137:
  pushl $0
  102533:	6a 00                	push   $0x0
  pushl $137
  102535:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10253a:	e9 88 05 00 00       	jmp    102ac7 <__alltraps>

0010253f <vector138>:
.globl vector138
vector138:
  pushl $0
  10253f:	6a 00                	push   $0x0
  pushl $138
  102541:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102546:	e9 7c 05 00 00       	jmp    102ac7 <__alltraps>

0010254b <vector139>:
.globl vector139
vector139:
  pushl $0
  10254b:	6a 00                	push   $0x0
  pushl $139
  10254d:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102552:	e9 70 05 00 00       	jmp    102ac7 <__alltraps>

00102557 <vector140>:
.globl vector140
vector140:
  pushl $0
  102557:	6a 00                	push   $0x0
  pushl $140
  102559:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  10255e:	e9 64 05 00 00       	jmp    102ac7 <__alltraps>

00102563 <vector141>:
.globl vector141
vector141:
  pushl $0
  102563:	6a 00                	push   $0x0
  pushl $141
  102565:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10256a:	e9 58 05 00 00       	jmp    102ac7 <__alltraps>

0010256f <vector142>:
.globl vector142
vector142:
  pushl $0
  10256f:	6a 00                	push   $0x0
  pushl $142
  102571:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102576:	e9 4c 05 00 00       	jmp    102ac7 <__alltraps>

0010257b <vector143>:
.globl vector143
vector143:
  pushl $0
  10257b:	6a 00                	push   $0x0
  pushl $143
  10257d:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102582:	e9 40 05 00 00       	jmp    102ac7 <__alltraps>

00102587 <vector144>:
.globl vector144
vector144:
  pushl $0
  102587:	6a 00                	push   $0x0
  pushl $144
  102589:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10258e:	e9 34 05 00 00       	jmp    102ac7 <__alltraps>

00102593 <vector145>:
.globl vector145
vector145:
  pushl $0
  102593:	6a 00                	push   $0x0
  pushl $145
  102595:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10259a:	e9 28 05 00 00       	jmp    102ac7 <__alltraps>

0010259f <vector146>:
.globl vector146
vector146:
  pushl $0
  10259f:	6a 00                	push   $0x0
  pushl $146
  1025a1:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1025a6:	e9 1c 05 00 00       	jmp    102ac7 <__alltraps>

001025ab <vector147>:
.globl vector147
vector147:
  pushl $0
  1025ab:	6a 00                	push   $0x0
  pushl $147
  1025ad:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1025b2:	e9 10 05 00 00       	jmp    102ac7 <__alltraps>

001025b7 <vector148>:
.globl vector148
vector148:
  pushl $0
  1025b7:	6a 00                	push   $0x0
  pushl $148
  1025b9:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1025be:	e9 04 05 00 00       	jmp    102ac7 <__alltraps>

001025c3 <vector149>:
.globl vector149
vector149:
  pushl $0
  1025c3:	6a 00                	push   $0x0
  pushl $149
  1025c5:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1025ca:	e9 f8 04 00 00       	jmp    102ac7 <__alltraps>

001025cf <vector150>:
.globl vector150
vector150:
  pushl $0
  1025cf:	6a 00                	push   $0x0
  pushl $150
  1025d1:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1025d6:	e9 ec 04 00 00       	jmp    102ac7 <__alltraps>

001025db <vector151>:
.globl vector151
vector151:
  pushl $0
  1025db:	6a 00                	push   $0x0
  pushl $151
  1025dd:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1025e2:	e9 e0 04 00 00       	jmp    102ac7 <__alltraps>

001025e7 <vector152>:
.globl vector152
vector152:
  pushl $0
  1025e7:	6a 00                	push   $0x0
  pushl $152
  1025e9:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1025ee:	e9 d4 04 00 00       	jmp    102ac7 <__alltraps>

001025f3 <vector153>:
.globl vector153
vector153:
  pushl $0
  1025f3:	6a 00                	push   $0x0
  pushl $153
  1025f5:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1025fa:	e9 c8 04 00 00       	jmp    102ac7 <__alltraps>

001025ff <vector154>:
.globl vector154
vector154:
  pushl $0
  1025ff:	6a 00                	push   $0x0
  pushl $154
  102601:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102606:	e9 bc 04 00 00       	jmp    102ac7 <__alltraps>

0010260b <vector155>:
.globl vector155
vector155:
  pushl $0
  10260b:	6a 00                	push   $0x0
  pushl $155
  10260d:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102612:	e9 b0 04 00 00       	jmp    102ac7 <__alltraps>

00102617 <vector156>:
.globl vector156
vector156:
  pushl $0
  102617:	6a 00                	push   $0x0
  pushl $156
  102619:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10261e:	e9 a4 04 00 00       	jmp    102ac7 <__alltraps>

00102623 <vector157>:
.globl vector157
vector157:
  pushl $0
  102623:	6a 00                	push   $0x0
  pushl $157
  102625:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10262a:	e9 98 04 00 00       	jmp    102ac7 <__alltraps>

0010262f <vector158>:
.globl vector158
vector158:
  pushl $0
  10262f:	6a 00                	push   $0x0
  pushl $158
  102631:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102636:	e9 8c 04 00 00       	jmp    102ac7 <__alltraps>

0010263b <vector159>:
.globl vector159
vector159:
  pushl $0
  10263b:	6a 00                	push   $0x0
  pushl $159
  10263d:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102642:	e9 80 04 00 00       	jmp    102ac7 <__alltraps>

00102647 <vector160>:
.globl vector160
vector160:
  pushl $0
  102647:	6a 00                	push   $0x0
  pushl $160
  102649:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  10264e:	e9 74 04 00 00       	jmp    102ac7 <__alltraps>

00102653 <vector161>:
.globl vector161
vector161:
  pushl $0
  102653:	6a 00                	push   $0x0
  pushl $161
  102655:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10265a:	e9 68 04 00 00       	jmp    102ac7 <__alltraps>

0010265f <vector162>:
.globl vector162
vector162:
  pushl $0
  10265f:	6a 00                	push   $0x0
  pushl $162
  102661:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102666:	e9 5c 04 00 00       	jmp    102ac7 <__alltraps>

0010266b <vector163>:
.globl vector163
vector163:
  pushl $0
  10266b:	6a 00                	push   $0x0
  pushl $163
  10266d:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102672:	e9 50 04 00 00       	jmp    102ac7 <__alltraps>

00102677 <vector164>:
.globl vector164
vector164:
  pushl $0
  102677:	6a 00                	push   $0x0
  pushl $164
  102679:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10267e:	e9 44 04 00 00       	jmp    102ac7 <__alltraps>

00102683 <vector165>:
.globl vector165
vector165:
  pushl $0
  102683:	6a 00                	push   $0x0
  pushl $165
  102685:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10268a:	e9 38 04 00 00       	jmp    102ac7 <__alltraps>

0010268f <vector166>:
.globl vector166
vector166:
  pushl $0
  10268f:	6a 00                	push   $0x0
  pushl $166
  102691:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102696:	e9 2c 04 00 00       	jmp    102ac7 <__alltraps>

0010269b <vector167>:
.globl vector167
vector167:
  pushl $0
  10269b:	6a 00                	push   $0x0
  pushl $167
  10269d:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1026a2:	e9 20 04 00 00       	jmp    102ac7 <__alltraps>

001026a7 <vector168>:
.globl vector168
vector168:
  pushl $0
  1026a7:	6a 00                	push   $0x0
  pushl $168
  1026a9:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1026ae:	e9 14 04 00 00       	jmp    102ac7 <__alltraps>

001026b3 <vector169>:
.globl vector169
vector169:
  pushl $0
  1026b3:	6a 00                	push   $0x0
  pushl $169
  1026b5:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1026ba:	e9 08 04 00 00       	jmp    102ac7 <__alltraps>

001026bf <vector170>:
.globl vector170
vector170:
  pushl $0
  1026bf:	6a 00                	push   $0x0
  pushl $170
  1026c1:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1026c6:	e9 fc 03 00 00       	jmp    102ac7 <__alltraps>

001026cb <vector171>:
.globl vector171
vector171:
  pushl $0
  1026cb:	6a 00                	push   $0x0
  pushl $171
  1026cd:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1026d2:	e9 f0 03 00 00       	jmp    102ac7 <__alltraps>

001026d7 <vector172>:
.globl vector172
vector172:
  pushl $0
  1026d7:	6a 00                	push   $0x0
  pushl $172
  1026d9:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1026de:	e9 e4 03 00 00       	jmp    102ac7 <__alltraps>

001026e3 <vector173>:
.globl vector173
vector173:
  pushl $0
  1026e3:	6a 00                	push   $0x0
  pushl $173
  1026e5:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1026ea:	e9 d8 03 00 00       	jmp    102ac7 <__alltraps>

001026ef <vector174>:
.globl vector174
vector174:
  pushl $0
  1026ef:	6a 00                	push   $0x0
  pushl $174
  1026f1:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1026f6:	e9 cc 03 00 00       	jmp    102ac7 <__alltraps>

001026fb <vector175>:
.globl vector175
vector175:
  pushl $0
  1026fb:	6a 00                	push   $0x0
  pushl $175
  1026fd:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102702:	e9 c0 03 00 00       	jmp    102ac7 <__alltraps>

00102707 <vector176>:
.globl vector176
vector176:
  pushl $0
  102707:	6a 00                	push   $0x0
  pushl $176
  102709:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10270e:	e9 b4 03 00 00       	jmp    102ac7 <__alltraps>

00102713 <vector177>:
.globl vector177
vector177:
  pushl $0
  102713:	6a 00                	push   $0x0
  pushl $177
  102715:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10271a:	e9 a8 03 00 00       	jmp    102ac7 <__alltraps>

0010271f <vector178>:
.globl vector178
vector178:
  pushl $0
  10271f:	6a 00                	push   $0x0
  pushl $178
  102721:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102726:	e9 9c 03 00 00       	jmp    102ac7 <__alltraps>

0010272b <vector179>:
.globl vector179
vector179:
  pushl $0
  10272b:	6a 00                	push   $0x0
  pushl $179
  10272d:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102732:	e9 90 03 00 00       	jmp    102ac7 <__alltraps>

00102737 <vector180>:
.globl vector180
vector180:
  pushl $0
  102737:	6a 00                	push   $0x0
  pushl $180
  102739:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  10273e:	e9 84 03 00 00       	jmp    102ac7 <__alltraps>

00102743 <vector181>:
.globl vector181
vector181:
  pushl $0
  102743:	6a 00                	push   $0x0
  pushl $181
  102745:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10274a:	e9 78 03 00 00       	jmp    102ac7 <__alltraps>

0010274f <vector182>:
.globl vector182
vector182:
  pushl $0
  10274f:	6a 00                	push   $0x0
  pushl $182
  102751:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102756:	e9 6c 03 00 00       	jmp    102ac7 <__alltraps>

0010275b <vector183>:
.globl vector183
vector183:
  pushl $0
  10275b:	6a 00                	push   $0x0
  pushl $183
  10275d:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102762:	e9 60 03 00 00       	jmp    102ac7 <__alltraps>

00102767 <vector184>:
.globl vector184
vector184:
  pushl $0
  102767:	6a 00                	push   $0x0
  pushl $184
  102769:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  10276e:	e9 54 03 00 00       	jmp    102ac7 <__alltraps>

00102773 <vector185>:
.globl vector185
vector185:
  pushl $0
  102773:	6a 00                	push   $0x0
  pushl $185
  102775:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10277a:	e9 48 03 00 00       	jmp    102ac7 <__alltraps>

0010277f <vector186>:
.globl vector186
vector186:
  pushl $0
  10277f:	6a 00                	push   $0x0
  pushl $186
  102781:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102786:	e9 3c 03 00 00       	jmp    102ac7 <__alltraps>

0010278b <vector187>:
.globl vector187
vector187:
  pushl $0
  10278b:	6a 00                	push   $0x0
  pushl $187
  10278d:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102792:	e9 30 03 00 00       	jmp    102ac7 <__alltraps>

00102797 <vector188>:
.globl vector188
vector188:
  pushl $0
  102797:	6a 00                	push   $0x0
  pushl $188
  102799:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10279e:	e9 24 03 00 00       	jmp    102ac7 <__alltraps>

001027a3 <vector189>:
.globl vector189
vector189:
  pushl $0
  1027a3:	6a 00                	push   $0x0
  pushl $189
  1027a5:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1027aa:	e9 18 03 00 00       	jmp    102ac7 <__alltraps>

001027af <vector190>:
.globl vector190
vector190:
  pushl $0
  1027af:	6a 00                	push   $0x0
  pushl $190
  1027b1:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1027b6:	e9 0c 03 00 00       	jmp    102ac7 <__alltraps>

001027bb <vector191>:
.globl vector191
vector191:
  pushl $0
  1027bb:	6a 00                	push   $0x0
  pushl $191
  1027bd:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1027c2:	e9 00 03 00 00       	jmp    102ac7 <__alltraps>

001027c7 <vector192>:
.globl vector192
vector192:
  pushl $0
  1027c7:	6a 00                	push   $0x0
  pushl $192
  1027c9:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1027ce:	e9 f4 02 00 00       	jmp    102ac7 <__alltraps>

001027d3 <vector193>:
.globl vector193
vector193:
  pushl $0
  1027d3:	6a 00                	push   $0x0
  pushl $193
  1027d5:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1027da:	e9 e8 02 00 00       	jmp    102ac7 <__alltraps>

001027df <vector194>:
.globl vector194
vector194:
  pushl $0
  1027df:	6a 00                	push   $0x0
  pushl $194
  1027e1:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1027e6:	e9 dc 02 00 00       	jmp    102ac7 <__alltraps>

001027eb <vector195>:
.globl vector195
vector195:
  pushl $0
  1027eb:	6a 00                	push   $0x0
  pushl $195
  1027ed:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1027f2:	e9 d0 02 00 00       	jmp    102ac7 <__alltraps>

001027f7 <vector196>:
.globl vector196
vector196:
  pushl $0
  1027f7:	6a 00                	push   $0x0
  pushl $196
  1027f9:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  1027fe:	e9 c4 02 00 00       	jmp    102ac7 <__alltraps>

00102803 <vector197>:
.globl vector197
vector197:
  pushl $0
  102803:	6a 00                	push   $0x0
  pushl $197
  102805:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10280a:	e9 b8 02 00 00       	jmp    102ac7 <__alltraps>

0010280f <vector198>:
.globl vector198
vector198:
  pushl $0
  10280f:	6a 00                	push   $0x0
  pushl $198
  102811:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102816:	e9 ac 02 00 00       	jmp    102ac7 <__alltraps>

0010281b <vector199>:
.globl vector199
vector199:
  pushl $0
  10281b:	6a 00                	push   $0x0
  pushl $199
  10281d:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102822:	e9 a0 02 00 00       	jmp    102ac7 <__alltraps>

00102827 <vector200>:
.globl vector200
vector200:
  pushl $0
  102827:	6a 00                	push   $0x0
  pushl $200
  102829:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  10282e:	e9 94 02 00 00       	jmp    102ac7 <__alltraps>

00102833 <vector201>:
.globl vector201
vector201:
  pushl $0
  102833:	6a 00                	push   $0x0
  pushl $201
  102835:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10283a:	e9 88 02 00 00       	jmp    102ac7 <__alltraps>

0010283f <vector202>:
.globl vector202
vector202:
  pushl $0
  10283f:	6a 00                	push   $0x0
  pushl $202
  102841:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102846:	e9 7c 02 00 00       	jmp    102ac7 <__alltraps>

0010284b <vector203>:
.globl vector203
vector203:
  pushl $0
  10284b:	6a 00                	push   $0x0
  pushl $203
  10284d:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102852:	e9 70 02 00 00       	jmp    102ac7 <__alltraps>

00102857 <vector204>:
.globl vector204
vector204:
  pushl $0
  102857:	6a 00                	push   $0x0
  pushl $204
  102859:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  10285e:	e9 64 02 00 00       	jmp    102ac7 <__alltraps>

00102863 <vector205>:
.globl vector205
vector205:
  pushl $0
  102863:	6a 00                	push   $0x0
  pushl $205
  102865:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10286a:	e9 58 02 00 00       	jmp    102ac7 <__alltraps>

0010286f <vector206>:
.globl vector206
vector206:
  pushl $0
  10286f:	6a 00                	push   $0x0
  pushl $206
  102871:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102876:	e9 4c 02 00 00       	jmp    102ac7 <__alltraps>

0010287b <vector207>:
.globl vector207
vector207:
  pushl $0
  10287b:	6a 00                	push   $0x0
  pushl $207
  10287d:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102882:	e9 40 02 00 00       	jmp    102ac7 <__alltraps>

00102887 <vector208>:
.globl vector208
vector208:
  pushl $0
  102887:	6a 00                	push   $0x0
  pushl $208
  102889:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10288e:	e9 34 02 00 00       	jmp    102ac7 <__alltraps>

00102893 <vector209>:
.globl vector209
vector209:
  pushl $0
  102893:	6a 00                	push   $0x0
  pushl $209
  102895:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10289a:	e9 28 02 00 00       	jmp    102ac7 <__alltraps>

0010289f <vector210>:
.globl vector210
vector210:
  pushl $0
  10289f:	6a 00                	push   $0x0
  pushl $210
  1028a1:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1028a6:	e9 1c 02 00 00       	jmp    102ac7 <__alltraps>

001028ab <vector211>:
.globl vector211
vector211:
  pushl $0
  1028ab:	6a 00                	push   $0x0
  pushl $211
  1028ad:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1028b2:	e9 10 02 00 00       	jmp    102ac7 <__alltraps>

001028b7 <vector212>:
.globl vector212
vector212:
  pushl $0
  1028b7:	6a 00                	push   $0x0
  pushl $212
  1028b9:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1028be:	e9 04 02 00 00       	jmp    102ac7 <__alltraps>

001028c3 <vector213>:
.globl vector213
vector213:
  pushl $0
  1028c3:	6a 00                	push   $0x0
  pushl $213
  1028c5:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1028ca:	e9 f8 01 00 00       	jmp    102ac7 <__alltraps>

001028cf <vector214>:
.globl vector214
vector214:
  pushl $0
  1028cf:	6a 00                	push   $0x0
  pushl $214
  1028d1:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1028d6:	e9 ec 01 00 00       	jmp    102ac7 <__alltraps>

001028db <vector215>:
.globl vector215
vector215:
  pushl $0
  1028db:	6a 00                	push   $0x0
  pushl $215
  1028dd:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1028e2:	e9 e0 01 00 00       	jmp    102ac7 <__alltraps>

001028e7 <vector216>:
.globl vector216
vector216:
  pushl $0
  1028e7:	6a 00                	push   $0x0
  pushl $216
  1028e9:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1028ee:	e9 d4 01 00 00       	jmp    102ac7 <__alltraps>

001028f3 <vector217>:
.globl vector217
vector217:
  pushl $0
  1028f3:	6a 00                	push   $0x0
  pushl $217
  1028f5:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1028fa:	e9 c8 01 00 00       	jmp    102ac7 <__alltraps>

001028ff <vector218>:
.globl vector218
vector218:
  pushl $0
  1028ff:	6a 00                	push   $0x0
  pushl $218
  102901:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102906:	e9 bc 01 00 00       	jmp    102ac7 <__alltraps>

0010290b <vector219>:
.globl vector219
vector219:
  pushl $0
  10290b:	6a 00                	push   $0x0
  pushl $219
  10290d:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102912:	e9 b0 01 00 00       	jmp    102ac7 <__alltraps>

00102917 <vector220>:
.globl vector220
vector220:
  pushl $0
  102917:	6a 00                	push   $0x0
  pushl $220
  102919:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  10291e:	e9 a4 01 00 00       	jmp    102ac7 <__alltraps>

00102923 <vector221>:
.globl vector221
vector221:
  pushl $0
  102923:	6a 00                	push   $0x0
  pushl $221
  102925:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10292a:	e9 98 01 00 00       	jmp    102ac7 <__alltraps>

0010292f <vector222>:
.globl vector222
vector222:
  pushl $0
  10292f:	6a 00                	push   $0x0
  pushl $222
  102931:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102936:	e9 8c 01 00 00       	jmp    102ac7 <__alltraps>

0010293b <vector223>:
.globl vector223
vector223:
  pushl $0
  10293b:	6a 00                	push   $0x0
  pushl $223
  10293d:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102942:	e9 80 01 00 00       	jmp    102ac7 <__alltraps>

00102947 <vector224>:
.globl vector224
vector224:
  pushl $0
  102947:	6a 00                	push   $0x0
  pushl $224
  102949:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  10294e:	e9 74 01 00 00       	jmp    102ac7 <__alltraps>

00102953 <vector225>:
.globl vector225
vector225:
  pushl $0
  102953:	6a 00                	push   $0x0
  pushl $225
  102955:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10295a:	e9 68 01 00 00       	jmp    102ac7 <__alltraps>

0010295f <vector226>:
.globl vector226
vector226:
  pushl $0
  10295f:	6a 00                	push   $0x0
  pushl $226
  102961:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102966:	e9 5c 01 00 00       	jmp    102ac7 <__alltraps>

0010296b <vector227>:
.globl vector227
vector227:
  pushl $0
  10296b:	6a 00                	push   $0x0
  pushl $227
  10296d:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102972:	e9 50 01 00 00       	jmp    102ac7 <__alltraps>

00102977 <vector228>:
.globl vector228
vector228:
  pushl $0
  102977:	6a 00                	push   $0x0
  pushl $228
  102979:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  10297e:	e9 44 01 00 00       	jmp    102ac7 <__alltraps>

00102983 <vector229>:
.globl vector229
vector229:
  pushl $0
  102983:	6a 00                	push   $0x0
  pushl $229
  102985:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10298a:	e9 38 01 00 00       	jmp    102ac7 <__alltraps>

0010298f <vector230>:
.globl vector230
vector230:
  pushl $0
  10298f:	6a 00                	push   $0x0
  pushl $230
  102991:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102996:	e9 2c 01 00 00       	jmp    102ac7 <__alltraps>

0010299b <vector231>:
.globl vector231
vector231:
  pushl $0
  10299b:	6a 00                	push   $0x0
  pushl $231
  10299d:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1029a2:	e9 20 01 00 00       	jmp    102ac7 <__alltraps>

001029a7 <vector232>:
.globl vector232
vector232:
  pushl $0
  1029a7:	6a 00                	push   $0x0
  pushl $232
  1029a9:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1029ae:	e9 14 01 00 00       	jmp    102ac7 <__alltraps>

001029b3 <vector233>:
.globl vector233
vector233:
  pushl $0
  1029b3:	6a 00                	push   $0x0
  pushl $233
  1029b5:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1029ba:	e9 08 01 00 00       	jmp    102ac7 <__alltraps>

001029bf <vector234>:
.globl vector234
vector234:
  pushl $0
  1029bf:	6a 00                	push   $0x0
  pushl $234
  1029c1:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1029c6:	e9 fc 00 00 00       	jmp    102ac7 <__alltraps>

001029cb <vector235>:
.globl vector235
vector235:
  pushl $0
  1029cb:	6a 00                	push   $0x0
  pushl $235
  1029cd:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1029d2:	e9 f0 00 00 00       	jmp    102ac7 <__alltraps>

001029d7 <vector236>:
.globl vector236
vector236:
  pushl $0
  1029d7:	6a 00                	push   $0x0
  pushl $236
  1029d9:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1029de:	e9 e4 00 00 00       	jmp    102ac7 <__alltraps>

001029e3 <vector237>:
.globl vector237
vector237:
  pushl $0
  1029e3:	6a 00                	push   $0x0
  pushl $237
  1029e5:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1029ea:	e9 d8 00 00 00       	jmp    102ac7 <__alltraps>

001029ef <vector238>:
.globl vector238
vector238:
  pushl $0
  1029ef:	6a 00                	push   $0x0
  pushl $238
  1029f1:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1029f6:	e9 cc 00 00 00       	jmp    102ac7 <__alltraps>

001029fb <vector239>:
.globl vector239
vector239:
  pushl $0
  1029fb:	6a 00                	push   $0x0
  pushl $239
  1029fd:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102a02:	e9 c0 00 00 00       	jmp    102ac7 <__alltraps>

00102a07 <vector240>:
.globl vector240
vector240:
  pushl $0
  102a07:	6a 00                	push   $0x0
  pushl $240
  102a09:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102a0e:	e9 b4 00 00 00       	jmp    102ac7 <__alltraps>

00102a13 <vector241>:
.globl vector241
vector241:
  pushl $0
  102a13:	6a 00                	push   $0x0
  pushl $241
  102a15:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102a1a:	e9 a8 00 00 00       	jmp    102ac7 <__alltraps>

00102a1f <vector242>:
.globl vector242
vector242:
  pushl $0
  102a1f:	6a 00                	push   $0x0
  pushl $242
  102a21:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102a26:	e9 9c 00 00 00       	jmp    102ac7 <__alltraps>

00102a2b <vector243>:
.globl vector243
vector243:
  pushl $0
  102a2b:	6a 00                	push   $0x0
  pushl $243
  102a2d:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102a32:	e9 90 00 00 00       	jmp    102ac7 <__alltraps>

00102a37 <vector244>:
.globl vector244
vector244:
  pushl $0
  102a37:	6a 00                	push   $0x0
  pushl $244
  102a39:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102a3e:	e9 84 00 00 00       	jmp    102ac7 <__alltraps>

00102a43 <vector245>:
.globl vector245
vector245:
  pushl $0
  102a43:	6a 00                	push   $0x0
  pushl $245
  102a45:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  102a4a:	e9 78 00 00 00       	jmp    102ac7 <__alltraps>

00102a4f <vector246>:
.globl vector246
vector246:
  pushl $0
  102a4f:	6a 00                	push   $0x0
  pushl $246
  102a51:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102a56:	e9 6c 00 00 00       	jmp    102ac7 <__alltraps>

00102a5b <vector247>:
.globl vector247
vector247:
  pushl $0
  102a5b:	6a 00                	push   $0x0
  pushl $247
  102a5d:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102a62:	e9 60 00 00 00       	jmp    102ac7 <__alltraps>

00102a67 <vector248>:
.globl vector248
vector248:
  pushl $0
  102a67:	6a 00                	push   $0x0
  pushl $248
  102a69:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102a6e:	e9 54 00 00 00       	jmp    102ac7 <__alltraps>

00102a73 <vector249>:
.globl vector249
vector249:
  pushl $0
  102a73:	6a 00                	push   $0x0
  pushl $249
  102a75:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102a7a:	e9 48 00 00 00       	jmp    102ac7 <__alltraps>

00102a7f <vector250>:
.globl vector250
vector250:
  pushl $0
  102a7f:	6a 00                	push   $0x0
  pushl $250
  102a81:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102a86:	e9 3c 00 00 00       	jmp    102ac7 <__alltraps>

00102a8b <vector251>:
.globl vector251
vector251:
  pushl $0
  102a8b:	6a 00                	push   $0x0
  pushl $251
  102a8d:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102a92:	e9 30 00 00 00       	jmp    102ac7 <__alltraps>

00102a97 <vector252>:
.globl vector252
vector252:
  pushl $0
  102a97:	6a 00                	push   $0x0
  pushl $252
  102a99:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102a9e:	e9 24 00 00 00       	jmp    102ac7 <__alltraps>

00102aa3 <vector253>:
.globl vector253
vector253:
  pushl $0
  102aa3:	6a 00                	push   $0x0
  pushl $253
  102aa5:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102aaa:	e9 18 00 00 00       	jmp    102ac7 <__alltraps>

00102aaf <vector254>:
.globl vector254
vector254:
  pushl $0
  102aaf:	6a 00                	push   $0x0
  pushl $254
  102ab1:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102ab6:	e9 0c 00 00 00       	jmp    102ac7 <__alltraps>

00102abb <vector255>:
.globl vector255
vector255:
  pushl $0
  102abb:	6a 00                	push   $0x0
  pushl $255
  102abd:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102ac2:	e9 00 00 00 00       	jmp    102ac7 <__alltraps>

00102ac7 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102ac7:	1e                   	push   %ds
    pushl %es
  102ac8:	06                   	push   %es
    pushl %fs
  102ac9:	0f a0                	push   %fs
    pushl %gs
  102acb:	0f a8                	push   %gs
    pushal
  102acd:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102ace:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102ad3:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102ad5:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102ad7:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102ad8:	e8 60 f5 ff ff       	call   10203d <trap>

    # pop the pushed stack pointer
    popl %esp
  102add:	5c                   	pop    %esp

00102ade <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102ade:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102adf:	0f a9                	pop    %gs
    popl %fs
  102ae1:	0f a1                	pop    %fs
    popl %es
  102ae3:	07                   	pop    %es
    popl %ds
  102ae4:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102ae5:	83 c4 08             	add    $0x8,%esp
    iret
  102ae8:	cf                   	iret   

00102ae9 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102ae9:	55                   	push   %ebp
  102aea:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102aec:	8b 45 08             	mov    0x8(%ebp),%eax
  102aef:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102af2:	b8 23 00 00 00       	mov    $0x23,%eax
  102af7:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102af9:	b8 23 00 00 00       	mov    $0x23,%eax
  102afe:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102b00:	b8 10 00 00 00       	mov    $0x10,%eax
  102b05:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102b07:	b8 10 00 00 00       	mov    $0x10,%eax
  102b0c:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102b0e:	b8 10 00 00 00       	mov    $0x10,%eax
  102b13:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102b15:	ea 1c 2b 10 00 08 00 	ljmp   $0x8,$0x102b1c
}
  102b1c:	90                   	nop
  102b1d:	5d                   	pop    %ebp
  102b1e:	c3                   	ret    

00102b1f <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102b1f:	f3 0f 1e fb          	endbr32 
  102b23:	55                   	push   %ebp
  102b24:	89 e5                	mov    %esp,%ebp
  102b26:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102b29:	b8 20 19 11 00       	mov    $0x111920,%eax
  102b2e:	05 00 04 00 00       	add    $0x400,%eax
  102b33:	a3 a4 18 11 00       	mov    %eax,0x1118a4
    ts.ts_ss0 = KERNEL_DS;
  102b38:	66 c7 05 a8 18 11 00 	movw   $0x10,0x1118a8
  102b3f:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102b41:	66 c7 05 08 0a 11 00 	movw   $0x68,0x110a08
  102b48:	68 00 
  102b4a:	b8 a0 18 11 00       	mov    $0x1118a0,%eax
  102b4f:	0f b7 c0             	movzwl %ax,%eax
  102b52:	66 a3 0a 0a 11 00    	mov    %ax,0x110a0a
  102b58:	b8 a0 18 11 00       	mov    $0x1118a0,%eax
  102b5d:	c1 e8 10             	shr    $0x10,%eax
  102b60:	a2 0c 0a 11 00       	mov    %al,0x110a0c
  102b65:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b6c:	24 f0                	and    $0xf0,%al
  102b6e:	0c 09                	or     $0x9,%al
  102b70:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b75:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b7c:	0c 10                	or     $0x10,%al
  102b7e:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b83:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b8a:	24 9f                	and    $0x9f,%al
  102b8c:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b91:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102b98:	0c 80                	or     $0x80,%al
  102b9a:	a2 0d 0a 11 00       	mov    %al,0x110a0d
  102b9f:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102ba6:	24 f0                	and    $0xf0,%al
  102ba8:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102bad:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102bb4:	24 ef                	and    $0xef,%al
  102bb6:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102bbb:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102bc2:	24 df                	and    $0xdf,%al
  102bc4:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102bc9:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102bd0:	0c 40                	or     $0x40,%al
  102bd2:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102bd7:	0f b6 05 0e 0a 11 00 	movzbl 0x110a0e,%eax
  102bde:	24 7f                	and    $0x7f,%al
  102be0:	a2 0e 0a 11 00       	mov    %al,0x110a0e
  102be5:	b8 a0 18 11 00       	mov    $0x1118a0,%eax
  102bea:	c1 e8 18             	shr    $0x18,%eax
  102bed:	a2 0f 0a 11 00       	mov    %al,0x110a0f
    gdt[SEG_TSS].sd_s = 0;
  102bf2:	0f b6 05 0d 0a 11 00 	movzbl 0x110a0d,%eax
  102bf9:	24 ef                	and    $0xef,%al
  102bfb:	a2 0d 0a 11 00       	mov    %al,0x110a0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102c00:	c7 04 24 10 0a 11 00 	movl   $0x110a10,(%esp)
  102c07:	e8 dd fe ff ff       	call   102ae9 <lgdt>
  102c0c:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel));
  102c12:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102c16:	0f 00 d8             	ltr    %ax
}
  102c19:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102c1a:	90                   	nop
  102c1b:	c9                   	leave  
  102c1c:	c3                   	ret    

00102c1d <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102c1d:	f3 0f 1e fb          	endbr32 
  102c21:	55                   	push   %ebp
  102c22:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102c24:	e8 f6 fe ff ff       	call   102b1f <gdt_init>
}
  102c29:	90                   	nop
  102c2a:	5d                   	pop    %ebp
  102c2b:	c3                   	ret    

00102c2c <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102c2c:	f3 0f 1e fb          	endbr32 
  102c30:	55                   	push   %ebp
  102c31:	89 e5                	mov    %esp,%ebp
  102c33:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102c36:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102c3d:	eb 03                	jmp    102c42 <strlen+0x16>
        cnt ++;
  102c3f:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102c42:	8b 45 08             	mov    0x8(%ebp),%eax
  102c45:	8d 50 01             	lea    0x1(%eax),%edx
  102c48:	89 55 08             	mov    %edx,0x8(%ebp)
  102c4b:	0f b6 00             	movzbl (%eax),%eax
  102c4e:	84 c0                	test   %al,%al
  102c50:	75 ed                	jne    102c3f <strlen+0x13>
    }
    return cnt;
  102c52:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102c55:	c9                   	leave  
  102c56:	c3                   	ret    

00102c57 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102c57:	f3 0f 1e fb          	endbr32 
  102c5b:	55                   	push   %ebp
  102c5c:	89 e5                	mov    %esp,%ebp
  102c5e:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102c61:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102c68:	eb 03                	jmp    102c6d <strnlen+0x16>
        cnt ++;
  102c6a:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102c6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c70:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102c73:	73 10                	jae    102c85 <strnlen+0x2e>
  102c75:	8b 45 08             	mov    0x8(%ebp),%eax
  102c78:	8d 50 01             	lea    0x1(%eax),%edx
  102c7b:	89 55 08             	mov    %edx,0x8(%ebp)
  102c7e:	0f b6 00             	movzbl (%eax),%eax
  102c81:	84 c0                	test   %al,%al
  102c83:	75 e5                	jne    102c6a <strnlen+0x13>
    }
    return cnt;
  102c85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102c88:	c9                   	leave  
  102c89:	c3                   	ret    

00102c8a <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102c8a:	f3 0f 1e fb          	endbr32 
  102c8e:	55                   	push   %ebp
  102c8f:	89 e5                	mov    %esp,%ebp
  102c91:	57                   	push   %edi
  102c92:	56                   	push   %esi
  102c93:	83 ec 20             	sub    $0x20,%esp
  102c96:	8b 45 08             	mov    0x8(%ebp),%eax
  102c99:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102ca2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ca8:	89 d1                	mov    %edx,%ecx
  102caa:	89 c2                	mov    %eax,%edx
  102cac:	89 ce                	mov    %ecx,%esi
  102cae:	89 d7                	mov    %edx,%edi
  102cb0:	ac                   	lods   %ds:(%esi),%al
  102cb1:	aa                   	stos   %al,%es:(%edi)
  102cb2:	84 c0                	test   %al,%al
  102cb4:	75 fa                	jne    102cb0 <strcpy+0x26>
  102cb6:	89 fa                	mov    %edi,%edx
  102cb8:	89 f1                	mov    %esi,%ecx
  102cba:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102cbd:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102cc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return dst;
  102cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102cc6:	83 c4 20             	add    $0x20,%esp
  102cc9:	5e                   	pop    %esi
  102cca:	5f                   	pop    %edi
  102ccb:	5d                   	pop    %ebp
  102ccc:	c3                   	ret    

00102ccd <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102ccd:	f3 0f 1e fb          	endbr32 
  102cd1:	55                   	push   %ebp
  102cd2:	89 e5                	mov    %esp,%ebp
  102cd4:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  102cda:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102cdd:	eb 1e                	jmp    102cfd <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102cdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ce2:	0f b6 10             	movzbl (%eax),%edx
  102ce5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ce8:	88 10                	mov    %dl,(%eax)
  102cea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102ced:	0f b6 00             	movzbl (%eax),%eax
  102cf0:	84 c0                	test   %al,%al
  102cf2:	74 03                	je     102cf7 <strncpy+0x2a>
            src ++;
  102cf4:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102cf7:	ff 45 fc             	incl   -0x4(%ebp)
  102cfa:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102cfd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d01:	75 dc                	jne    102cdf <strncpy+0x12>
    }
    return dst;
  102d03:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102d06:	c9                   	leave  
  102d07:	c3                   	ret    

00102d08 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102d08:	f3 0f 1e fb          	endbr32 
  102d0c:	55                   	push   %ebp
  102d0d:	89 e5                	mov    %esp,%ebp
  102d0f:	57                   	push   %edi
  102d10:	56                   	push   %esi
  102d11:	83 ec 20             	sub    $0x20,%esp
  102d14:	8b 45 08             	mov    0x8(%ebp),%eax
  102d17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102d20:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102d23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d26:	89 d1                	mov    %edx,%ecx
  102d28:	89 c2                	mov    %eax,%edx
  102d2a:	89 ce                	mov    %ecx,%esi
  102d2c:	89 d7                	mov    %edx,%edi
  102d2e:	ac                   	lods   %ds:(%esi),%al
  102d2f:	ae                   	scas   %es:(%edi),%al
  102d30:	75 08                	jne    102d3a <strcmp+0x32>
  102d32:	84 c0                	test   %al,%al
  102d34:	75 f8                	jne    102d2e <strcmp+0x26>
  102d36:	31 c0                	xor    %eax,%eax
  102d38:	eb 04                	jmp    102d3e <strcmp+0x36>
  102d3a:	19 c0                	sbb    %eax,%eax
  102d3c:	0c 01                	or     $0x1,%al
  102d3e:	89 fa                	mov    %edi,%edx
  102d40:	89 f1                	mov    %esi,%ecx
  102d42:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102d45:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102d48:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102d4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102d4e:	83 c4 20             	add    $0x20,%esp
  102d51:	5e                   	pop    %esi
  102d52:	5f                   	pop    %edi
  102d53:	5d                   	pop    %ebp
  102d54:	c3                   	ret    

00102d55 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102d55:	f3 0f 1e fb          	endbr32 
  102d59:	55                   	push   %ebp
  102d5a:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102d5c:	eb 09                	jmp    102d67 <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102d5e:	ff 4d 10             	decl   0x10(%ebp)
  102d61:	ff 45 08             	incl   0x8(%ebp)
  102d64:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102d67:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d6b:	74 1a                	je     102d87 <strncmp+0x32>
  102d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d70:	0f b6 00             	movzbl (%eax),%eax
  102d73:	84 c0                	test   %al,%al
  102d75:	74 10                	je     102d87 <strncmp+0x32>
  102d77:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7a:	0f b6 10             	movzbl (%eax),%edx
  102d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d80:	0f b6 00             	movzbl (%eax),%eax
  102d83:	38 c2                	cmp    %al,%dl
  102d85:	74 d7                	je     102d5e <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102d87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d8b:	74 18                	je     102da5 <strncmp+0x50>
  102d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d90:	0f b6 00             	movzbl (%eax),%eax
  102d93:	0f b6 d0             	movzbl %al,%edx
  102d96:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d99:	0f b6 00             	movzbl (%eax),%eax
  102d9c:	0f b6 c0             	movzbl %al,%eax
  102d9f:	29 c2                	sub    %eax,%edx
  102da1:	89 d0                	mov    %edx,%eax
  102da3:	eb 05                	jmp    102daa <strncmp+0x55>
  102da5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102daa:	5d                   	pop    %ebp
  102dab:	c3                   	ret    

00102dac <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102dac:	f3 0f 1e fb          	endbr32 
  102db0:	55                   	push   %ebp
  102db1:	89 e5                	mov    %esp,%ebp
  102db3:	83 ec 04             	sub    $0x4,%esp
  102db6:	8b 45 0c             	mov    0xc(%ebp),%eax
  102db9:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102dbc:	eb 13                	jmp    102dd1 <strchr+0x25>
        if (*s == c) {
  102dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  102dc1:	0f b6 00             	movzbl (%eax),%eax
  102dc4:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102dc7:	75 05                	jne    102dce <strchr+0x22>
            return (char *)s;
  102dc9:	8b 45 08             	mov    0x8(%ebp),%eax
  102dcc:	eb 12                	jmp    102de0 <strchr+0x34>
        }
        s ++;
  102dce:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd4:	0f b6 00             	movzbl (%eax),%eax
  102dd7:	84 c0                	test   %al,%al
  102dd9:	75 e3                	jne    102dbe <strchr+0x12>
    }
    return NULL;
  102ddb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102de0:	c9                   	leave  
  102de1:	c3                   	ret    

00102de2 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102de2:	f3 0f 1e fb          	endbr32 
  102de6:	55                   	push   %ebp
  102de7:	89 e5                	mov    %esp,%ebp
  102de9:	83 ec 04             	sub    $0x4,%esp
  102dec:	8b 45 0c             	mov    0xc(%ebp),%eax
  102def:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102df2:	eb 0e                	jmp    102e02 <strfind+0x20>
        if (*s == c) {
  102df4:	8b 45 08             	mov    0x8(%ebp),%eax
  102df7:	0f b6 00             	movzbl (%eax),%eax
  102dfa:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102dfd:	74 0f                	je     102e0e <strfind+0x2c>
            break;
        }
        s ++;
  102dff:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102e02:	8b 45 08             	mov    0x8(%ebp),%eax
  102e05:	0f b6 00             	movzbl (%eax),%eax
  102e08:	84 c0                	test   %al,%al
  102e0a:	75 e8                	jne    102df4 <strfind+0x12>
  102e0c:	eb 01                	jmp    102e0f <strfind+0x2d>
            break;
  102e0e:	90                   	nop
    }
    return (char *)s;
  102e0f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102e12:	c9                   	leave  
  102e13:	c3                   	ret    

00102e14 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102e14:	f3 0f 1e fb          	endbr32 
  102e18:	55                   	push   %ebp
  102e19:	89 e5                	mov    %esp,%ebp
  102e1b:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102e1e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102e25:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102e2c:	eb 03                	jmp    102e31 <strtol+0x1d>
        s ++;
  102e2e:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102e31:	8b 45 08             	mov    0x8(%ebp),%eax
  102e34:	0f b6 00             	movzbl (%eax),%eax
  102e37:	3c 20                	cmp    $0x20,%al
  102e39:	74 f3                	je     102e2e <strtol+0x1a>
  102e3b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3e:	0f b6 00             	movzbl (%eax),%eax
  102e41:	3c 09                	cmp    $0x9,%al
  102e43:	74 e9                	je     102e2e <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102e45:	8b 45 08             	mov    0x8(%ebp),%eax
  102e48:	0f b6 00             	movzbl (%eax),%eax
  102e4b:	3c 2b                	cmp    $0x2b,%al
  102e4d:	75 05                	jne    102e54 <strtol+0x40>
        s ++;
  102e4f:	ff 45 08             	incl   0x8(%ebp)
  102e52:	eb 14                	jmp    102e68 <strtol+0x54>
    }
    else if (*s == '-') {
  102e54:	8b 45 08             	mov    0x8(%ebp),%eax
  102e57:	0f b6 00             	movzbl (%eax),%eax
  102e5a:	3c 2d                	cmp    $0x2d,%al
  102e5c:	75 0a                	jne    102e68 <strtol+0x54>
        s ++, neg = 1;
  102e5e:	ff 45 08             	incl   0x8(%ebp)
  102e61:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102e68:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e6c:	74 06                	je     102e74 <strtol+0x60>
  102e6e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102e72:	75 22                	jne    102e96 <strtol+0x82>
  102e74:	8b 45 08             	mov    0x8(%ebp),%eax
  102e77:	0f b6 00             	movzbl (%eax),%eax
  102e7a:	3c 30                	cmp    $0x30,%al
  102e7c:	75 18                	jne    102e96 <strtol+0x82>
  102e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  102e81:	40                   	inc    %eax
  102e82:	0f b6 00             	movzbl (%eax),%eax
  102e85:	3c 78                	cmp    $0x78,%al
  102e87:	75 0d                	jne    102e96 <strtol+0x82>
        s += 2, base = 16;
  102e89:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102e8d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102e94:	eb 29                	jmp    102ebf <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102e96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e9a:	75 16                	jne    102eb2 <strtol+0x9e>
  102e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e9f:	0f b6 00             	movzbl (%eax),%eax
  102ea2:	3c 30                	cmp    $0x30,%al
  102ea4:	75 0c                	jne    102eb2 <strtol+0x9e>
        s ++, base = 8;
  102ea6:	ff 45 08             	incl   0x8(%ebp)
  102ea9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102eb0:	eb 0d                	jmp    102ebf <strtol+0xab>
    }
    else if (base == 0) {
  102eb2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102eb6:	75 07                	jne    102ebf <strtol+0xab>
        base = 10;
  102eb8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102ebf:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec2:	0f b6 00             	movzbl (%eax),%eax
  102ec5:	3c 2f                	cmp    $0x2f,%al
  102ec7:	7e 1b                	jle    102ee4 <strtol+0xd0>
  102ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  102ecc:	0f b6 00             	movzbl (%eax),%eax
  102ecf:	3c 39                	cmp    $0x39,%al
  102ed1:	7f 11                	jg     102ee4 <strtol+0xd0>
            dig = *s - '0';
  102ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed6:	0f b6 00             	movzbl (%eax),%eax
  102ed9:	0f be c0             	movsbl %al,%eax
  102edc:	83 e8 30             	sub    $0x30,%eax
  102edf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ee2:	eb 48                	jmp    102f2c <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ee7:	0f b6 00             	movzbl (%eax),%eax
  102eea:	3c 60                	cmp    $0x60,%al
  102eec:	7e 1b                	jle    102f09 <strtol+0xf5>
  102eee:	8b 45 08             	mov    0x8(%ebp),%eax
  102ef1:	0f b6 00             	movzbl (%eax),%eax
  102ef4:	3c 7a                	cmp    $0x7a,%al
  102ef6:	7f 11                	jg     102f09 <strtol+0xf5>
            dig = *s - 'a' + 10;
  102ef8:	8b 45 08             	mov    0x8(%ebp),%eax
  102efb:	0f b6 00             	movzbl (%eax),%eax
  102efe:	0f be c0             	movsbl %al,%eax
  102f01:	83 e8 57             	sub    $0x57,%eax
  102f04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f07:	eb 23                	jmp    102f2c <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102f09:	8b 45 08             	mov    0x8(%ebp),%eax
  102f0c:	0f b6 00             	movzbl (%eax),%eax
  102f0f:	3c 40                	cmp    $0x40,%al
  102f11:	7e 3b                	jle    102f4e <strtol+0x13a>
  102f13:	8b 45 08             	mov    0x8(%ebp),%eax
  102f16:	0f b6 00             	movzbl (%eax),%eax
  102f19:	3c 5a                	cmp    $0x5a,%al
  102f1b:	7f 31                	jg     102f4e <strtol+0x13a>
            dig = *s - 'A' + 10;
  102f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f20:	0f b6 00             	movzbl (%eax),%eax
  102f23:	0f be c0             	movsbl %al,%eax
  102f26:	83 e8 37             	sub    $0x37,%eax
  102f29:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102f2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f2f:	3b 45 10             	cmp    0x10(%ebp),%eax
  102f32:	7d 19                	jge    102f4d <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102f34:	ff 45 08             	incl   0x8(%ebp)
  102f37:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f3a:	0f af 45 10          	imul   0x10(%ebp),%eax
  102f3e:	89 c2                	mov    %eax,%edx
  102f40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102f43:	01 d0                	add    %edx,%eax
  102f45:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102f48:	e9 72 ff ff ff       	jmp    102ebf <strtol+0xab>
            break;
  102f4d:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102f4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102f52:	74 08                	je     102f5c <strtol+0x148>
        *endptr = (char *) s;
  102f54:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f57:	8b 55 08             	mov    0x8(%ebp),%edx
  102f5a:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102f5c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102f60:	74 07                	je     102f69 <strtol+0x155>
  102f62:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f65:	f7 d8                	neg    %eax
  102f67:	eb 03                	jmp    102f6c <strtol+0x158>
  102f69:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102f6c:	c9                   	leave  
  102f6d:	c3                   	ret    

00102f6e <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102f6e:	f3 0f 1e fb          	endbr32 
  102f72:	55                   	push   %ebp
  102f73:	89 e5                	mov    %esp,%ebp
  102f75:	57                   	push   %edi
  102f76:	83 ec 24             	sub    $0x24,%esp
  102f79:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f7c:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102f7f:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102f83:	8b 45 08             	mov    0x8(%ebp),%eax
  102f86:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102f89:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102f8c:	8b 45 10             	mov    0x10(%ebp),%eax
  102f8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102f92:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102f95:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102f99:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102f9c:	89 d7                	mov    %edx,%edi
  102f9e:	f3 aa                	rep stos %al,%es:(%edi)
  102fa0:	89 fa                	mov    %edi,%edx
  102fa2:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102fa5:	89 55 e8             	mov    %edx,-0x18(%ebp)
    return s;
  102fa8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102fab:	83 c4 24             	add    $0x24,%esp
  102fae:	5f                   	pop    %edi
  102faf:	5d                   	pop    %ebp
  102fb0:	c3                   	ret    

00102fb1 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102fb1:	f3 0f 1e fb          	endbr32 
  102fb5:	55                   	push   %ebp
  102fb6:	89 e5                	mov    %esp,%ebp
  102fb8:	57                   	push   %edi
  102fb9:	56                   	push   %esi
  102fba:	53                   	push   %ebx
  102fbb:	83 ec 30             	sub    $0x30,%esp
  102fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fc4:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fc7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102fca:	8b 45 10             	mov    0x10(%ebp),%eax
  102fcd:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if (dst < src) {
  102fd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fd3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102fd6:	73 42                	jae    10301a <memmove+0x69>
  102fd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fdb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102fde:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102fe1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102fe4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fe7:	89 45 dc             	mov    %eax,-0x24(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102fea:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102fed:	c1 e8 02             	shr    $0x2,%eax
  102ff0:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102ff2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102ff5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ff8:	89 d7                	mov    %edx,%edi
  102ffa:	89 c6                	mov    %eax,%esi
  102ffc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102ffe:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  103001:	83 e1 03             	and    $0x3,%ecx
  103004:	74 02                	je     103008 <memmove+0x57>
  103006:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103008:	89 f0                	mov    %esi,%eax
  10300a:	89 fa                	mov    %edi,%edx
  10300c:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  10300f:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  103012:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  103015:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  103018:	eb 36                	jmp    103050 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  10301a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10301d:	8d 50 ff             	lea    -0x1(%eax),%edx
  103020:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103023:	01 c2                	add    %eax,%edx
  103025:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103028:	8d 48 ff             	lea    -0x1(%eax),%ecx
  10302b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10302e:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  103031:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103034:	89 c1                	mov    %eax,%ecx
  103036:	89 d8                	mov    %ebx,%eax
  103038:	89 d6                	mov    %edx,%esi
  10303a:	89 c7                	mov    %eax,%edi
  10303c:	fd                   	std    
  10303d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10303f:	fc                   	cld    
  103040:	89 f8                	mov    %edi,%eax
  103042:	89 f2                	mov    %esi,%edx
  103044:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103047:	89 55 c8             	mov    %edx,-0x38(%ebp)
  10304a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  10304d:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103050:	83 c4 30             	add    $0x30,%esp
  103053:	5b                   	pop    %ebx
  103054:	5e                   	pop    %esi
  103055:	5f                   	pop    %edi
  103056:	5d                   	pop    %ebp
  103057:	c3                   	ret    

00103058 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103058:	f3 0f 1e fb          	endbr32 
  10305c:	55                   	push   %ebp
  10305d:	89 e5                	mov    %esp,%ebp
  10305f:	57                   	push   %edi
  103060:	56                   	push   %esi
  103061:	83 ec 20             	sub    $0x20,%esp
  103064:	8b 45 08             	mov    0x8(%ebp),%eax
  103067:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10306a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10306d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103070:	8b 45 10             	mov    0x10(%ebp),%eax
  103073:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103076:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103079:	c1 e8 02             	shr    $0x2,%eax
  10307c:	89 c1                	mov    %eax,%ecx
    asm volatile (
  10307e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103081:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103084:	89 d7                	mov    %edx,%edi
  103086:	89 c6                	mov    %eax,%esi
  103088:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10308a:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10308d:	83 e1 03             	and    $0x3,%ecx
  103090:	74 02                	je     103094 <memcpy+0x3c>
  103092:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103094:	89 f0                	mov    %esi,%eax
  103096:	89 fa                	mov    %edi,%edx
  103098:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10309b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10309e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  1030a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  1030a4:	83 c4 20             	add    $0x20,%esp
  1030a7:	5e                   	pop    %esi
  1030a8:	5f                   	pop    %edi
  1030a9:	5d                   	pop    %ebp
  1030aa:	c3                   	ret    

001030ab <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  1030ab:	f3 0f 1e fb          	endbr32 
  1030af:	55                   	push   %ebp
  1030b0:	89 e5                	mov    %esp,%ebp
  1030b2:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  1030b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  1030bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030be:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  1030c1:	eb 2e                	jmp    1030f1 <memcmp+0x46>
        if (*s1 != *s2) {
  1030c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1030c6:	0f b6 10             	movzbl (%eax),%edx
  1030c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1030cc:	0f b6 00             	movzbl (%eax),%eax
  1030cf:	38 c2                	cmp    %al,%dl
  1030d1:	74 18                	je     1030eb <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  1030d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1030d6:	0f b6 00             	movzbl (%eax),%eax
  1030d9:	0f b6 d0             	movzbl %al,%edx
  1030dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1030df:	0f b6 00             	movzbl (%eax),%eax
  1030e2:	0f b6 c0             	movzbl %al,%eax
  1030e5:	29 c2                	sub    %eax,%edx
  1030e7:	89 d0                	mov    %edx,%eax
  1030e9:	eb 18                	jmp    103103 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  1030eb:	ff 45 fc             	incl   -0x4(%ebp)
  1030ee:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  1030f1:	8b 45 10             	mov    0x10(%ebp),%eax
  1030f4:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030f7:	89 55 10             	mov    %edx,0x10(%ebp)
  1030fa:	85 c0                	test   %eax,%eax
  1030fc:	75 c5                	jne    1030c3 <memcmp+0x18>
    }
    return 0;
  1030fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103103:	c9                   	leave  
  103104:	c3                   	ret    

00103105 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  103105:	f3 0f 1e fb          	endbr32 
  103109:	55                   	push   %ebp
  10310a:	89 e5                	mov    %esp,%ebp
  10310c:	83 ec 58             	sub    $0x58,%esp
  10310f:	8b 45 10             	mov    0x10(%ebp),%eax
  103112:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103115:	8b 45 14             	mov    0x14(%ebp),%eax
  103118:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10311b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10311e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103121:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103124:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  103127:	8b 45 18             	mov    0x18(%ebp),%eax
  10312a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  10312d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103130:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103133:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103136:	89 55 f0             	mov    %edx,-0x10(%ebp)
  103139:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10313c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10313f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103143:	74 1c                	je     103161 <printnum+0x5c>
  103145:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103148:	ba 00 00 00 00       	mov    $0x0,%edx
  10314d:	f7 75 e4             	divl   -0x1c(%ebp)
  103150:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103153:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103156:	ba 00 00 00 00       	mov    $0x0,%edx
  10315b:	f7 75 e4             	divl   -0x1c(%ebp)
  10315e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103161:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103164:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103167:	f7 75 e4             	divl   -0x1c(%ebp)
  10316a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10316d:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103170:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103173:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103176:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103179:	89 55 ec             	mov    %edx,-0x14(%ebp)
  10317c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10317f:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  103182:	8b 45 18             	mov    0x18(%ebp),%eax
  103185:	ba 00 00 00 00       	mov    $0x0,%edx
  10318a:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  10318d:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  103190:	19 d1                	sbb    %edx,%ecx
  103192:	72 4c                	jb     1031e0 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  103194:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103197:	8d 50 ff             	lea    -0x1(%eax),%edx
  10319a:	8b 45 20             	mov    0x20(%ebp),%eax
  10319d:	89 44 24 18          	mov    %eax,0x18(%esp)
  1031a1:	89 54 24 14          	mov    %edx,0x14(%esp)
  1031a5:	8b 45 18             	mov    0x18(%ebp),%eax
  1031a8:	89 44 24 10          	mov    %eax,0x10(%esp)
  1031ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031af:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1031b2:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031b6:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1031ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1031c4:	89 04 24             	mov    %eax,(%esp)
  1031c7:	e8 39 ff ff ff       	call   103105 <printnum>
  1031cc:	eb 1b                	jmp    1031e9 <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1031ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031d1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031d5:	8b 45 20             	mov    0x20(%ebp),%eax
  1031d8:	89 04 24             	mov    %eax,(%esp)
  1031db:	8b 45 08             	mov    0x8(%ebp),%eax
  1031de:	ff d0                	call   *%eax
        while (-- width > 0)
  1031e0:	ff 4d 1c             	decl   0x1c(%ebp)
  1031e3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1031e7:	7f e5                	jg     1031ce <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1031e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1031ec:	05 50 3f 10 00       	add    $0x103f50,%eax
  1031f1:	0f b6 00             	movzbl (%eax),%eax
  1031f4:	0f be c0             	movsbl %al,%eax
  1031f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1031fa:	89 54 24 04          	mov    %edx,0x4(%esp)
  1031fe:	89 04 24             	mov    %eax,(%esp)
  103201:	8b 45 08             	mov    0x8(%ebp),%eax
  103204:	ff d0                	call   *%eax
}
  103206:	90                   	nop
  103207:	c9                   	leave  
  103208:	c3                   	ret    

00103209 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  103209:	f3 0f 1e fb          	endbr32 
  10320d:	55                   	push   %ebp
  10320e:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103210:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103214:	7e 14                	jle    10322a <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  103216:	8b 45 08             	mov    0x8(%ebp),%eax
  103219:	8b 00                	mov    (%eax),%eax
  10321b:	8d 48 08             	lea    0x8(%eax),%ecx
  10321e:	8b 55 08             	mov    0x8(%ebp),%edx
  103221:	89 0a                	mov    %ecx,(%edx)
  103223:	8b 50 04             	mov    0x4(%eax),%edx
  103226:	8b 00                	mov    (%eax),%eax
  103228:	eb 30                	jmp    10325a <getuint+0x51>
    }
    else if (lflag) {
  10322a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10322e:	74 16                	je     103246 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  103230:	8b 45 08             	mov    0x8(%ebp),%eax
  103233:	8b 00                	mov    (%eax),%eax
  103235:	8d 48 04             	lea    0x4(%eax),%ecx
  103238:	8b 55 08             	mov    0x8(%ebp),%edx
  10323b:	89 0a                	mov    %ecx,(%edx)
  10323d:	8b 00                	mov    (%eax),%eax
  10323f:	ba 00 00 00 00       	mov    $0x0,%edx
  103244:	eb 14                	jmp    10325a <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  103246:	8b 45 08             	mov    0x8(%ebp),%eax
  103249:	8b 00                	mov    (%eax),%eax
  10324b:	8d 48 04             	lea    0x4(%eax),%ecx
  10324e:	8b 55 08             	mov    0x8(%ebp),%edx
  103251:	89 0a                	mov    %ecx,(%edx)
  103253:	8b 00                	mov    (%eax),%eax
  103255:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10325a:	5d                   	pop    %ebp
  10325b:	c3                   	ret    

0010325c <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  10325c:	f3 0f 1e fb          	endbr32 
  103260:	55                   	push   %ebp
  103261:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103263:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103267:	7e 14                	jle    10327d <getint+0x21>
        return va_arg(*ap, long long);
  103269:	8b 45 08             	mov    0x8(%ebp),%eax
  10326c:	8b 00                	mov    (%eax),%eax
  10326e:	8d 48 08             	lea    0x8(%eax),%ecx
  103271:	8b 55 08             	mov    0x8(%ebp),%edx
  103274:	89 0a                	mov    %ecx,(%edx)
  103276:	8b 50 04             	mov    0x4(%eax),%edx
  103279:	8b 00                	mov    (%eax),%eax
  10327b:	eb 28                	jmp    1032a5 <getint+0x49>
    }
    else if (lflag) {
  10327d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103281:	74 12                	je     103295 <getint+0x39>
        return va_arg(*ap, long);
  103283:	8b 45 08             	mov    0x8(%ebp),%eax
  103286:	8b 00                	mov    (%eax),%eax
  103288:	8d 48 04             	lea    0x4(%eax),%ecx
  10328b:	8b 55 08             	mov    0x8(%ebp),%edx
  10328e:	89 0a                	mov    %ecx,(%edx)
  103290:	8b 00                	mov    (%eax),%eax
  103292:	99                   	cltd   
  103293:	eb 10                	jmp    1032a5 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  103295:	8b 45 08             	mov    0x8(%ebp),%eax
  103298:	8b 00                	mov    (%eax),%eax
  10329a:	8d 48 04             	lea    0x4(%eax),%ecx
  10329d:	8b 55 08             	mov    0x8(%ebp),%edx
  1032a0:	89 0a                	mov    %ecx,(%edx)
  1032a2:	8b 00                	mov    (%eax),%eax
  1032a4:	99                   	cltd   
    }
}
  1032a5:	5d                   	pop    %ebp
  1032a6:	c3                   	ret    

001032a7 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1032a7:	f3 0f 1e fb          	endbr32 
  1032ab:	55                   	push   %ebp
  1032ac:	89 e5                	mov    %esp,%ebp
  1032ae:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1032b1:	8d 45 14             	lea    0x14(%ebp),%eax
  1032b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1032b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032ba:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1032be:	8b 45 10             	mov    0x10(%ebp),%eax
  1032c1:	89 44 24 08          	mov    %eax,0x8(%esp)
  1032c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032c8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1032cf:	89 04 24             	mov    %eax,(%esp)
  1032d2:	e8 03 00 00 00       	call   1032da <vprintfmt>
    va_end(ap);
}
  1032d7:	90                   	nop
  1032d8:	c9                   	leave  
  1032d9:	c3                   	ret    

001032da <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1032da:	f3 0f 1e fb          	endbr32 
  1032de:	55                   	push   %ebp
  1032df:	89 e5                	mov    %esp,%ebp
  1032e1:	56                   	push   %esi
  1032e2:	53                   	push   %ebx
  1032e3:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1032e6:	eb 17                	jmp    1032ff <vprintfmt+0x25>
            if (ch == '\0') {
  1032e8:	85 db                	test   %ebx,%ebx
  1032ea:	0f 84 c0 03 00 00    	je     1036b0 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  1032f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032f7:	89 1c 24             	mov    %ebx,(%esp)
  1032fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1032fd:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1032ff:	8b 45 10             	mov    0x10(%ebp),%eax
  103302:	8d 50 01             	lea    0x1(%eax),%edx
  103305:	89 55 10             	mov    %edx,0x10(%ebp)
  103308:	0f b6 00             	movzbl (%eax),%eax
  10330b:	0f b6 d8             	movzbl %al,%ebx
  10330e:	83 fb 25             	cmp    $0x25,%ebx
  103311:	75 d5                	jne    1032e8 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103313:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  103317:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  10331e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103321:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103324:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10332b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10332e:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103331:	8b 45 10             	mov    0x10(%ebp),%eax
  103334:	8d 50 01             	lea    0x1(%eax),%edx
  103337:	89 55 10             	mov    %edx,0x10(%ebp)
  10333a:	0f b6 00             	movzbl (%eax),%eax
  10333d:	0f b6 d8             	movzbl %al,%ebx
  103340:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103343:	83 f8 55             	cmp    $0x55,%eax
  103346:	0f 87 38 03 00 00    	ja     103684 <vprintfmt+0x3aa>
  10334c:	8b 04 85 74 3f 10 00 	mov    0x103f74(,%eax,4),%eax
  103353:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  103356:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  10335a:	eb d5                	jmp    103331 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  10335c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  103360:	eb cf                	jmp    103331 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103362:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  103369:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10336c:	89 d0                	mov    %edx,%eax
  10336e:	c1 e0 02             	shl    $0x2,%eax
  103371:	01 d0                	add    %edx,%eax
  103373:	01 c0                	add    %eax,%eax
  103375:	01 d8                	add    %ebx,%eax
  103377:	83 e8 30             	sub    $0x30,%eax
  10337a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  10337d:	8b 45 10             	mov    0x10(%ebp),%eax
  103380:	0f b6 00             	movzbl (%eax),%eax
  103383:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  103386:	83 fb 2f             	cmp    $0x2f,%ebx
  103389:	7e 38                	jle    1033c3 <vprintfmt+0xe9>
  10338b:	83 fb 39             	cmp    $0x39,%ebx
  10338e:	7f 33                	jg     1033c3 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  103390:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  103393:	eb d4                	jmp    103369 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  103395:	8b 45 14             	mov    0x14(%ebp),%eax
  103398:	8d 50 04             	lea    0x4(%eax),%edx
  10339b:	89 55 14             	mov    %edx,0x14(%ebp)
  10339e:	8b 00                	mov    (%eax),%eax
  1033a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1033a3:	eb 1f                	jmp    1033c4 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  1033a5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033a9:	79 86                	jns    103331 <vprintfmt+0x57>
                width = 0;
  1033ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  1033b2:	e9 7a ff ff ff       	jmp    103331 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  1033b7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  1033be:	e9 6e ff ff ff       	jmp    103331 <vprintfmt+0x57>
            goto process_precision;
  1033c3:	90                   	nop

        process_precision:
            if (width < 0)
  1033c4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033c8:	0f 89 63 ff ff ff    	jns    103331 <vprintfmt+0x57>
                width = precision, precision = -1;
  1033ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1033d4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  1033db:	e9 51 ff ff ff       	jmp    103331 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  1033e0:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  1033e3:	e9 49 ff ff ff       	jmp    103331 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1033e8:	8b 45 14             	mov    0x14(%ebp),%eax
  1033eb:	8d 50 04             	lea    0x4(%eax),%edx
  1033ee:	89 55 14             	mov    %edx,0x14(%ebp)
  1033f1:	8b 00                	mov    (%eax),%eax
  1033f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033f6:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033fa:	89 04 24             	mov    %eax,(%esp)
  1033fd:	8b 45 08             	mov    0x8(%ebp),%eax
  103400:	ff d0                	call   *%eax
            break;
  103402:	e9 a4 02 00 00       	jmp    1036ab <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  103407:	8b 45 14             	mov    0x14(%ebp),%eax
  10340a:	8d 50 04             	lea    0x4(%eax),%edx
  10340d:	89 55 14             	mov    %edx,0x14(%ebp)
  103410:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103412:	85 db                	test   %ebx,%ebx
  103414:	79 02                	jns    103418 <vprintfmt+0x13e>
                err = -err;
  103416:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103418:	83 fb 06             	cmp    $0x6,%ebx
  10341b:	7f 0b                	jg     103428 <vprintfmt+0x14e>
  10341d:	8b 34 9d 34 3f 10 00 	mov    0x103f34(,%ebx,4),%esi
  103424:	85 f6                	test   %esi,%esi
  103426:	75 23                	jne    10344b <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  103428:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10342c:	c7 44 24 08 61 3f 10 	movl   $0x103f61,0x8(%esp)
  103433:	00 
  103434:	8b 45 0c             	mov    0xc(%ebp),%eax
  103437:	89 44 24 04          	mov    %eax,0x4(%esp)
  10343b:	8b 45 08             	mov    0x8(%ebp),%eax
  10343e:	89 04 24             	mov    %eax,(%esp)
  103441:	e8 61 fe ff ff       	call   1032a7 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103446:	e9 60 02 00 00       	jmp    1036ab <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  10344b:	89 74 24 0c          	mov    %esi,0xc(%esp)
  10344f:	c7 44 24 08 6a 3f 10 	movl   $0x103f6a,0x8(%esp)
  103456:	00 
  103457:	8b 45 0c             	mov    0xc(%ebp),%eax
  10345a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10345e:	8b 45 08             	mov    0x8(%ebp),%eax
  103461:	89 04 24             	mov    %eax,(%esp)
  103464:	e8 3e fe ff ff       	call   1032a7 <printfmt>
            break;
  103469:	e9 3d 02 00 00       	jmp    1036ab <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  10346e:	8b 45 14             	mov    0x14(%ebp),%eax
  103471:	8d 50 04             	lea    0x4(%eax),%edx
  103474:	89 55 14             	mov    %edx,0x14(%ebp)
  103477:	8b 30                	mov    (%eax),%esi
  103479:	85 f6                	test   %esi,%esi
  10347b:	75 05                	jne    103482 <vprintfmt+0x1a8>
                p = "(null)";
  10347d:	be 6d 3f 10 00       	mov    $0x103f6d,%esi
            }
            if (width > 0 && padc != '-') {
  103482:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103486:	7e 76                	jle    1034fe <vprintfmt+0x224>
  103488:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  10348c:	74 70                	je     1034fe <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  10348e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103491:	89 44 24 04          	mov    %eax,0x4(%esp)
  103495:	89 34 24             	mov    %esi,(%esp)
  103498:	e8 ba f7 ff ff       	call   102c57 <strnlen>
  10349d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1034a0:	29 c2                	sub    %eax,%edx
  1034a2:	89 d0                	mov    %edx,%eax
  1034a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1034a7:	eb 16                	jmp    1034bf <vprintfmt+0x1e5>
                    putch(padc, putdat);
  1034a9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1034ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  1034b0:	89 54 24 04          	mov    %edx,0x4(%esp)
  1034b4:	89 04 24             	mov    %eax,(%esp)
  1034b7:	8b 45 08             	mov    0x8(%ebp),%eax
  1034ba:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  1034bc:	ff 4d e8             	decl   -0x18(%ebp)
  1034bf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1034c3:	7f e4                	jg     1034a9 <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1034c5:	eb 37                	jmp    1034fe <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  1034c7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  1034cb:	74 1f                	je     1034ec <vprintfmt+0x212>
  1034cd:	83 fb 1f             	cmp    $0x1f,%ebx
  1034d0:	7e 05                	jle    1034d7 <vprintfmt+0x1fd>
  1034d2:	83 fb 7e             	cmp    $0x7e,%ebx
  1034d5:	7e 15                	jle    1034ec <vprintfmt+0x212>
                    putch('?', putdat);
  1034d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034de:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  1034e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1034e8:	ff d0                	call   *%eax
  1034ea:	eb 0f                	jmp    1034fb <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  1034ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034f3:	89 1c 24             	mov    %ebx,(%esp)
  1034f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1034f9:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1034fb:	ff 4d e8             	decl   -0x18(%ebp)
  1034fe:	89 f0                	mov    %esi,%eax
  103500:	8d 70 01             	lea    0x1(%eax),%esi
  103503:	0f b6 00             	movzbl (%eax),%eax
  103506:	0f be d8             	movsbl %al,%ebx
  103509:	85 db                	test   %ebx,%ebx
  10350b:	74 27                	je     103534 <vprintfmt+0x25a>
  10350d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103511:	78 b4                	js     1034c7 <vprintfmt+0x1ed>
  103513:	ff 4d e4             	decl   -0x1c(%ebp)
  103516:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10351a:	79 ab                	jns    1034c7 <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  10351c:	eb 16                	jmp    103534 <vprintfmt+0x25a>
                putch(' ', putdat);
  10351e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103521:	89 44 24 04          	mov    %eax,0x4(%esp)
  103525:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10352c:	8b 45 08             	mov    0x8(%ebp),%eax
  10352f:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103531:	ff 4d e8             	decl   -0x18(%ebp)
  103534:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103538:	7f e4                	jg     10351e <vprintfmt+0x244>
            }
            break;
  10353a:	e9 6c 01 00 00       	jmp    1036ab <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10353f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103542:	89 44 24 04          	mov    %eax,0x4(%esp)
  103546:	8d 45 14             	lea    0x14(%ebp),%eax
  103549:	89 04 24             	mov    %eax,(%esp)
  10354c:	e8 0b fd ff ff       	call   10325c <getint>
  103551:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103554:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  103557:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10355a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10355d:	85 d2                	test   %edx,%edx
  10355f:	79 26                	jns    103587 <vprintfmt+0x2ad>
                putch('-', putdat);
  103561:	8b 45 0c             	mov    0xc(%ebp),%eax
  103564:	89 44 24 04          	mov    %eax,0x4(%esp)
  103568:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  10356f:	8b 45 08             	mov    0x8(%ebp),%eax
  103572:	ff d0                	call   *%eax
                num = -(long long)num;
  103574:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103577:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10357a:	f7 d8                	neg    %eax
  10357c:	83 d2 00             	adc    $0x0,%edx
  10357f:	f7 da                	neg    %edx
  103581:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103584:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  103587:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  10358e:	e9 a8 00 00 00       	jmp    10363b <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  103593:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103596:	89 44 24 04          	mov    %eax,0x4(%esp)
  10359a:	8d 45 14             	lea    0x14(%ebp),%eax
  10359d:	89 04 24             	mov    %eax,(%esp)
  1035a0:	e8 64 fc ff ff       	call   103209 <getuint>
  1035a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1035ab:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1035b2:	e9 84 00 00 00       	jmp    10363b <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1035b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1035ba:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035be:	8d 45 14             	lea    0x14(%ebp),%eax
  1035c1:	89 04 24             	mov    %eax,(%esp)
  1035c4:	e8 40 fc ff ff       	call   103209 <getuint>
  1035c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035cc:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  1035cf:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  1035d6:	eb 63                	jmp    10363b <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  1035d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035df:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  1035e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1035e9:	ff d0                	call   *%eax
            putch('x', putdat);
  1035eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035f2:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  1035f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1035fc:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  1035fe:	8b 45 14             	mov    0x14(%ebp),%eax
  103601:	8d 50 04             	lea    0x4(%eax),%edx
  103604:	89 55 14             	mov    %edx,0x14(%ebp)
  103607:	8b 00                	mov    (%eax),%eax
  103609:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10360c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103613:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10361a:	eb 1f                	jmp    10363b <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10361c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10361f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103623:	8d 45 14             	lea    0x14(%ebp),%eax
  103626:	89 04 24             	mov    %eax,(%esp)
  103629:	e8 db fb ff ff       	call   103209 <getuint>
  10362e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103631:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103634:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10363b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  10363f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103642:	89 54 24 18          	mov    %edx,0x18(%esp)
  103646:	8b 55 e8             	mov    -0x18(%ebp),%edx
  103649:	89 54 24 14          	mov    %edx,0x14(%esp)
  10364d:	89 44 24 10          	mov    %eax,0x10(%esp)
  103651:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103654:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103657:	89 44 24 08          	mov    %eax,0x8(%esp)
  10365b:	89 54 24 0c          	mov    %edx,0xc(%esp)
  10365f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103662:	89 44 24 04          	mov    %eax,0x4(%esp)
  103666:	8b 45 08             	mov    0x8(%ebp),%eax
  103669:	89 04 24             	mov    %eax,(%esp)
  10366c:	e8 94 fa ff ff       	call   103105 <printnum>
            break;
  103671:	eb 38                	jmp    1036ab <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103673:	8b 45 0c             	mov    0xc(%ebp),%eax
  103676:	89 44 24 04          	mov    %eax,0x4(%esp)
  10367a:	89 1c 24             	mov    %ebx,(%esp)
  10367d:	8b 45 08             	mov    0x8(%ebp),%eax
  103680:	ff d0                	call   *%eax
            break;
  103682:	eb 27                	jmp    1036ab <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103684:	8b 45 0c             	mov    0xc(%ebp),%eax
  103687:	89 44 24 04          	mov    %eax,0x4(%esp)
  10368b:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  103692:	8b 45 08             	mov    0x8(%ebp),%eax
  103695:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  103697:	ff 4d 10             	decl   0x10(%ebp)
  10369a:	eb 03                	jmp    10369f <vprintfmt+0x3c5>
  10369c:	ff 4d 10             	decl   0x10(%ebp)
  10369f:	8b 45 10             	mov    0x10(%ebp),%eax
  1036a2:	48                   	dec    %eax
  1036a3:	0f b6 00             	movzbl (%eax),%eax
  1036a6:	3c 25                	cmp    $0x25,%al
  1036a8:	75 f2                	jne    10369c <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  1036aa:	90                   	nop
    while (1) {
  1036ab:	e9 36 fc ff ff       	jmp    1032e6 <vprintfmt+0xc>
                return;
  1036b0:	90                   	nop
        }
    }
}
  1036b1:	83 c4 40             	add    $0x40,%esp
  1036b4:	5b                   	pop    %ebx
  1036b5:	5e                   	pop    %esi
  1036b6:	5d                   	pop    %ebp
  1036b7:	c3                   	ret    

001036b8 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1036b8:	f3 0f 1e fb          	endbr32 
  1036bc:	55                   	push   %ebp
  1036bd:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1036bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036c2:	8b 40 08             	mov    0x8(%eax),%eax
  1036c5:	8d 50 01             	lea    0x1(%eax),%edx
  1036c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036cb:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1036ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036d1:	8b 10                	mov    (%eax),%edx
  1036d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036d6:	8b 40 04             	mov    0x4(%eax),%eax
  1036d9:	39 c2                	cmp    %eax,%edx
  1036db:	73 12                	jae    1036ef <sprintputch+0x37>
        *b->buf ++ = ch;
  1036dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036e0:	8b 00                	mov    (%eax),%eax
  1036e2:	8d 48 01             	lea    0x1(%eax),%ecx
  1036e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  1036e8:	89 0a                	mov    %ecx,(%edx)
  1036ea:	8b 55 08             	mov    0x8(%ebp),%edx
  1036ed:	88 10                	mov    %dl,(%eax)
    }
}
  1036ef:	90                   	nop
  1036f0:	5d                   	pop    %ebp
  1036f1:	c3                   	ret    

001036f2 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1036f2:	f3 0f 1e fb          	endbr32 
  1036f6:	55                   	push   %ebp
  1036f7:	89 e5                	mov    %esp,%ebp
  1036f9:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1036fc:	8d 45 14             	lea    0x14(%ebp),%eax
  1036ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103702:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103705:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103709:	8b 45 10             	mov    0x10(%ebp),%eax
  10370c:	89 44 24 08          	mov    %eax,0x8(%esp)
  103710:	8b 45 0c             	mov    0xc(%ebp),%eax
  103713:	89 44 24 04          	mov    %eax,0x4(%esp)
  103717:	8b 45 08             	mov    0x8(%ebp),%eax
  10371a:	89 04 24             	mov    %eax,(%esp)
  10371d:	e8 08 00 00 00       	call   10372a <vsnprintf>
  103722:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103725:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103728:	c9                   	leave  
  103729:	c3                   	ret    

0010372a <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10372a:	f3 0f 1e fb          	endbr32 
  10372e:	55                   	push   %ebp
  10372f:	89 e5                	mov    %esp,%ebp
  103731:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103734:	8b 45 08             	mov    0x8(%ebp),%eax
  103737:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10373a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10373d:	8d 50 ff             	lea    -0x1(%eax),%edx
  103740:	8b 45 08             	mov    0x8(%ebp),%eax
  103743:	01 d0                	add    %edx,%eax
  103745:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103748:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  10374f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103753:	74 0a                	je     10375f <vsnprintf+0x35>
  103755:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103758:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10375b:	39 c2                	cmp    %eax,%edx
  10375d:	76 07                	jbe    103766 <vsnprintf+0x3c>
        return -E_INVAL;
  10375f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103764:	eb 2a                	jmp    103790 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103766:	8b 45 14             	mov    0x14(%ebp),%eax
  103769:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10376d:	8b 45 10             	mov    0x10(%ebp),%eax
  103770:	89 44 24 08          	mov    %eax,0x8(%esp)
  103774:	8d 45 ec             	lea    -0x14(%ebp),%eax
  103777:	89 44 24 04          	mov    %eax,0x4(%esp)
  10377b:	c7 04 24 b8 36 10 00 	movl   $0x1036b8,(%esp)
  103782:	e8 53 fb ff ff       	call   1032da <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  103787:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10378a:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  10378d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103790:	c9                   	leave  
  103791:	c3                   	ret    
