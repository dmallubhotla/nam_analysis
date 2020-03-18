USED_FIG_NAMES_INE = chiZEarounduFVaryingFrequency.jpg chiZEarounduFVaryingTemp.jpg chiZEarounduFVaryingTau.jpg chiZEarounduFVaryingVf.jpg
USED_FIGS_INE = $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_INE))
figures/%.jpg: $(SCRIPT_DIR)/%.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/interpolated_noise_estimation.pdf: $(TEX_DIR)/interpolated_noise_estimation.tex $(USED_FIG_INE)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/interpolated_noise_estimation.tex $(USED_FIGS_INE)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/interpolated_noise_estimation.pdf
