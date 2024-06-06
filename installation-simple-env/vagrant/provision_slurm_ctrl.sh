#!/bin/bash

# Update package repositories
sudo apt-get update

# Install dependencies
sudo apt-get install -y git gcc make ruby ruby-dev libpam0g-dev libmariadb-client-lgpl-dev libmysqlclient-dev
sudo gem install fpm

# Clone Slurm repository
sudo mkdir -p /storage             # Create directory to clone Slurm repository
cd /storage                        # Change directory to /storage
git clone https://github.com/mknoxnv/ubuntu-slurm.git  # Clone Slurm repository from GitHub

# Customize slurm.conf
sudo cp /storage/ubuntu-slurm/slurm.conf /etc/slurm/slurm.conf  # Copy slurm.conf from cloned repository to /etc/slurm
sudo sed -i 's/ControlMachine=slurm-ctrl/ControlMachine=slurm-ctrl/' /etc/slurm/slurm.conf  # Replace ControlMachine with hostname
sudo sed -i 's/NodeName=linux1/NodeName=slurm-ctrl/' /etc/slurm/slurm.conf  # Replace NodeName with hostname

# Install and configure Munge
sudo apt-get install -y libmunge-dev libmunge2 munge  # Install Munge authentication service
sudo systemctl enable munge       # Enable Munge service
sudo systemctl start munge        # Start Munge service

# Test Munge
munge -n | unmunge | grep STATUS  # Test Munge service

# Install MariaDB
sudo apt-get install -y mariadb-server  # Install MariaDB
sudo systemctl enable mysql              # Enable MariaDB service
sudo systemctl start mysql               # Start MariaDB service
mysql -u root <<EOF                       # Execute MySQL commands
CREATE DATABASE slurm_acct_db;           # Create Slurm accounting database
CREATE USER 'slurm'@'localhost';         # Create Slurm user
SET PASSWORD FOR 'slurm'@'localhost' = PASSWORD('slurmdbpass');  # Set password for Slurm user
GRANT USAGE ON *.* TO 'slurm'@'localhost';  # Grant privileges to Slurm user
GRANT ALL PRIVILEGES ON slurm_acct_db.* TO 'slurm'@'localhost';  # Grant privileges to Slurm user
FLUSH PRIVILEGES;                         # Flush privileges
EOF

# Download, build, and install Slurm
cd /storage                                # Change directory to /storage
wget https://download.schedmd.com/slurm/slurm-17.11.12.tar.bz2  # Download Slurm source
tar xvjf slurm-17.11.12.tar.bz2            # Extract Slurm source
cd slurm-17.11.12                          # Change directory to extracted source
./configure --prefix=/tmp/slurm-build --sysconfdir=/etc/slurm --enable-pam --with-pam_dir=/lib/x86_64-linux-gnu/security/ --without-shared-libslurm  # Configure Slurm
make                                       # Build Slurm
make contrib                               # Build contrib components
make install                               # Install Slurm
cd ..                                      # Change directory back to parent
sudo fpm -s dir -t deb -v 1.0 -n slurm-17.11.12 --prefix=/usr -C /tmp/slurm-build .  # Create Debian package for Slurm
sudo dpkg -i slurm-17.11.12_1.0_amd64.deb  # Install Slurm Debian package
sudo useradd slurm                         # Add Slurm user
sudo mkdir -p /etc/slurm /etc/slurm/prolog.d /etc/slurm/epilog.d /var/spool/slurm/ctld /var/spool/slurm/d /var/log/slurm  # Create Slurm directories
sudo chown slurm /var/spool/slurm/ctld /var/spool/slurm/d /var/log/slurm  # Change ownership of Slurm directories to Slurm user

# Enable and start Slurm services
sudo systemctl daemon-reload              # Reload systemd configurations
sudo systemctl enable slurmdbd            # Enable SlurmDBD service
sudo systemctl start slurmdbd             # Start SlurmDBD service
sudo systemctl enable slurmctld           # Enable Slurmctld service
sudo systemctl start slurmctld            # Start Slurmctld service

# Set up cgroups
sudo sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub  # Update GRUB configuration
sudo update-grub                           # Update GRUB
sudo reboot                               # Reboot the system to apply changes
