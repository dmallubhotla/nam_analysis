LATEXMK = latexmk -g -lualatex
WS = wolframscript -f

all: ../output/bigkinterpolation.pdf

.PHONY: all clean

../output/bigkinterpolation.pdf: bigkinterpolation.pdf | ../output
	cp bigkinterpolation.pdf ../output/

clean:
	latexmk -C

../output:
	mkdir -p ../output

figures:
	mkdir -p figures

USED_FIG_NAMES = imrp1.jpg imrp2.jpg imrpU2NoResponseAboveCutoff.jpg imrpU2SmoothJoin.jpg chiZEarounduF.jpg
USED_FIGS = $(addprefix figures/, $(USED_FIG_NAMES))
figures/%.jpg: scripts/%.wls | figures
	$(WS) $<

bigkinterpolation.pdf: bigkinterpolation.tex $(USED_FIGS)
	$(LATEXMK) bigkinterpolation.tex

