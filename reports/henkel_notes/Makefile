LATEXMK = latexmk -use-make -g -lualatex
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

henkel_notes.pdf: henkel_notes.tex henkel_notes.bib
	$(LATEXMK) henkel_notes.tex