USED_FIGS_COND_NOTES = $(FIG_DIR)/ReT0K1vsWmultV.jpg $(FIG_DIR)/ReT0V1vsWmultK.jpg $(FIG_DIR)/ImT0V1vsWmultK.jpg $(FIG_DIR)/ReT1V1vsWmultK.jpg $(FIG_DIR)/ImT1V1vsWmultK.jpg $(FIG_DIR)/ReT0V1vsKmultW.jpg $(FIG_DIR)/ImT0V1vsKmultW.jpg $(FIG_DIR)/ReT1V1vsKmultW.jpg $(FIG_DIR)/ImT1V1vsKmultW.jpg
#Figures after here
$(FIG_DIR)/ReT0K1vsWmultV.jpg: $(SCRIPT_DIR)/ConductivityRe_T0K1vsWmultV.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ReT0V1vsWmultK.jpg: $(SCRIPT_DIR)/ConductivityRe_T0V1vsWmultK.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ImT0V1vsWmultK.jpg: $(SCRIPT_DIR)/ConductivityIm_T0V1vsWmultK.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ReT1V1vsWmultK.jpg: $(SCRIPT_DIR)/ConductivityRe_T1V1vsWmultK.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ImT1V1vsWmultK.jpg: $(SCRIPT_DIR)/ConductivityIm_T1V1vsWmultK.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ReT0V1vsKmultW.jpg: $(SCRIPT_DIR)/ConductivityRe_T0V1vsKmultW.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ImT0V1vsKmultW.jpg: $(SCRIPT_DIR)/ConductivityIm_T0V1vsKmultW.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ReT1V1vsKmultW.jpg: $(SCRIPT_DIR)/ConductivityRe_T1V1vsKmultW.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(FIG_DIR)/ImT1V1vsKmultW.jpg: $(SCRIPT_DIR)/ConductivityIm_T1V1vsKmultW.wls $(MATHEMATICA_INSTALLS) | $(FIG_DIR)
	$(WS) $<

$(PDF_DIR)/conductivity_notes.pdf: $(TEX_DIR)/conductivity_notes.tex $(USED_FIGS_COND_NOTES)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/conductivity_notes.tex $(USED_FIGS_COND_NOTES)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/conductivity_notes.pdf
