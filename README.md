# High Performance Computing (HPC) Systems Project

This project aims to introduce you to HPC systems and their software stack, empowering you to leverage parallel and distributed programming along with computing resources to solve complex problems across various domains such as machine learning, deep learning, data science, big data, and more.

## HPC Architecture

High Performance Computing (HPC) architecture integrates multiple computing resources to deliver high computational power. An HPC cluster comprises several components, each crucial for ensuring efficient operation.

![HPC Architecture Diagram](https://github.com/glauberss2007/AI-hpc/assets/22028539/eb0558d5-ebd3-4b90-9118-430a19a3fa88)

### Components of HPC Architecture

1. **Compute Nodes**: These nodes execute computation tasks, equipped with powerful CPUs and sometimes GPUs for parallel processing.
2. **Login Nodes**: Serve as the user interface for accessing the HPC system, where users submit jobs, compile code, and manage data.
3. **Management Node (Master/Head Node)**: Manages cluster operations, including job scheduling, resource allocation, and overall cluster management.
4. **Storage Nodes**: Dedicated to storing data used and produced by compute tasks, often utilizing high-speed storage solutions.

### Setting Up an HPC Environment Using VMWare (Demo)

To configure a simple ENV considering a master node and workes node, follow the steps in "https://github.com/mknoxnv/ubuntu-slurm".

PS: The folder vagrant in this repository has vagrant files and scripts to configure an small env based on 1 master and 2 workes.

## HPC Software Modules

Environment modules facilitate the availability of software packages and versions on HPC systems.

### Basic Module Commands

- `module`: Print usage instructions.
- `avail` or `av`: List available software modules.
- `whatis`: List modules with brief descriptions.
- `load`: Add a module to your environment.
- `unload`: Remove a module.
- `purge`: Remove all modules.

### Using Modules in Batch Files

Simply specify `module load <package_name>` in a batch job script.

### Creating Custom Modules

Define custom modules by loading `module load use.own`, enabling module configuration in your home directory.

## HPC Job and Scheduling JOB (PBS and Slurm)

![HPC Job and Scheduling Diagram](https://github.com/glauberss2007/AI-hpc/assets/22028539/bcfe9068-ee59-47fa-adce-24c475428689)

## What is an HPC Job?

In the realm of High-Performance Computing (HPC), jobs refer to commands we wish to run along with requests for resources such as compute time, disk space, memory, and software environments. HPC jobs are typically time-consuming and resource-intensive, often run non-interactively. However, they can also be run interactively for testing purposes. Jobs are submitted to a queue, and when machines have available resources, the jobs are executed. Upon completion, the output of the jobs can be inspected.

### Batch Queuing Systems and Job Schedulers

The batch system is a program, typically residing on the head node of an HPC cluster, that allows users to add and remove jobs from the queue and monitor the queue. It is driven by scripts or command-line inputs.

Job schedulers manage job queues and schedule jobs from the queue as sufficient resources become available (i.e., when cluster compute nodes are idle). Users typically do not interact directly with schedulers.

- **Portable Batch System (PBS)**: PBS is a widely used batch system that provides powerful job management and scheduling capabilities. It allows users to submit, monitor, and manage jobs efficiently. PBS supports various job types, resource requests, and job dependencies.

- **Simple Linux Utility for Resource Management (SLURM)**: SLURM is another popular batch system designed for high-performance computing clusters. It offers robust job scheduling and workload management features, including job prioritization, fair resource allocation, and efficient job execution. SLURM is known for its scalability and flexibility, making it suitable for large-scale HPC environments.

## SLURM

Slurm is an open-source job scheduler designed for Linux and Unix-like kernels. It is widely used in supercomputers and clusters worldwide, providing essential functions for workload management.

### Key Functions

Slurm serves three primary functions:

1. **Resource Allocation:** Allocates exclusive and/or non-exclusive access to computing resources (nodes) for users over a specified duration.
2. **Job Execution:** Provides a framework for starting, executing, and monitoring parallel jobs (e.g., MPI) on allocated nodes.
3. **Contention Management:** Arbitrates contention for resources by managing a queue of pending jobs.

### Components

Slurm consists of two primary daemons:
- **slurmd:** Runs on each compute node, providing fault-tolerant hierarchical communications.
- **slurmctld:** Runs on a central management/master node, coordinating overall cluster operations.

### Entities

In Slurm, workload management revolves around four entities:
- **Nodes:** Compute resources within the system.
- **Partitions:** Logical sets of nodes (similar to queues in other systems) with various constraints.
- **Jobs:** Allocations of resources assigned to users for a specified duration.
- **Job Steps:** Sets of tasks, possibly parallel, within a job.

Slurm partitions function as job queues, each with specific constraints such as job size limits, time limits, and permitted users.

![image](https://github.com/glauberss2007/AI-hpc/assets/22028539/accbd5e2-b30e-4ff5-a362-849bb06fae9f)

### Slurm Command

Slurm offers a range of commands to interact with its daemons and manage jobs efficiently:

- **sacct:** Reports job or job step accounting information about active or completed jobs.
- **salloc:** Allocates resources for a job in real-time.
- **sattach:** Attaches standard input, output, and error plus signal capabilities to a currently running job or job step.
- **sbatch:** Submits a job script for later execution, typically containing one or more srun commands to launch parallel tasks.
- **sbcast:** Transfers a file from local disk to local disk on nodes allocated to a job.
- **scancel:** Cancels a pending or running job or job step, or sends an arbitrary signal to all associated processes.
- **scontrol:** The administrative tool for viewing and/or modifying Slurm state, often requiring root privileges.
- **sinfo:** Reports the state of partitions and nodes managed by Slurm, with filtering, sorting, and formatting options.
- **smap:** Reports state information graphically for jobs, partitions, and nodes, reflecting network topology.
- **squeue:** Reports the state of jobs or job steps with filtering, sorting, and formatting options, prioritizing running and pending jobs.
- **srun:** Submits a job for execution or initiates job steps in real-time.
- **strigger:** Sets, gets, or views event triggers, such as nodes going down or jobs approaching their time limit.
- **sview:** A graphical user interface for getting and updating state information for jobs, partitions, and nodes managed by Slurm.

These commands facilitate efficient management and monitoring of jobs within Slurm.

### Example of a Simple Slurm Job

Submitting a job in Slurm is done by running the `sbatch` command and specifying a job script.

```bash
sbatch slurmjob.script
```

Here's a simple example of a Slurm job submission script:

```bash
#!/bin/bash
#SBATCH --job-name=MyJob
#SBATCH --account=monash001
#SBATCH --time=01:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

./helloworld
```

This script describes the information of the job:
- It's a serial job with only one process (`--ntasks=1`).
- It requires one CPU core to run (`--cpus-per-task=1`).

To cancel a job:
```bash
scancel [JOBID]
```

To cancel all jobs for a specific user:
```bash
scancel -u [USERID]
```

To check all your running/pending jobs:
```bash
squeue -u [USERID]
```

To check the status of a single job:
```bash
scontrol show job [JOBID]
```

### Slurm Distributed MPI and GPU Jobs

An MPI job can be considered as a cross-node and multi-process job. A sample Slurm MPI job script would look like the following:

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

In the script above, Slurm is informed that this is a multi-processing job. It requests a total of 32 MPI processes (`ntasks=32`). It will launch 16 MPI processes (`ntasks-per-node=16`) on each node (implicitly requesting 2 nodes). For each MPI process, it requires 1 CPU core to handle (`cpus-per-task=1`).

If you need 6 nodes with 4 CPU cores (`ntasks=24` and `ntasks-per-node=4`) and 2 GPUs (`gres=gpu:2`) on each node, then the Slurm submission script should look like:

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

### Slurm Multi-threaded OpenMP Jobs

Multi-threading allows multiple threads to exist within the context of a single process. In Slurm, a multi-threaded job typically refers to a single-process, multi-core job. This category includes various applications like OpenMP program codes and Matlab scripts with Parallel Computing Toolbox.

Here's a sample Slurm script for a Multi-threaded job:

```bash
#!/bin/bash

#SBATCH --job-name=MyJob
#SBATCH --account=monash001
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8

./openmp_helloworld.exe
```

In this script:
- `--job-name=MyJob`: Specifies the name of the job.
- `--account=monash001`: Indicates the account associated with the job.
- `--ntasks=1`: Specifies the number of tasks (processes) needed for the job.
- `--cpus-per-task=8`: Specifies the number of CPU cores required for each task (thread).

This script informs Slurm that it is a multi-threading job with only 1 process (`ntasks=1`), and each process requires 8 CPU cores to handle (`cpus-per-task=8`).

### Slurm Interactive Jobs

Interactive jobs in Slurm provide users with direct access to a compute node for interactive development, testing, or debugging tasks. Here's how to launch and manage interactive jobs using Slurm:

1. **Launching an Interactive Job**:
   - To launch an interactive job with default values (1 CPU core, 1GB memory, 24 hours duration), use the following command:
     ```
     sinteractive --account=username
     ```
   - To customize the interactive job, you can specify parameters such as duration, number of CPU cores, and GPU requirements:
     - Change the duration to 3 days:
       ```
       sinteractive --account=username --time=3-00:00:00
       ```
     - Specify the number of CPU cores (e.g., 2 cores):
       ```
       sinteractive --account=username --ntasks=2
       ```
     - Request GPU cards along with CPU cores (e.g., 2 GPUs for 2 CPUs):
       ```
       sinteractive --account=username --ntasks=2 --gres=gpu:2
       ```

2. **Managing Interactive Jobs**:
   - An interactive job will not automatically terminate unless the user manually exits the session.
   - To exit the interactive session, simply type `exit`.
   - Alternatively, you can cancel the interactive job using its job ID with the command `scancel [JOB ID]`.

Interactive jobs are useful for tasks that require direct access to compute resources and cannot be easily performed on login nodes. They allow users to interactively develop and test job scripts or execute tasks that require significant computational resources.

### Slurm array jobs

Slurm array jobs enable the execution of a group of identical or similar jobs, each with a unique identifier. Here's how to use Slurm array jobs:

1. **Defining the Job Array**:
   - In your submission script, add the following statement to define the job array:
     ```
     #SBATCH --array=1-10
     ```
   - Alternatively, you can specify the job array during submission without modifying your script:
     ```
     sbatch --array=1-10 job.script
     ```

2. **Job Array Implementation**:
   - Slurm implements the job array as a group of individual jobs, each with a unique job ID.
   - For example, if you submit an array job with `#SBATCH --array=1-10` and the starting job ID is 1000, the job IDs of all jobs will be 1000, 1001, 1002, 1003, and so on.

3. **Job Script Configuration**:
   - The job script for each subjob in the array should be identical.
   - You can use the environment variable `$SLURM_ARRAY_TASK_ID` within the job script to differentiate between subjobs.
   - This allows for data-level parallelization, where each subjob can process a different data chunk or perform a specific task.

By leveraging Slurm array jobs, you can efficiently execute multiple instances of a job with varying parameters or input data, facilitating tasks such as parameter sweeps, Monte Carlo simulations, or data processing pipelines.

### Slurm job dependence

Slurm job dependencies allow you to specify that a job should only start after another job has completed successfully. Here's how to use Slurm job dependencies with an example involving two jobs named Alpha and Beta:

1. **Submitting Job Alpha**:
   - Submit the Job Alpha script:
     ```
     sbatch jobAlpha.script
     ```
   - Note the JOBID assigned to Job Alpha (e.g., JOBID 44234).

2. **Submitting Job Beta with Dependency**:
   - Submit the Job Beta script and specify the dependency on Job Alpha's completion:
     ```
     sbatch --dependency=afterok:44234 jobBeta.script
     ```
   - This command tells Slurm to run Job Beta only after Job Alpha has completed successfully (`afterok` dependency).

3. **Alternative Dependency Options**:
   - If you want Job Beta to start regardless of the outcome of Job Alpha, you can use:
     ```
     sbatch --dependency=afterany:44234 jobBeta.script
     ```
   - This command instructs Slurm to run Job Beta regardless of the outcome of Job Alpha (`afterany` dependency).

By setting job dependencies in Slurm, you can establish execution sequences and ensure that jobs are executed in the desired order based on their completion status.

## PBS - Portable batch system

PBS is a job scheduler that allows users to submit, monitor, and control compute jobs in a multi-user, multi-node HPC environment. It is designed to optimize the utilization of computing resources by handling job queuing and execution based on predefined policies and user specifications.

## PBS Command Examples
Here are some basic PBS commands to get you started:

### PBS Basic Commands
- `qsub`: Submits a job to the queue.
- `qstat`: Displays the status of PBS jobs.
- `qdel`: Deletes a job from the queue.
- `qalter`: Modifies the attributes of a job.

## PBS Job Script Example
Here's an example of a PBS job script that requests resources and executes a program:

```bash
#!/bin/bash
#PBS -N my_job_name
#PBS -l select=1:ncpus=8:mem=16gb
#PBS -l walltime=02:00:00
#PBS -j oe

cd $PBS_O_WORKDIR
./my_program
```

## PBS Interactive Jobs
Interactive jobs allow you to work directly on a compute node, which is useful for debugging or interactive data analysis.

## PBS Arrays
Job arrays are a way to submit multiple similar jobs with a single `qsub` command. They are useful for running the same application with different inputs.

## Parallel Programming with OpenMP

### Introduction to OpenMP

OpenMP (Open Multi-Processing) is an application programming interface (API) that supports multi-platform shared memory multiprocessing programming in C, C++, and Fortran. It is designed for systems with multiple processors, cores, or computing threads.

### OpenMP Components

### Directives
OpenMP directives are special pragmas that are inserted into the code to provide instructions for parallelization. They start with `#pragma omp` followed by the directive name and necessary clauses.

### Routines
OpenMP provides a set of runtime library routines for tasks such as setting the number of threads, initializing locks, etc.

### Variables
Environment variables in OpenMP are used to control the execution of parallel code, such as `OMP_NUM_THREADS` which sets the number of threads to use.

### OpenMP Clauses

Clauses are used with OpenMP directives to modify their behavior. Common clauses include `private`, `shared`, `reduction`, and `schedule`.

### OpenMP - Worksharing Constructs

Worksharing constructs are used to divide the execution of the code among the members of the team of threads. Constructs like `for`, `sections`, and `single` are commonly used.

Hello World! Code Example

```c
#include <omp.h>
#include <stdio.h>

int main() {
    #pragma omp parallel
    {
        int ID = omp_get_thread_num();
        printf("hello(%d)", ID);
        printf(" world(%d)\\n", ID);
    }
}
```


Compile the code with an OpenMP-enabled compiler using the `-fopenmp` flag and run the executable. You should see the "hello" and "world" messages printed by each thread.

## Parallel and Distributed Computing with MPI

### Introduction to MPI

MPI, or Message Passing Interface, is a standardized and portable message-passing system designed to function on a wide variety of parallel computing architectures. It enables the development of parallel applications across different platforms.

### MPI Program Structure

An MPI program structure typically consists of initialization, communication, and finalization. The program starts with `MPI_Init` and ends with `MPI_Finalize`. Between these, the program may use any MPI communication routines to exchange messages among processes.

### MPI - Hello World! Example

```c
#include <mpi.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    int world_size, world_rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    printf("Hello world from rank %d out of %d processors\\n", world_rank, world_size);

    MPI_Finalize();
    return 0;
}
```

### MPI Hello World! Demonstration

To run the MPI Hello World program:
1. Compile the code using an MPI compiler, such as `mpicc`.
2. Execute the program using `mpirun` or `mpiexec` with the desired number of processes.

MPI Send and Receive operations are used for point-to-point communication between processes.

MPI Send Example:

```c
MPI_Send(&data, count, MPI_INT, dest, tag, MPI_COMM_WORLD);
```

MPI Receive Example:

```c
MPI_Recv(&data, count, MPI_INT, source, tag, MPI_COMM_WORLD, &status);
```

Replace `data`, `count`, `dest`, `source`, and `tag` with appropriate values for your specific use case.

Got it! Let's streamline it for a more concise README.md:

---

## GPU Programming with CUDA

Basics of GPU programming, particularly focusing on Nvidia GPUs and CUDA. This README covers essential concepts and includes practical examples to get you started.

### Installation

Instructions for installing the CUDA Toolkit on Windows are provided. Follow the steps to set up your development environment.

### Examples

Explore simple CUDA examples, including "Hello World!" and basic variable addition on the device. Understand CUDA kernel functions and how to launch them.