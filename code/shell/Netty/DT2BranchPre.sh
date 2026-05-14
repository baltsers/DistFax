#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./ne_global.sh
source ./ne_global.sh/
#DRIVERCLASS=C
#subjectloc=$ROOT/TEST/


MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaintNetty.jar"
echo $MAINCP
rm -R out-DT2BrPre -f
mkdir -p out-DT2BrPre


SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/4119:$subjectloc/java:$ROOT/DistTaintNetty.jar"
#SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/dist/classes:$ROOT/tools/DUAForensics-bins-code/LocalsBox"


echo $SOOTCP
OUTDIR=$subjectloc/DT2BrPre
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
	
java -Xmx400g -ea -cp ${MAINCP} disttaint.dt2BranchPre \
	-w -cp ${SOOTCP} \
	-p cg verbose:false,implicit-entry:false -p cg.spark verbose:false,on-fly-cg:true,rta:false  \
	-f c -d "$OUTDIR" -brinstr:off -duainstr:off \
	-process-dir $subjectloc/4119 \
	-process-dir $subjectloc/java \
   	-duaverbose \
	-slicectxinsens \
   	-brinstr:off -duainstr:off  \
	-wrapTryCatch \
        -intraCD \
        -interCD \
        -exInterCD \
	-allowphantom \
	-serializeVTG \
	1>out-DT2BrPre/instr.out 2>out-DT2BrPre/instr.err

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds
cp $subjectloc/DT2BrPre/entitystmt.out.branch .
echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

