#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<org.apache.jute.BinaryInputArchive: long readLong(java.lang.String)> - \$l0 = interfaceinvoke \$r2.<java.io.DataInput: long readLong()>(); <org.apache.zookeeper.ClientCnxnSocketNIO: void disableWrite()> - virtualinvoke \$r2.<java.nio.channels.SelectionKey: java.nio.channels.SelectionKey interestOps(int)>(\$i2)"}

source ./zk_global.sh


INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DT2Instrumented
echo $BINDIR

#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/libs/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint.jar:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx90g -ea -cp ${MAINCP} disttaint.dt2Analysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"-method" \
	"-stmtcov" \
    "-preprune" \
	"-debug" \
    "" \ 
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0



