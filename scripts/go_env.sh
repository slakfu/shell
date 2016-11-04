#!/bin/bash

#--------------------------------------------------------------------------79-#
# go_env.sh
# 
# Dependency: bootstrap_dev.sh must be run before running this script
# Usage: sh go_env.sh <dev dir name> <go distro path>
# Args:                     $1             $2                
#
# This script configures a "bootstrapped" (cf bootstrap_dev.sh) user with
# slakfu's golang development environment, including path, variables, etc.
#--------------------------------------------------------------------------79-#

dev_dir=$1
go_distro=$2

# Print usage
printUsage() {
  echo ""
  echo "Usage: sh go_env.sh <dev dir name> <go distro path>"
  echo ""
  echo "       Where <dev dir name> is the name of the development directory"
  echo "       that was bootstrapped. <go distro path> is where you installed"
  echo "       the golang package/distribution (ie /opt/go)."
  echo ""
}

# Check usage arguments are not null
if [ -z "$dev_dir" ]
then
	printUsage
	exit 1

elif [ -z "$go_distro" ]
then
	printUsage
	exit 1
fi

# Check that the dev_dir has been bootstrapped 
if [ ! -f "$dev_dir/bash/dev/README" ]
then
	echo ""
	echo "$dev_dir is not bootstrapped or doesn't exist."
	echo "Run the bootstrap_dev.sh script."
	echo ""
	exit 1

# Check that the golang package is installed at the go_distro location
elif ! type $go_distro/bin/go > /dev/null 
then
	echo ""
	echo "Go is not installed at $go_distro."
	echo ""
	exit 1
fi

# Clone slakfu's go repository
# echo "...cloning go git repository from github.com:"
# git clone https://github.com/slakfu/go $dev_dir/go
# Remove the below mkdir line once there is a go repo to clone
mkdir $dev_dir/go

# Setup environment variables and configure .bash_profile
cd $dev_dir
go_path=$(pwd)/go
cd ..

echo "" >> ~/.bash_profile
echo "# Go Environment" >> ~/.bash_profile
echo "# GOROOT = location of the installed go package/distribution" >> ~/.bash_profile
echo "# GOPATH = workspace for src, packages, build artifacts, etc" >> ~/.bash_profile
echo "export GOROOT=$go_distro" >> ~/.bash_profile
echo "export GOPATH=$go_path" >> ~/.bash_profile
echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> ~/.bash_profile
echo ""

export GOROOT=$go_distro
export GOPATH=$go_path
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
