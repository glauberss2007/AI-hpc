# High Performance Computing (HPC) Systems Project

Welcome to the High Performance Computing (HPC) Systems project repository. This project aims to introduce you to HPC systems and their software stack, empowering you to leverage parallel and distributed programming along with computing resources to solve complex problems across various domains such as machine learning, deep learning, data science, big data, and more.

## HPC Architecture

High Performance Computing (HPC) architecture integrates multiple computing resources to deliver high computational power. An HPC cluster comprises several components, each crucial for ensuring efficient operation.

![HPC Architecture Diagram](https://github.com/glauberss2007/AI-hpc/assets/22028539/eb0558d5-ebd3-4b90-9118-430a19a3fa88)

### Components of HPC Architecture

1. **Compute Nodes**: These nodes execute computation tasks, equipped with powerful CPUs and sometimes GPUs for parallel processing.
2. **Login Nodes**: Serve as the user interface for accessing the HPC system, where users submit jobs, compile code, and manage data.
3. **Management Node (Master/Head Node)**: Manages cluster operations, including job scheduling, resource allocation, and overall cluster management.
4. **Storage Nodes**: Dedicated to storing data used and produced by compute tasks, often utilizing high-speed storage solutions.
5. **Ethernet Switches**: Facilitate node-to-node communication at speeds of 1/10 GB.
6. **Infiniband Switches**: Enable faster inter-node communication at speeds of 56/100 GB, crucial for MPI-enabled software.

### Setting Up an HPC Environment Using VMWare (Demo)

To create a small HPC environment, deploy 2 virtual Linux servers named "hpc-head" and "node001" using the provided Vagrant file:

```bash
vagrant up
```

This command automatically deploys both VMs with properly configured networking and installed HPC software.

## HPC Access and Data Transfers

To access HPC systems, obtain an account from your HPC authority.

### Accessing HPC Systems on Campus

- **Linux**: Open a terminal and type: `ssh username@login-hostname`
- **Windows**: Use an SSH client like PuTTY or MobaXterm.

### Password-less Login

Generate SSH keys using `ssh-keygen` and send the public key (`id_rsa.pub`) to your HPC authority.

### Accessing HPC Systems Off Campus

Access may require VPN services. Install OpenVPN on Linux:

```bash
sudo apt-get update
sudo apt-get install openvpn
```

Refer to your institution's access methods.

### Data Transfer

- **FTP (File Transfer Protocol)**: Use an FTP client like FileZilla.
- **Secure Copy (SCP)**: A command-line file transfer method.
- **Getting Files from the Internet**: Use `wget <URL_to_file>`.
- **Dealing with Archived Files**: Unzip or extract files using corresponding commands.

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

## HPC Software List

Below is a list of commonly available software on HPC systems:

### Programming Language Compilers
- GNU compilers
- JDK (Java Development Kit)
- Intel compilers ©
- SolarisStudio

### Scripting
- Guile
- Perl
- Python
- Tcl/Tk
- Bash
- Zsh

### File Formats and Data Management
- HDF (Hierarchical Data Format)
- netCDF (Network Common Data Form)

### Astronomy and Astrophysics
- IDL ©
- Tecplot ©
- DS9
- IRAF
- Figaro
- Rebound

### CFD & Engineering and Modeling
- COMSOL ©
- ANSYS Fluent software ©
- APSIM
- Cantera
- Converge CFG
- Eilmer

### Climate Modeling
- GMT (Generic Mapping Tools)
- Opengrads

### Mathematics and Statistics
- Matlab ©
- R and RStudio
- Scilab
- Numpy
- Scipy

### Graphics
- Ferret
- Gnuplot
- Paraview
- Atlas
- NCL (NCAR Command Language)
- Wine (Wine Is Not an Emulator)
- NetworkX
- Gephi
- yED

### Parallel Programming Libraries/Tools
- Intel MPI ©
- Open MPI
- MPICH
- CUDA Toolkit

### Schedulers (any one)
- PBS (Portable Batch System)
- PBS Pro
- Slurm

## HPC Job and Scheduling JOB (PBS and Slurm)

![HPC Job and Scheduling Diagram](https://github.com/glauberss2007/AI-hpc/assets/22028539/bcfe9068-ee59-47fa-adce-24c475428689)

## What is an HPC Job?

In the realm of High-Performance Computing (HPC), jobs refer to commands we wish to run along with requests for resources such as compute time, disk space, memory, and software environments. HPC jobs are typically time-consuming and resource-intensive, often run non-interactively. However, they can also be run interactively for testing purposes. Jobs are submitted to a queue, and when machines have available resources, the jobs are executed. Upon completion, the output of the jobs can be inspected.

### Batch Queuing Systems and Job Schedulers

The batch system is a program, typically residing on the head node of an HPC cluster, that allows users to add and remove jobs from the queue and monitor the queue. It is driven by scripts or command-line inputs.

Job schedulers manage job queues and schedule jobs from the queue as sufficient resources become available (i.e., when cluster compute nodes are idle). Users typically do not interact directly with schedulers.

#### Common Cluster Batch Systems:

- Portable Batch System (PBS)
- Simple Linux Utility for Resource Management (SLURM)
- Moab
- Univa Grid Engine
- LoadLeveler
- Condor
- OpenLava
- IBM’s Platform LSF

The first two, PBS and SLURM, are widely used!!

- **Portable Batch System (PBS)**: PBS is a widely used batch system that provides powerful job management and scheduling capabilities. It allows users to submit, monitor, and manage jobs efficiently. PBS supports various job types, resource requests, and job dependencies.

- **Simple Linux Utility for Resource Management (SLURM)**: SLURM is another popular batch system designed for high-performance computing clusters. It offers robust job scheduling and workload management features, including job prioritization, fair resource allocation, and efficient job execution. SLURM is known for its scalability and flexibility, making it suitable for large-scale HPC environments.


## References

- [How to Setup Slurm on Ubuntu 20.04](https://drtailor.medium.com/how-to-setup-slurm-on-ubuntu-20-04-for-single-node-work-scheduling-6cc909574365)
- [Udemy HPC Course](https://www.udemy.com/course/learn-to-use-hpc-systems-and-supercomputers)
- [Slurm Quickstart](https://slurm.schedmd.com/quickstart.html)
- [Supercomputers: The Amazing Race](https://gordonbell.azurewebsites.net/MSR-TR-2015-2_Supercomputers-The_Amazing_Race_Bell.pdf)
- [History of Supercomputers](https://www-users.york.ac.uk/~mijp1/teaching/4th_year_HPC/lecture_notes/History_of_Supercomputers.pdf)
- [Top500 List](https://www.top500.org/lists/)

