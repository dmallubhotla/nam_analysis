Needs["namConductivity`"];

(* Populates the figures directory as ../figures *)
figuresDirectory = FileNameJoin[{
	ParentDirectory[
		DirectoryName[
			FileNameJoin[{
				Directory[],
				$ScriptCommandLine[[1]]
			}]
		]
	], "figures"
}];

figure[filename_] := FileNameJoin[{figuresDirectory, filename}];

label = AxesLabel -> {"\[Kappa]", "Im[\[CapitalSigma](\[Xi], \[Kappa])]"};

plot1 = ListPlot[{
	ParallelTable[{k, Im[\[CapitalSigma]ZeroTemp[1.5, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Im[\[CapitalSigma]ZeroTemp[2.5, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Im[\[CapitalSigma]ZeroTemp[3.5, k, 1]]}, {k, .25, 10, .2}]
}, ImageSize->Large, PlotLegends -> {"\[Xi] = 1.5", "\[Xi] = 2.5", "\[Xi] = 3.5"}, label];
Export[figure["ImT0V1vsKmultW.jpg"], plot1, ImageResolution -> 1200];