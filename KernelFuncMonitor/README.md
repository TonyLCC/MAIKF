--------------------- kernel function monitor ---------------------



cd Kprobes_register

make

sudo make install

dmesg

(launch firefox)

dmesg

[23502.477636] *************************************************************
[23502.477641] [Emergency] A high-risk function is called!!!
[23502.477677] [Emergency] Function name: _do_fork
[23502.477680] [Emergency] Process information: pid:  14440 |comm:   firefox
[23502.477711] [Emergency] Register information: rdi: 00000011  rsi: 00000000  rdx: 00000000  rcx: 00000000  r8: 00000000  r9: 00000000
[23502.477715] [Emergency] Timestamp: 1493640848.141706
[23502.477717] [Emergency] Beijing time: 2017-05-01 20:14:08 
[23502.477719] [Emergency] This process has be killed!
[23502.477721] *************************************************************

sudo make clean
