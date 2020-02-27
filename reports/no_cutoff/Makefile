LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/no_cutoff.pdf

.PHONY: all clean

../output/no_cutoff.pdf: no_cutoff.pdf | ../output
	cp no_cutoff.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

calc:
	mkdir -p calc

USED_FIG_NAMES = T1ZE1.jpg T1ZE2.jpg T1ZE3.jpg T1ZE4.jpg T1ZE5.jpg
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
USED_CALC_NAMES = $(USED_FIG_NAMES:.jpg=.csv)
USED_CALC = $(addprefix calc/, $(USED_CALC_NAMES))

.SECONDARY: $(USED_CALC)

calc/%.csv: scripts/%Calc.wls | calc
	$(WS) $<

figures/%.jpg: scripts/%Plot.wls calc/%.csv | figures
	$(WS) $<

no_cutoff.pdf: no_cutoff.tex $(USED_FIGS)
	$(LATEXMK) no_cutoff.tex

