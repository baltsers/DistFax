#!/bin/bash
echo $1 $2
echo $3 $4
echo $5 $6
for((i=$1;i<=$2;i++)); 
do   
	for((j=$3;j<=$4;j++)); 
	do  		
		for((k=$5;k<=$6;k++)); 
		do  
		
			cd /home/username/z3411/test1
			cat /home/username/z3411/test1/clientlog/${i}_${j}_${k}/*.FL > /home/username/z3411/test1/clientlog/${i}_${j}_${k}/FL.txt
			file1=/home/username/z3411/test1/clientlog/${i}_${j}_${k}/FL.txt
			echo $file1
			echo -e "\n"
				for((i2=$1;i2<=$2;i2++)); 
				do   
					for((j2=$3;j2<=$4;j2++)); 
					do  		
						for((k2=$5;k2<=$6;k2++)); 
						do  
		                    #echo ${i}-${j}-${k}_${i2}-${j2}-${k2}
							if [ $i2 -gt $i ] || [ $j2 -gt $j ] || [ $k2 -gt $k ];
							then
		                    echo ${i}-${j}-${k}_${i2}-${j2}-${k2}
		cat /home/username/z3411/test1/clientlog/${i2}_${j2}_${k2}/*.FL > /home/username/z3411/test1/clientlog/${i2}_${j2}_${k2}/FL.txt
		file2=/home/username/z3411/test1/clientlog/${i2}_${j2}_${k2}/FL.txt
		diff $file1 $file2 > /home/username/z3411/test1/diff/diffClient_${i}-${j}-${k}_${i2}-${j2}-${k2}.txt
		echo /home/username/z3411/test1/diff/diffClient_${i}-${j}-${k}_${i2}-${j2}-${k2}.txt
							fi						
						done
					done
				done  	
	
		echo /home/username/z3411/test1/diff/diffClient_*.txt -size +1 -delete
		done
	done
done  
find /home/username/z3411/test1/diff/diffClient_*.txt -size 0 > /home/username/z3411/test1/diff0/diff0.txt

