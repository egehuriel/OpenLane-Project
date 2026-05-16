OPENLANE_DIR := $(HOME)/egehuriel/projects/OpenLane
DESIGNS      := part1_alu part2_alu_flags part3_regfile part4_halfcpu part5_full
DOCKER_IMG   := efabless/openlane:ff5509f

DOCKER_RUN = docker run --rm \
	-v $(OPENLANE_DIR):/openlane \
	-v $(HOME)/.ciel:/root/.ciel \
	$(DOCKER_IMG)

.PHONY: all part1 part2 part3 part4 part5 clean gds help

all:
	@for d in $(DESIGNS); do \
		echo ""; \
		echo "=== Running $$d ==="; \
		cd $(OPENLANE_DIR) && $(DOCKER_RUN) ./flow.tcl -design $$d; \
	done

part1:
	cd $(OPENLANE_DIR) && $(DOCKER_RUN) ./flow.tcl -design part1_alu

part2:
	cd $(OPENLANE_DIR) && $(DOCKER_RUN) ./flow.tcl -design part2_alu_flags

part3:
	cd $(OPENLANE_DIR) && $(DOCKER_RUN) ./flow.tcl -design part3_regfile

part4:
	cd $(OPENLANE_DIR) && $(DOCKER_RUN) ./flow.tcl -design part4_halfcpu

part5:
	cd $(OPENLANE_DIR) && $(DOCKER_RUN) ./flow.tcl -design part5_full

clean:
	@for d in $(DESIGNS); do \
		echo "Cleaning $$d..."; \
		rm -rf $(OPENLANE_DIR)/designs/$$d/runs; \
	done

clean_part1:
	rm -rf $(OPENLANE_DIR)/designs/part1_alu/runs

clean_part2:
	rm -rf $(OPENLANE_DIR)/designs/part2_alu_flags/runs

clean_part3:
	rm -rf $(OPENLANE_DIR)/designs/part3_regfile/runs

clean_part4:
	rm -rf $(OPENLANE_DIR)/designs/part4_halfcpu/runs

clean_part5:
	rm -rf $(OPENLANE_DIR)/designs/part5_full/runs

gds:
	@for d in $(DESIGNS); do \
		latest=$$(ls -td $(OPENLANE_DIR)/designs/$$d/runs/RUN_* 2>/dev/null | head -1); \
		if [ -n "$$latest" ]; then \
			echo "$$d -> $$latest/results/final/gds/"; \
		else \
			echo "$$d -> no runs found"; \
		fi \
	done

help:
	@echo ""
	@echo "CSE 224 Term Project - OpenLane Makefile"
	@echo "========================================"
	@echo ""
	@echo "Usage:"
	@echo "  make all          Run flow for all 5 parts"
	@echo "  make part1        Run Part 1 - 8-bit ALU"
	@echo "  make part2        Run Part 2 - ALU with flags"
	@echo "  make part3        Run Part 3 - Register file"
	@echo "  make part4        Run Part 4 - Half CPU"
	@echo "  make part5        Run Part 5 - Full system"
	@echo "  make gds          Show GDS output paths"
	@echo "  make clean        Remove all run directories"
	@echo "  make clean_partN  Remove runs for specific part"
	@echo ""

