LATEXMK = latexmk -use-make -g -lualatex
WS = wolframscript -f

all: ../output/initial_notes.pdf

.PHONY: all clean

../output/initial_notes.pdf: initial_notes.pdf | ../output
	cp initial_notes.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

#Figures after here
figures/ReT0K1vsWmultV.jpg: scripts/ConductivityRe_T0K1vsWmultV.wls | figures
	$(WS) scripts/ConductivityRe_T0K1vsWmultV.wls

figures/ReT0V1vsWmultK.jpg: scripts/ConductivityRe_T0V1vsWmultK.wls | figures
	$(WS) scripts/ConductivityRe_T0V1vsWmultK.wls

figures/ImT0V1vsWmultK.jpg: scripts/ConductivityIm_T0V1vsWmultK.wls | figures
	$(WS) scripts/ConductivityIm_T0V1vsWmultK.wls

figures/ReT1V1vsWmultK.jpg: scripts/ConductivityRe_T1V1vsWmultK.wls | figures
	$(WS) scripts/ConductivityRe_T1V1vsWmultK.wls

figures/ImT1V1vsWmultK.jpg: scripts/ConductivityIm_T1V1vsWmultK.wls | figures
	$(WS) scripts/ConductivityIm_T1V1vsWmultK.wls


initial_notes.pdf: initial_notes.tex figures/ReT0K1vsWmultV.jpg figures/ReT0V1vsWmultK.jpg figures/ImT0V1vsWmultK.jpg figures/ReT1V1vsWmultK.jpg figures/ImT1V1vsWmultK.jpg
	$(LATEXMK) initial_notes.tex