#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./chord_global.sh
source ./chord_global.sh/
#DRIVERCLASS=C
#subjectloc=$ROOT/TEST/


MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint/bin"
echo $MAINCP
rm entitystmt.out.branch -f
rm -R out-DT2BrPre -f
mkdir -p out-DT2BrPre


SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/build/classes:$ROOT/DistTaint/bin"



echo $SOOTCP
OUTDIR=$subjectloc/DT2BrPre
rm -R $OUTDIR -f 
mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`
	#-sclinit \
	#-wrapTryCatch \
	#-debug \
	#-dumpJimple \	
    #    -dumpFunctionList \
	#-statUncaught \
	#-ignoreRTECD \
	#-exInterCD \
	#-main-class ScheduleClass -entry:ScheduleClass \
java -Xmx100g -ea -cp ${MAINCP} disttaint.dt2BranchPre \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false  \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-process-dir $subjectloc/build/classes \
	-brinstr:off -duainstr:off \
	-allowphantom \
	-wrapTryCatch \
            -interCD \
            -interCD \
            -exInterCD \
        -duaverbose   \
        -serializeVTG \
	-slicectxinsens \
    	 1>out-DT2BrPre/bpre.out 2>out-DT2BrPre/bpre.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds
cp $subjectloc/DT2BrPre/entitystmt.out.branch .
echo "Running finished."
exit 0




