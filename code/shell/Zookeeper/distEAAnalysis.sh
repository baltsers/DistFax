#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 query traceDir number_of_inputs"
	exit 1
fi

source ./zk_global.sh

#INDIR=$subjectloc/distEAoutdynComm
#INDIR=$subjectloc/OutTraces/i
INDIR=$subjectloc
query=${1:-"$subjectloc/distEAInstrumented/functionList.out"}
#NT=${2:-"195"}
NT=${2:-"1"}

MAINCP=".:$ROOT/DistEA/DUA1.jar:$ROOT/DistEA/DistEA.jar::$ROOT/libs/soot-trunk.jar:$subjectloc/bin:$INDIR"

for i in $subjectloc/lib/*.jar;
do
	MAINCP=$MAINCP:$i
done

starttime=`date +%s%N | cut -b1-13`

	#-debug
	#"-nonseparate"
java -Xmx40800m -ea -cp ${MAINCP} distEA.distEAAnalysis \
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


