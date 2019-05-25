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

plot2 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma][o, .1, .5, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, .1, 1, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, .1, 2, 1]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}];
Export[figure["ReT1K01vsW.jpg"], plot2, ImageResolution -> 1200];

plot3 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma][o, 1, .5, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 1, 1, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 1, 2, 1]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}];
Export[figure["ReT1K1vsW.jpg"], plot3, ImageResolution -> 1200];

plot4 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma][o, 10, .5, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 10, 1, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 10, 2, 1]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}];
Export[figure["ReT1K10vsW.jpg"], plot4, ImageResolution -> 1200];