LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/convergence.pdf

.PHONY: all clean

../output/convergence.pdf: convergence.pdf | ../output
	cp convergence.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

convergence.pdf: convergence.tex convergence.bib
	$(LATEXMK) convergence.tex

