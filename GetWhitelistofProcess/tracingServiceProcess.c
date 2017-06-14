#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main()
{
	long tmpPid[3];
	char tmpShell[100];

	FILE *fp = NULL;

	system("sh getPids.sh");

	if(fp = fopen("tracePidList.txt", "r"))
	{
		long zPid;
		int i = 0;
		char tmp[100];
		while(fscanf(fp,"%ld",&zPid) != EOF)
		{
			tmpPid[i++] = zPid;
			//printf("tmpPid = %ld\n", tmpPid[i-1]);
			//printf("zPid = %ld\n", zPid);
			sprintf(tmp, "echo %ld >> /sys/kernel/debug/tracing/set_ftrace_pid", zPid);			
			system(tmp);
		}
	}
	else 
		printf("\nROpen file of tracePidList.txt failed!\n");

	fclose(fp);

	system("sh startTracing.sh");

	sprintf(tmpShell, "sh traceResultHandler.sh %ld %ld %ld", tmpPid[0], tmpPid[1], tmpPid[2]);
	//printf("%s\n", tmpShell);

	//sleep(5);

	for(int i=1;i<2147483646;i++)
	{
		printf("%d\n",i);
		system(tmpShell);
		//system("sh traceResultHandler.sh");
	}
	system("sh resultHandler.sh");

	return 0;
}
