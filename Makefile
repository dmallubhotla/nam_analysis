all: dist/wl_installed
	@echo "Done."

# Convenience targets
.PHONY: all

dist:
	mkdir -p dist

dist/wl_installed: dist src/wl/namConductivity.wl
	@$(eval MATHEMATICA_INSTALL_LOCATION=$(shell wolframscript -c 'FileNameJoin[{StringReplace[$$UserBaseDirectory, "\\" -> "/"], "Applications", "namConductivity"}, OperatingSystem -> "Unix"]'))
	mkdir -p $(MATHEMATICA_INSTALL_LOCATION)
	cp src/wl/namConductivity.wl $(MATHEMATICA_INSTALL_LOCATION)
	touch dist/wl_installed