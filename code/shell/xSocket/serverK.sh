#!/bin/bash
source ./xs_global.sh

INDIR=$ROOT/fuzz/kelinci/examples/xSocket/bin-instrumented/

MAINCP=".:$ROOT/fuzz/kelinci/examples/xSocket/xSocket.jar:$INDIR"

starttime=`date +%s%N | cut -b1-13`

java -cp ${MAINCP} XSocketServer


stoptime=`date +%s%N | cut -b1-13`
echo "RunTime : " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

