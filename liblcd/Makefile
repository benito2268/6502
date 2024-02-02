AS = ca65
# liblcd.a Makefile
# Ben Staehle
# 2/1/2024

AR = ar65

SRCS = liblcd.s
OBJS = liblcd.o

TARGET = liblcd.a

.PHONY: clean

all: $(TARGET)

%.o: %.s
	$(AS) $^ -o $@

$(TARGET): $(OBJS)
	$(AR) r $@ $^

clean:
	rm *.o
	rm $(TARGET)
