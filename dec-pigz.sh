#!/bin/sh

echo; echo "#### $0 ####"; echo

[ -z $THREADS ] && THREADS=16
NPROC=$(nproc); if [ $NPROC -lt $THREADS ]; then THREADS=$NPROC; fi
echo "using $THREADS threads"

#ARCHIVE="$1"
[ -z $ARCHIVE ] && ARCHIVE="silesia.tar.1G"

NULLDEV=/dev/null
UNAME=`uname`; if [ "${UNAME:0:5}" = "MINGW" ]; then NULLDEV=nul; fi

[ -z $SLEEPTS ] && SLEEPTS=2

sleepts()
    {
    sleepts=0
    if [ $((SLEEPTS)) -gt 0 ]; then sleepts=$SLEEPTS; fi
    if [ $(($1)) -gt 0 ]; then sleepts=$1; fi
    sleep $sleepts
    }

reps_lv()
    {
    case "$1" in
    1) echo 10 ;;
    6) echo 10 ;;
    9) echo 10 ;;
    esac
    }

reps_th()
    {
    case "$1" in
    [0-5]) echo 1 ;;
    [6-10]) echo 1 ;;
    [11-16]) echo 1 ;;
    esac
    }

max()
    {
    a=$1; b=$2;
    echo $(( a > b ? a : b ))
    }

[ -f $ARCHIVE ] || { echo file "$ARCHIVE" not found; exit 1; }

PAK=./pigz
EXT=.gz
OPTS=
OPT_TH=-p
LEVELS="1 6 9"
REPS=10

echo "#### $PAK -d"
echo
for lv in $LEVELS; do
    ARC=$ARCHIVE$EXT-$lv
    echo "## $PAK -d -$lv"
    for ((th=1; th<=1; th++)); do
        CMD="$PAK $OPT_TH$th -f -d -c $ARC > $NULLDEV"
        REPS=`max $(reps_lv $lv) $(reps_th $th)`
        echo $ $CMD "xx $REPS"
        time for ((i=0; i<$REPS; i++)); do
            eval $CMD
        done # for $reps
        sleepts
        echo
    done # for th;
    echo
done # for lv;

