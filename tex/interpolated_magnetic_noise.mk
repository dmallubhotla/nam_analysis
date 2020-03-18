USED_FIG_NAMES_IMN = chiZBarounduFVaryingCutoff.jpg chiZBarounduFVaryingFrequency.jpg chiZBarounduFVaryingTemp.jpg chiZBarounduFVaryingTau.jpg chiZBarounduFVaryingVf.jpg
USED_FIGS_IMN = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_IMN))
USED_CALC_NAMES_IMN = $(USED_FIG_NAMES_IMN:.jpg=.csv)
USED_CALC_IMN = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_IMN))

.SECONDARY: $(USED_CALC_IMN)

$(USED_CALC_IMN): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_IMN): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/interpolated_magnetic_noise.pdf: $(TEX_DIR)/interpolated_magnetic_noise.tex $(USED_FIGS_IMN)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/interpolated_magnetic_noise.tex $(USED_FIGS_IMN)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/interpolated_magnetic_noise.pdf
