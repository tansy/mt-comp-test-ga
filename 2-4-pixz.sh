#!/bin/sh

ARCH=silesia.tar.1G

sh comp-pixz.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.xz* | sort -r

echo
sh dec-pixz.sh
