REPORTS = initial_notes noise_notes convergence imrpasymptotic

all: $(REPORTS) output

.PHONY: $(REPORTS)

$(REPORTS): | output
	$(MAKE) -C $@

output:
	mkdir -p output