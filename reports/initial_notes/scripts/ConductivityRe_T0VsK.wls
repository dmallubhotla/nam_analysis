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

plot4 = ListPlot[{
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[10, k, .5]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[10, k, 1]]}, {k, .25, 10, .2}],
	ParallelTable[{k, Re[\[CapitalSigma]ZeroTemp[10, k, 2]]}, {k, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT0W10vsK.jpg"], plot4, ImageResolution -> 1200];