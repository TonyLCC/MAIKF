traceResult=./traceResult

# Get sorted function list
echo > $traceResult/tmp
grep -E '<-' $traceResult/$1 | awk -v fpath="$traceResult/tmp" '{print $(NF-1),$(NF) > fpath}'
sed 's/ <-/\n/g' $traceResult/tmp | sort | uniq -c | sort -k1nr -o $traceResult/$1.txt

rm -f $traceResult/$1

#rm -f $traceResult/tmp

#echo done
