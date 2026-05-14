#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 query traceDir number_of_inputs"
	exit 1
fi

source ./zk_global.sh

#INDIR=$subjectloc/distEAoutdynComm
#INDIR=$subjectloc/OutTraces/i
INDIR=$subjectloc/test1_System
query=${1:-"$subjectloc/methods_System.txt"}
#NT=${2:-"195"}
NT=${2:-"1"}

MAINCP=".:$ROOT/DUA1.jar:$ROOT/DistEA.jar::$ROOT/libs/soot-trunk.jar:$subjectloc/bin:$INDIR"

for i in $subjectloc/lib/*.jar;
do
	MAINCP=$MAINCP:$i
done

starttime=`date +%s%N | cut -b1-13`

	#-debug
	#"-nonseparate"
java -Xmx4g -ea -cp ${MAINCP} distEA.distEAAnalysis \
	"$query" \
	"$INDIR" \
	"$NT" \
	"-separate" \
	"-common" \
	"-nstrict" \
	"-prec" \
	"" \

stoptime=`date +%s%N | cut -b1-13`

echo "Time elapsed: " `expr $stoptime - $starttime` milliseconds
exit 0


