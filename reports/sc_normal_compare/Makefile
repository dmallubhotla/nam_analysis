LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/sc_normal_compare.pdf

.PHONY: all clean

../output/sc_normal_compare.pdf: sc_normal_compare.pdf | ../output
	cp sc_normal_compare.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

calc:
	mkdir -p calc

USED_FIG_NAMES = T1ZE1.jpg
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
USED_CALC_NAMES = $(USED_FIG_NAMES:.jpg=.csv)
USED_CALC = $(addprefix calc/, $(USED_CALC_NAMES))

.SECONDARY: $(USED_CALC)

calc/%.csv: scripts/%Calc.wls | calc
	$(WS) $<

figures/%.jpg: scripts/%Plot.wls calc/%.csv | figures
	$(WS) $<

sc_normal_compare.pdf: sc_normal_compare.tex $(USED_FIGS)
	$(LATEXMK) sc_normal_compare.tex

