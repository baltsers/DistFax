#!/bin/bash
source ./ka_global.sh
source ./ka_global.sh
MAINCP=".:$ROOT/libs/soot-trunk.jar"

starttime=`date +%s%N | cut -b1-13`

java -Xmx10g -ea -cp ${MAINCP} CountMethodComplexityFromFiles \
	$subjectloc/willInst \
#	 1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

