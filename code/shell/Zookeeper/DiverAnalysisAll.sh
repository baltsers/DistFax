#!/bin/bash
source ./zk_global.sh

INDIR=$ROOT/z349/Diveroutdyn
echo $INDIR
BINDIR=$ROOT/z349/DiverInstrumented
echo $BINDIR
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/DUA1.jar:$ROOT/soot-trunk.jar:$ROOT/distDIVER.jar:$INDIR:$BINDIR"



cat methods.txt | while read LINE
do
     echo "WORK Method\n"
     echo $LINE
#	query=\$\{1:-\"<\"$LINE\">\"\}
	starttime=`date +%s%N | cut -b1-13`
	query=$LINE
	 echo $query	
	java -Xmx92000m -ea -cp ${MAINCP} Diver.DiverAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	2
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	
done



echo "Running finished."

exit 0



