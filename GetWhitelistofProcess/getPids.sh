echo "Pid of xrdp is         : \c" && pidof xrdp
echo "Pid of xrdp-sesman is  : \c" && pidof xrdp-sesman
echo "Pid of Xvnc is         : \c" && pidof Xvnc
echo "Pid of vsftpd is       : \c" && pidof vsftpd

pidof xrdp > tracePidList.txt
pidof xrdp-sesman >> tracePidList.txt
#pidof Xvnc >> tracePidList.txt
pidof vsftpd >> tracePidList.txt


#echo "Turn off the switch of trace..."
echo "Intialize tracing..."
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo "Value of tracing_on is : \c" && cat /sys/kernel/debug/tracing/tracing_on

echo nop > /sys/kernel/debug/tracing/current_tracer

#sed 's/ /\n/g' XvncList.txt > traceXvncPidsList.txt
echo "" > /sys/kernel/debug/tracing/set_ftrace_pid

echo "" > /sys/kernel/debug/tracing/trace
