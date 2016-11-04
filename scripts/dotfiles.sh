#!/bin/bash

#--------------------------------------------------------------------------79-#
# dotfiles.sh
#
# The purpose of this script is to help manage the dotfiles and dotdirectories
# located in the $dotfilesdir directory.
#
# When run without any arguments or invalid arguments, will print usage info.
#
# When run with 'check' option, it does a dry pass and outputs what it will do 
# when run with effect.
# 
# When run with 'run' option, it will create symlinks in the user's home
# directory to all files in the root of dotfilesdir directory. However, this
# is a passive script and will only create them where there isn't a file or
# directory named the same thing.
#--------------------------------------------------------------------------79-#

# dotfiles directory where your master dotfiles/directories will be found
dotfilesdir="/home/some directory/dotfiles"

# Print usage
printUsage() {
  echo ""
  echo "Usage: sh dotlinks.sh <option>"
  echo ""
  echo "       This script will help maintain your dotfiles."
  echo ""
  echo "       Make sure to set the dotfilesdir variable in this script to "
  echo "       point to where your master dotfiles are located. "
  echo ""
  echo "       Options:"
  echo "               check   Reads all files and directories in the "
  echo "                       dotfiles directory and performs a dry run"
  echo "                       with output for the user to resolve conflicts."
  echo ""
  echo "               run     Passively create sylinks to the dotfiles and "
  echo "                       dotdirectories in the dotfiles directory."
  echo ""
}

check() {
  echo "Files or directories queued for symlink in your home directory:"
  i=0
  ls -1 "$dotfilesdir" | while read line; do
    dotfiles[ $i ]="$line"
    echo .${dotfiles[$i]}
    (( i++ ))
  done 

  echo ""
  echo "Files or directories that already exist in your home directory and will not be symlinked:"
  i=0
  ls -1 "$dotfilesdir" | while read line; do
    dotfiles[ $i ]="$line"
    find ~ -maxdepth 1 -name .${dotfiles[$i]} | awk -F/ '{print $(NF)}'
    (( i++ ))
  done 

  echo ""
}

run() {
  echo "Linking dotfiles..."
  echo ""
  i=0
  ls -1 "$dotfilesdir" | while read line; do
    dotfiles[ $i ]="$line"
    if [ -f ~/.${dotfiles[$i]} ] || [ -d ~/.${dotfiles[$i]} ]; then
      echo "skipping ~/.${dotfiles[$i]} (already exists)" 
    else
      ln -s $dotfilesdir/${dotfiles[$i]} ~/.${dotfiles[$i]} 
      echo "linking  ~/.${dotfiles[$i]} (doesn't exist)"
    fi
    (( i++ ))
  done 
}

# If no arguments passed, print usage and exit with error
if [ -z "$1" ]; then
  printUsage
  exit 1
else
  option=$1
fi

# Check arguments and act accordingly
case $option in
  check)
    check
  ;;

  run)
    run
  ;;

  *)
    printUsage
    exit 1
  ;; 
esac
