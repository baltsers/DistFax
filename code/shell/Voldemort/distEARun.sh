#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./vd_global.sh

INDIR=$subjectloc/distEAInstrumented
#INDIR=$subjectloc/distEAInstrumented.syncnio.thread
#INDIR=$subjectloc/distEAInstrumented.asyn.thread/
#INDIR=$subjectloc/dist/classes/:$subjectloc/dist/testclasses

#MAINCP=".:/etc/alternatives/java_sdk/jre/lib/rt.jar:$ROOT/tools/j2sdk1.4.2_18/lib/tools.jar:$ROOT/tools/polyglot-1.3.5/lib/polyglot.jar:$ROOT/tools/soot-2.3.0/lib/sootclasses-2.5.0.jar:$ROOT/tools/jasmin-2.3.0/lib/jasminclasses-2.3.0.jar:$ROOT/tools/java_cup.jar:$ROOT/workspace/DUAForensics/bin:$ROOT/workspace/LocalsBox/bin:$ROOT/workspace/InstrReporters/bin:$ROOT/workspace/mcia/bin:$INDIR"
MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:/opt/jdk1.8.0_101/lib/tools.jar:$ROOT/DistEA/DUA1.jar:$ROOT/DistEA/DistEA.jar:$ROOT/libs/soot-trunk4.jar:$subjectloc/conf:$subjectloc/distEAInstrumented:$subjectloc/OutTraces/:$subjectloc/bin:$INDIR"

for i in $ROOT/libs/*.jar;
do
	MAINCP=$MAINCP:$i
done

suffix="zk"

OUTDIR=distEAoutdyn_tmp
mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`

al=`cat $subjectloc/inputs/testinputs.txt | wc -l`
for ((l=1;l<="$al";l++))
do
		#"-fullseq" 
		#"-callmap" \
	java -Xmx40800m -ea -DforceMirror=false -DuseToken=false -DltsDebug=false -cp ${MAINCP} distEA.distEARun \
		$DRIVERCLASS \
		"$subjectloc" \
		"$INDIR" \
		$OUTDIR \
		$l \
		-perthread \
		-nointercept \
		#-debug

done

stoptime=`date +%s%N | cut -b1-13`

echo "RunTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds
exit 0


