#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./chord_global.sh
source ./chord_global.sh
MAINCP="$ROOT/DUA1.jar:$ROOT/DistTaint.jar:$ROOT/libs/soot-trunk.jar"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/build/classes:$ROOT/DistTaint.jar"

suffix="SourceSink"

LOGDIR=out-DTInstr
mkdir -p $LOGDIR
logout=$LOGDIR/SourceSink-$suffix.out
logerr=$LOGDIR/SourceSink-$suffix.err

OUTDIR=/tmp
mkdir -p $OUTDIR

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
java -Xmx400m -ea -cp ${MAINCP} disttaint.dtSourceSink \
	$subjectloc/build/classes \
	 1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

