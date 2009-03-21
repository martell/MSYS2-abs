#!/bin/bash

/usr/bin/svn2abs /srv/abs/checkout /srv/abs/rsync file:///srv/svn-packages
/usr/bin/community2abs /srv/abs/rsync /srv/cvs/cvs-community

for repo in testing core extra community; do
    for arch in i686 x86_64; do
        tar -czf /srv/ftp/${repo}/os/${arch}/${repo}.abs.tar.gz \
            -C /srv/abs/rsync/${arch} ${repo}
    done
done

