#!/bin/bash

cd /home/username/fuzz/test1
echo $1 $2
echo $3 $4
echo $5 $6
for((i=$1;i<=$2;i++)); 
do   
	for((j=$3;j<=$4;j++)); 
	do  		
		for((k=$5;k<=$6;k++)); 
		do  
			cd /home/username/fuzz/test1
			cat /home/username/fuzz/test1/clientlog/${i}_${j}_${k}/branches*.out > /home/username/fuzz/test1/clientlog/${i}_${j}_${k}/branches.txt		
		done
	done
done  
