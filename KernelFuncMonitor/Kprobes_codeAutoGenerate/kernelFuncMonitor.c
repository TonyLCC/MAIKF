#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/kprobes.h>
#include <linux/slab.h>

/* For each kernel function in the monitor list, we need to allocate a kprobe structure. */
static struct kprobe _do_fork_kp = {.symbol_name = "_do_fork",};
static struct kprobe do_execve_kp = {.symbol_name = "do_execve",};
static struct kprobe do_exit_kp = {.symbol_name = "do_exit",};

/* kprobe pre_handler_emerg: called just before the high-risk kernel function is executed */
static int pre_handler_emerg(struct kprobe *p, struct pt_regs *regs)
{
	printk("-----------------------------------------------------------\n");
	printk(KERN_EMERG "[Emergency] This is the pre_handler_emerg().\n");
	return 0;
}

/* kprobe pre_handler_warning: called just before the medium-risk kernel function is executed */
static int pre_handler_warning(struct kprobe *p, struct pt_regs *regs)
{
	printk("-----------------------------------------------------------\n");
	printk(KERN_WARNING "[Warning] This is the pre_handler_warning().\n");
	return 0;
}

/* kprobe pre_handler_notice: called just before the low-risk kernel function is executed */
static int pre_handler_notice(struct kprobe *p, struct pt_regs *regs)
{
	printk("-----------------------------------------------------------\n");
	printk(KERN_NOTICE "[Notification] This is the pre_handler_notice().\n");
	return 0;
}

/* kprobe post_handler: called after the probed function is executed */
static void post_handler(struct kprobe *p, struct pt_regs *regs, unsigned long flags)
{
	printk("    This is the post_handler().\n");
	printk("-----------------------------------------------------------\n");
}

/*
 * fault_handler: this is called if an exception is generated for any
 * instruction within the pre- or post-handler.
 */
static int fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr)
{
	printk("    Attention, the fault_handler() is called.\n");
	/* Return 0 because we don't handle the fault. */
	return 0;
}

static int __init kprobe_init(void)
{
	int _do_fork_ret;
	int do_execve_ret;
	int do_exit_ret;

	_do_fork_kp.pre_handler = pre_handler_emerg;
	_do_fork_kp.post_handler = post_handler;
	_do_fork_kp.fault_handler = fault_handler;

	do_execve_kp.pre_handler = pre_handler_warning;
	do_execve_kp.post_handler = post_handler;
	do_execve_kp.fault_handler = fault_handler;

	do_exit_kp.pre_handler = pre_handler_notice;
	do_exit_kp.post_handler = post_handler;
	do_exit_kp.fault_handler = fault_handler;

	_do_fork_ret = register_kprobe(&_do_fork_kp);
	if (_do_fork_ret < 0)
	{
		printk(KERN_INFO "register_kprobe of _do_fork_kp failed, returned %d\n", _do_fork_ret);
	}
	else
	{
		printk(KERN_INFO "Planted _do_fork_kp at %p\n", _do_fork_kp.addr);
	}

	do_execve_ret = register_kprobe(&do_execve_kp);
	if (do_execve_ret < 0)
	{
		printk(KERN_INFO "register_kprobe of do_execve_kp failed, returned %d\n", do_execve_ret);
	}
	else
	{
		printk(KERN_INFO "Planted do_execve_kp at %p\n", do_execve_kp.addr);
	}

	do_exit_ret = register_kprobe(&do_exit_kp);
	if (do_exit_ret < 0)
	{
		printk(KERN_INFO "register_kprobe of do_exit_kp failed, returned %d\n", do_exit_ret);
	}
	else
	{
		printk(KERN_INFO "Planted do_exit_kp at %p\n", do_exit_kp.addr);
	}

	return 0;
}

static void __exit kprobe_exit(void)
{
	unregister_kprobe(&_do_fork_kp);
	printk(KERN_INFO "_do_fork_kp at %p unregistered\n", _do_fork_kp.addr);

	unregister_kprobe(&do_execve_kp);
	printk(KERN_INFO "do_execve_kp at %p unregistered\n", do_execve_kp.addr);

	unregister_kprobe(&do_exit_kp);
	printk(KERN_INFO "do_exit_kp at %p unregistered\n", do_exit_kp.addr);

}

module_init(kprobe_init)
module_exit(kprobe_exit)
MODULE_LICENSE("GPL");
