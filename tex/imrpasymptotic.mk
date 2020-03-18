$(PDF_DIR)/imrpasymptotic.pdf: $(TEX_DIR)/imrpasymptotic.tex

MAIN_PDF_DEPS := $(MAIN_PDF_DEPS) $(TEX_DIR)/imrpasymptotic.tex
ALL_PDFS := $(ALL_PDFS) $(PDF_DIR)/imrpasymptotic.pdf
