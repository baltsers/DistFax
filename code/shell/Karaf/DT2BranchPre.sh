#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./ka_global.sh
source ./ka_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
subjectloc=$ROOT/karaf/


#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar:$ROOT/karaf/bin"
MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
echo $MAINCP
rm -R out-DTInstr -f
mkdir -p out-DTInstr

#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin":$subjectloc/bin/${ver}${seed}:$subjectloc/lib
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk4.jar:$ROOT/DistEA/DUA1.jar:$ROOT/Diver/LocalsBox:$ROOT/Diver/InstrReporters:$ROOT/multichat/bin/${ver}${seed}:$ROOT/Diver/Diver.jar:$ROOT/multichat/lib"
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/DUA1.jar:$ROOT/multichat/bin/${ver}${seed}:$ROOT/libs/mcia.jar:$ROOT/multichat/lib:$ROOT/mcia/bin"

#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/karaf/bin:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/willInst:$ROOT/DistTaint.jar"


echo $SOOTCP
OUTDIR=$ROOT/karaf/DT2BrPre
rm -R $OUTDIR
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
	
java -Xmx200g -ea -cp ${MAINCP} disttaint.dt2BranchPre \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
   	-brinstr:off -duainstr:off  \
	-process-dir $subjectloc/willInst \
	-allowphantom \
#	 1>out-DTInstr/instr.out 2>out-DTInstr/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

