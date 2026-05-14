#!/bin/bash
source ./zk_global.sh
query=${1:-"<org.apache.jute.BinaryInputArchive: byte readByte(java.lang.String)>"}
INDIR=$subjectloc/Diveroutdyn2
echo $INDIR
BINDIR=$subjectloc/DiverInstrumented2BK4
echo $BINDIR

MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DiverThread.jar:$INDIR:$BINDIR"



	starttime=`date +%s%N | cut -b1-13`
#   query=methods_0.txt
	 echo $query	
	java -Xmx25g -ea -cp ${MAINCP} Diver.DiverAnalysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
    3	
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	



echo "Running finished."

exit 0



