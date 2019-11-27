LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/magnetic_noise.pdf

.PHONY: all clean

../output/magnetic_noise.pdf: magnetic_noise.pdf | ../output
	cp magnetic_noise.pdf ../output/

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

magnetic_noise.pdf: magnetic_noise.tex $(USED_FIGS)
	$(LATEXMK) magnetic_noise.tex

