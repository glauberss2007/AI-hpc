#!/bin/bash

# Update package repositories
sudo apt-get update

# Install Munge
sudo apt-get install -y libmunge-dev libmunge2 munge  # Install Munge authentication service
sudo scp slurm-ctrl:/etc/munge/munge.key /etc/munge/  # Copy Munge key from slurm-ctrl
sudo chown munge:munge /etc/munge/munge.key          # Change ownership of Munge key
sudo chmod 400 /etc/munge/munge.key                   # Set permissions of Munge key
sudo systemctl enable munge       # Enable Munge service
sudo systemctl restart munge      # Restart Munge service

# Test Munge
munge -n | unmunge | grep STATUS  # Test Munge service

# Install Slurm
sudo dpkg -i /storage/slurm-17.11.12_1.0_amd64.deb   # Install Slurm package
sudo mkdir /etc/slurm                                # Create Slurm configuration directory
sudo cp /storage/ubuntu-slurm/slurm.conf /etc/slurm/slurm.conf  # Copy Slurm configuration file
sudo cp /storage/ubuntu-slurm/gres.conf /etc/slurm/gres.conf    # Copy GRES configuration file
sudo cp /storage/ubuntu-slurm/cgroup.conf /etc/slurm/cgroup.conf    # Copy cgroup configuration file
sudo cp /storage/ubuntu-slurm/cgroup_allowed_devices_file.conf /etc/slurm/cgroup_allowed_devices_file.conf  # Copy cgroup allowed devices file
sudo useradd slurm                                   # Add Slurm user
sudo mkdir -p /var/spool/slurm/d                     # Create Slurm spool directory

# Start Slurm service
sudo systemctl enable slurmd    # Enable Slurm service
sudo systemctl start slurmd     # Start Slurm service
