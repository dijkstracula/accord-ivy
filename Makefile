SRCDIR=src
TOPLVLSRC=protocol.ivy
SRCS=$(SRCDIR)/$(TOPLVLSRC) $(wildcard $(SRCDIR)/*.ivy)

CC=ivyc
CFLAGS=target=test

LCH=ivy_launch
LCHFLAGS=coord_id.max=2
EXE=protocol

CHK=ivy_check
CHKFLAGS=isolate=this detailed=false

.PHONY: all build clean test bmc
all: build test Makefile

build: $(SRCDIR)$(EXE)

$(SRCDIR)$(EXE): $(SRCS)
	cd $(SRCDIR); $(CC) $(CFLAGS) $(notdir $<)

test: build
	cd $(SRCDIR); $(LCH) $(LCHFLAGS) $(EXE) | sed -e '/{$$/,/}$$/ d'

bmc:
	cd $(SRCDIR); $(CHK) $(CHKFLAGS) $(TOPLVLSRC)

clean:
	./scripts/ivy_clean.sh
