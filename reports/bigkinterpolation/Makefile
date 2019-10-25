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

USED_FIGS =
#Figures after here
figures/imrp1.jpg: scripts/imrp1.wls | figures
	$(WS) scripts/imrp1.wls

figures/imrp2.jpg: scripts/imrp2.wls | figures
	$(WS) scripts/imrp2.wls

figures/imrp3.jpg: scripts/imrp3.wls | figures
	$(WS) scripts/imrp3.wls


bigkinterpolation.pdf: bigkinterpolation.tex $(USED_FIGS)
	$(LATEXMK) bigkinterpolation.tex

