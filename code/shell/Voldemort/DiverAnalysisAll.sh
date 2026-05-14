#!/bin/bash
source ./zk_global.sh

INDIR=$ROOT/voldemort/Diveroutdyn
echo $INDIR
BINDIR=$ROOT/voldemort/DiverInstrumented

echo $BINDIR
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/libs/distEADIVER.jar:$INDIR:$BINDIR"



cat methods.txt | while read LINE
do
     echo "WORK Method\n"
     echo $LINE
#	query=\$\{1:-\"<\"$LINE\">\"\}
	starttime=`date +%s%N | cut -b1-13`
	query=$LINE
	 echo $query	
	java -Xmx9200m -ea -cp ${MAINCP} Diver.DiverAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	4
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	
done



echo "Running finished."

exit 0



