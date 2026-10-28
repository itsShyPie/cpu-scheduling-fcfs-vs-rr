#!/bin/bash

#java -ea -cp bin Simulate configurations/run_rr_q50_10_1_example.inp > output/RR_output.txt
#java -ea -cp bin Simulate configurations/run_fcfs_example.inp > output/FCFS_output.txt

# Create the output directory if it doesn't exist
mkdir -p output

# Iterate over each .inp file in the configurations directory
for file in configurations/*.inp; do
    output_file="output/$(basename "${file%.*}").txt"

    # Run the simulation command and pipe the output into the output file
    java -ea -cp bin Simulate "$file" > "$output_file"

    echo "Simulation completed for $file" 

done

python3 Calculator.py