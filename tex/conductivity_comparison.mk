USED_FIG_NAMES_CONDCOM = Cond1.jpg Cond2.jpg Cond3.jpg Cond4.jpg Cond5.jpg Cond6.jpg local1.jpg local2.jpg
USED_FIGS_CONDCOM = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_CONDCOM))
USED_CALC_NAMES_CONDCOM = $(USED_FIG_NAMES_CONDCOM:.jpg=.csv)
USED_CALC_CONDCOM = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_CONDCOM))

.SECONDARY: $(USED_CALC_CONDCOM)

$(USED_CALC_CONDCOM): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLs) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_CONDCOM): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/conductivity_comparison.pdf: $(TEX_DIR)/conductivity_comparison.tex $(USED_FIGS_CONDCOM)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/conductivity_comparison.tex $(USED_FIGS_CONDCOM)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/conductivity_comparison.pdf
