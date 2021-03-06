ABS_VERSION = 2.4.4
DESTDIR = $$PWD
BINDIR = /usr/bin/
CONFDIR = /etc/
PROTOTYPEDIR = /usr/share/pacman/
BUILDDIR = build/

scripts = \
	abs \
	makeworld \
	scripts/svn2abs

all: $(scripts)

#### Output formatting ####
SPC  = \x20
RST  = \e[0m
BOLD = \e[1m
RED  = \e[1;31m
YLW  = \e[1;33m
IND1 = $(RED)===$(SPC)$(RST)
IND2 = $(YLW)$(SPC)=>$(SPC)$(RST)
MSG1 = $(IND1)$(BOLD)$(1)$(SPC)$(IND1)
MSG2 = $(IND2)$(BOLD)$(1)$(RST)

V_GEN = $(_v_GEN_$(V))
_v_GEN_ = $(_v_GEN_0)
_v_GEN_0 = @echo "  GEN     " $@;
_v_GEN_1 =

%: %.in
	$(edit) $<
	@chmod 755 $@

edit = \
	$(V_GEN) sed \
	-e 's,%%CONF_DIR%%,$(CONFDIR),g' \
	-e 's,%%ABS_VERSION%%,$(ABS_VERSION),g' \
	< $< > $@ || rm $@

.PHONY: install
install: $(scripts)
	@echo -e "$(call MSG1,abs install)"
	@echo -e "$(call MSG2,Installing scripts into $(DESTDIR)$(BINDIR))"
	@mkdir -p $(DESTDIR)$(BINDIR)
	@install -m755 abs $(DESTDIR)$(BINDIR)
	@install -m755 makeworld $(DESTDIR)$(BINDIR)
	@echo -e "$(call MSG2,Installing abs configuration file into $(DESTDIR)$(CONFDIR))"
	@mkdir -p $(DESTDIR)$(CONFDIR)
	@install -m 644 conf/abs.conf $(DESTDIR)$(CONFDIR)
	@echo -e "$(call MSG2,Installing prototype files into $(DESTDIR)$(PROTOTYPEDIR))"
	@mkdir -p $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-gnome.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-haskell.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-perl.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-python.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-rubygem.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/proto-gnome.install $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/proto-haskell.install $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/proto-info.install $(DESTDIR)$(PROTOTYPEDIR)

.PHONY: uninstall
uninstall:
	@echo -e "$(call MSG1,abs uninstall)"
	@echo -e "$(call MSG2,Removing scripts)"
	@rm $(DESTDIR)$(BINDIR)abs
	@rm $(DESTDIR)$(BINDIR)makeworld
	@echo -e "$(call MSG2,Removing configuration file)"
	@rm $(DESTDIR)$(CONFDIR)abs.conf
	@echo -e "$(call MSG2,Removing prototype files)"
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-gnome.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-haskell.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-perl.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-python.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-rubygem.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)proto-gnome.install
	@rm $(DESTDIR)$(PROTOTYPEDIR)proto-haskell.install
	@rm $(DESTDIR)$(PROTOTYPEDIR)proto-info.install

.PHONY: dist
dist:
	git archive --format=tar --prefix=abs-$(ABS_VERSION)/ $(ABS_VERSION) | gzip -9 > abs-$(ABS_VERSION).tar.gz

clean:
	$(RM) $(scripts)
