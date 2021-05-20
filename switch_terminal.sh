#!/bin/bash
if [ "$#" -ne 2 ]; then
        echo "usage: $0 <pid> </path/to/new/pty>"
        exit 1
fi
PID=$1
PTYPATH=$2
NR_open=2

gdb -q -ex 'call (int)close((int)0)' \
       -ex 'call (int)syscall('$NR_open', "'$PTYPATH'", 0, 0)' \
       -ex 'call (int)close((int)1)' \
       -ex 'call (int)syscall('$NR_open', "'$PTYPATH'", 1, 0)' \
       -ex 'call (int)close((int)2)' \
       -ex 'call (int)syscall('$NR_open', "'$PTYPATH'", 1, 0)' -ex detach -ex quit -p $PID
