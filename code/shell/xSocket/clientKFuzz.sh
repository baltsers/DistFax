#!/bin/bash


source ./xs_global.sh

INDIR=$subjectloc/bin-instrumented/

MAINCP=".:$ROOT/fuzz/kelinci/examples/xSocket/xSocket.jar:$ROOT/fuzz/kelinci/instrumentor/build/libs/kelinci.jar:$INDIR"

    #"queries.lst"
starttime=`date +%s%N | cut -b1-13`
# java -cp bin-instrumented edu.cmu.sv.kelinci.Kelinci SimpleBuggy @@
java -Xmx1g -ea -cp ${MAINCP} \
	XSocketClient3 \
	in_dir/example 

stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

