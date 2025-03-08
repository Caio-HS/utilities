#!/bin/bash
set -e  # Stops the script in case of error

echo "Starting benchmark using sysbench..."

# Wait for 30 seconds before init the test
sudo sleep 30

echo "Sumario:" | tee -a benchmark.txt
echo "1- CPU monocore Test" | tee -a benchmark.txt
echo "2- CPU multicore (4 threads)" | tee -a benchmark.txt
echo "3- RAM (8GB test)" | tee -a benchmark.txt
echo "4- Threads management (4 threads)" | tee -a benchmark.txt
echo "5- Threads management (16 threads)" | tee -a benchmark.txt
echo "6- Recurse lock management (4 concurrent threads)" | tee -a benchmark.txt
echo "7- Recurse lock management (8 concurrent threads)" | tee -a benchmark.txt
echo "8.1- Fileio 1GB (Sequencial Write):" | tee -a benchmark.txt
echo "8.2- Fileio 1GB (Sequencial Read):" | tee -a benchmark.txt
echo "9.1- Fileio 10GB (Sequencial Write):" | tee -a benchmark.txt
echo "9.2- Fileio 10GB (Sequencial Read):" | tee -a benchmark.txt
echo "" | tee -a benchmark.txt
echo "" | tee -a benchmark.txt
sudo sleep 30

echo "1- CPU 1 Thread:" | tee -a benchmark.txt
sysbench cpu --cpu-max-prime=20000 --threads=1 run | tee -a benchmark.txt
sudo sleep 30

echo "2- CPU 4 Threads:" | tee -a benchmark.txt
sysbench cpu --cpu-max-prime=20000 --threads=4 run | tee -a benchmark.txt
sudo sleep 30

echo "3- Memory 8 GB:" | tee -a benchmark.txt
sysbench memory --memory-total-size=8G run | tee -a benchmark.txt
sudo sleep 30

echo "4- Threads 4:" | tee -a benchmark.txt
sysbench threads --threads=4 run | tee -a benchmark.txt
sudo sleep 30

echo "5- Threads 16:" | tee -a benchmark.txt
sysbench threads --threads=16 run | tee -a benchmark.txt
sudo sleep 30

echo "6- Mutex 4 Threads:" | tee -a benchmark.txt
sysbench mutex --threads=4 run | tee -a benchmark.txt
sudo sleep 30

echo "7- Mutex 8 Threads:" | tee -a benchmark.txt
sysbench mutex --threads=8 run | tee -a benchmark.txt
sudo sleep 30

echo "8.1- Fileio 1GB (Sequencial Write):" | tee -a benchmark.txt
sudo sysbench fileio --file-total-size=1G prepare
sudo sysbench fileio --file-total-size=1G --file-test-mode=seqwr run | tee -a benchmark.txt
sudo sysbench fileio cleanup
sudo sleep 30

echo "8.2- Fileio 1GB (Sequencial Read):" | tee -a benchmark.txt
sudo sysbench fileio --file-total-size=1G prepare
sudo sysbench fileio --file-total-size=1G --file-test-mode=seqrd run | tee -a benchmark.txt
sudo sysbench fileio cleanup
sudo sleep 30

echo "9.1- Fileio 10GB (Sequencial Write):" | tee -a benchmark.txt
sudo sysbench fileio --file-total-size=10G prepare
sudo sysbench fileio --file-total-size=10G --file-test-mode=seqwr run | tee -a benchmark.txt
sudo sysbench fileio cleanup
sudo sleep 30

echo "9.2- Fileio 10GB (Sequencial Read):" | tee -a benchmark.txt
sudo sysbench fileio --file-total-size=10G prepare
sudo sysbench fileio --file-total-size=10G --file-test-mode=seqrd run | tee -a benchmark.txt
sudo sysbench fileio cleanup
sudo sleep 30


