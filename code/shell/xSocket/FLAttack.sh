#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./xs_global.sh
source ./xs_global.sh
MAINCP="$ROOT/DUA1.jar:$ROOT/FlowDistAttackSurface.jar:$ROOT/libs/soot-trunk.jar"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/bin:$ROOT/FlowDistAttackSurface.jar"

suffix="SourceSink"

LOGDIR=out-DTInstr
mkdir -p $LOGDIR
logout=$LOGDIR/SourceSink-$suffix.out
logerr=$LOGDIR/SourceSink-$suffix.err

INDIR=$subjectloc/DTInstrumented
OUTDIR=/tmp
mkdir -p $OUTDIR
rm source_1.txt -f
rm sink_1.txt -f
rm s*DiffClass.txt -f
rm s*Pair.txt -f
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
java -Xmx100g -ea -cp ${MAINCP} FLOWDist.dtAttackSurfaceM \
	$subjectloc/bin \
#	 1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

