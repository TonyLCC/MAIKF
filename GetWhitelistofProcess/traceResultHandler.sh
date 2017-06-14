traceResultPath=./traceResultOfXvnc
xrdp=$traceResultPath/xrdp
vsftpd=$traceResultPath/vsftpd
xrdp_sesman=$traceResultPath/xrdp_sesman

pidofxrdp=\\-$1
pidofxrdp_sesman=\\-$2
pidofvsftpd=\\-$3
pidoftotal=\'\\\|\\-$1\\\|\\-$2\\\|\\-$3\'

#echo $pidofxrdp
#echo $pidofxrdp_sesman
#echo $pidofvsftpd
#echo $pidoftotal

echo "Get the result of trace..."

cat /sys/kernel/debug/tracing/trace > $traceResultPath/traceResult.txt #获取跟踪原始结果

echo "" > /sys/kernel/debug/tracing/trace



#Case 1: xrdp, Pid = 2343->2409->2413->2357->2372

grep -E $pidofxrdp $traceResultPath/traceResult.txt > $xrdp/traceResult_xrdp2.txt

echo "" > $xrdp/traceResult_xrdp3.txt

awk -v fpath="$xrdp/traceResult_xrdp3.txt" '{print $(NF-1),$(NF) > fpath}'  $xrdp/traceResult_xrdp2.txt

sed 's/ <-/\n/g' $xrdp/traceResult_xrdp3.txt > $xrdp/traceResult_xrdp4.txt

sort -o $xrdp/traceResult_xrdp5.txt $xrdp/traceResult_xrdp4.txt

uniq $xrdp/traceResult_xrdp5.txt > $xrdp/traceResult_xrdp6.txt

cat $xrdp/traceResult_xrdp6.txt >> $xrdp/appendTraceResult_xrdp6.txt

######Don't handle the appendTraceResult every time, just handle it finally!!! note20161118######

#sort -o $xrdp/sortedAppendTraceResult_xrdp6.txt $xrdp/appendTraceResult_xrdp6.txt

#uniq $xrdp/sortedAppendTraceResult_xrdp6.txt > $xrdp/finalAppendTraceResult_xrdp.txt

#记录函数调用关系

sort $xrdp/traceResult_xrdp3.txt | uniq >> $xrdp/sortedFunCallRelationship_xrdp.txt

#grep -wvf $xrdp/funcallRelationship_xrdp.txt $xrdp/sortedFunCallRelationship_xrdp.txt >> $xrdp/newSortedFunCallRelationship_xrdp.txt



#Case 2: xrdp-sesman, Pid = 2351->2411->2415->2363->2381

grep -E $pidofxrdp_sesman $traceResultPath/traceResult.txt > $xrdp_sesman/traceResult_xrdp_sesman2.txt

echo "" > $xrdp_sesman/traceResult_xrdp_sesman3.txt

awk -v fpath="$xrdp_sesman/traceResult_xrdp_sesman3.txt" '{print $(NF-1),$(NF) > fpath}' $xrdp_sesman/traceResult_xrdp_sesman2.txt

sed 's/ <-/\n/g' $xrdp_sesman/traceResult_xrdp_sesman3.txt > $xrdp_sesman/traceResult_xrdp_sesman4.txt

sort -o $xrdp_sesman/traceResult_xrdp_sesman5.txt $xrdp_sesman/traceResult_xrdp_sesman4.txt

uniq $xrdp_sesman/traceResult_xrdp_sesman5.txt > $xrdp_sesman/traceResult_xrdp_sesman6.txt

cat $xrdp_sesman/traceResult_xrdp_sesman6.txt >> $xrdp_sesman/appendTraceResult_xrdp_sesman6.txt

#sort -o $xrdp_sesman/sortedAppendTraceResult_xrdp_sesman6.txt $xrdp_sesman/appendTraceResult_xrdp_sesman6.txt

#uniq $xrdp_sesman/sortedAppendTraceResult_xrdp_sesman6.txt > $xrdp_sesman/finalAppendTraceResult_xrdp_sesman.txt

#记录函数调用关系

sort $xrdp_sesman/traceResult_xrdp_sesman3.txt | uniq >> $xrdp_sesman/sortedFunCallRelationship_xrdp_sesman.txt

#grep -wvf $xrdp_sesman/funcallRelationship_xrdp_sesman.txt $xrdp_sesman/sortedFunCallRelationship_xrdp_sesman.txt >> $xrdp_sesman/newSortedFunCallRelationship_xrdp_sesman.txt



#Case 3: vsftpd, Pid = 81552->2096->2166->2084->2090

grep -E $pidofvsftpd $traceResultPath/traceResult.txt > $vsftpd/traceResult_vsftpd2.txt

echo "" > $vsftpd/traceResult_vsftpd3.txt

awk -v fpath="$vsftpd/traceResult_vsftpd3.txt" '{print $(NF-1),$(NF) > fpath}' $vsftpd/traceResult_vsftpd2.txt

sed 's/ <-/\n/g' $vsftpd/traceResult_vsftpd3.txt > $vsftpd/traceResult_vsftpd4.txt

sort -o $vsftpd/traceResult_vsftpd5.txt $vsftpd/traceResult_vsftpd4.txt

uniq $vsftpd/traceResult_vsftpd5.txt > $vsftpd/traceResult_vsftpd6.txt

cat $vsftpd/traceResult_vsftpd6.txt >> $vsftpd/appendTraceResult_vsftpd6.txt

#sort -o $vsftpd/sortedAppendTraceResult_vsftpd6.txt $vsftpd/appendTraceResult_vsftpd6.txt

#uniq $vsftpd/sortedAppendTraceResult_vsftpd6.txt > $vsftpd/finalAppendTraceResult_vsftpd.txt

#记录函数调用关系

sort $vsftpd/traceResult_vsftpd3.txt | uniq >> $vsftpd/sortedFunCallRelationship_vsftpd.txt

#grep -wvf $vsftpd/funcallRelationship_vsftpd.txt $vsftpd/sortedFunCallRelationship_vsftpd.txt >> $vsftpd/newSortedFunCallRelationship_vsftpd.txt



#Case 4: Other Pid Results
grep -v $pidoftotal $traceResultPath/traceResult.txt >> $traceResultPath/otherResult.txt



echo done
