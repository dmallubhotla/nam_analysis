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

calc:
	mkdir -p calc

USED_FIG_NAMES = chiZELindhard.jpg T1ZELindhard.jpg
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
USED_CALC_NAMES = $(USED_FIG_NAMES:.jpg=.csv)
USED_CALC = $(addprefix calc/, $(USED_CALC_NAMES))

.SECONDARY: $(USED_CALC)

calc/%.csv: scripts/%Calc.wls | calc
	$(WS) $<

figures/%.jpg: scripts/%Plot.wls calc/%.csv | figures
	$(WS) $<

lindhard_calc.pdf: lindhard_calc.tex $(USED_FIGS)
	$(LATEXMK) lindhard_calc.tex

