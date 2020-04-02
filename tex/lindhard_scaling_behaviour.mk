USED_FIG_NAMES_LSB = LSB1.jpg
USED_FIGS_LSB = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_LSB))
USED_CALC_NAMES_LSB = $(USED_FIG_NAMES_LSB:.jpg=.csv)
USED_CALC_LSB = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_LSB))

.SECONDARY: $(USED_CALC_LSB)

$(USED_CALC_LSB): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_LSB): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/lindhard_scaling_behaviour.pdf: $(TEX_DIR)/lindhard_scaling_behaviour.tex $(USED_FIGS_LSB)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/lindhard_scaling_behaviour.tex $(USED_FIGS_LSB)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/lindhard_scaling_behaviour.pdf
