SRCDIR=src
TOPLVLSRC=protocol.ivy
ABSSRC=abstract_protocol.ivy

SRCS=$(SRCDIR)/$(TOPLVLSRC) $(wildcard $(SRCDIR)/*.ivy)

CC=ivyc
CFLAGS=target=test

LCH=ivy_launch
LCHFLAGS=node_id.max=3
EXE=protocol

CHK=ivy_check
CHKFLAGS=isolate=this detailed=false

.PHONY: all build clean test bmc
all: build test Makefile

build: $(SRCDIR)/$(EXE)

$(SRCDIR)/$(EXE): $(SRCS)
	cd $(SRCDIR); $(CC) $(CFLAGS) $(notdir $<)

test: build
	cd $(SRCDIR); $(LCH) $(LCHFLAGS) $(EXE) #| sed -e '/{$$/,/}$$/ d'

proof:
	cd $(SRCDIR); $(CHK) $(CHKFLAGS) $(TOPLVLSRC)
	cd $(SRCDIR); $(CHK) $(CHKFLAGS) $(ABSSRC)

clean:
	./scripts/ivy_clean.sh
