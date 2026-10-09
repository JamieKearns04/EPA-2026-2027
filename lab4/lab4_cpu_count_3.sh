#!/bin/bash

# Check that an arument was provided
if [ $# -ne 1 ]; then
	echo "Usage: $0 <required_cpu_cores>"
	exit 1
fi

# Stores the required number of CPU cores
required_cpu=$1

# Validates that the argument pass in is a non-negative integer
if ! [[ "$required_cpu" =~ ^[0-9]+$ ]]; then
	echo "Error: Please provide a valid positive integer."
	exit 1
fi

# Moves the grep into a function.
checkAvailableCPUCores() {
	grep -c '^processor' /proc/cpuinfo
} 

# Counts the available CPU cores
num_cpu=$(checkAvailableCPUCores)

if [ "$num_cpu" -ge "$required_cpu" ]; then
	echo "OK: The VM has $num_cpu CPU cores (Required: $required_cpu)."
else
	echo "Error: The VM has only $num_cpu CPU cores; at least $required_cpu are required."
	exit 1
fi 
