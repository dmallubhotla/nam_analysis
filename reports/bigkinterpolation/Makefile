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

bigkinterpolation.pdf: bigkinterpolation.tex
	$(LATEXMK) bigkinterpolation.tex

