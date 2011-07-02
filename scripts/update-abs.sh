#!/bin/bash

SERVERS=('gerolde' 'sigurd')
ARCHES=('i686' 'x86_64' 'any')

# ensure needed directories are present
mkdir -p /srv/abs/{checkout,rsync,tree}

# clear any "broken" entries from previous ABS tree generation
for server in ${SERVERS[@]}; do
   [ -d /srv/abs/tree/$server ] && rm -rf /srv/abs/tree/$server/*
done

# create ABS trees
/srv/abs/svn2abs /srv/abs/checkout/gerolde /srv/abs/tree/gerolde file:///srv/svn-packages
/srv/abs/svn2abs /srv/abs/checkout/sigurd /srv/abs/tree/sigurd file:///srv/svn-community

# clean and regenerate ABS rsync folder
for arch in ${ARCHES[@]}; do
    if [ ! -d /srv/abs/rsync/$arch ]; then
        mkdir /srv/abs/rsync/$arch
    else
        rm -rf /srv/abs/rsync/$arch/*
    fi

    for server in ${SERVERS[@]}; do
        if [ -d /srv/abs/tree/$server/$arch ]; then
            mv /srv/abs/tree/$server/$arch/* /srv/abs/rsync/$arch/
        fi
    done
done

# generate tarballs for package mirrors
for repo in testing core extra community community-testing; do
    for arch in ${ARCHES[@]/any/}; do
        tarcmd="tar -czf /srv/ftp/${repo}/os/${arch}/${repo}.abs.tar.gz \
                    -C /srv/abs/rsync/${arch} ${repo}"

        if [ -d "/srv/abs/rsync/any/${repo}" ]; then
            tarcmd="$tarcmd -C /srv/abs/rsync/any ${repo}"
        fi

	$tarcmd
    done
done
