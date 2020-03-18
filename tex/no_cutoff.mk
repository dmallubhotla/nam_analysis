USED_FIG_NAMES_NO_CUT = NoCutT1ZE1.jpg NoCutT1ZE2.jpg NoCutT1ZE3.jpg NoCutT1ZE4.jpg NoCutT1ZE5.jpg
USED_FIGS_NO_CUT = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_NO_CUT))
USED_CALC_NAMES_NO_CUT = $(USED_FIG_NAMES_NO_CUT:.jpg=.csv)
USED_CALC_NO_CUT = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_NO_CUT))

.SECONDARY: $(USED_CALC_NO_CUT)

$(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
	$(WS) $<

$(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/no_cutoff.pdf: $(TEX_DIR)/no_cutoff.tex $(USED_FIGS_NO_CUT)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/no_cutoff.tex $(USED_FIGS_NO_CUT)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/no_cutoff.pdf


