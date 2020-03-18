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

label = AxesLabel -> {"\[Xi]", "Re[\[CapitalSigma](\[Xi], \[Kappa] = 1)]"};

plot1 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 1, .5]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 1, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 1, 2]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}, label];
Export[figure["ReT0K1vsWmultV.jpg"], plot1, ImageResolution -> 1200];