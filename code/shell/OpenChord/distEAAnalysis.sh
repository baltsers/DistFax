#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 query traceDir number_of_inputs"
	exit 1
fi

source ./chord_global.sh

#INDIR=$subjectloc/distEAoutdynComm
#INDIR=$subjectloc/OutTraces/
INDIR=$subjectloc/distEAoutdyn
query=${1:-"$subjectloc/distEAInstrumented/functionList.out"}
NT=${2:-"1"}

#MAINCP=".:/etc/alternatives/java_sdk/jre/lib/rt.jar:$ROOT/tools/j2sdk1.4.2_18/lib/tools.jar:$ROOT/tools/polyglot-1.3.5/lib/polyglot.jar:$ROOT/tools/soot-2.3.0/lib/sootclasses-2.5.0.jar:$ROOT/tools/jasmin-2.3.0/lib/jasminclasses-2.3.0.jar:$ROOT/tools/java_cup.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin"
#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/tools.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/DUA1.jar:$ROOT/libs/mcia.jar:$subjectloc/build/classes"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/DUA1.jar:$ROOT/libs/DistEA8.jar:$ROOT/libs/soot-trunk.jar:$subjectloc/build/classes"


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


