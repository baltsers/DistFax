#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./qs_global.sh
MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
echo $MAINCP
SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/bin:$subjectloc/QuickServer:$subjectloc/echoserver:$ROOT/DistTaint.jar"
for i in $subjectloc/lib/*.jar;
do
	SOOTCP=$SOOTCP:$i
done

suffix="vd"

LOGDIR=out-DT2BrPre
mkdir -p $LOGDIR
logout=$LOGDIR/instr-$suffix.out
logerr=$LOGDIR/instr-$suffix.err

OUTDIR=$subjectloc/DT2BrPre
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
	
java -Xmx100g -ea -cp ${MAINCP} disttaint.dt2BranchPre \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false  \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-process-dir $subjectloc/bin \
	-process-dir $subjectloc/QuickServer \
	-process-dir $subjectloc/echoserver \
    -duaverbose \
	-slicectxinsens \
   	-brinstr:off -duainstr:off  \
	-wrapTryCatch \
        -intraCD \
        -interCD \
        -exInterCD \
	-allowphantom \
	-serializeVTG \
#	1>out-DT2BrPre/instr.out 2>out-DT2BrPre/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds
#echo "Instrumentation done, now copying resources required for running."


echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

