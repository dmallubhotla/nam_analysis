LATEXMK = latexmk -use-make -g -lualatex
WS = wolframscript -f

all: ../output/initial_notes.pdf

../output/initial_notes.pdf: initial_notes.pdf
	cp initial_notes.pdf ../output/

figures/T0K001vsW.jpg: scripts/conductivityVsK.wls
	$(WS) scripts/conductivityVsK.wls

clean:
	latexmk -C

.PHONY: all clean

initial_notes.pdf: initial_notes.tex figures/T0K001vsW.jpg
	$(LATEXMK) initial_notes.tex