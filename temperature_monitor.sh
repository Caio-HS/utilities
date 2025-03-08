#!/bin/bash
set -e  # Stop script in caso of error

# Check if some temperature limit has been defined
if [ "$1" == '' ]; then
	echo "Insert the max Value in ceusius"
	exit 1
fi
TEMP_MAX=$1  

# Identify the sensor
SENSOR_CMD="sensors | grep 'temp1' | awk '{print \$2}' | tr -d '+' | cut -d'.' -f1"

echo "Monitoring Temperature... (Limit: ${TEMP_MAX}°C)"

while true; do
    # Get CPU temperature
    TEMP_ATUAL=$(eval $SENSOR_CMD)

    # Check if temperature cross the limit
    if [ "$TEMP_ATUAL" -ge "$TEMP_MAX" ]; then
        echo "⚠️ Critical Temperature Detected: ${TEMP_ATUAL}°C" | tee -a benchmark.txt
        echo "Killing benchmark and shutting down the system..." | tee -a benchmark.txt

        # Kill any sysbench process
        pkill -9 sysbench || echo "Any sysbench process find."

        # System Shutdown
        sudo shutdown -h now
        exit 1
    fi

    # Await for 5 seconds before the next scan
    sleep 5
done

