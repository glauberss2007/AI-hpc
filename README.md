# High Performance Computing (HPC) Systems Project

Welcome to the High Performance Computing (HPC) Systems project repository. The main goal of this project is to introduce you to HPC systems and their software stack. This repository is designed to help you utilize parallel and distributed programming, as well as computing resources, to solve complex problems using HPC systems and supercomputers. This knowledge can be applied in fields such as machine learning, deep learning, data science, big data, and more.

## HPC Architecture

High Performance Computing (HPC) architecture integrates multiple computing resources to deliver high computational power. An HPC cluster consists of several components, each playing a vital role in ensuring efficient operation.

![image](https://github.com/glauberss2007/AI-hpc/assets/22028539/eb0558d5-ebd3-4b90-9118-430a19a3fa88)

### Components of HPC Architecture

1. **Compute Nodes**
   - **Function:** Perform the actual computation tasks.
   - **Description:** These are the main workhorses of an HPC system, equipped with powerful CPUs and sometimes GPUs for parallel processing.

2. **Login Nodes**
   - **Function:** User interface for accessing the HPC system.
   - **Description:** Nodes where users log in to submit jobs, compile code, and manage data.

3. **Management Node (Master/Head Node)**
   - **Function:** Manages the overall cluster operations.
   - **Description:** Handles job scheduling, resource allocation, and overall cluster management.

4. **Storage Nodes**
   - **Function:** Provide data storage solutions.
   - **Description:** Nodes dedicated to storing the data used and produced by compute tasks, often using high-speed storage solutions.

5. **Ethernet Switches**
   - **Function:** Facilitate node-to-node communication.
   - **Description:** Provide necessary communication infrastructure between nodes, typically at speeds of 1/10 GB.

6. **Infiniband Switches**
   - **Function:** Enable faster inter-node communication.
   - **Description:** Used for high-speed networking (56/100 GB), particularly important for MPI-enabled software.

### Creating an small HPC env using VMWare (demo)

Create 2 virtual linux servers with names "hpc-head" and "node001". Use the vagrant file attached to deploy it in automatic way:

Execute it inside vagrant folder:
´´´´
vagrant up
´´´´

It will automatically deploy both VMs with the network configured properly nad HPC software installed.

## HPC Access and Data Transfers

To access the HPC systems at your institution, you'll need an account provided by your HPC authority.

### Accessing HPC systems on campus

- **Linux:**
  - Open a terminal and type:
    ```bash
    ssh username@login-hostname
    ```

- **Windows:**
  - Use an SSH client like PuTTY or MobaXterm.

### Password-less login

To enable passwordless logins, generate SSH keys using the following command:
```bash
ssh-keygen
```
Send the public key (`id_rsa.pub`) to your HPC authority.

### Accessing HPC systems off campus

Access from off-campus may require VPN services. You can use tools like Cisco AnyConnect Secure Mobility client or OpenVPN.

- **Linux:**
  ```bash
  sudo apt-get update
  sudo apt-get install openvpn
  ```

PS: Institutions have different access methods. Consult your HPC authority for assistance.

###  Data Transfer

On HPC systems, we can interact with the command line over SSH, create and move files and directories, run programs, and get output. But how do we:

### FTP (File Transfer Protocol)

You can use an FTP client like FileZilla. Connect to the server (e.g., hpc.yourinstitution.edu) on port 22, and authenticate with your username and password. All FTP communication to the HPC machine is secure.

### Secure Copy (SCP)

SCP is a secure, command-line file transfer method. It's non-interactive but scriptable.

```bash
scp <file_name.ext> <user_name>@hpc.yourinstitution.edu:<dest_dir>
```

### Getting files from the Internet

To download files from the Internet, use `wget <URL_to_file>` at the command line while logged into the HPC machine via SSH. This downloads the file to your current working directory.

### Dealing with archived files

Common archive formats include `.zip`, `.tar`, `.tgz`, `.gz`, and `.bz2`. Here's how to handle them:

- Unzip a `.zip` file:
  ```bash
  unzip <file_name>.zip
  ```

- Extract a `.tar` file:
  ```bash
  tar xvf <file_name>.tar
  ```

- Extract a `.tgz` file:
  ```bash
  tar xzvf <file_name>.tgz
  ```

- Uncompress a `.gz` file:
  ```bash
  gunzip <file_name>.gz
  ```

- Decompress a `.bz2` file:
  ```bash
  bunzip2 <file_name>.bz2
  ```

## HPC Software Models

## HPC Software Modules

On an HPC system, the user environment is configured using environment modules. These modules facilitate the availability of various software packages and versions, making it easier to run applications and submit jobs to the cluster.

### What is an Environment Module?

Environment modules enable the selective activation and deactivation of modifications to the user environment, allowing specific packages and versions to be accessible. They work by setting environment variables like PATH and LD_LIBRARY_PATH.

### Basic Module Commands

- `module`: Print usage instructions.
- `avail` or `av`: List available software modules.
- `whatis`: List available modules with brief descriptions.
- `load`: Add a module to your environment.
- `unload`: Remove a module.
- `purge`: Remove all modules.

### Using Modules in Batch Files

To use a software package in a batch job script, simply specify `module load <package_name>`.

### Creating Custom Modules

You can define your own modules by loading `module load use.own`. This sets up the `$HOME/privatemodules` directory with an initial module file called `null` and changes the `MODULEPATH` environment variable to ensure that the `module` command looks for modules in your home directory.

Refer to `man modulefile` for further information on writing your own modules.

## Software list

## HPC Software List

Below is a list of commonly available software on HPC systems, which may be loaded through software modules. Note that commercial software is marked with a © symbol.

### Programming Language Compilers
- GNU compilers (e.g., gnu-c, gnu-cpp, Fortran)
- JDK (Java Development Kit)
- Intel compilers (e.g., C++, Fortran) ©
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

![image](https://github.com/glauberss2007/AI-hpc/assets/22028539/bcfe9068-ee59-47fa-adce-24c475428689)

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
