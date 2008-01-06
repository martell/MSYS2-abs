BUILDDIR = build
CONFDIR = $(DESTDIR)/etc/abs

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

uninstall:
	rm $(DESTDIR)/usr/bin/abs
	rm $(DESTDIR)/usr/bin/makeworld
	rm $(CONFDIR)/abs.conf
	rm $(CONFDIR)/supfile.core
	rm $(CONFDIR)/supfile.extra
	rm $(CONFDIR)/supfile.unstable
	rm $(CONFDIR)/supfile.community
	rm $(CONFDIR)/supfile.testing

zip:
	mkdir -p $(BUILDDIR)/abs
	cp Makefile $(BUILDDIR)/abs/
	cp abs $(BUILDDIR)/abs/
	cp makeworld $(BUILDDIR)/abs/
	cp -R conf $(BUILDDIR)/abs/
	cd $(BUILDDIR) && tar czf abs.tar.gz "abs/"
	mv $(BUILDDIR)/abs.tar.gz .
	rm -rf $(BUILDDIR)
