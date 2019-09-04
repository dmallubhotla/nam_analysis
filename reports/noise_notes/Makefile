LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/noise_notes.pdf

.PHONY: all clean

../output/noise_notes.pdf: noise_notes.pdf | ../output
	cp noise_notes.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

calc:
	mkdir -p calc

calc/epsDataZone1.csv: scripts/epsZone1Calc.wls | calc
	$(WS) scripts/epsZone1Calc.wls

calc/epsAsymptoticLowKDataZone1.csv: scripts/epsALowKZone1Calc.wls | calc
	$(WS) scripts/epsALowKZone1Calc.wls

calc/ConductivityZone3AsymptoticForm.csv calc/ConductivityZone3Normal.csv: scripts/ConductivityZone3SmallKVsFullCalc.wls | calc
	$(WS) scripts/ConductivityZone3SmallKVsFullCalc.wls

figures/ConductivityZone3Real.jpg figures/ConductivityZone3Imag.jpg: scripts/ConductivityZone3SmallKVsFullPlots.wls calc/ConductivityZone3AsymptoticForm.csv calc/ConductivityZone3Normal.csv | figures
	$(WS) scripts/ConductivityZone3SmallKVsFullPlots.wls

USED_FIGS = figures/SampleElectricNoiseFresnelPerfectConductor.jpg figures/SampleElectricNoiseZetaPerfectConductor.jpg figures/ConductivityZone3Real.jpg figures/ConductivityZone3Imag.jpg

figures/SampleElectricNoiseFresnelPerfectConductor.jpg: scripts/SampleElectricNoiseFresnelPerfectConductor.wls | figures
	$(WS) scripts/SampleElectricNoiseFresnelPerfectConductor.wls

figures/SampleElectricNoiseZetaPerfectConductor.jpg: scripts/SampleElectricNoiseZetaPerfectConductor.wls | figures
	$(WS) scripts/SampleElectricNoiseZetaPerfectConductor.wls

noise_notes.pdf: noise_notes.tex noise_notes.bib $(USED_FIGS)
	$(LATEXMK) noise_notes.tex

