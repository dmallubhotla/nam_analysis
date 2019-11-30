REPORTS = initial_notes noise_notes convergence imrpasymptotic bigkinterpolation interpolated_noise_estimation interpolated_magnetic_noise lindhard_calc

all: $(REPORTS) output

.PHONY: $(REPORTS)

$(REPORTS): | output
	$(MAKE) -C $@

output:
	mkdir -p output