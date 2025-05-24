#!/bin/sh

echo; echo "#### $0 ####"; echo

[ -z $THREADS ] && THREADS=16
NPROC=$(nproc); if [ $NPROC -lt $THREADS ]; then THREADS=$NPROC; fi
echo "using $THREADS threads"; echo

ARCHIVE="$1"
[ -z $ARCHIVE ] && ARCHIVE="silesia.tar.1G"

NULLDEV=/dev/null
UNAME=$(uname | head -c 5 -); if [ "$UNAME" = "MINGW" ]; then NULLDEV=nul; fi

[ -z $SLEEPTS ] && SLEEPTS=5

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
    0) echo 2 ;;
    6) echo 1 ;;
    9) echo 1 ;;
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

if [ -n $ARCHIVE ]; then
    ARC="$ARCHIVE"
else
    echo empty archive, use default
    ARC="silesia.tar"
fi
#echo $arc
[ -f $ARC ] || { echo file "$ARC" not found; exit 1; }

PAK=./xz
EXT=.xz
OPTS=
OPT_TH=-T
LEVELS="0 6 9"
REPS=1

for lv in $LEVELS; do
    echo "## $PAK -$lv"
    echo
    for ((th=1; th<=$THREADS; th++)); do
        CMD="$PAK -$lv $OPTS $OPT_TH$th -f -c $ARC > $NULLDEV"
        REPS=`max $(reps_lv $lv) $(reps_th $th)`
        echo $ $CMD "xx $REPS"
        time for ((i=0; i<$REPS; i++)); do
            eval $CMD
        done # for $reps
        echo
        sleepts
    done # for th;

    CMD="$PAK -$lv $OPTS $OPT_TH$th -f -c $ARC > $ARC$EXT-$lv"
    eval $CMD
done # for lv;

