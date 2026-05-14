#!/bin/bash
source ./xn_global.sh

INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DTInstrumented
echo $BINDIR
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint.jar:$INDIR:$BINDIR"

rm $subjectloc/methodList.out -f
rm $subjectloc/methodsInPair.out -f
starttime0=`date +%s%N | cut -b1-13`
cat sourceSinkMethodPairDiffClass2.txt | while read LINE
do
#     echo "WORK Method\n"
#     echo $LINE
#	query=\$\{1:-\"<\"$LINE\">\"\}
	starttime=`date +%s%N | cut -b1-13`
	query=$LINE
#	 echo $query	
	java -Xmx100g -ea -cp ${MAINCP} disttaint.dtAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"" \
	"" \
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	
done

echo "Running finished."
stoptime0=`date +%s%N | cut -b1-13`
echo "All runTime elapsed: " `expr $stoptime0 - $starttime0` milliseconds	
exit 0

# hcai vim :set ts=4 tw=4 tws=4

