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

## Example: Submitting a job in SLURM is performed by running sbatch command and specifying a job script.
```
  sbatch slurmjob.script
```
A simple example of a Slurm job submission script:
```
#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=monash001
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
 
./helloworld
```
This script describe the information of the job: it is a serial job with only one process (--ntasks=1). It only need one cpu core to run such process.

To cancel a job:
```
scancel [JOBID]
```

To cancel all jobs for a specific user:
```
scancel -u [USERID]
```

To check all your running/pending jobs:

```
squeue -u [USERID]
```

If you want to check the status of a single job:
```
scontrol show job [JOBID]
```

## Example: Slurm distributed MPI and GPU jobs

An MPI job can considered as a cross-node and multi-process job. Sample Slurm MPI job script would look like below:

```
#!/bin/bash
 
#SBATCH --job-name=MyJob
#SBATCH --account=username
#SBATCH --ntasks=32
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-tasks=1
 
module load openmpi
mpiexec <your program>
```

The script above tells Slurm that this is a multi-processing job. It requests a total of 32 MPI processes (ntasks=32). It will launch 16 MPI processess (ntasks-per-node=16) on each node (it implicitly requested 2 nodes). For each MPI process, it needs 1 cpu core to handle (cpus-per-task=1).

GPU jobs
If you need 6 nodes with 4 cpu cores (ntasks=24 and ntasks-per-node=4) and 2 GPUs (gres=gpu:2) on each node, then the slurm submission script should look like:

```
#!/bin/bash
 
#SBATCH --job-name=MyJob
#SBATCH --account=username
#SBATCH --time=01:00:00
#SBATCH --ntasks=24
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2
 
module load openmpi
module load cuda
 
mpiexec <your program>
```

## Slurm Multi-threaded OpenMP Jobs

Multi-threading is a type of execution model that allows multiple threads to exist within the context of a process. Simply speaking, a Slurm multi-threading job is a singler process, multi-core job. Many application can drop to this category: OpenMP program codes, Matlab scripts with Parallel Computing Toolbox, etc.

A sample Slurm Multi-threading job would look like below:

```
#!/bin/bash 
#SBATCH --job-name=MyJob
#SBATCH --account=monash001
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
     
./openmp_helloworld.exe
```

This script tells Slurm it is a multi-threading job. It only has only 1 process (ntasks=1), where for such process it needs 8 cpu cores (cpus-per-task=8) to handle.

## Slurm Interactive Jobs

Slurm interactive sessions allows you to connect to a compute node and work on that node directly. This allows you to develop how your jobs might run e.g., test that commands run as expected before putting them into a script and do heavy development tasks that cannot be done on the login nodes.

To launch an interactive job (using default values, e.g., ntask=1 (1 cpu core), mem=1G, t=24hrs) here is the command:
```
    sinteractive --acount=username
```
If you want to change default time to 3 days:
```
    sinteractive --account=username --time=3-00:00:00
```
If you need multi-core (e.g., 2 CPU cores):
```
    sinteractive --account=username --ntasks=2
```
If you need GPU cards per 2 CPUs:
```
    sinteractive --account=username --ntasks=2 --gres=gpu:2
```
Therefore, an interactive job will not be automatically terminate unless user manually quit the session. To quit it, type: exit or scancel [JOB ID].

## Slurm Array Jobs
Slurm job dependencies

A Slurm job can be given the constraint that it only starts after another job has finished. Let have an example with two Jobs, named Alpha and Beta. We want Job Beta to start after Job Alpha has successfully completed. First, let’s submit the job Alpha script:

    sbatch jobAlpha.script
    Waiting for JOBID 44234 to start

Now we can submit the job Beta script and tell Slurm to run Job Beta when the job Alpha completes:

    sbatch --dependency=afterok:44234 jobBeta.script 
    sbatch --dependency=afterany:44234 jobBeta.script // Run job Beta regardlessly
Job array allows you to run a group of identical/similar jobs. To do that, just add the following statement in your submission script:
```
    #SBATCH --array=1-10
```
You can also do this during submission without modify your job script:
```
    sbatch --array=1-10 job.script
```
The job array is implemented as a group of single jobs, e.g., if you submit an array job with #SBATCH --array=1-10. When the starting job is ID=1000, the ids of all jobs are: 1000, 1001, 1002, 1003 and so on.

Note tha the Slurm script is should exactly be the same. The only difference is between each subjob the environment variable, $SLURM_ARRAY_TASK_ID will have a different value. Therefore, it would allow you to do some data level parallelization e.g., let subjob-1 (SLURM_ARRAY_TASK_ID=1) process datachunk-1, subjob-2 processes datachunk-2,…, etc.

## Slurm job dependencies

A Slurm job can be given the constraint that it only starts after another job has finished. Let have an example with two Jobs, named Alpha and Beta. We want Job Beta to start after Job Alpha has successfully completed. First, let’s submit the job Alpha script:
```
    sbatch jobAlpha.script
    Waiting for JOBID 44234 to start
```
Now we can submit the job Beta script and tell Slurm to run Job Beta when the job Alpha completes:
```
    sbatch --dependency=afterok:44234 jobBeta.script 
    sbatch --dependency=afterany:44234 jobBeta.script // Run job Beta regardlessly
```


# References

- https://www.udemy.com/course/learn-to-use-hpc-systems-and-supercomputers
- https://slurm.schedmd.com/quickstart.html
- https://gordonbell.azurewebsites.net/MSR-TR-2015-2_Supercomputers-The_Amazing_Race_Bell.pdf
- https://www-users.york.ac.uk/~mijp1/teaching/4th_year_HPC/lecture_notes/History_of_Supercomputers.pdf
- https://www.top500.org/lists/


