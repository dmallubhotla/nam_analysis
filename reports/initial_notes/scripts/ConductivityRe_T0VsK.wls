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

label = AxesLabel -> {"k", "Re[\[CapitalSigma](\[Omega], k)]"};

plot1 = ListPlot[{
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[.01, k, .5]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[.01, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[.01, k, 2]]}, {k, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT0W001vsK.jpg"], plot1, ImageResolution -> 1200];

plot2 = ListPlot[{
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[.1, k, .5]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[.1, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[.1, k, 2]]}, {k, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT0W01vsK.jpg"], plot2, ImageResolution -> 1200];

plot3 = ListPlot[{
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[1, k, .5]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[1, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[1, k, 2]]}, {k, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT0W1vsK.jpg"], plot3, ImageResolution -> 1200];

plot4 = ListPlot[{
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[10, k, .5]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[10, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[10, k, 2]]}, {k, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT0W10vsK.jpg"], plot4, ImageResolution -> 1200];