SRCDIR=src
TOPLVLSRC=protocol.ivy
ABSSRC=abstract_protocol.ivy

SRCS=$(SRCDIR)/$(TOPLVLSRC) $(wildcard $(SRCDIR)/*.ivy)

CC=ivyc
CFLAGS=target=test

LCH=ivy_launch
LCHFLAGS=node_id.max=4 iters=2500
EXE=protocol

CHK=ivy_check
CHKFLAGS=detailed=false

CTAGS=ctags
CTAGSFLAGS=--options=./scripts/ivy.ctags

.PHONY: all build clean test bmc
all: build test Makefile

build: $(SRCDIR)/$(EXE)

$(SRCDIR)/$(EXE): $(SRCS)
	cd $(SRCDIR); $(CC) $(CFLAGS) $(notdir $<)

test: build
	cd $(SRCDIR); $(LCH) $(LCHFLAGS) $(EXE) #| sed -e '/{$$/,/}$$/ d'

proof:
	cd $(SRCDIR); $(CHK) $(CHKFLAGS) $(ABSSRC)
	cd $(SRCDIR); $(CHK) $(CHKFLAGS) $(TOPLVLSRC)

tags: $(SRCS)
	rm tags || true
	$(CTAGS) $(CTAGSFLAGS) -L<(find ~/code/ivy/ivy/include/1.8)
	$(CTAGS) $(CTAGSFLAGS) --append -R


clean:
	./scripts/ivy_clean.sh
