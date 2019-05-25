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

label = AxesLabel -> {"\[Omega]", "Re[\[CapitalSigma](\[Omega], k)]"};

plot2 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma][o, .1, .5, 0.4]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, .1, 1,  0.4]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, .1, 2,  0.4]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT04K01vsW.jpg"], plot2, ImageResolution -> 1200];

plot3 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma][o, 1, .5, 0.4]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 1, 1,  0.4]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 1, 2,  0.4]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT04K1vsW.jpg"], plot3, ImageResolution -> 1200];

plot4 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma][o, 10, .5, 0.4]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 10, 1,  0.4]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma][o, 10, 2,  0.4]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT04K10vsW.jpg"], plot4, ImageResolution -> 1200];