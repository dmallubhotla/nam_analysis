REPORTS = initial_notes noise_notes convergence imrpasymptotic bigkinterpolation interpolated_noise_estimation interpolated_magnetic_noise lindhard_calc sc_normal_compare

all: $(REPORTS) output

.PHONY: $(REPORTS)

$(REPORTS): | output
	$(MAKE) -C $@

output:
	mkdir -p output