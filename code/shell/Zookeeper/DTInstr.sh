#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./zk_global.sh
source ./zs_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
#subjectloc=$subjectloc/


#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar:$subjectloc/dist/classes"
MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint3.jar"
echo $MAINCP
rm -R out-DTInstr -f
mkdir -p out-DTInstr


SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/build/classes:$subjectloc/build/test/classes:$ROOT/DistTaint3.jar"


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
java -Xmx400g -ea -cp ${MAINCP} disttaint.dtInst \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
   	-duaverbose \
	-slicectxinsens \
   	-brinstr:off -duainstr:off  \
	-process-dir $subjectloc/build/classes \
	-process-dir $subjectloc/build/test/classes \
	-allowphantom \
	# 1>out-DTInstr/instr.out 2>out-DTInstr/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

