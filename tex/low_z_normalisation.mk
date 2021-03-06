#USED_FIG_NAMES_SC_NC = SCNCT1ZE1.jpg SCNCT1ZE3.jpg SCNCT1ZE4.jpg
#USED_FIGS_SC_NC = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_SC_NC))
#USED_CALC_NAMES_SC_NC = $(USED_FIG_NAMES_SC_NC:.jpg=.csv)
#USED_CALC_SC_NC = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_SC_NC))

#.SECONDARY: $(USED_CALC_SC_NC)

#$(USED_CALC_SC_NC): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
#	$(WS) $<
#
#$(USED_FIGS_SC_NC): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv | $(FIG_DIR)
#	$(WS) $<

$(PDF_DIR)/low_z_normalisation.pdf: $(TEX_DIR)/low_z_normalisation.tex# $(USED_FIGS_SC_NC)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/low_z_normalisation.tex
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/low_z_normalisation.pdf


