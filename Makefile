all: dist/wl_installed dist/alowk_installed dist/ahighk_installed dist/coefficient_installed reports
	@echo "Done."

# Convenience targets
.PHONY: all reports

reports:
	$(MAKE) -C $@

dist:
	mkdir -p dist

dist/wl_installed: src/wl/namConductivity.wl | dist
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/wl_installed

dist/alowk_installed: src/wl/namAsymptoticLowKConductivity.wl | dist
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namAsymptoticLowKConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namAsymptoticLowKConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/alowk_installed

dist/ahighk_installed: src/wl/namAsymptoticHighKConductivity.wl | dist
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namAsymptoticHighKConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namAsymptoticHighKConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/ahighk_installed

dist/coefficient_installed: src/wl/namDielectricFunctionCoefficientApproximator.wl | dist
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namDielectricFunctionCoefficientApproximator"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namDielectricFunctionCoefficientApproximator.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/coefficient_installed
