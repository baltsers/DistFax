#!/bin/bash
# $file$=${1:-"in_dir/example"}

source ./xs_global.sh

INDIR=$ROOT/fuzz/kelinci/examples/xSocket/bin-instrumented/

MAINCP=".:$ROOT/fuzz/kelinci/examples/xSocket/xSocket.jar:$ROOT/fuzz/kelinci/instrumentor/build/libs/kelinci.jar:$INDIR"

    #"queries.lst"
starttime=`date +%s%N | cut -b1-13`
java -Xmx1g -ea -cp ${MAINCP} \
	XSocketClient4  $1

stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

