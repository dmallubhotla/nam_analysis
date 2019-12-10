LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/conductivity_comparison.pdf

.PHONY: all clean

../output/conductivity_comparison.pdf: conductivity_comparison.pdf | ../output
	cp conductivity_comparison.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

calc:
	mkdir -p calc

USED_FIG_NAMES =
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
USED_CALC_NAMES = $(USED_FIG_NAMES:.jpg=.csv)
USED_CALC = $(addprefix calc/, $(USED_CALC_NAMES))

.SECONDARY: $(USED_CALC)

calc/%.csv: scripts/%Calc.wls | calc
	$(WS) $<

figures/%.jpg: scripts/%Plot.wls calc/%.csv | figures
	$(WS) $<

conductivity_comparison.pdf: conductivity_comparison.tex $(USED_FIGS)
	$(LATEXMK) conductivity_comparison.tex

