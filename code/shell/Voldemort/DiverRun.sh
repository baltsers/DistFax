#!/bin/bash

source ./vd_global.sh
source ./vd_global.sh/
subjectloc=$ROOT/voldemort/
INDIR=$ROOT/voldemort/DiverInstrumented
echo $INDIR

BINDIR=$ROOT/voldemort/DiverInstrumented/test/unit

#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:/opt/jdk1.8.0_101/lib/tools.jar:$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/:$ROOT/Diver/InstrReporters/:$ROOT/Diver/LocalsBox/:$ROOT/libs/mcia.jar:$ROOT/mcia/bin:$ROOT/chord/lib:$INDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar:$ROOT/libs/DUA3.jar:$ROOT/libs/soot-trunk6.jar:$ROOT/libs/mcia6.jar:INDIR:$BINDIR"
OUTDIR=$ROOT/voldemort/Diveroutdyn
echo $OUTDIR
mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`
java -Xmx2800m -ea -cp ${MAINCP} Diver.DiverRun \
	$DRIVERCLASS \
        $ROOT/voldemort/ \
	"$INDIR" \
	v1 \
	$OUTDIR 

stoptime=`date +%s%N | cut -b1-13`
echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0




