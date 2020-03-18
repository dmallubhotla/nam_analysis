USED_FIG_NAMES_BIGK := imrp1.jpg imrp2.jpg imrpU2NoResponseAboveCutoff.jpg imrpU2SmoothJoin.jpg chiZEarounduF.jpg
USED_FIGS_BIGK := $(addprefix $(FIG_DIR)/, $(USED_FIG_NAMES_BIGK))

$(USED_FIGS_BIGK): $(FIG_DIR)/%.jpg: $(SCRIPT_DIR)/%.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/bigkinterpolation.pdf: $(TEX_DIR)/bigkinterpolation.tex $(USED_FIGS_BIGK)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/bigkinterpolation.pdf
MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/bigkinterpolation.tex $(USED_FIGS_BIGK)