#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./xn_global.sh
MAINCP=".:$ROOT/DUA1.jar:$ROOT/distEA.jar:$ROOT/libs/soot-trunk.jar:"
#MAINCP=".:$ROOT/tools/j2sdk1.4.2_18/jre/lib/rt.jar:$ROOT/tools/polyglot-1.3.5/lib/polyglot.jar:$ROOT/tools/soot-2.3.0/lib/sootclasses-2.5.0.jar:$ROOT/tools/jasmin-2.3.0/lib/jasminclasses-2.3.0.jar:$ROOT/workspace/DUA1.jar:$ROOT/workspace/mcia/bin:$ROOT/tools/java_cup.jar"
#MAINCP=".:$ROOT/tools/j2sdk1.4.2_18/jre/lib/rt.jar:$ROOT/tools/polyglot-1.3.5/lib/polyglot.jar:$ROOT/tools/soot-2.3.0/lib/sootclasses-trunk.jar:$ROOT/tools/jasmin-2.3.0/lib/jasminclasses-2.3.0.jar:$ROOT/workspace/DUA1.jar:$ROOT/workspace/mcia/bin:$ROOT/tools/java_cup.jar"

#SOOTCP=".:/etc/alternatives/java_sdk/jre/lib/rt.jar:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/DUA1.jar:$ROOT/workspace/mcia/bin:$subjectloc/dist/classes:$subjectloc/dist/testclasses:$subjectloc/lib/netty-3.5.8.Final.jar"
#SOOTCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/DistEA6.jar:$subjectloc/bin:$subjectloc/lib/netty-3.7.0.Final.jar:$ROOT/DistEA/DUA1.jar:$ROOT/libs/soot-trunk.jar:$subjectloc/dist/classes:$subjectloc/dist/testclasses:$subjectloc/bin"
SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$subjectloc/java2:$subjectloc/jar:$ROOT/distEA.jar"
#for i in $subjectloc/lib/*.jar;
#do
#	SOOTCP=$SOOTCP:$i
#done

suffix="xn"

LOGDIR=out-distEAInstr
mkdir -p $LOGDIR
logout=$LOGDIR/instr-$suffix.out
logerr=$LOGDIR/instr-$suffix.err

OUTDIR=$subjectloc/distEAInstrumented
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
	#-main-class $DRIVERCLASS \
	#-entry:$DRIVERCLASS \
	
java -Xmx4000m -ea -cp ${MAINCP} distEA.distEAInst \
	-w -cp $SOOTCP -p cg verbose:false,implicit-entry:false \
	-p cg.spark verbose:false,on-fly-cg:false,rta:true -f c \
	-d $OUTDIR \
	-brinstr:on -duainstr:on \
	-allowphantom \
	-wrapTryCatch \
	-nio \
	-dumpFunctionList \
	-dumpJimple \
	-slicectxinsens \
	-process-dir $subjectloc/java2 \
	-process-dir $subjectloc/jar \
	1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds
#echo "Instrumentation done, now copying resources required for running."


echo "Running finished."
exit 0


# hcai vim :set ts=4 tw=4 tws=4

