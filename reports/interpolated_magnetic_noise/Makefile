LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/interpolated_magnetic_noise.pdf

.PHONY: all clean

../output/interpolated_magnetic_noise.pdf: interpolated_magnetic_noise.pdf | ../output
	cp interpolated_magnetic_noise.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

USED_FIG_NAMES = chiZBarounduFVaryingCutoff.jpg chiZBarounduFVaryingFrequency.jpg chiZBarounduFVaryingTemp.jpg chiZBarounduFVaryingTau.jpg chiZBarounduFVaryingVf.jpg
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
figures/%.jpg: scripts/%.wls | figures
	$(WS) $<

interpolated_magnetic_noise.pdf: interpolated_magnetic_noise.tex $(USED_FIGS)
	$(LATEXMK) interpolated_magnetic_noise.tex

