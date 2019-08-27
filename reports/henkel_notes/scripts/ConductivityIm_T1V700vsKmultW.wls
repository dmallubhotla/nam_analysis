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
	ParallelTable[{k, Im[\[CapitalSigma][.01, k, 700, 1]]}, {k, .000025, .0005, .000005}],
	ParallelTable[{k, Im[\[CapitalSigma][.1, k, 700, 1]]}, {k, .000025, .0005, .000005}],
	ParallelTable[{k, Im[\[CapitalSigma][1, k, 700, 1]]}, {k, .000025, .0005, .000005}]
}, ImageSize->Large, PlotLegends -> {"\[Xi] = .01", "\[Xi] = .1", "\[Xi] = 1"}, label];
Export[figure["ImT1V700vsKmultW.jpg"], plot1, ImageResolution -> 1200];