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

calc:
	mkdir -p calc

USED_FIG_NAMES = chiZBarounduFVaryingCutoff.jpg chiZBarounduFVaryingFrequency.jpg chiZBarounduFVaryingTemp.jpg chiZBarounduFVaryingTau.jpg chiZBarounduFVaryingVf.jpg
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
USED_CALC_NAMES = $(USED_FIG_NAMES:.jpg=.csv)
USED_CALC = $(addprefix calc/, $(USED_CALC_NAMES))

.SECONDARY: $(USED_CALC)

calc/%.csv: scripts/%Calc.wls | calc
	$(WS) $<

figures/%.jpg: scripts/%Plot.wls calc/%.csv | figures
	$(WS) $<

interpolated_magnetic_noise.pdf: interpolated_magnetic_noise.tex $(USED_FIGS)
	$(LATEXMK) interpolated_magnetic_noise.tex

