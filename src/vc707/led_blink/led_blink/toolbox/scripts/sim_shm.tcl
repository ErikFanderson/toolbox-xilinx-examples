# Probe all in Simulation History Manager (SHM) format used by Cadence
database -shm -default waves
probe -shm {{xcelium["testbench"]}} -memories -depth all -all
run
