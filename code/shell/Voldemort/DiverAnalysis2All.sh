#!/bin/bash
source ./vd_global.sh

INDIR=$subjectloc/Diveroutdyn
echo $INDIR
BINDIR=$subjectloc/DiverInstrumented
echo $BINDIR

cp $ROOT/nioecho/stmtCoverage1.out $INDIR
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/distEADIVER/bin:$INDIR:$BINDIR"



cat methods.txt | while read LINE
do
     echo "WORK Method\n"
     echo $LINE
#	query=\$\{1:-\"<\"$LINE\">\"\}
	starttime=`date +%s%N | cut -b1-13`
	query=$LINE
	 echo $query	
	java -Xmx9200m -ea -cp ${MAINCP} Diver.DiverAnalysisStmt \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
    4	
	
	stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	
done



echo "Running finished."

exit 0



