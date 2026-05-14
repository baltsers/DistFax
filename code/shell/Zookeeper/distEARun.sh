#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./zk_global.sh

#INDIR=$subjectloc/distEAInstrumented
INDIR=$subjectloc/build/test/classes/:$subjectloc/build/classes

MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:/opt/jdk1.8.0_101/lib/tools.jar:$ROOT/DistEA/DUA1.jar:$ROOT/DistEA/DistEA.jar::$ROOT/libs/soot-trunk.jar:$subjectloc/bin:$ROOT/workspace/mcia/bin:$INDIR"

for i in $subjectloc/lib/*.jar;
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
	#java -Xmx40800m -ea -DforceMirror=false -DuseToken=true -DltsDebug=true -cp ${MAINCP} distEA.distEARun \
	java -Xmx40800m -ea -DforceMirror=false -DuseToken=true -DltsDebug=false -cp ${MAINCP} distEA.distEARun \
		$DRIVERCLASS \
		"$subjectloc" \
		"$INDIR" \
		$OUTDIR \
		$l \
		-perthread \
		-intercept \
		#-debug

done

stoptime=`date +%s%N | cut -b1-13`

echo "RunTime for $suffix elapsed: " `expr $stoptime - $starttime` milliseconds
exit 0


