/*
* hello-world.c
* a hello world program for Ben Eater's 6502 computer
* compile cc65 and link against liblcd.a (see Makefile)
*
* Ben Staehle
* 2/1/24
*/

//declare the lcd functions (part of liblcd.a)
//TODO fix linkage - won't link since C functions are prefixed with '_'
extern void lcd_init(void);
extern void lcd_clear(void);
extern void lcd_putstr(void);

void main(void)
{
    char *str = "Hello World!";

    //located in liblcd.s
    lcd_init();

    //lcd_putstr expects a pointer to a null-terminated string
    //in the X register (for now)
    __asm__ volatile("ldx %s", str);
    lcd_putstr();

    //infinite loop
    for(;;);
}