#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/kprobes.h>
#include <linux/slab.h>
#include <linux/time.h>
#include <linux/timex.h> 
#include <linux/rtc.h>

struct timex txc;
struct rtc_time tm;

/* For each probe you need to allocate a kprobe structure */
static struct kprobe _do_fork_kp = {
	.symbol_name	= "_do_fork",
};

/***** _do_fork ************************************************************************************/
static int pre_handler_emerg(struct kprobe *p, struct pt_regs *regs)
{
	if(!strcmp(current->comm , "firefox"))
	{
		do_gettimeofday(&(txc.time));
		rtc_time_to_tm(txc.time.tv_sec,&tm); 

//		printk("*************************************************************\n");
/*		printk(KERN_EMERG "[Emergency] A high-risk function is called : ");
		printk("Function name: %s", p->symbol_name);
		printk(", Process information: pid: %6d |comm: %8s", current->pid, current->comm);
		printk(", Register information: rdi: %08lx  rsi: %08lx  rdx: %08lx  rcx: %08lx  r8: %08lx  r9: %08lx", regs->di, regs->si, regs->dx, regs->cx, regs->r8, regs->r9);
		printk(", Timestamp: %ld.%ld", txc.time.tv_sec, txc.time.tv_usec);
		printk(", Beijing time: %d-%02d-%02d %02d:%02d:%02d\n", tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday, tm.tm_hour+8, tm.tm_min, tm.tm_sec);
*/

		printk(KERN_EMERG "[Emergency] {\"funcName\":\"%s\",\"processInfo\":{\"pid\":%d,\"comm\":\"%s\"},\"registerInfo\":{\"rdi\":\"%lx\",\"rsi\":\"%lx\",\"rdx\":\"%lx\",\"rcx\":\"%lx\",\"r8\":\"%lx\",\"r9\":\"%lx\"},\"timestamp\":\"%ld.%ld\",\"BeijingTime\":\"%d-%02d-%02d %02d:%02d:%02d\"}\n", p->symbol_name, current->pid, current->comm, regs->di, regs->si, regs->dx, regs->cx, regs->r8, regs->r9, txc.time.tv_sec, txc.time.tv_usec, tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday, tm.tm_hour+8, tm.tm_min, tm.tm_sec);

		/* send signal SIGTERM to kill */
//		if(current->pid > 0)
//		{
//			force_sig(SIGKILL, current);
//			printk("[Emergency] This process has be killed!\n");
//		}

//		printk("*************************************************************\n");
	}

	return 0;
}
/*
static int pre_handler_warning(struct kprobe *p, struct pt_regs *regs)
{
//	Emergency Critical Warning Notification Information 

//	printk(KERN_EMERG "Hello, EMERG.\n");

//	printk(KERN_ALERT "Hello, ALERT.\n");

//	printk(KERN_CRIT "Hello, CRIT.\n");

//	printk(KERN_ERR "Hello, ERR.\n");

//	printk(KERN_WARNING "Hello, WARNING.\n");

//	printk(KERN_NOTICE "Hello, NOTICE.\n");

//	printk(KERN_INFO "Hello, INFO.\n");

//	printk(KERN_DEBUG "Hello, DEBUG.\n");

//	if(!strcmp(current->comm , "firefox"))
	{
		do_gettimeofday(&(txc.time));
		rtc_time_to_tm(txc.time.tv_sec,&tm);

		printk("*************************************************************\n");
		printk(KERN_WARNING "[Warning] A high-risk function is called!!!\n");
		printk(KERN_WARNING "[Warning] Function name: %s\n", p->symbol_name);
		printk(KERN_WARNING "[Warning] Process information: pid: %6d |comm: %8s\n", current->pid, current->comm);
		printk(KERN_WARNING "[Warning] Register information: rdi: %08lx  rsi: %08lx  rdx: %08lx  rcx: %08lx  r8: %08lx  r9: %08lx\n", regs->di, regs->si, regs->dx, regs->cx, regs->r8, regs->r9);
		printk(KERN_WARNING "[Warning] Timestamp: %ld.%ld\n", txc.time.tv_sec, txc.time.tv_usec);
		printk(KERN_WARNING "[Warning] Beijing time: %d-%02d-%02d %02d:%02d:%02d \n", tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday, tm.tm_hour+8, tm.tm_min, tm.tm_sec);

		if(current->pid > 0)
		{
//			force_sig(SIGKILL, current);
//			printk("[Emergency] This process has be killed!\n");
		}

		printk("*************************************************************\n");
	}

	return 0;
}

static int pre_handler_notice(struct kprobe *p, struct pt_regs *regs)
{
//	if(!strcmp(current->comm , "firefox"))
	{
		do_gettimeofday(&(txc.time));
		rtc_time_to_tm(txc.time.tv_sec,&tm); 

		printk("*************************************************************\n");
		printk(KERN_NOTICE "[Notification] A high-risk function is called!!!\n");
		printk(KERN_NOTICE "[Notification] Function name: %s\n", p->symbol_name);
		printk(KERN_NOTICE "[Notification] Process information: pid: %6d |comm: %8s\n", current->pid, current->comm);
		printk(KERN_NOTICE "[Notification] Register information: rdi: %08lx  rsi: %08lx  rdx: %08lx  rcx: %08lx  r8: %08lx  r9: %08lx\n", regs->di, regs->si, regs->dx, regs->cx, regs->r8, regs->r9);
		printk(KERN_NOTICE "[Notification] Timestamp: %ld.%ld\n", txc.time.tv_sec, txc.time.tv_usec);
		printk(KERN_NOTICE "[Notification] Beijing time: %d-%02d-%02d %02d:%02d:%02d \n", tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday, tm.tm_hour+8, tm.tm_min, tm.tm_sec);

		if(current->pid > 0)
		{
//			force_sig(SIGKILL, current);
//			printk("[Emergency] This process has be killed!\n");
		}

		printk("*************************************************************\n");
	}

	return 0;
}
*/
static void post_handler(struct kprobe *p, struct pt_regs *regs, unsigned long flags)
{
//	printk("    Hello, this is the post_handler() of _do_fork_kp.\n");
//	printk("-----------------------------------------------------------\n");
}

static int fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr)
{
	printk("    Attention, the fault_handler() of _do_fork_kp is called.");	
	printk(KERN_INFO "      fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
	/* Return 0 because we don't handle the fault. */
	return 0;
}

/****************************************************************************************************/
/****************************************************************************************************/
/****************************************************************************************************/

static int __init kprobe_init(void)
{
	int _do_fork_ret = 0;

	_do_fork_kp.pre_handler = pre_handler_emerg;
	_do_fork_kp.post_handler = post_handler;
	_do_fork_kp.fault_handler = fault_handler;

	_do_fork_ret = register_kprobe(&_do_fork_kp);
	if (_do_fork_ret < 0)
	{
		printk(KERN_INFO "register_kprobe of _do_fork_kp failed, returned %d\n", _do_fork_ret);
	}
	else
	{
		printk(KERN_INFO "Planted _do_fork_kp at %p\n", _do_fork_kp.addr);
	}

	return 0;
}

static void __exit kprobe_exit(void)
{
	unregister_kprobe(&_do_fork_kp);
	printk(KERN_INFO "_do_fork_kp at %p unregistered\n", _do_fork_kp.addr);
}

module_init(kprobe_init)
module_exit(kprobe_exit)
MODULE_LICENSE("GPL");
