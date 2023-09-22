# ScyCom-ParallelDistributed
Repository about Parallel and Distributed Programming considering tools like OpenMP, CUDA, MPI, HPC, Slurm, PBS and AWS HPC.

![image](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/2eea4d54-3927-4bfe-a8f2-af1d2122605c)

# Parallelism VS Not-Parallelism

Benefits of using cluster computing

HPC systems derive their computational power by exploiting parallelism. Programs for HPC systems must be splitted up into many smaller sub-programs which can be executed in parallel on different processors. HPC systems can offer parallelism at a much larger scale, with 100’s or 1000’s, or even millions of tasks running concurrently.However, writing parallel software can be challenging, and many existing software packages do not already support parallelism & may require development. Therefore, HPCs are userful when you have:

When use parallelism?
1. A program that can be recompiled or reconfigured to use optimized numerical libraries that are available on HPC systems but not on your own system;
2. You have a parallel problem, e.g. you have a single application that needs to be rerun many times with different parameters;
3. You have an application that has already been designed with parallelism;
4. To make use of the large memory available;
5. Problem solutions require backups for future use. HPC facilities are reliable and regularly backed up.

When not to use HPC systems?
1. You have a single threaded job which will only run one job at a time (typical of MatLab users);
2. You rely on DBMS/ databases;
3. You have a lot of data to transfer between your local machine and the HPC on a continuous basis (e.g. per job);
4. You need to have a GUI to interact with your program.

# Example of a layout and componenets

![image](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/d7c7c6b3-6846-4827-b95a-68be2433b02e)

An HPC node is based on 

![image](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/9c11af28-5f14-4d92-bf51-1a9bbfd55430)

- Login nodes: that will be used to login the users throu SSH sessions, testing and compiling purpose, or run interative programs.
- Master/Head nodes: Manage the computer nodes, provision other nodes and/or run jobs (optionally)
- Storage server: That can be mounted or configured using diferents sources and protocols lije NFS, GPFS, MS Shared Volume, buckets and OCI File System.
- Computing nodes: These nodes are managed by the schedulers and Run jobs.

PS: Monitoring NODEs can be done based on softwares like "OSCAR" (free), "Bright" and "MS HPC Cluster Manager"

# HPC Access, Data Transfer and software list

- Commands and descriptions are in [](usefull-commands).

- Softwares normally used on HPC environment are in the [](hpc-software-list).

# HPC Job Schedulers Software (SLURMS and PBS)

In the arena of HPC, we talk a lot about jobs, these are simply commands we wish to run and requests for resources (e.g. compute time, disk space, memory amount, software environments etc.). HPC jobs are generally time consuming and resource intensive run non-interactively. However, they nan be run interactively, but mainly for testing purposes.You need add your jobs to a queue and when machines have free resources jobs run. Once jobs are complete, you can inspect their output.

The batch system is a program (typically resides on the head node) that lets you add and remove jobs from the queue and monitor the queue. It’s a script/command line driven program. The Job schedulers manages job queues. Typically, the scheduler will schedule jobs from the queue as sufficient resources (more precisely - cluster compute nodes) become idle. You do not need to interact with schedulers directly.

Some widely used cluster batch systems are:

1. Portable Batch System (PBS)
2. Simple Linux Utility for Resource Management (SLURM)
3. Moab
4. Univa Grid Engine
5. LoadLeveler, Condor
6. OpenLava
7. IBM’s Platform LSF

The first two in the above list will be considered here.

# Slurm Workload Manager

The Slurm Workload Manager (formerly known as Simple Linux Utility for Resource Management or SLURM), is a free and open-source job scheduler for Linux and Unix-like kernels, used by many of the world’s supercomputers and computer clusters. It provides three key functions:

1. First, it allocates exclusive and/or non-exclusive access to resources (computer nodes) to users for some duration of time so they can perform work.
2. Second, it provides a framework for starting, executing, and monitoring work (typically a parallel job such as MPI) on a set of allocated nodes.
3. Finally, it arbitrates contention for resources by managing a queue of pending jobs.

![image](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/1c804b17-9987-4cc4-8170-83b91ae94c04)

Slurm consists of a slurmd daemon running on each compute node and a central slurmctld daemon running on a management/master node. The slurmd daemons provide fault-tolerant hierarchical communications. The user commands include: sacct, salloc, sattach, sbatch, sbcast, scancel, scontrol, sinfo, smap, squeue, srun, strigger and sview. All of the commands can run anywhere in the cluster and a detailed description of each one can be founded at [](slurm-comands).

## Alurm Entities

![image](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/e1e48c87-8d68-462a-b641-f7ebd0896075)

Where nodes are the compute resource in Slurm, partitions are the group of nodes into logical (possibly overlapping) sets, jobs are the allocations of resources assigned to a user for a specified amount of time, and job steps are the sets of (possibly parallel) tasks within a job. Note that the Slurm partitions can be considered job queues, each of which has an assortment of constraints such as job size limit, job time limit, users permitted to use it, etc.

# References

- https://www.udemy.com/course/learn-to-use-hpc-systems-and-supercomputers
- https://slurm.schedmd.com/quickstart.html
- https://gordonbell.azurewebsites.net/MSR-TR-2015-2_Supercomputers-The_Amazing_Race_Bell.pdf
- https://www-users.york.ac.uk/~mijp1/teaching/4th_year_HPC/lecture_notes/History_of_Supercomputers.pdf
- https://www.top500.org/lists/


