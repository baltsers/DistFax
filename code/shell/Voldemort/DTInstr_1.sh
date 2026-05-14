#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./vd_global.sh
source ./vd_global.sh/
#DRIVERCLASS=ChatServer.core.MainServer
subjectloc=$subjectloc/


#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar:$subjectloc/dist/classes"
MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/libs/DUA1.jar:$ROOT/DistTaint.jar"
echo $MAINCP

rm -R out-DTInstr -f
mkdir -p out-DTInstr

#SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin":$subjectloc/dist/classes/${ver}${seed}:$subjectloc/lib
#SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/soot-trunk4.jar:$ROOT/DistEA/DUA1.jar:$ROOT/Diver/LocalsBox:$ROOT/Diver/InstrReporters:$subjectloc/dist/classes/${ver}${seed}:$ROOT/Diver/Diver.jar:$subjectloc/lib"
#SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/DUA1.jar:$subjectloc/dist/classes/${ver}${seed}:$ROOT/libs/mcia.jar:$subjectloc/lib:$ROOT/mcia/bin"

#SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/dist/classes:$ROOT/libs/soot-trunk8.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/mcia8.jar"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/dist/classes:$ROOT/DistTaint.jar"


echo $SOOTCP
OUTDIR=$subjectloc/DTInstrumented/classes
# rm -R $OUTDIR -f
# mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`
	#-sclinit \
	#-wrapTryCatch \
	#-debug \
	#-dumpJimple \
	#-statUncaught \
	#-ignoreRTECD \
	#-exInterCD \
	#-main-class ScheduleClass -entry:ScheduleClass \
java -Xmxi400g -ea -cp ${MAINCP} disttaint.dtInst \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
   	-duaverbose \
	-slicectxinsens \
   	-brinstr:off -duainstr:off  \
	-process-dir $subjectloc/dist/classes \
	-allowphantom \
	 1>out-DTInstr/instr_1.out 2>out-DTInstr/instr_1.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

cp $subjectloc/dist/classes/voldemort/xml/*.xsd  $OUTDIR/voldemort/xml 
echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

