PWD = $(shell pwd)

KDIR = /lib/modules/$(shell uname -r)/build

module := kernelFuncMonitor

obj-m := $(module).o

TARGET = $(module).ko

all:
	make -C $(KDIR) M=$(PWD) modules

install:
	insmod $(TARGET)
 
remove:
	rmmod $(TARGET)

clean:
	make -C $(KDIR) M=$(PWD) clean
