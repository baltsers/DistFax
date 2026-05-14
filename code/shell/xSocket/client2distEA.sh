source ./xs_global.sh
#MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/libs/DistEA6.jar:$ROOT/xSocket/distEAInstrumented"
MAINCP=".:$ROOT/libs/soot-trunk.jar:$ROOT/DUA1.jar:$ROOT/xSocket/distEAInstrumented:$ROOT/libs/DistEA8.jar"
starttime=`date +%s%N | cut -b1-13`
java -cp ${MAINCP} -DltsDebug=true -DtrackSender=true XSocketClient2
stoptime=`date +%s%N | cut -b1-13`
echo "StaticAnalysisTime for ${ver}${seed} elapsed: " `expr $stoptime - $starttime` milliseconds
