#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./th_global.sh
source ./th_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
subjectloc=$subjectloc


#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar:$subjectloc/bin"
MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
echo $MAINCP
rm -R out-DTInstr -f
mkdir -p out-DTInstr


SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/java/bin:$subjectloc/0110/lib/java/build:$ROOT/DistTaint.jar"
#SOOTCP="$subjectloc/java/bin"


echo $SOOTCP
OUTDIR=$subjectloc/DTInstrumented
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
java -Xmx1g -ea -cp ${MAINCP} disttaint.dtInst \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
   	-brinstr:off -duainstr:off  \
        -process-dir $subjectloc/java/bin  \
        -process-dir $subjectloc/0110/lib/java/build  \
	-allowphantom \
	# 1>out-DTInstr/instr.out 2>out-DTInstr/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

