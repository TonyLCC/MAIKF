#!/bin/bash
traceResult=./traceResult

# Quantity of traceResult file
resultFileCount=$(ls -l $traceResult | awk '/traceResult/ && /.txt/' | wc -l)
echo "File Count:" $resultFileCount

# Traverse all traceResult files
for((i=1;i<=$resultFileCount;i++))
do
	echo traceResult$i.txt
	cat $traceResult/traceResult$i.txt >> $traceResult/result
done

sort -k1nr $traceResult/result -o $traceResult/result.txt


echo > $traceResult/totalFuncs
echo > $traceResult/result1
echo > $traceResult/result2
echo > $traceResult/tmp1
echo > $traceResult/tmp2

# All functions in trace result
awk -v fpath="$traceResult/totalFuncs" '{print $2 > fpath}' $traceResult/result.txt
sort -u $traceResult/totalFuncs -o $traceResult/totalFuncs.txt

# Functions: called frequency lower than k
awk -v fpath="$traceResult/result1" '{if($1<=100) print $0 > fpath}' $traceResult/result.txt
awk -v fpath="$traceResult/tmp1" '{print $2 > fpath}' $traceResult/result1
sort -u $traceResult/tmp1 -o $traceResult/result1.txt

# Functions: called frequency higher than k
awk -v fpath="$traceResult/result2" '{if($1>100) print $0 > fpath}' $traceResult/result.txt
awk -v fpath="$traceResult/tmp2" '{print $2 > fpath}' $traceResult/result2
sort -u $traceResult/tmp2 -o $traceResult/result2.txt

grep -wvf $traceResult/result2.txt $traceResult/result1.txt > $traceResult/kernelFuncMonitorList
grep -v '\.' $traceResult/kernelFuncMonitorList > $traceResult/kernelFuncMonitorList.txt

rm -f $traceResult/tmp $traceResult/tmp1 $traceResult/tmp2 $traceResult/totalFuncs

echo done
