# ScyCom-ParallelDistributed

Repository on Parallel and Distributed Programming using tools like OpenMP, CUDA, MPI, HPC, Slurm, PBS, and AWS HPC.

![ScyCom-ParallelDistributed](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/2eea4d54-3927-4bfe-a8f2-af1d2122605c)

## Parallelism vs. Non-Parallelism

### Benefits of Using Cluster Computing

High-Performance Computing (HPC) systems achieve their power through parallelism, enabling programs to be divided into smaller sub-programs that run simultaneously on different processors. Key scenarios where HPC is beneficial include:

- Programs optimized with numerical libraries available only on HPC systems.
- Applications designed with parallelism in mind.
- Tasks requiring significant memory.
- Situations where reliable, backed-up storage is essential.

### When Not to Use HPC Systems

HPC may not be suitable if:

- Your job is single-threaded and runs only one task at a time.
- You rely heavily on database management systems.
- You frequently transfer large amounts of data between your local machine and the HPC.
- You need a GUI to interact with your program.

## Example HPC Layout and Components

![HPC Layout](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/d7c7c6b3-6846-4827-b95a-68be2433b02e)

An HPC node consists of:

- **Login Nodes**: Used for SSH sessions, testing, and compiling.
- **Master/Head Nodes**: Manage computing nodes and run jobs (optionally).
- **Storage Servers**: Can be configured with various protocols like NFS, GPFS, MS Shared Volume, and more.
- **Computing Nodes**: Managed by schedulers to run jobs.

Monitoring nodes can be achieved using software like "OSCAR" (free), "Bright", and "MS HPC Cluster Manager".

## HPC Access, Data Transfer, and Software List

- Useful commands: [here](useful-commands)
- Commonly used software: [here](hpc-software-list)

## HPC Job Schedulers (SLURM and PBS)

HPC jobs, typically time-consuming and resource-intensive, are managed by job schedulers. Common batch systems include:

- Portable Batch System (PBS)
- Simple Linux Utility for Resource Management (SLURM)
- Moab
- Univa Grid Engine
- LoadLeveler, Condor
- OpenLava
- IBM’s Platform LSF

### Slurm Workload Manager

Slurm is a widely used open-source job scheduler. It allocates resources, manages job execution, and handles resource contention. 

![Slurm Architecture](https://github.com/glauberss2007/ScyCom-ParallelDistributed/assets/22028539/1c804b17-9987-4cc4-8170-83b91ae94c04)

Key Slurm commands include `sacct`, `salloc`, `sattach`, `sbatch`, `sbcast`, `scancel`, `scontrol`, `sinfo`, `smap`, `squeue`, `srun`, `strigger`, and `sview`. Detailed descriptions are available [here](slurm-commands).

### Example Slurm Jobs

**Submitting a Job:**

```bash
sbatch slurmjob.script
```

**Simple Job Script:**

```bash
#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=monash001
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

./helloworld
```

**Cancelling a Job:**

```bash
scancel [JOBID]
```

**Checking Job Status:**

```bash
squeue -u [USERID]
```

**MPI Job Script:**

```bash
#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=username
#SBATCH --ntasks=32
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1

module load openmpi
mpiexec <your program>
```

**GPU Job Script:**

```bash
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

**Multi-threaded Job Script:**

```bash
#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=monash001
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

./openmp_helloworld.exe
```

**Interactive Job:**

```bash
sinteractive --account=username
```

**Job Array:**

```bash
#SBATCH --array=1-10
```

**Job Dependency:**

```bash
sbatch --dependency=afterok:44234 jobBeta.script 
```

## References

- [Setup Slurm on Ubuntu](https://drtailor.medium.com/how-to-setup-slurm-on-ubuntu-20-04-for-single-node-work-scheduling-6cc909574365)
- [Learn to Use HPC Systems](https://www.udemy.com/course/learn-to-use-hpc-systems-and-supercomputers)
- [Slurm Quickstart](https://slurm.schedmd.com/quickstart.html)
- [Supercomputers: The Amazing Race](https://gordonbell.azurewebsites.net/MSR-TR-2015-2_Supercomputers-The_Amazing_Race_Bell.pdf)
- [History of Supercomputers](https://www-users.york.ac.uk/~mijp1/teaching/4th_year_HPC/lecture_notes/History_of_Supercomputers.pdf)
- [TOP500 List](https://www.top500.org/lists/)
