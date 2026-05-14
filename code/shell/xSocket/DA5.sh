#!/bin/bash
source ./kf_global.sh

INDIR=$ROOT/MINA/Diveroutdyn
echo $INDIR
BINDIR=$ROOT/MINA/DiverInstrumented
echo $BINDIR
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/libs/distDIVER.jar:$INDIR:$BINDIR"



cat method5.txt | while read LINE
do
     echo "WORK Method\n"
     echo $LINE
#	query=\$\{1:-\"<\"$LINE\">\"\}
	starttime=`date +%s%N | cut -b1-13`
	query=$LINE
	 echo $query	
	java -Xmx9000m -ea -cp ${MAINCP} Diver.DiverAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	5
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	
done



echo "Running finished."

exit 0

# hcai vim :set ts=4 tw=4 tws=4

