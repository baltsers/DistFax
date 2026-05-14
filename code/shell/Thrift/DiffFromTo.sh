#!/bin/bash

for((i=$1;i<=$2;i++)); 
do   
	for((j=$1;j<=$2;j++)); 
	do
	if [ $i -gt $j ];
    then
		cd $subjectloc/test1
		cat $subjectloc/test1/clientlog/$i/*.FL > $subjectloc/test1/clientlog/$i/FL.txt
		file1=$subjectloc/test1/clientlog/$i/FL.txt
		echo $file1
		echo -e "\n"		
		cat $subjectloc/test1/clientlog/$j/*.FL > $subjectloc/test1/clientlog/$j/FL.txt
		file2=$subjectloc/test1/clientlog/$j/FL.txt
		echo $file2
		echo -e "\n"
		diff $file1 $file2 > $subjectloc/test1/diff/diffClient_${i}_${j}.txt
    fi
    done
done	
