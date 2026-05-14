#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./chord_global.sh
source ./chord_global.sh/
echo $DRIVERCLASS
echo $subjectloc


MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint/bin"
echo $MAINCP
rm -R out-DT2BrInstrumented -f
mkdir -p out-DT2BrInstrumented 


SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/DT2BrPre:$ROOT/DistTaint/bin"


echo $SOOTCP
OUTDIR=$subjectloc/DT2BrInstrumented
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
java -Xmx100g -ea -cp ${MAINCP} disttaint.dt2BranchInst \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false  \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-process-dir $subjectloc/DT2BrPre \
	-dumpJimple \
	-dumpFunctionList \
    #-main-class $DRIVERCLASS  -entry:$DRIVERCLASS \
        #	 1>out-DiverInstr/instr.out 2>out-DiverInstr/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds
echo "Running finished."
exit 0




