# hello world Makefile
# Ben Staehle
# 2/1/2024

CC = cc65
LD = ld65

SRCS = hello-world.c
OBJS = hello-world.o

TARGET = hello-world

.PHONY: clean

%.o: %.c
	$(CC) $^ -o $@

$(TARGET): $(OBJS)
	$(LD) $^ -o $@ -C linker.cfg -L liblcd --lib liblcd.a

clean:
	rm *.o
	rm $(TARGET)