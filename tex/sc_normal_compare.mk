USED_FIG_NAMES_SC_NC = SCNCT1ZE1.jpg SCNCT1ZE3.jpg SCNCT1ZE4.jpg
USED_FIGS_SC_NC = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_SC_NC))
USED_CALC_NAMES_SC_NC = $(USED_FIG_NAMES_SC_NC:.jpg=.csv)
USED_CALC_SC_NC = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_SC_NC))

.SECONDARY: $(USED_CALC_SC_NC)

$(USED_CALC_SC_NC): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_SC_NC): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv | $(FIG_DIR)
	$(WS) $<

sc_normal_compare.pdf: sc_normal_compare.tex $(USED_FIGS)
	$(LATEXMK) sc_normal_compare.tex

$(PDF_DIR)/sc_normal_compare.pdf: $(TEX_DIR)/sc_normal_compare.tex $(USED_FIGS_SC_NC)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/sc_normal_compare.tex $(USED_FIGS_SC_NC)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/sc_normal_compare.pdf


