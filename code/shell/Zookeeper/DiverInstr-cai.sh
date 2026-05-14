#!/bin/bash

source ./zk_global.sh
source ./zs_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
subjectloc=$ROOT/z349


MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/libs/DUA1.jar:/home/hcai/mcia.jar"

echo $MAINCP
mkdir -p out-DiverInstr-cai

#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin":$subjectloc/bin/${ver}${seed}:$subjectloc/lib
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk4.jar:$ROOT/DistEA/DUA1.jar:$ROOT/Diver/LocalsBox:$ROOT/Diver/InstrReporters:$ROOT/multichat/bin/${ver}${seed}:$ROOT/Diver/Diver.jar:$ROOT/multichat/lib"
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/DUA1.jar:$ROOT/multichat/bin/${ver}${seed}:$ROOT/libs/mcia.jar:$ROOT/multichat/lib:$ROOT/mcia/bin"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/build/classes:$subjectloc/build/test/classes:/home/hcai//mcia.jar"
echo $SOOTCP
OUTDIR=$ROOT/z349/DiverInstrumented-cai
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
   	#-duaverbose \
java -Xmx120g -ea -cp ${MAINCP} Diver.DiverInst \
	-w -cp ${SOOTCP} \
	-p cg verbose:true,implicit-entry:false -p cg.spark verbose:true,on-fly-cg:true,rta:false \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-slicectxinsens \
	-wrapTryCatch \
        -intraCD     \
        -interCD     \
        -exInterCD   \
	-allowphantom \
	-serializeVTG \
        -process-dir $ROOT/z349/build/classes \
         1>out-DiverInstr-cai/instr.out 2>out-DiverInstr-cai/instr.err        

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0




