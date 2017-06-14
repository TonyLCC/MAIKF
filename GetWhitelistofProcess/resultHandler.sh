traceResultPath=./traceResultOfXvnc
xrdp=$traceResultPath/xrdp
vsftpd=$traceResultPath/vsftpd
xrdp_sesman=$traceResultPath/xrdp_sesman

echo 0 > /sys/kernel/debug/tracing/tracing_on
echo "Stop tracing..."

#Case 1: xrdp, Pid = 2343->2409->2413

#sort -o $xrdp/sortedAppendTraceResult_xrdp6.txt $xrdp/appendTraceResult_xrdp6.txt
#uniq $xrdp/sortedAppendTraceResult_xrdp6.txt > $xrdp/finalAppendTraceResult_xrdp.txt
sort $xrdp/appendTraceResult_xrdp6.txt | uniq > $xrdp/finalAppendTraceResult_xrdp.txt
#记录函数调用关系
#grep -wvf $xrdp/funcallRelationship_xrdp.txt $xrdp/sortedFunCallRelationship_xrdp.txt >> $xrdp/newSortedFunCallRelationship_xrdp.txt
sort $xrdp/sortedFunCallRelationship_xrdp.txt | uniq > $xrdp/newSortedFunCallRelationship_xrdp.txt

#Case 2: xrdp-sesman, Pid = 2351->2411->2415

#sort -o $xrdp_sesman/sortedAppendTraceResult_xrdp_sesman6.txt $xrdp_sesman/appendTraceResult_xrdp_sesman6.txt
#uniq $xrdp_sesman/sortedAppendTraceResult_xrdp_sesman6.txt > $xrdp_sesman/finalAppendTraceResult_xrdp_sesman.txt
sort $xrdp_sesman/appendTraceResult_xrdp_sesman6.txt | uniq > $xrdp_sesman/finalAppendTraceResult_xrdp_sesman.txt
#记录函数调用关系
#grep -wvf $xrdp_sesman/funcallRelationship_xrdp_sesman.txt $xrdp_sesman/sortedFunCallRelationship_xrdp_sesman.txt >> $xrdp_sesman/newSortedFunCallRelationship_xrdp_sesman.txt
sort $xrdp_sesman/sortedFunCallRelationship_xrdp_sesman.txt | uniq > $xrdp_sesman/newSortedFunCallRelationship_xrdp_sesman.txt

#Case 3: vsftpd, Pid = 81552->2096->2166

#sort -o $vsftpd/sortedAppendTraceResult_vsftpd6.txt $vsftpd/appendTraceResult_vsftpd6.txt
#uniq $vsftpd/sortedAppendTraceResult_vsftpd6.txt > $vsftpd/finalAppendTraceResult_vsftpd.txt
sort $vsftpd/appendTraceResult_vsftpd6.txt | uniq > $vsftpd/finalAppendTraceResult_vsftpd.txt
#记录函数调用关系
#grep -wvf $vsftpd/funcallRelationship_vsftpd.txt $vsftpd/sortedFunCallRelationship_vsftpd.txt >> $vsftpd/newSortedFunCallRelationship_vsftpd.txt
sort $vsftpd/sortedFunCallRelationship_vsftpd.txt | uniq > $vsftpd/newSortedFunCallRelationship_vsftpd.txt

#Case 4: Other Pid Results

grep -E 'xrdp\-' $traceResultPath/otherResult.txt >> $traceResultPath/otherResult_xrdp.txt
grep -E 'vsftpd\-' $traceResultPath/otherResult.txt >> $traceResultPath/otherResult_vsftpd.txt
rm $traceResultPath/otherResult.txt


echo Finish
