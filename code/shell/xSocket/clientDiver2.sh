source ./xs_global.sh
MAINCP=".:$ROOT/xSocket/DiverInstrumented2:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/DiverThread.jar"
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} XSocketClient
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds
