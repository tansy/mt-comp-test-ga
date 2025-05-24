#!/bin/sh

ARCH=silesia.tar.1G

sh comp-bzip2.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.bz2* | sort -r

echo
sh dec-bzip2.sh

