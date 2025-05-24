#!/bin/sh

ARCH=silesia.tar.1G

sh comp-pigz.sh

echo
echo "#### ls"
wc -c $ARCH $ARCH*.gz* | sort -r

echo
sh dec-pigz.sh
