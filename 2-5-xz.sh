#!/bin/sh

ARCH=silesia.tar.1G

sh comp-xz.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.xz* | sort -r

echo
sh dec-xz.sh
