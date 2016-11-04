# shell 
The purpose of this repo is to provide the scripts to bootstrap a bash/nix user's home directory with my (slakfu's) shell environment, along with other miscellaneous scripts that help maintain the environment or perform other tasks.

**Clone: git clone https://gitlab.com/slakfu/shell**

## /scripts
Utility scripts for configuring and maintaining slakfu's shell environment.

* Linking dotfiles and dotdirectories
* Creating development directories
* Bootstrapping language-specific developement environment, including checking for dependencies, installing dev kits and run time programs, etc.
* Operator scripts for day-to-day work
* Automated installation of tools, utilities, etc

**Run: scripts/dotlinks.sh** to create/update symlinks  
Simply point this script to where the master dotfiles/dirs are located.

