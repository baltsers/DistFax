#!/bin/bash

cd /home/username/fuzz/test1
for((i=$1;i<=$2;i++)); 
do   
    cd /home/username/fuzz/test1
	cat /home/username/fuzz/test1/clientlog/$i/*.FL > /home/username/fuzz/test1/clientlog/$i/FL.txt
done

