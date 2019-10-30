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

USED_FIGS = figures/imrp1.jpg figures/imrp2.jpg figures/imrpU2NoResponseAboveCutoff.jpg figures/imrpU2SmoothJoin.jpg
figures/%.jpg: scripts/%.wls | figures
	$(WS) $<

bigkinterpolation.pdf: bigkinterpolation.tex $(USED_FIGS)
	$(LATEXMK) bigkinterpolation.tex

