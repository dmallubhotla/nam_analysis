USED_FIG_NAMES_HIGH_TEMP_NAM = HighTempNam1.jpg HighTempNam2.jpg HighTempNam3.jpg HighTempNam4.jpg HighTempNam5.jpg HighTempNam6.jpg
USED_FIGS_HIGH_TEMP_NAM = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_HIGH_TEMP_NAM))
USED_CALC_NAMES_HIGH_TEMP_NAM = $(USED_FIG_NAMES_HIGH_TEMP_NAM:.jpg=.csv)
USED_CALC_HIGH_TEMP_NAM = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_HIGH_TEMP_NAM))

.SECONDARY: $(USED_CALC_HIGH_TEMP_NAM)

$(USED_CALC_HIGH_TEMP_NAM): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(EWJN_INSTALL) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_HIGH_TEMP_NAM): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/high_temp_nam.pdf: $(TEX_DIR)/high_temp_nam.tex $(USED_FIGS_HIGH_TEMP_NAM)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/high_temp_nam.tex $(USED_FIGS_HIGH_TEMP_NAM)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/high_temp_nam.pdf
