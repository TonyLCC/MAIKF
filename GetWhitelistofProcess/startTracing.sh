echo function > /sys/kernel/debug/tracing/current_tracer

#echo "Write trace pid list into /sys/kernel/debug/tracing/set_ftrace_pid..."
echo "Set pids of tracing..."

#echo "Turn on the switch of trace..."
echo "Start tracing..."
echo 1 > /sys/kernel/debug/tracing/tracing_on

echo "Value of tracing_on is : \c" && cat /sys/kernel/debug/tracing/tracing_on
