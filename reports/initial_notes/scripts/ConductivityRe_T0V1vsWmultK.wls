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

label = AxesLabel -> {"\[Xi]", "Re[\[CapitalSigma](\[Xi], \[Kappa])]"};

plot1 = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, .1, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 1, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 5, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 10, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, 20, 1]]}, {o, .25, 10, .2}]
}, ImageSize->Large, PlotLegends -> {"\[Kappa] = .1", "\[Kappa] = 1", "\[Kappa] = 5", "\[Kappa] = 10", "\[Kappa] = 20"}, label];
Export[figure["ReT0V1vsWmultK.jpg"], plot1, ImageResolution -> 1200];