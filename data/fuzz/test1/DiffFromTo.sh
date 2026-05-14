#!/bin/bash

cd /home/username/fuzz/test1
for((i=$1;i<=$2;i++)); 
do   
    cd /home/username/fuzz/test1
	cat /home/username/fuzz/test1/clientlog/$i/*.FL > /home/username/fuzz/test1/clientlog/$i/FL.txt
	file1=/home/username/fuzz/test1/clientlog/$i/FL.txt
	echo $file1
	echo -e "\n"		
	for((j=1;j<=$2;j++)); 
	do
	if [ $i -gt $j ];
    then
		#cd /home/username/fuzz/test1
		#cat /home/username/fuzz/test1/clientlog/$i/*.FL > /home/username/fuzz/test1/clientlog/$i/FL.txt
		#file1=/home/username/fuzz/test1/clientlog/$i/FL.txt
		#echo $file1
		#echo -e "\n"		
		cat /home/username/fuzz/test1/clientlog/$j/*.FL > /home/username/fuzz/test1/clientlog/$j/FL.txt
		file2=/home/username/fuzz/test1/clientlog/$j/FL.txt
		#echo $file2
		#echo -e "\n"
		diff $file1 $file2 > /home/username/fuzz/test1/diff/diffClient_${i}_${j}.txt
		echo /home/username/fuzz/test1/diff/diffClient_${i}_${j}.txt
        #find /home/username/fuzz/test1/diff/diffClient_*.txt -size +1 -delete
    fi
    done
    find /home/username/fuzz/test1/diff/diffClient_*.txt -size +1 -delete
done
find /home/username/fuzz/test1/diff/diffClient_*.txt -size 0 > /home/username/fuzz/test1/diff0/diff0.txt

