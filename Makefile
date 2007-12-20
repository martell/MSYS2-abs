CONFDIR = $(DESTDIR)/etc/abs

all:

install:
	# install the script
	mkdir -p $(DESTDIR)/usr/bin
	install -m 755 abs $(DESTDIR)/usr/bin
	# install conf files
	mkdir -p $(CONFDIR)
	install -m 744 conf/abs.conf $(CONFDIR)
	install -m 744 conf/supfile.core $(CONFDIR)
	install -m 744 conf/supfile.extra $(CONFDIR)
	install -m 744 conf/supfile.unstable $(CONFDIR)
	install -m 744 conf/supfile.community $(CONFDIR)
	install -m 744 conf/supfile.testing $(CONFDIR)

uninstall:
	rm $(DESTDIR)/usr/bin/abs
	rm $(CONFDIR)/abs.conf
	rm $(CONFDIR)/supfile.core
	rm $(CONFDIR)/supfile.extra
	rm $(CONFDIR)/supfile.unstable
	rm $(CONFDIR)/supfile.community
	rm $(CONFDIR)/supfile.testing
