#!/bin/bash
source ./vd_global.sh

INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DT2BrPre
echo $BINDIR
cp $subjectloc/DT2Instrumented/staticVtg.dat $BINDIR
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint/bin:$INDIR:$BINDIR"

cp $subjectloc/stmtCoverage1.out $BINDIR
starttime0=`date +%s%N | cut -b1-13`
cat sourceSinkStmtPairDiffClass2_6.txt | while read LINE
do
#     echo "WORK Method\n"
#     echo $LINE
#	query=\$\{1:-\"<\"$LINE\">\"\}
	starttime=`date +%s%N | cut -b1-13`
	query=$LINE
	 echo $query	
	java -Xmx9g -ea -cp ${MAINCP} disttaint.dt2Analysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"-method" \
	"-stmtcov" \
	"-postprune" \
	"" \
	"" \
	
    stoptime=`date +%s%N | cut -b1-13`
	echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds	
done

echo "Running finished."
stoptime0=`date +%s%N | cut -b1-13`
echo "All runTime elapsed: " `expr $stoptime0 - $starttime0` milliseconds	
exit 0



