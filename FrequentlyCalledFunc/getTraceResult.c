#include <stdio.h>
#include <unistd.h>
#include <pthread.h>

pthread_t t;
int count_file = 0;

void* handler_thread(void* arg)
{
//	printf("Thread Run : ");
	char cmd[20] = {0};
	sprintf(cmd, "sh resultHandler.sh traceResult%d", count_file);
//	printf("%s\n", cmd);
	system(cmd);

	pthread_exit(0);
}

int main()
{
	int thread_ret = 0;
	char cmd[120] = {0};
	FILE* fp = NULL;

	system("echo function > /sys/kernel/debug/tracing/current_tracer && echo 1 > /sys/kernel/debug/tracing/tracing_on");

	while (1)
	{
		fp = fopen("/sys/kernel/debug/tracing/trace", "rb");
		if (fp == NULL)
		{
			printf("Failed to open file.\n");
			return -1;
		}
//		printf("File opened.\n");

		thread_ret = pthread_join(t, NULL);
		if (thread_ret != 0)
		{
			printf("Pthread_join error!\n");
		}

		count_file++;

		sprintf(cmd,
				"cat /sys/kernel/debug/tracing/trace > ./traceResult/traceResult%d && echo > /sys/kernel/debug/tracing/trace",
				count_file);
//		printf("%s\n", cmd);
		printf("traceResult%d\n", count_file);
		system(cmd);

		thread_ret = pthread_create(&t, NULL, handler_thread, NULL);
		if (thread_ret != 0)
		{
			printf("Pthread_create failed!");
		}
//		else
//		{
//			printf("Pthread_create success!\n");
//		}

		fclose(fp);
		fp = NULL;

		sleep(1);
	}

	return 0;
}

