source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/DTInstrumented:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistTaint/bin"
java -cp ${MAINCP} XSocketClient2
