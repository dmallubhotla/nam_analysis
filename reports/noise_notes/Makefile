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

USED_FIGS = figures/SampleElectricNoiseFresnelPerfectConductor.jpg figures/SampleElectricNoiseZetaPerfectConductor.jpg figures/ReT1V700vsKmultW.jpg figures/ImT1V700vsKmultW.jpg figures/SampleElectricNoiseNamZerothOrder.jpg figures/SampleElectricNoiseNamZerothOrderGs.jpg

figures/SampleElectricNoiseFresnelPerfectConductor.jpg: scripts/SampleElectricNoiseFresnelPerfectConductor.wls | figures
	$(WS) scripts/SampleElectricNoiseFresnelPerfectConductor.wls

figures/SampleElectricNoiseZetaPerfectConductor.jpg: scripts/SampleElectricNoiseZetaPerfectConductor.wls | figures
	$(WS) scripts/SampleElectricNoiseZetaPerfectConductor.wls

figures/SampleElectricNoiseNamZerothOrder.jpg: scripts/SampleElectricNoiseNamZerothOrder.wls | figures
	$(WS) scripts/SampleElectricNoiseNamZerothOrder.wls

figures/SampleElectricNoiseNamZerothOrderGs.jpg: scripts/SampleElectricNoiseNamZerothOrderGs.wls | figures
	$(WS) scripts/SampleElectricNoiseNamZerothOrderGs.wls

figures/ReT1V700vsKmultW.jpg: scripts/ConductivityRe_T1V700vsKmultW.wls | figures
	$(WS) scripts/ConductivityRe_T1V700vsKmultW.wls

figures/ImT1V700vsKmultW.jpg: scripts/ConductivityIm_T1V700vsKmultW.wls | figures
	$(WS) scripts/ConductivityIm_T1V700vsKmultW.wls

noise_notes.pdf: noise_notes.tex noise_notes.bib $(USED_FIGS)
	$(LATEXMK) noise_notes.tex

