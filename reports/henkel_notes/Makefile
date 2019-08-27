LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/henkel_notes.pdf

.PHONY: all clean

../output/henkel_notes.pdf: henkel_notes.pdf | ../output
	cp henkel_notes.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

USED_FIGS = figures/SampleElectricNoiseFresnelPerfectConductor.jpg figures/SampleElectricNoiseZetaPerfectConductor.jpg figures/ReT1V700vsKmultW.jpg figures/ImT1V700vsKmultW.jpg

figures/SampleElectricNoiseFresnelPerfectConductor.jpg: scripts/SampleElectricNoiseFresnelPerfectConductor.wls | figures
	$(WS) scripts/SampleElectricNoiseFresnelPerfectConductor.wls

figures/SampleElectricNoiseZetaPerfectConductor.jpg: scripts/SampleElectricNoiseZetaPerfectConductor.wls | figures
	$(WS) scripts/SampleElectricNoiseZetaPerfectConductor.wls

figures/ReT1V700vsKmultW.jpg: scripts/ConductivityRe_T1V700vsKmultW.wls | figures
	$(WS) scripts/ConductivityRe_T1V700vsKmultW.wls

figures/ImT1V700vsKmultW.jpg: scripts/ConductivityIm_T1V700vsKmultW.wls | figures
	$(WS) scripts/ConductivityIm_T1V700vsKmultW.wls

henkel_notes.pdf: henkel_notes.tex henkel_notes.bib $(USED_FIGS)
	$(LATEXMK) henkel_notes.tex

