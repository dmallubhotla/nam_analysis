LATEXMK = latexmk -use-make -g -lualatex

all: ../output/initial_notes.pdf

../output/initial_notes.pdf: initial_notes.pdf
	cp initial_notes.pdf ../output/

clean:
	latexmk -C

.PHONY: all clean

initial_notes.pdf: initial_notes.tex
	$(LATEXMK) initial_notes.tex