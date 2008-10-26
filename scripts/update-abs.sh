#!/bin/bash

/usr/bin/svn2abs /home/abs/checkout /home/abs/rsync file:///home/svn-packages
/usr/bin/community2abs /home/abs/rsync /home/cvs-community

for repo in testing core extra community; do
    for arch in i686 x86_64; do
        tar -czf /home/ftp/${repo}/os/${arch}/${repo}.abs.tar.gz \
            -C /home/abs/rsync/${arch} ${repo}
    done
done
