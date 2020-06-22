USED_FIG_NAMES_MAG_NOISE = T1BzzComparison.jpg
USED_FIGS_MAG_NOISE = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_MAG_NOISE))
USED_CALC_NAMES_MAG_NOISE = $(USED_FIG_NAMES_MAG_NOISE:.jpg=.csv)
USED_CALC_MAG_NOISE = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_MAG_NOISE))

.SECONDARY: $(USED_CALC_MAG_NOISE)

$(USED_CALC_MAG_NOISE): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(EWJNT1BZZ_INSTALL) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_MAG_NOISE): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/magnetic_noise_start.pdf: $(TEX_DIR)/magnetic_noise_start.tex $(USED_FIGS_MAG_NOISE)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/magnetic_noise_start.tex $(USED_FIGS_MAG_NOISE)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/magnetic_noise_start.pdf
