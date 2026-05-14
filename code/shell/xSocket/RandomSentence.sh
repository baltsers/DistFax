#!/bin/bash
#java -cp $ROOT/RandomSentence.jar SimpleRandomSentences
export sentence=$(java -cp $ROOT/RandomSentence.jar SimpleRandomSentences)
#java SimpleRandomSentences
#export sentence=$((java SimpleRandomSentences))
echo $sentence
