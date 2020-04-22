### Build tools
#
LATEXMK := latexmk -pdflatex="luahblatex %O %S" -pdf -dvi- -ps- -quiet -logfilewarninglist
WS := wolframscript -f

### Directory variables
#
PDF_DIR := pdfs
TEX_DIR := tex
DIST_DIR := dist
FIG_DIR := figures
SCRIPT_DIR := scripts
CALC_DIR := calc

SOURCES := $(wildcard tex/*.tex)
OUTPUTS := $(patsubst tex/%.tex, pdfs/%.pdf,$(SOURCES))

### Here we go
#
.PHONY: all
all: allpdfs mathematicainstall ewjnnoiseInstall

### How we do that
#

## setup main pdf deps as variable that subdirs can add to
MAIN_PDF_DEPS := bibliography.bib
ALL_PDFS := $(PDF_DIR)/main.pdf
-include $(TEX_DIR)/*.mk

.PHONY: allpdfs
allpdfs: $(ALL_PDFS)

## Defining common directory recipes
$(PDF_DIR):
	mkdir $(PDF_DIR)
$(DIST_DIR):
	mkdir -p $(DIST_DIR)
$(FIG_DIR):
	mkdir -p $(FIG_DIR)
$(CALC_DIR):
	mkdir -p $(CALC_DIR)

## Making main.pdf and other pdfs
#
$(PDF_DIR)/main.pdf: main.tex $(MAIN_PDF_DEPS) | $(PDF_DIR)
	$(LATEXMK) $(<F)
	cp $(@F) $@

$(OUTPUTS): $(PDF_DIR)/%.pdf: tex/%.tex main.tex bibliography.bib | $(PDF_DIR)
	cd $(<D); $(LATEXMK) $(<F)
	@cp $(<D)/$(@F) $@
##
# Mathematicas
MATHEMATICA_INSTALLS := $(DIST_DIR)/wl_installed $(DIST_DIR)/alowk_installed $(DIST_DIR)/ahighk_installed $(DIST_DIR)/coefficient_installed
.PHONY: mathematicainstall ewjnnoiseInstall
mathematicainstall: $(MATHEMATICA_INSTALLS)
ewjnnoiseInstall: $(DIST_DIR)/ewjnwl_installed

$(DIST_DIR)/wl_installed: src/wl/namConductivity.wl | $(DIST_DIR)
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/wl_installed

$(DIST_DIR)/alowk_installed: src/wl/namAsymptoticLowKConductivity.wl | $(DIST_DIR)
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namAsymptoticLowKConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namAsymptoticLowKConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/alowk_installed

$(DIST_DIR)/ahighk_installed: src/wl/namAsymptoticHighKConductivity.wl | $(DIST_DIR)
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namAsymptoticHighKConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namAsymptoticHighKConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/ahighk_installed

$(DIST_DIR)/coefficient_installed: src/wl/namDielectricFunctionCoefficientApproximator.wl $(DIST_DIR)/alowk_installed $(DIST_DIR)/wl_installed | $(DIST_DIR)
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namDielectricFunctionCoefficientApproximator"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namDielectricFunctionCoefficientApproximator.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/coefficient_installed

$(DIST_DIR)/ewjnwl_installed: src/wl/ewjnNoise.wl $(DIST_DIR)/coefficient_installed | $(DIST_DIR)
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "ewjnNoise"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/ewjnNoise.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/ewjnwl_installed

### Convenience scripts for tidying tex
.PHONY: declutter
declutter:
	@rm -f $(TEX_DIR)/*.tdo
	@rm -f $(TEX_DIR)/*.run.xml
	@rm -f $(TEX_DIR)/*.bbl
	@rm -f *.tdo
	@rm -f *.run.xml
	@rm -f *.bbl

.PHONY: tidy
tidy: declutter
	@latexmk -c
	@cd $(TEX_DIR); latexmk -c
.PHONY: clean
clean: declutter
	rm -rf $(PDF_DIR)
	@latexmk -C
	@cd $(TEX_DIR); latexmk -C

.PHONY: listdeps
listdeps:
	@echo "Main pdf deps:"
	@echo $(MAIN_PDF_DEPS)
	@echo "All pdfs"
	@echo $(ALL_PDFS)

### Testing
.PHONY: test
test:
	$(WS) src/wltest/RunTests.wls