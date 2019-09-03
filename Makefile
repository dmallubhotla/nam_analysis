all: dist/wl_installed dist/lowk_installed reports
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
	touch dist/lowk_installed
