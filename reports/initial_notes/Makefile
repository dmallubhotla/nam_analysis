LATEXMK = latexmk -use-make -g -lualatex
WS = wolframscript -f

FIGS_1 = figures/ReT0K001vsW.jpg figures/ReT0K01vsW.jpg figures/ReT0K1vsW.jpg figures/ReT0K10vsW.jpg
FIGS_2 = figures/ReT1K01vsW.jpg figures/ReT1K1vsW.jpg figures/ReT1K10vsW.jpg
FIGS_3 = figures/ReT04K01vsW.jpg figures/ReT04K1vsW.jpg figures/ReT04K10vsW.jpg

all: ../output/initial_notes.pdf

../output/initial_notes.pdf: ../output initial_notes.pdf
	cp initial_notes.pdf ../output/

$(FIGS_1): figures scripts/conductivityVsK.wls
	$(WS) scripts/conductivityVsK.wls

$(FIGS_2): figures scripts/conductivityT1VsK.wls
	$(WS) scripts/conductivityT1VsK.wls

$(FIGS_3): figures scripts/ConductivityRe_T04VsW.wls
	$(WS) scripts/ConductivityRe_T04VsW.wls

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

.PHONY: all clean

initial_notes.pdf: initial_notes.tex $(FIGS_1) $(FIGS_2) $(FIGS_3)
	$(LATEXMK) initial_notes.tex