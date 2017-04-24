#!/bin/bash

# Quantity of traceResult file
resultFileCount=$(ls -l /tmp | awk '/traceResult/ && !/.txt/' | wc -l)
echo "File Count:" $resultFileCount

echo > /tmp/tmp
# Traverse all traceResult files
for((i=1;i<=$resultFileCount;i++))
do
	# Get sorted function list
	grep -E '<-' /tmp/$1$i | awk -v fpath="/tmp/tmp" '{print $(NF-1),$(NF) > fpath}'
	sed 's/ <-/\n/g' /tmp/tmp | sort | uniq -c | sort -k1nr -o /tmp/$1$i.txt
	#sed 's/ <-/\n/g' /tmp/tmp1 > /tmp/tmp2
	#sort /tmp/tmp2 | uniq -c > /tmp/tmp3
	#sort -k1nr /tmp/tmp3 -o $1$i.txt
	#sort -k1n /tmp/tmp3 > /tmp/tmp4
	cat /tmp/$1$i.txt >> /tmp/result
done

rm -f /tmp/tmp #/tmp/tmp1 /tmp/tmp2 /tmp/tmp3

sort -k1nr /tmp/result -o /tmp/result.txt

# Count specific function in traceResult file
#grep -o vfs_write $1 | wc -l

echo done
