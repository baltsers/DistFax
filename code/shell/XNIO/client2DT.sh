source ./gl_global.sh
MAINCP=".:$ROOT/XNIO/DTInstrumented:$ROOT/XNIO/jar/xnio-nio-3.0.8.GA.jar:$ROOT/XNIO/jar/jboss-logging-3.1.2.GA.jar:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
java -cp ${MAINCP} -DltsDebug=true XNIOClient2 $1
