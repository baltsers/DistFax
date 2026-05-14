#!/bin/bash
if [ $# -lt 0 ];then
	echo "Usage: $0 "
	exit 1
fi

source ./zk_global.sh
DRIVERCLASS=org.apache.zookeeper.ZooKeeperMain
INDIR=$subjectloc/DiverInstrumented
#INDIR=$subjectloc/build/test/classes/:$subjectloc/build/classes

#MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:/opt/jdk1.8.0_101/lib/tools.jar:$ROOT/DistEA/DUA1.jar:$ROOT/DistEA/DistEA.jar::$ROOT/libs/soot-trunk.jar:$subjectloc/bin:$ROOT/workspace/mcia/bin:$INDIR"
MAINCP=".:/opt/jdk1.8.0_101/jre/lib/rt.jar:$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$INDIR"
OUTDIR=$ROOT/z349/Diveroutdyn
echo $OUTDIR
mkdir -p $OUTDIR

starttime=`date +%s%N | cut -b1-13`
java -Xmx2800m -ea -cp ${MAINCP} Diver.DiverRun \
	$DRIVERCLASS \
        $ROOT/z349 \
	"$INDIR" \
	v1 \
	$OUTDIR 

stoptime=`date +%s%N | cut -b1-13`
echo "RunTime elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0




