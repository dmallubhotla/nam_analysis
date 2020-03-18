Needs["namConductivity`"];

(* Populates the figures directory as ../calc *)
calculatedDirectory = FileNameJoin[{
	ParentDirectory[
		DirectoryName[
			FileNameJoin[{
				Directory[],
				$ScriptCommandLine[[1]]
			}]
		]
	], "calc"
}];

calc[filename_] := FileNameJoin[{calculatedDirectory, filename}];

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

asymptoticPoints = ToExpression[Import[calc["ConductivityZone3AsymptoticForm.csv"]]];
realPoints1 = Map[{#[[1]], Re[#[[2]]]} &, asymptoticPoints];
normalPoints = ToExpression[Import[calc["ConductivityZone3Normal.csv"]]];
realPoints2 = Map[{#[[1]], Re[#[[2]]]} &, normalPoints];
asymptoticHighPoints = ToExpression[Import[calc["ConductivityZone3AsymptoticHighForm.csv"]]];
realPoints3 = Map[{#[[1]], Re[#[[2]]]} &, asymptoticHighPoints];

realPlot = ListLogLogPlot[{realPoints1, realPoints2, realPoints3}, ImageSize->Large, AxesLabel -> {"u", "Re[\[CapitalSigma]]"}, PlotLabels -> {"small k approx", "Nam form", "high k approx"}];
Export[figure["ConductivityZone3Real.jpg"], realPlot, ImageResolution -> 1200];
