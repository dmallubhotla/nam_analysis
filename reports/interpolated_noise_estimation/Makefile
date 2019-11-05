LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/interpolated_noise_estimation.pdf

.PHONY: all clean

../output/interpolated_noise_estimation.pdf: interpolated_noise_estimation.pdf | ../output
	cp interpolated_noise_estimation.pdf ../output/

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

interpolated_noise_estimation.pdf: interpolated_noise_estimation.tex $(USED_FIGS)
	$(LATEXMK) interpolated_noise_estimation.tex

