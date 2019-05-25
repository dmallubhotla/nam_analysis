LATEXMK = latexmk -use-make -g -lualatex
WS = wolframscript -f

FIGS_1 = figures/ReT0K001vsW.jpg figures/ReT0K01vsW.jpg figures/ReT0K1vsW.jpg figures/ReT0K10vsW.jpg
FIGS_4 = figures/ImT0K001vsW.jpg figures/ImT0K01vsW.jpg figures/ImT0K1vsW.jpg figures/ImT0K10vsW.jpg
FIGS_2 = figures/ReT1K01vsW.jpg figures/ReT1K1vsW.jpg figures/ReT1K10vsW.jpg
FIGS_3 = figures/ReT04K01vsW.jpg figures/ReT04K1vsW.jpg figures/ReT04K10vsW.jpg

FIGS_T0_VS_K = figures/ReT0W001vsK.jpg figures/ReT0W01vsK.jpg figures/ReT0W1vsK.jpg figures/ReT0W10vsK.jpg

all: ../output/initial_notes.pdf

../output/initial_notes.pdf: ../output initial_notes.pdf
	cp initial_notes.pdf ../output/

$(FIGS_1): figures scripts/ConductivityRe_T0VsW.wls
	$(WS) scripts/ConductivityRe_T0VsW.wls

$(FIGS_4): figures scripts/ConductivityIm_T0VsW.wls
	$(WS) scripts/ConductivityIm_T0VsW.wls

$(FIGS_2): figures scripts/ConductivityRe_T1VsW.wls
	$(WS) scripts/ConductivityRe_T1VsW.wls

$(FIGS_3): figures scripts/ConductivityRe_T04VsW.wls
	$(WS) scripts/ConductivityRe_T04VsW.wls


$(FIGS_T0_VS_K): figures scripts/ConductivityRe_T0VsK.wls
	$(WS) scripts/ConductivityRe_T0VsK.wls

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

.PHONY: all clean

initial_notes.pdf: initial_notes.tex $(FIGS_1) $(FIGS_2) $(FIGS_3) $(FIGS_4) $(FIGS_T0_VS_K)
	$(LATEXMK) initial_notes.tex