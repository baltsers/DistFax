#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./th_global.sh
source ./th_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
#subjectloc=$subjectloc


#MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint/bin"
MAINCP=".:$ROOT/DistTaint.jar:$ROOT/banderaCommons.jar:$ROOT/banderaToolFramework.jar:$ROOT/commons-cli-1.3.1.jar:$ROOT/commons-io-1.4.jar:$ROOT/commons-lang-2.1.jar:$ROOT/commons-logging-1.2.jar:$ROOT/commons-pool-1.2.jar:$ROOT/trove-2.1.0.jar:$ROOT/xmlenc-0.52.jar:$ROOT/DUA1.jar:$ROOT/jibx-run-1.1.3.jar:$ROOT/libs/soot-trunk.jar"
echo $MAINCP

rm -R out-DT2Instr -f
mkdir -p out-DT2Instr

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/java/bin:$subjectloc/0110/lib/java/build:$ROOT/DistTaint.jar"


echo $SOOTCP
OUTDIR=$subjectloc/DT2Instrumented
rm -R $OUTDIR -f
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
	
java -Xmx100g -ea -cp ${MAINCP} disttaint.dt2Inst \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
   	-duaverbose \
	-slicectxinsens \
   	-brinstr:off -duainstr:off  \
        -process-dir $subjectloc/0110/lib/java/build  \
        -process-dir $subjectloc/java/bin  \
	-wrapTryCatch \
        -intraCD \
        -interCD \
        -exInterCD \
	-allowphantom \
	-serializeVTG \
    1>out-DT2Instr/instr.out 2>out-DT2Instr/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

