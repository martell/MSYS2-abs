BUILDDIR = build
CONFDIR = $(DESTDIR)/etc/abs
PROTOTYPEDIR = $(DESTDIR)/usr/share/pacman/

all:

install:
	# install the scripts
	mkdir -p $(DESTDIR)/usr/bin
	install -m 755 abs $(DESTDIR)/usr/bin
	install -m 755 makeworld $(DESTDIR)/usr/bin
	# install conf files
	mkdir -p $(CONFDIR)
	install -m 644 conf/abs.conf $(CONFDIR)
	install -m 644 conf/supfile.core $(CONFDIR)
	install -m 644 conf/supfile.extra $(CONFDIR)
	install -m 644 conf/supfile.unstable $(CONFDIR)
	install -m 644 conf/supfile.community $(CONFDIR)
	install -m 644 conf/supfile.testing $(CONFDIR)
	# install prototype files
	mkdir -p $(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-cvs.proto $(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-darcs.proto $(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-git.proto $(PROTOTYPEDIR)
	install -m 644 prototypes/PKGBUILD-svn.proto $(PROTOTYPEDIR)
	install -m 644 prototypes/rc-script.proto $(PROTOTYPEDIR)

uninstall:
	rm $(DESTDIR)/usr/bin/abs
	rm $(DESTDIR)/usr/bin/makeworld
	rm $(CONFDIR)/abs.conf
	rm $(CONFDIR)/supfile.core
	rm $(CONFDIR)/supfile.extra
	rm $(CONFDIR)/supfile.unstable
	rm $(CONFDIR)/supfile.community
	rm $(CONFDIR)/supfile.testing
	rm $(PROTOTYPEDIR)/PKGBUILD-cvs.proto
	rm $(PROTOTYPEDIR)/PKGBUILD-darcs.proto
	rm $(PROTOTYPEDIR)/PKGBUILD-git.proto
	rm $(PROTOTYPEDIR)/PKGBUILD-svn.proto
	rm $(PROTOTYPEDIR)/rc-script.proto

zip:
	mkdir -p $(BUILDDIR)/abs
	cp Makefile $(BUILDDIR)/abs/
	cp abs $(BUILDDIR)/abs/
	cp makeworld $(BUILDDIR)/abs/
	cp -R conf $(BUILDDIR)/abs/
	cp -R prototypes $(BUILDDIR)/abs/
	cd $(BUILDDIR) && tar czf abs.tar.gz "abs/"
	mv $(BUILDDIR)/abs.tar.gz .
	rm -rf $(BUILDDIR)
