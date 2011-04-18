ABS_VERSION = 2.4.3
DESTDIR = $$PWD
BINDIR = /usr/bin/
CONFDIR = /etc/
PROTOTYPEDIR = /usr/share/pacman/
BUILDDIR = build/

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

.PHONY: prepare
prepare:
	@echo -e "$(call MSG1,Prepare abs for install)"
	@echo -e "$(call MSG2,Setting version)"
	@echo -e "$(call MSG2,Setting configuration directory )"
	@sed -i -e 's#%%ABS_VERSION%%#$(ABS_VERSION)#g' \
		-e 's#%%CONF_DIR%%#$(CONFDIR)#g' \
		abs makeworld scripts/svn2abs

.PHONY: install
install:
	@echo -e "$(call MSG1,abs install)"
	@echo -e "$(call MSG2,Installing scripts into $(DESTDIR)$(BINDIR))"
	@mkdir -p $(DESTDIR)$(BINDIR)
	@install -m 755 abs $(DESTDIR)$(BINDIR)
	@install -m 755 makeworld $(DESTDIR)$(BINDIR)
	@echo -e "$(call MSG2,Installing abs configuration file into $(DESTDIR)$(CONFDIR))"
	@mkdir -p $(DESTDIR)$(CONFDIR)
	@install -m 644 conf/abs.conf $(DESTDIR)$(CONFDIR)
	@echo -e "$(call MSG2,Installing prototype files into $(DESTDIR)$(PROTOTYPEDIR))"
	@mkdir -p $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-bzr.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-cvs.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-darcs.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-git.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-gnome.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-haskell.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-hg.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-perl.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-python.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-rubygem.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/PKGBUILD-svn.proto $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/proto-gnome.install $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/proto-haskell.install $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/proto-info.install $(DESTDIR)$(PROTOTYPEDIR)
	@install -m 644 prototypes/rc-script.proto $(DESTDIR)$(PROTOTYPEDIR)

.PHONY: uninstall
uninstall:
	@echo -e "$(call MSG1,abs uninstall)"
	@echo -e "$(call MSG2,Removing scripts)"
	@rm $(DESTDIR)$(BINDIR)abs
	@rm $(DESTDIR)$(BINDIR)makeworld
	@echo -e "$(call MSG2,Removing configuration file)"
	@rm $(DESTDIR)$(CONFDIR)abs.conf
	@echo -e "$(call MSG2,Removing prototype files)"
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-bzr.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-cvs.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-darcs.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-git.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-gnome.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-haskell.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-hg.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-perl.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-python.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-rubygem.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)PKGBUILD-svn.proto
	@rm $(DESTDIR)$(PROTOTYPEDIR)proto-gnome.install
	@rm $(DESTDIR)$(PROTOTYPEDIR)proto-haskell.install
	@rm $(DESTDIR)$(PROTOTYPEDIR)proto-info.install
	@rm $(DESTDIR)$(PROTOTYPEDIR)rc-script.proto

.PHONY: dist
dist:
	@echo -e "$(call MSG1,Build abs-$(ABS_VERSION) release)"
	@echo -e "$(call MSG2,Creating build directory)"
	@mkdir $(BUILDDIR)
	@echo -e "$(call MSG2,Copying files)"
	@cp abs $(BUILDDIR)
	@cp AUTHORS $(BUILDDIR)
	@cp COPYING $(BUILDDIR)
	@cp Makefile $(BUILDDIR)
	@cp makeworld $(BUILDDIR)
	@cp README $(BUILDDIR)
	@cp -R conf $(BUILDDIR)
	@cp -R prototypes $(BUILDDIR)
	@cp -R scripts $(BUILDDIR)
	@echo -e "$(call MSG2,Tarring files)"
	@tar czf abs-$(ABS_VERSION).tar.gz $(BUILDDIR) --transform="s#^$(BUILDDIR)*#abs/#"
	@echo -e "$(call MSG2,Removing build directory)"
	@rm -rf $(BUILDDIR)
