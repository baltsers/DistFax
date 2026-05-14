#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./vd_global.sh
source ./vd_global.sh
MAINCP="$ROOT/DUA1.jar:$ROOT/DistTaint/bin:$ROOT/libs/soot-trunk.jar"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/dist/classes:$ROOT/DistTaint/bin"

suffix="SourceSink"

LOGDIR=out-DTInstr
mkdir -p $LOGDIR
logout=$LOGDIR/SourceSink-$suffix.out
logerr=$LOGDIR/SourceSink-$suffix.err

INDIR=$subjectloc/DT2BrPre
OUTDIR=$subjectloc/DT2SourceSink
mkdir -p $OUTDIR

cp $subjectloc/DT2Instrumented/staticVtg.dat $INDIR
cp methodList.out $INDIR
cp stmtCoverage1.out $INDIR
rm source*2.txt -f
rm sink*2.txt -f
starttime=`date +%s%N | cut -b1-13`

	#-allowphantom \
   	#-duaverbose \
	#-wrapTryCatch \
	#-dumpJimple \
	#-statUncaught \
	#-perthread \
	#-syncnio \
	#-main-class $DRIVERCLASS \
	#-entry:$DRIVERCLASS \
	#-syncnio \
	#-syncnio \
	#-main-class $DRIVERCLASS \
	#-entry:$DRIVERCLASS \
java -Xmx10g -ea -cp ${MAINCP} disttaint.dt2SourceSink \
	$OUTDIR \
	$INDIR \
	"-method" \
	"-stmt" \
	"" \
    #	 1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0




