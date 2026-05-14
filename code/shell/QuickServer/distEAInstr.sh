#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./qs_global.sh
MAINCP=".:$ROOT/DUA1.jar:$ROOT/distEA11.jar:$ROOT/libs/soot-trunk.jar:"
SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/echoserver:$subjectloc/QuickServer:$subjectloc/java:$ROOT/distEA11.jar"
for i in $subjectloc/lib/*.jar;
do
	SOOTCP=$SOOTCP:$i
done

suffix="vd"

LOGDIR=out-distEAInstr
mkdir -p $LOGDIR
logout=$LOGDIR/instr-$suffix.out
logerr=$LOGDIR/instr-$suffix.err

OUTDIR=$subjectloc/distEAInstrumented
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
	#-main-class $DRIVERCLASS \
	#-entry:$DRIVERCLASS \
	
java -Xmx40g -ea -cp ${MAINCP} distEA.distEAInst \
	-w -cp $SOOTCP -p cg verbose:false,implicit-entry:false \
	-p cg.spark verbose:false,on-fly-cg:false,rta:true -f c \
	-d $OUTDIR \
	-brinstr:on -duainstr:on \
	-allowphantom \
	-wrapTryCatch \
	-nio \
	-socket \
	-dumpFunctionList \
	-slicectxinsens \
	-process-dir $subjectloc/echoserver \
	-process-dir $subjectloc/QuickServer \
    # 1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds
#echo "Instrumentation done, now copying resources required for running."


echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

