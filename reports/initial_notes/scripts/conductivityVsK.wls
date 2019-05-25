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

plot = ListPlot[{
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, .01, .5]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, .01, 1]]}, {o, .25, 10, .2}],
	ParallelTable[{o, Re[\[CapitalSigma]ZeroTemp[o, .01, 2]]}, {o, .25, 10, .2}]
}, PlotLabels -> {"\[Nu] = .5", "\[Nu] = 1", "\[Nu] = 2"}];
Export[figure["T0K001vsW.jpg"], plot, ImageResolution -> 1200];