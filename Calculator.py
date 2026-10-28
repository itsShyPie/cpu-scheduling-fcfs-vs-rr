import re
import os
import csv

# List of configuration files
config_files = os.listdir("configurations")

# CSV headers
csv_headers = ["Config File", "CPU Usage", "Context Switches", "Avg Waiting Time", "Avg Turnaround Time", "Time Quantum", "Syscall Time", "Pairs", ]

# List to store the processed data
data = []

# Process each configuration file
for config_file in config_files:

     # Input file paths
    output_file_path = os.path.join("output/", f"{config_file}.txt")
    substring_to_remove = ".inp"
    output_file_path = output_file_path.replace(substring_to_remove, "")
    print(output_file_path)
    process_file_path = os.path.join("output/", f"tout_{config_file}.txt")
    process_file_path = process_file_path.replace(substring_to_remove, "")

    # Configuration file path
    config_file_path = os.path.join("configurations", config_file)    

    # Extract quantum and syscall time from the configuration file
    with open(config_file_path, "r") as config_file:
        for i, line in enumerate(config_file):
            if i == 2:
                time_quantum = line.strip()
            elif i == 3:
                sys_call_time = line.strip()
            elif i == 4:
                context_switch_time = line.strip()
                pairs = sys_call_time + "-" + context_switch_time
            elif i > 5:
                break

    # Read the output file
    with open(output_file_path, "r") as file:
        output = file.read()

    # Extract relevant information
    cpu_usage = re.search(r"CPU utilization: ([\d.]+)", output).group(1)
    # context_switches = re.search(r"Context switches: (\d+)", output).group(1)

    # Calculate average waiting time and average turnaround time
    pid_waiting_times = {}
    pid_turnaround_times = {}
    pid_start_times = {}

    with open(process_file_path, "r") as file:
        lines = file.readlines()

    for line in lines:
        match = re.match(r"(\d+), ([A-Z]+), .*, (\d+), (\d+|-)", line)
        if match:
            pid = match.group(1)
            state = str(match.group(2))
            start_time = int(match.group(3))
            try:
                end_time = int(match.group(4))
            except ValueError:
                if pid not in pid_turnaround_times:
                    pid_turnaround_times[pid] = 0
                pid_turnaround_times[pid] = start_time - pid_start_times[pid]
            
            if state == "READY":
                if pid not in pid_waiting_times:
                    pid_waiting_times[pid] = 0
                    pid_start_times[pid] = start_time
                pid_waiting_times[pid] += (end_time - start_time)

    total_waiting_time = sum(pid_waiting_times.values())
    total_turnaround_time = sum(pid_turnaround_times.values())

    avg_waiting_time = total_waiting_time / 18
    avg_turnaround_time = total_turnaround_time / 18

    # Append the processed data to the list
    data.append([output_file_path, cpu_usage, context_switch_time, avg_waiting_time, avg_turnaround_time, time_quantum, sys_call_time, pairs,])

# Write the data to a CSV file
with open("OutputSummary.csv", "w", newline="") as csv_file:
    writer = csv.writer(csv_file)
    writer.writerow(csv_headers)
    writer.writerows(data)

print("OutputSummary.csv Succesfully Generated")
