#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 query traceDir number_of_inputs"
	exit 1
fi

source ./qs_global.sh

INDIR=$subjectloc
#INDIR=$subjectloc/distEAoutdyn
query=${1:-"$subjectloc/distEAInstrumented/functionList.out"}
NT=${2:-"1"}

MAINCP=".:$ROOT/DUA1.jar:$ROOT/distEA.jar::$ROOT/libs/soot-trunk.jar"
starttime=`date +%s%N | cut -b1-13`

	#-debug
java -Xmx100g -ea -cp ${MAINCP} distEA.distEAAnalysis \
	"$query" \
	"$INDIR" \
	"$NT" \
	"-separate" \
	"-common" \
	"-nstrict" \
	"-debug"

stoptime=`date +%s%N | cut -b1-13`

echo "Time elapsed: " `expr $stoptime - $starttime` milliseconds
exit 0

# hcai vim :set ts=4 tw=4 tws=4
