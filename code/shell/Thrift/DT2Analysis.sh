#!/bin/bash

#query=${4:-"quantum_expire"}
query=${1:-"<org.apache.thrift.transport.TSocket: void open()> - specialinvoke \$r14.<java.io.BufferedInputStream: void <init>(java.io.InputStream,int)>(\$r16, 1024); <org.apache.thrift.transport.TIOStreamTransport: void write(byte[],int,int)> - virtualinvoke \$r4.<java.io.OutputStream: void write(byte[],int,int)>(r1, i0, i1)"}

source ./th_global.sh


INDIR=$subjectloc
echo $INDIR
BINDIR=$subjectloc/DT2Instrumented
echo $BINDIR

#MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk5.jar:$ROOT/libs/mcia.jar:$ROOT/chord/lib:$INDIR:$BINDIR"
MAINCP=".:$JAVA_HOME/jre/lib/rt.jar::$ROOT/DUA1.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DistTaint/bin:$INDIR:$BINDIR"

starttime=`date +%s%N | cut -b1-13`
	#"main,append" \
	#"append,ele" \
	#"add_process" \
	#-stmtcov
java -Xmx9g -ea -cp ${MAINCP} disttaint.dt2Analysis \
	"$query" \
	"$INDIR" \
	"$BINDIR" \
	"-method" \
	"-stmtcov" \
    "-postprune" \
	"-debug" \
    "" \ 
 
stoptime=`date +%s%N | cut -b1-13`
echo "RunTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds

echo "Running finished."

exit 0


# hcai vim :set ts=4 tw=4 tws=4

