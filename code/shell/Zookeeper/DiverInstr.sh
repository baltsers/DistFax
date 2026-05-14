#!/bin/bash

source ./zk_global.sh
source ./zs_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
subjectloc=$ROOT/z349


MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/distDIVER.jar"

echo $MAINCP
mkdir -p out-DiverInstr

#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin":$subjectloc/bin/${ver}${seed}:$subjectloc/lib
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk4.jar:$ROOT/DistEA/DUA1.jar:$ROOT/Diver/LocalsBox:$ROOT/Diver/InstrReporters:$ROOT/multichat/bin/${ver}${seed}:$ROOT/Diver/Diver.jar:$ROOT/multichat/lib"
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/DUA1.jar:$ROOT/multichat/bin/${ver}${seed}:$ROOT/libs/mcia.jar:$ROOT/multichat/lib:$ROOT/mcia/bin"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/build/classes:$subjectloc/build/test/classes:$ROOT/distDIVER.jar"
echo $SOOTCP
OUTDIR=$ROOT/z349/DiverInstrumented
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
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:true,on-fly-cg:false,rta:true \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-slicectxinsens \
	-wrapTryCatch \
        -intraCD     \
        -interCD     \
        -exInterCD   \
	-allowphantom \
	-serializeVTG \
	-visualizeVTG \
	-dumpJimple \
	-dumpFunctionList \
    -process-dir $ROOT/z349/build/classes \
        -process-dir $ROOT/z349/build/test/classes \
       1>out-DiverInstr/instr.out 2>out-DiverInstr/instr.err        

        # -process-dir $ROOT/z349/build/test/classes \
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0




