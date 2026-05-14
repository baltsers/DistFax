#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./zk_global.sh
source ./zs_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
#subjectloc=$ROOT/z349/


MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/libs/DUA1.jar:$ROOT/DistTaint/bin"
echo $MAINCP
mkdir -p out-DT2Branch

SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$subjectloc/build/classes:$subjectloc/build/test/classes:$ROOT/DistTaint/bin"


echo $SOOTCP
OUTDIR=$ROOT/z349/DT2Instrumented
mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`
	#-sclinit \
	#-wrapTryCatch \
	#-debug \
	#-dumpJimple \
	#-statUncaught \
	#-ignoreRTECD \
	#-exInterCD \
	#-main-class ScheduleClass -entry:ScheduleClass \
java -Xmx1000m -ea -cp ${MAINCP} disttaint.dt2Branch \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:false,rta:true \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-process-dir $subjectloc/build/classes \
	-process-dir $subjectloc/build/test/classes \
        -debug \
#	 1>out-DiverInstr/instr.out 2>out-DiverInstr/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0




