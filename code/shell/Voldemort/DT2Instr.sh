#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi
source ./vd_global.sh
source ./vd_global.sh
#MAINCP="$ROOT/DistEA/DUA1.jar:$ROOT/DistTaint/bin:$ROOT/libs/soot-trunk.jar"
MAINCP=".:$ROOT/DistTaint.jar:$ROOT/banderaCommons.jar:$ROOT/banderaToolFramework.jar:$ROOT/commons-cli-1.3.1.jar:$ROOT/commons-io-1.4.jar:$ROOT/commons-lang-2.1.jar:$ROOT/commons-logging-1.2.jar:$ROOT/commons-pool-1.2.jar:$ROOT/trove-2.1.0.jar:$ROOT/xmlenc-0.52.jar:$ROOT/DUA1.jar:$ROOT/jibx-run-1.1.3.jar:$ROOT/libs/soot-trunk.jar"
SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/dist/classes:$subjectloc/dist/testclasses:$ROOT/DistTaint.jar"

suffix="voldemort"

LOGDIR=out-DT2Instr
mkdir -p $LOGDIR
logout=$LOGDIR/instr-$suffix.out
logerr=$LOGDIR/instr-$suffix.err

OUTDIR=$subjectloc/DT2Instrumented
mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`

	#-allowphantom \
   	#-duaverbose \
	#-wrapTryCatch \
	#-dumpJimple \
	#-statUncaught \
	#-perthread \
	#-syncnio \
	#-main-class $DRIVERCLASS \
	#-entry:$DRIVERCLASS \
	#-syncnio \
	#-syncnio \
	#-main-class $DRIVERCLASS \
	#-entry:$DRIVERCLASS \
	
java -Xmx120g -ea -cp ${MAINCP} disttaint.dt2Inst \
	-w -cp $SOOTCP -p cg verbose:false,implicit-entry:false \
	-p cg.spark verbose:false,on-fly-cg:true,rta:false -f c \
	-d $OUTDIR \
	-brinstr:off -duainstr:off \
	-allowphantom \
	-wrapTryCatch \
            -interCD \
            -interCD \
            -exInterCD \
        -duaverbose   \
        -serializeVTG \
	-slicectxinsens \
        -debug \
          -process-dir $subjectloc/dist/classes \
		  -process-dir $subjectloc/dist/testclasses \
	 1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."
exit 0




