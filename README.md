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

- https://gordonbell.azurewebsites.net/MSR-TR-2015-2_Supercomputers-The_Amazing_Race_Bell.pdf
- https://www-users.york.ac.uk/~mijp1/teaching/4th_year_HPC/lecture_notes/History_of_Supercomputers.pdf
- https://www.top500.org/lists/


