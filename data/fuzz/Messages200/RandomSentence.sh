#!/bin/bash
#java -cp /home/username/RandomSentence.jar SimpleRandomSentences
export sentence=$(java -cp ./RandomSentence.jar RandomEnglish)
#java SimpleRandomSentences
#export sentence=$((java SimpleRandomSentences))
echo $sentence
