#!/bin/bash

mkdir -p configurations

# Define the arrays for x and y
FCFS_x_values=(1 2 3 4 5 6 7 8 9 10
11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30
31 32 33 34 35 36 37 38 39 40
41 42 43 44 45 46 47 48 49 50)

FCFS_y_values=(10 12 14 16 18 20 22 24 26 28
30 32 34 36 38 40 42 44 46 48
50 52 54 56 58 60 62 64 66 68
70 72 74 76 78 80 82 84 86 88
90 92 94 96 98 100 102 104 106 108)

# Iterate over each pair of x and y values
for ((i=0; i<${#FCFS_x_values[@]}; i++)); do
    x=${FCFS_x_values[$i]}
    y=${FCFS_y_values[$i]}

    # Create the .inp file
    filename="configurations/FCFS_${x}_${y}.inp"
    echo "workload/workloadConfig.cfg" > "$filename"
    echo "FCFSKernel" >> "$filename"
    echo "" >> "$filename"
    echo "$x" >> "$filename"
    echo "$y" >> "$filename"
    echo "output/tout_FCFS_${x}_${y}.txt" >> "$filename"

    echo "Created $filename"

done

RR_x_values=(30 60 90 120 150 180 210 240 270 310
330 360 390 420 450 480 510 540 570 600
630 660 690 720 750 780 810 840 870 1000
30 60 90 120 150 180 210 240 270 310
330 360 390 420 450 480 510 540 570 600
630 660 690 720 750 780 810 840 870 1000
30 60 90 120 150 180 210 240 270 310
330 360 390 420 450 480 510 540 570 600
630 660 690 720 750 780 810 840 870 1000)

RR_y_values=(10 10 10 10 10 10 10 10 10 10
10 10 10 10 10 10 10 10 10 10
10 10 10 10 10 10 10 10 10 10
100 100 100 100 100 100 100 100 100 100
100 100 100 100 100 100 100 100 100 100
100 100 100 100 100 100 100 100 100 100
200 200 200 200 200 200 200 200 200 200
200 200 200 200 200 200 200 200 200 200
200 200 200 200 200 200 200 200 200 200)

for ((k=0; k<${#RR_x_values[@]}; k++)); do
    x=${RR_x_values[$k]}
    y=${RR_y_values[$k]}

    # Create the run_rr_q300_20_1.inp file
    rr_filename="configurations/run_rr_q${x}_${y}_1.inp"
    echo "workload/workloadConfig.cfg" > "$rr_filename"
    echo "RRKernel" >> "$rr_filename"
    echo "${x}" >> "$rr_filename"
    echo "1" >> "$rr_filename"
    echo "${y}" >> "$rr_filename"
    echo "output/tout_run_rr_q${x}_${y}_1.txt" >> "$rr_filename"

    echo "Created $rr_filename"

done