$(CALC_DIR)/ConductivityZone3AsymptoticForm.csv $(CALC_DIR)/ConductivityZone3Normal.csv $(CALC_DIR)/ConductivityZone3AsymptoticHighForm.csv: $(SCRIPT_DIR)/ConductivityZone3SmallKVsFullCalc.wls | $(CALC_DIR)
	$(WS) $(SCRIPT_DIR)/ConductivityZone3SmallKVsFullCalc.wls

.SECONDARY: $(CALC_DIR)/ConductivityZone3AsymptoticForm.csv $(CALC_DIR)/ConductivityZone3Normal.csv $(CALC_DIR)/ConductivityZone3AsymptoticHighForm.csv

$(FIG_DIR)/ConductivityZone3Real.jpg: $(SCRIPT_DIR)/ConductivityZone3SmallKVsFullPlots.wls $(CALC_DIR)/ConductivityZone3AsymptoticForm.csv $(CALC_DIR)/ConductivityZone3Normal.csv $(CALC_DIR)/ConductivityZone3AsymptoticHighForm.csv | $(FIG_DIR)
	$(WS) $(SCRIPT_DIR)/ConductivityZone3SmallKVsFullPlots.wls

$(FIG_DIR)/ConductivityZone3Imag.jpg: $(SCRIPT_DIR)/ConductivityZone3SmallKVsFullImagPlots.wls $(CALC_DIR)/ConductivityZone3AsymptoticForm.csv $(CALC_DIR)/ConductivityZone3Normal.csv $(CALC_DIR)/ConductivityZone3AsymptoticHighForm.csv | $(FIG_DIR)
	$(WS) $(SCRIPT_DIR)/ConductivityZone3SmallKVsFullImagPlots.wls


USED_FIGS_NOISE_NOTES = $(FIG_DIR)/SampleElectricNoiseFresnelPerfectConductor.jpg $(FIG_DIR)/SampleElectricNoiseZetaPerfectConductor.jpg $(FIG_DIR)/ConductivityZone3Real.jpg $(FIG_DIR)/ConductivityZone3Imag.jpg

$(FIG_DIR)/SampleElectricNoiseFresnelPerfectConductor.jpg: $(SCRIPT_DIR)/SampleElectricNoiseFresnelPerfectConductor.wls | $(FIG_DIR)
	$(WS) $(SCRIPT_DIR)/SampleElectricNoiseFresnelPerfectConductor.wls

$(FIG_DIR)/SampleElectricNoiseZetaPerfectConductor.jpg: $(SCRIPT_DIR)/SampleElectricNoiseZetaPerfectConductor.wls | $(FIG_DIR)
	$(WS) $(SCRIPT_DIR)/SampleElectricNoiseZetaPerfectConductor.wls

$(PDF_DIR)/noise_notes.pdf: $(TEX_DIR)/noise_notes.tex $(USED_FIGS_NOISE_NOTES)

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/noise_notes.tex $(USED_FIGS_NOISE_NOTES)
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/noise_notes.pdf


