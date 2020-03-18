$(PDF_DIR)/convergence.pdf: $(TEX_DIR)/convergence.tex

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/convergence.tex
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/convergence.pdf
