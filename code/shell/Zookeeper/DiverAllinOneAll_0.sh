#!/bin/bash
source ./zk_global.sh

INDIR=$subjectloc/Diveroutdyn2
echo $INDIR
BINDIR=$subjectloc/DiverInstrumented2
echo $BINDIR

MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DiverThread.jar:$INDIR:$BINDIR"



	starttime=`date +%s%N | cut -b1-13`
    query=methods_0.txt
	 echo $query	
	java -Xmx25g -ea -cp ${MAINCP} Diver.DiverAllInOneAll \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
    2	
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	



echo "Running finished."

exit 0



