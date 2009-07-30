#!/bin/bash

/usr/bin/svn2abs /srv/abs/checkout/gerolde /srv/abs/rsync file:///srv/svn-packages
/usr/bin/svn2abs /srv/abs/checkout/sigurd /srv/abs/rsync svn://aur.archlinux.org/srv/svn-packages

for repo in testing core extra community; do
    for arch in i686 x86_64; do
        tarcmd="tar -czf /srv/ftp/${repo}/os/${arch}/${repo}.abs.tar.gz \
                    -C /srv/abs/rsync/${arch} ${repo}"

        if [ -d "/srv/abs/rsync/any/${repo}" ]; then
            tarcmd="$tarcmd -C /srv/abs/rsync/any ${repo}"
        fi

	$tarcmd
    done
done

