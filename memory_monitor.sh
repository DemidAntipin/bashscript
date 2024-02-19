#!/bin/bash

# File to store the memory usage data
output_file="memory_usage_log.txt"

# Header for the output file (if it doesn't exist)
if [ ! -f "$output_file" ]; then
    echo "Datetime Memory_Usage(KB)" > "$output_file"
fi

# Function to get memory usage of the process by PID
get_memory_usage() {
    local pid=$1
    local memory_usage=$(ps -o rss= -p "$pid" | awk '{ sum+=$1 } END { print sum }')
    echo "$memory_usage"
}

# Function to get memory usage of a container by name
get_container_memory_usage() {
    local pid=$1
    local memory_usage=$(docker stats --no-stream --format "{{.MemUsage}}" "$pid" | awk '{ sum+=$1 } END { print sum }')
    echo "$memory_usage"
}

# Check if a process ID or container was provided as an argument
if test -z "$1" ; then
    echo "Usage: $0 <process_id> or <container_name>/<container_id>"
    exit 1
fi

# Check if the argument is a process ID or a container
# Argument contains only digits, it could be a process ID or a container ID.
if [[ $1 =~ ^[0-9]+$ ]]; then
    # Check if the PID is a process
    if ps -p "$1" > /dev/null 2>&1; then
        pid=$1
        get_memory_usage_function=get_memory_usage
    else
        # Check if the PID is a container
        if docker inspect "$1" > /dev/null 2>&1; then
            pid=$1
            get_memory_usage_function=get_container_memory_usage
        else
            echo "Invalid argument: \$1 is not a valid process ID or container name/ID."
            exit 1
        fi
    fi
else
    # Argument must be a container name
    if docker inspect "$1" > /dev/null 2>&1; then
        pid=$1
        get_memory_usage_function=get_container_memory_usage
    else
        echo "Invalid argument: \$1 is not a valid process ID or container name/ID."
        exit 1
    fi
fi


# Main loop to monitor and log memory usage
while true; do
    datetime=$(date +"%Y-%m-%d %H:%M:%S")
    memory_usage=$($get_memory_usage_function "$pid")

    # Append data to the output file
    echo "$datetime $memory_usage" >> "$output_file"

    # Wait for 1 second before the next iteration
    sleep 1
done
