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
#Figures after here
figures/imrp1.jpg: scripts/imrp1.wls | figures
	$(WS) scripts/imrp1.wls

figures/imrp2.jpg: scripts/imrp2.wls | figures
	$(WS) scripts/imrp2.wls

figures/imrp3.jpg: scripts/imrp3.wls | figures
	$(WS) scripts/imrp3.wls

figures/imrpU2NoResponseAboveCutoff.jpg: scripts/imrpU2NoResponseAboveCutoff.wls | figures
	$(WS) scripts/imrpU2NoResponseAboveCutoff.wls

figures/imrpU2SmoothJoin.jpg: scripts/imrpU2SmoothJoin.wls | figures
	$(WS) scripts/imrpU2SmoothJoin.wls

bigkinterpolation.pdf: bigkinterpolation.tex $(USED_FIGS)
	$(LATEXMK) bigkinterpolation.tex

