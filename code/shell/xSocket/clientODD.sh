source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/ODDInstrumented:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DistODD.jar"
java -cp ${MAINCP} XSocketClient
