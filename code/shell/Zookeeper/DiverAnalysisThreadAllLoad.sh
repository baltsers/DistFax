#!/bin/bash
source ./zk_global.sh

INDIR=$subjectloc/Diveroutdyn2_Load
echo $INDIR
BINDIR=$subjectloc/DiverInstrumented2BK5
echo $BINDIR

MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DiverThread.jar:$INDIR:$BINDIR"



	starttime=`date +%s%N | cut -b1-13`
    query=methods_Load_3.txt
	 echo $query	
	java -Xmx20g -ea -cp ${MAINCP} Diver.DiverAnalysisAll \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
    3	 \
	"-stmtcov" \
	"-postprune" \
	
    stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	



echo "Running finished."

exit 0



