CC				?=cc
CFLAGS			?=-O2 -g

prefix			?=/usr/local
exec_prefix		?=$(prefix)
bindir			?=$(exec_prefix)/bin
includedir		?=$(exec_prefix)/include
libdir			?=$(exec_prefix)/lib
datarootdir		?=$(prefix)/share
datadir			?=$(datarootdir)
docdir			?=$(datarootdir)/doc/musl-compat-$(VERSION)
mandir			?=$(datarootdir)/man

BINS			= $(notdir $(basename $(wildcard bin/*.c)))
BINS_SH			= $(notdir $(basename $(wildcard bin/*.sh)))
INCLUDES		= $(notdir $(wildcard include/*.h))
LIBS			= $(notdir $(wildcard lib/*.a))

VERSION			=1

build:	bin/getconf.o bin/getent.o bin/ldconfig.sh

bin/%.sh: bin/%.sh.in
	cp $< $@
	chmod +x "$@"

bin/%.o: bin/%.c
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

$(DESTDIR)$(bindir)/%: bin/$(notdir %)
	install -D $< $(basename $@)

$(DESTDIR)$(includedir)/%: include/$(notdir %)
	install -D $< $@

$(DESTDIR)$(libdir)/%: lib/$(notdir %)
	install -D $< $@

install: build $(foreach b,$(BINS),$(DESTDIR)$(bindir)/$(b).o) $(foreach b,$(BINS_SH),$(DESTDIR)$(bindir)/$(b).sh) $(foreach i,$(INCLUDES),$(DESTDIR)$(includedir)/$(i)) $(foreach l,$(LIBS),$(DESTDIR)$(libdir)/$(l))

clean:
	rm -rf $(foreach b,$(BINS),bin/$(b).o) $(foreach b,$(BINS_SH),bin/$(b).sh)

.PHONY:	all build clean install
