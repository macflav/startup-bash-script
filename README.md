# Overview

This bash script is meant to run after logging into the Arch linux system (in command line mode).

# What it does

When executed, the script shows a menu (`dialog` package required) with three main options: go to command prompt; upgrade the system; or start X.
There are other (hidden) options that allow the user to (r)eboot, (s)hut down, and even run c(m)atrix (a sort of easter egg, I guess).

# How to run it

Since it is intended to automate recurrent system administrator tasks (user with sudo privilege, naturally), the script should be called by the specific user's `~/.bash_profile`, `~/.bash_login` or `~/.profile`.
