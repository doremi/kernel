# Comment/uncomment the following line to disable/enable debugging
DEBUG = y

# Add your debugging flag (or not) to CFLAGS
ifeq ($(DEBUG),y)
  DEBFLAGS = -O -g # "-O" is needed to expand inlines
else
  DEBFLAGS = -O2
endif


EXTRA_CFLAGS += $(DEBFLAGS) 
#-I$(LDDINCDIR)

ifneq ($(KERNELRELEASE),)
# call from kernel build system

obj-m	:= simple.o

else

KERNELDIR ?= /home/shane/kernel/linux-2.6.33/build
#KERNELDIR ?= /usr/src/linux-source-2.6.28/build
#KERNELDIR ?= /lib/modules/$(shell uname -r)/build
#KERNELDIR ?= /home/doremi/android/kernel/common/build
PWD       := $(shell pwd)

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
#LDDINCDIR=$(PWD)/../include modules

endif



clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions

depend .depend dep:
	$(CC) $(CFLAGS) -M *.c > .depend


ifeq (.depend,$(wildcard .depend))
include .depend
endif
