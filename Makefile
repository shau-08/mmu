project = mmu

TARGET = MMU

# Toolchains and tools
MILL = ./../playground/mill

-include ./../playground/Makefile.include
-include cd.config

RTL_TARGET ?= rtl

# Targets
rtl: check-firtool ## Generates Verilog code from Chisel sources (output to ./generated_sv_dir)
	$(MILL) $(project).runMain redefine.rrm.mmu.genRTLMain $(TARGET)

.PHONY: rtl-dispatch
rtl-dispatch: ## Used by CD: runs whichever target cd.config's RTL_TARGET names (default: rtl)
	$(MAKE) $(RTL_TARGET) TARGET=$(TARGET)


check: test
.PHONY: test
test: check-verilator ## Run Chisel tests
	$(MILL) $(project).test.testOnly redefine.rrm.mmu.smoke.MMUTest
	@echo "If using WriteVcdAnnotation in your tests, the VCD files are generated in ./test_run_dir/testname directories."

