#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./de_global.sh
source ./de_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
subjectloc=${subjectloc}/


#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar:$${subjectloc}/bin"
#MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/libs/DUA1.jar:$ROOT/DistTaint/bin"
MAINCP=".:$ROOT/DistTaint3.jar:$ROOT/banderaCommons.jar:$ROOT/banderaToolFramework.jar:$ROOT/commons-cli-1.3.1.jar:$ROOT/commons-io-1.4.jar:$ROOT/commons-lang-2.1.jar:$ROOT/commons-logging-1.2.jar:$ROOT/commons-pool-1.2.jar:$ROOT/trove-2.1.0.jar:$ROOT/xmlenc-0.52.jar:$ROOT/DUA1.jar:$ROOT/jibx-run-1.1.3.jar:$ROOT/libs/soot-trunk.jar"
echo $MAINCP

rm -R out-DT2Instr -f
mkdir -p out-DT2Instr

#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin":${subjectloc}/bin/${ver}${seed}:${subjectloc}/lib
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk4.jar:$ROOT/DistEA/DUA1.jar:$ROOT/Diver/LocalsBox:$ROOT/Diver/InstrReporters:$ROOT/multichat/bin/${ver}${seed}:$ROOT/Diver/Diver.jar:$ROOT/multichat/lib"
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/DUA1.jar:$ROOT/multichat/bin/${ver}${seed}:$ROOT/libs/mcia.jar:$ROOT/multichat/lib:$ROOT/mcia/bin"

#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:${subjectloc}/bin:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:${subjectloc}/java:${subjectloc}/lib2:$ROOT/DistTaint3.jar"


echo $SOOTCP
OUTDIR=${subjectloc}/DT2Instrumented
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
	-process-dir ${subjectloc}/java \
	-process-dir ${subjectloc}/lib2 \
	-dumpJimple \
	-dumpFunctionList \
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

