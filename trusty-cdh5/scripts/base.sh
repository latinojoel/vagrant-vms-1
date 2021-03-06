#! /bin/bash

# Turn off ubuntu interactive mode
export DEBIAN_FRONTEND=noninteractive

# Disable IPV6 and set swappiness to 1
grep net.ipv6.conf.all.disable_ipv6 /etc/sysctl.conf || (echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf)
grep net.ipv6.conf.default.disable_ipv6 /etc/sysctl.conf || (echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf)
grep net.ipv6.conf.lo.disable_ipv6 /etc/sysctl.conf || (echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf)
grep vm.swappiness /etc/sysctl.conf || (echo "vm.swappiness = 1" | sudo tee -a /etc/sysctl.conf)
sysctl -p

# Install additional tools
apt-get -qq install -y software-properties-common vim

# Add Java Repo
add-apt-repository -y ppa:webupd8team/java

# Update and set defaults
apt-get update > /dev/null
sh -c "echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections"
sh -c "echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections"

# Install Java
apt-get -qq install -y oracle-java8-installer

# Remove the 127.0.1.1 entry from the hosts file
sed -i "s/127.0.1.1.*//" /etc/hosts

# Remove hostname pointing to 127.0.0.1
sed -i "1d" /etc/hosts
