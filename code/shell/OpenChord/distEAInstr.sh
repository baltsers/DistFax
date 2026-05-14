#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./chord_global.sh

MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/libs/DUA1.jar:$ROOT/libs/DistEA8.jar:$subjectloc/build/classes"

SOOTCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/DistEA8.jar:$subjectloc/build/classes"

#for i in $subjectloc/lib/*.jar;
#do
#	SOOTCP=$SOOTCP:$i
#done

suffix="chord"

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
	#-syncnio \
	#-socket \
	#-main-class org.apache.zookeeper.util.FatJarMain \
	#-entry:org.apache.zookeeper.util.FatJarMain \
	#-process-dir $subjectloc/build/contrib/fatjar/classes \
java -Xmx40g -ea -cp ${MAINCP} distEA.distEAInst \
	-w -cp $SOOTCP -p cg verbose:false,implicit-entry:false \
	-p cg.spark verbose:false,on-fly-cg:true,rta:false -f c \
	-d $OUTDIR \
	-brinstr:off -duainstr:off \
	-allowphantom \
	-dumpJimple \
	-nio \
	-objstream \
	-wrapTryCatch \
	-dumpFunctionList \
	-main-class $DRIVERCLASS \
	-entry:$DRIVERCLASS \
	-slicectxinsens \
	-process-dir $subjectloc/build/classes \
	1> $logout 2> $logerr

stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds

#echo "Instrumentation done, now copying resources required for running."
#cp -rf $subjectloc/build/classes/org/apache/fop/cli/image2fo.xsl $OUTDIR/org/apache/fop/cli/
#cp -rf $subjectloc/build/classes/org/apache/fop/pdf/*.icm* $OUTDIR/org/apache/fop/pdf/
#cp -rf $subjectloc/build/classes/org/apache/fop/render/awt/viewer/{images,resources} $OUTDIR/org/apache/fop/render/awt/viewer/
#cp -rf $subjectloc/build/classes/META-INF $OUTDIR/

echo "Running finished."
exit 0




