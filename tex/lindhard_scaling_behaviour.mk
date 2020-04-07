USED_FIG_NAMES_LSB = LSB1.jpg LSB2.jpg
USED_FIGS_LSB = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_LSB))
USED_CALC_NAMES_LSB = $(USED_FIG_NAMES_LSB:.jpg=.csv)
USED_CALC_LSB = $(addprefix $(CALC_DIR)/, $(USED_CALC_NAMES_LSB))

.SECONDARY: $(USED_CALC_LSB)

$(USED_CALC_LSB): $(CALC_DIR)/%.csv: $(SCRIPT_DIR)/%Calc.wls $(MATHEMATICA_INSTALLS) | $(CALC_DIR)
	$(WS) $<

$(USED_FIGS_LSB): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%Plot.wls $(CALC_DIR)/%.csv | $(FIG_DIR)
	$(WS) $<

# These three depend on LSB2.csv
$(FIG_DIR)/LSB2_2.jpg: $(SCRIPT_DIR)/LSB2DataOnlyPlot.wls $(CALC_DIR)/LSB2.csv
	$(WS) $<
$(FIG_DIR)/LSB2Smaller.jpg: $(SCRIPT_DIR)/LSB2PlotSmaller.wls $(CALC_DIR)/LSB2.csv
	$(WS) $<
$(FIG_DIR)/LSB2CubicToQuadraticRegion.jpg: $(SCRIPT_DIR)/LSB2PlotCubicToQuadraticRegion.wls $(CALC_DIR)/LSB2.csv
	$(WS) $<
# Nam and Lindhard together
$(CALC_DIR)/NSB1.csv: $(SCRIPT_DIR)/NSB1Calc.wls
	$(WS) $<
$(FIG_DIR)/NSB1.jpg: $(SCRIPT_DIR)/NSB1Plot.wls $(CALC_DIR)/LSB1.csv $(CALC_DIR)/NSB1.csv
	$(WS) $<

ALL_LSB_FIGS = $(USED_FIGS_LSB) $(FIG_DIR)/LSB2Smaller.jpg $(FIG_DIR)/LSB2_2.jpg $(FIG_DIR)/LSB2CubicToQuadraticRegion.jpg $(FIG_DIR)/NSB1.jpg

$(PDF_DIR)/lindhard_scaling_behaviour.pdf: $(TEX_DIR)/lindhard_scaling_behaviour.tex $(ALL_LSB_FIGS)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/lindhard_scaling_behaviour.tex $(ALL_LSB_FIGS)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/lindhard_scaling_behaviour.pdf
