GCC = nspire-gcc
LD = nspire-ld
GCCFLAGS = -Os -Wall -W
LDFLAGS = 
OBJCOPY := "$(shell which arm-elf-objcopy 2>/dev/null)"
ifeq (${OBJCOPY},"")
	OBJCOPY := arm-none-eabi-objcopy
endif
OBJS = run.o elf_header.o elf_section.o elf_string.o elf_reloc.o elf_load.o
DISTDIR = .
vpath %.tns $(DISTDIR)

GENZEHN = genzehn
ZEHNFLAGS = --name gpsp_launcher

all: gpsp_launcher.tns

%.o: %.c
	$(GCC) $(GCCFLAGS) -c $<

%.o: %.S
	$(GCC) $(GCCFLAGS) -c $<

gpsp_launcher.tns: $(OBJS)
	$(LD) $(LDFLAGS) $^ -o $(@:.tns=.elf)
	@mkdir -p $(DISTDIR)
	$(GENZEHN) --input $(@:.tns=.elf) --output $(DISTDIR)/_$@ $(ZEHNFLAGS)
	make-prg $(DISTDIR)/_$@ $(DISTDIR)/$@
	@rm $(DISTDIR)/_$@	

clean:
	rm -f *.o *.elf
	rm -f $(DISTDIR)/gpsp_launcher.tns
