#!/bin/bash
echo 1 > /sys/kernel/debug/tracing/tracing_on

for((i=1;i<=900;i++))
do
cat /sys/kernel/debug/tracing/trace >> /tmp/traceResult
echo > /sys/kernel/debug/tracing/trace
done

echo 0 > /sys/kernel/debug/tracing/tracing_on
