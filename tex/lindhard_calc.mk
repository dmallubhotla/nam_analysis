USED_FIG_NAMES_LINDC = chiZELindhard.jpg T1ZELindhard.jpg
USED_FIGS_LINDC = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_LINDC))
USED_CALC_NAMES_LINDC = $(USED_FIG_NAMES_LINDC:.jpg=.csv)
USED_CALC_LINDC = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_LINDC))

.SECONDARY: $(USED_CALC_LINDC)

$(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
	$(WS) $<

$(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

lindhard_calc.pdf: lindhard_calc.tex $(USED_FIGS_LINDC)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/lindhard_calc.tex $(USED_FIGS_LINDC)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/lindhard_calc.pdf
