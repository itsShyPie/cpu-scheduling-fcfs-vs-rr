# CPU scheduling: FCFS vs Round Robin

An experiment comparing First Come First Served and Round Robin scheduling on a simulated workload of
18 processes, measuring CPU utilisation, average turnaround time and average waiting time as system
call time, context switch time and the Round Robin time quantum change.

Operating systems assignment, University of Cape Town, 2023.

## What's here

- `INP_GENERATOR.sh` generates one simulator configuration per experiment: FCFS with system call
  times of 1 to 50 and context switch times of 10 to 108, and Round Robin across a range of time quanta
- `MAIN_RUN.sh` runs every configuration through the simulator, then calls `Calculator.py`
- `Calculator.py` parses each run's output into `results/OutputSummary.csv` (CPU usage, context
  switches, average waiting time, average turnaround time)

The Java scheduling simulator was supplied by the course and isn't included, so the scripts won't run
on their own.

## Findings

- With a well-chosen time quantum, Round Robin beat FCFS on CPU utilisation, turnaround time and
  waiting time.
- As the quantum grows, Round Robin behaves more and more like FCFS: past a quantum of about 600,
  utilisation, turnaround and waiting time all level off.
- Best CPU utilisation: 94.64% for FCFS and 94.62% for Round Robin (quantum 780), both with a system
  call time of 1 and a context switch time of 10.
- Longer context switches and system calls hurt both schedulers on every metric.
