PWD = $(shell pwd)

KDIR = /lib/modules/$(shell uname -r)/build

module := kprobe_test

obj-m := $(module).o

TARGET = $(module).ko

all:
	make -C $(KDIR) M=$(PWD) modules

install:
	insmod $(TARGET)
  
clean:
	rmmod $(TARGET)
	make -C $(KDIR) M=$(PWD) clean
	
