ABS_VERSION=2.3.3
BUILDDIR = build
BINDIR = /usr/bin/
CONFDIR = /etc/abs/
SHAREDIR = /usr/share/abs/
PROTOTYPEDIR = /usr/share/pacman/
DESTDIR =

all: config_abs

config_abs: 
	sed -i -e 's#%%ABS_VERSION%%#$(ABS_VERSION)#g' \
	       -e 's#%%CONF_DIR%%#$(CONFDIR)#g' \
			abs makeworld scripts/svn2abs

install:
	# install the scripts
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m 755 abs $(DESTDIR)$(BINDIR)
	install -m 755 makeworld $(DESTDIR)$(BINDIR)
	install -m 755 scripts/svn2abs $(DESTDIR)$(BINDIR)
	# install conf files
	mkdir -p $(DESTDIR)$(CONFDIR)
	install -m 644 conf/abs.conf $(DESTDIR)$(CONFDIR)
	# install /usr/share files
	mkdir -p $(DESTDIR)$(SHAREDIR)
	install -m 644 conf/rsyncd.conf.abs $(DESTDIR)$(SHAREDIR)
	# install prototype files
	mkdir -p $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-cvs.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-darcs.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-git.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-gnome.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-haskell.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-perl.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-rubygem.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-svn.proto $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/proto-gnome.install $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/proto-haskell.install $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/proto-info.install $(DESTDIR)$(PROTOTYPEDIR)
	install -m 644 prototypes/rc-script.proto $(DESTDIR)$(PROTOTYPEDIR)

uninstall:
	rm $(DESTDIR)$(BINDIR)/abs
	rm $(DESTDIR)$(BINDIR)/makeworld
	rm $(DESTDIR)$(CONFDIR)/abs.conf
	rm $(DESTDIR)$(CONFDIR)/rsyncd.conf.abs
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-cvs.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-darcs.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-git.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-gnome.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-haskell.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-perl.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-rubygem.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/PKGBUILD-svn.proto
	rm $(DESTDIR)$(PROTOTYPEDIR)/proto-gnome.install
	rm $(DESTDIR)$(PROTOTYPEDIR)/proto-haskell.install
	rm $(DESTDIR)$(PROTOTYPEDIR)/proto-info.install
	rm $(DESTDIR)$(PROTOTYPEDIR)/rc-script.proto

zip:
	mkdir -p $(BUILDDIR)/abs
	cp Makefile $(BUILDDIR)/abs/
	cp abs $(BUILDDIR)/abs/
	cp makeworld $(BUILDDIR)/abs/
	cp README $(BUILDDIR)/abs/
	cp COPYING $(BUILDDIR)/abs/
	cp -R conf $(BUILDDIR)/abs/
	cp -R prototypes $(BUILDDIR)/abs/
	cp -R scripts $(BUILDDIR)/abs/
	cd $(BUILDDIR) && tar czf abs-$(ABS_VERSION).tar.gz "abs/"
	mv $(BUILDDIR)/abs-$(ABS_VERSION).tar.gz .
	rm -rf $(BUILDDIR)
