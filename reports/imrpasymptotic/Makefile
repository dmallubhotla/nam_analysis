LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/imrpasymptotic.pdf

.PHONY: all clean

../output/imrpasymptotic.pdf: imrpasymptotic.pdf | ../output
	cp imrpasymptotic.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

imrpasymptotic.pdf: imrpasymptotic.tex
	$(LATEXMK) imrpasymptotic.tex

