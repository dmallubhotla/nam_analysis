LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/lindhard_calc.pdf

.PHONY: all clean

../output/lindhard_calc.pdf: lindhard_calc.pdf | ../output
	cp lindhard_calc.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

USED_FIG_NAMES =
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
figures/%.jpg: scripts/%.wls | figures
	$(WS) $<

lindhard_calc.pdf: lindhard_calc.tex $(USED_FIGS)
	$(LATEXMK) lindhard_calc.tex

