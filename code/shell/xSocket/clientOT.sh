source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/OTInstrumented:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint.jar"
java -cp ${MAINCP} XSocketClient
