#!/bin/sh

echo
echo "######## $0 ########"
echo

echo
echo "########"
echo
sh 2-0-bzip2.sh
sleep 5
echo
echo "########"
echo
sh 2-1-pbzip2.sh
sleep 5
echo
echo "########"
echo
sh 2-1-lbzip2.sh
sleep 5
echo
echo "########"
echo
sh 2-2-pigz.sh
sleep 5
echo
echo "########"
echo
sh 2-3-plzip.sh
sleep 5
echo
echo "########"
echo
sh 2-4-pixz.sh
sleep 5
echo
echo "########"
echo
sh 2-5-xz.sh
sleep 5
echo
echo "########"
echo
sh 2-6-ztsdmt.sh
sleep 5
echo
echo "########"
echo
sh 2-7-ztsd.sh

