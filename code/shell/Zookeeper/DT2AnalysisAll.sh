#!/bin/bash

queryFile=sourceSinkStmtPairDiffClass2.txt

source ./zk_global.sh


INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DT2BrPre
echo $BINDIR
cp $subjectloc/DT2Instrumented/staticVtg.dat $BINDIR
#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint.jar:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx50g -ea -cp ${MAINCP} disttaint.dt2AnalysisAll \
	$queryFile \
	"$INDIR" \
	"$BINDIR" \
	"-method" \
	"-stmtcov" \
    "-preprune" \
    "" \ 
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0



