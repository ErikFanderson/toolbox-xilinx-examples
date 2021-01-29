# Author: Erik Anderson 
# Date Created: 01/22/2021

default: test

# Lints ssp1_fpga directory recursively
lint:
	pylint ssp1_fpga tests

# Formats ssp1_fpga directory recursively
format:
	yapf -i -r ssp1_fpga tests

# Type checks ssp1_fpga directory recursively
type:
	mypy ssp1_fpga tests

# Runs all tests in tests directory 
test:
	pytest -v tests

# Export anaconda environment
export:
	conda env export --from-history | grep -v "prefix" > environment.yml
