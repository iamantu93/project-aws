#!/bin/bash


# Check if the process is running
if pgrep -x "java" >/dev/null; then
    echo "Process java is already running.Stopping it now"
    kill $(pgrep -x "java")
    nohup java -jar /home/ec2-user/spark-lms-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
    echo "started process again"
else
    # Start the process in the background
    nohup java -jar /home/ec2-user/spark-lms-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
    echo "Process java  started."
fi
