REPORTS = initial_notes noise_notes convergence

all: $(REPORTS) output

.PHONY: $(REPORTS)

$(REPORTS): | output
	$(MAKE) -C $@

output:
	mkdir -p output