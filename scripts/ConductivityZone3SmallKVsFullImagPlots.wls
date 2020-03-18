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
imagPoints1 = Map[{#[[1]], Im[#[[2]]]} &, asymptoticPoints];
normalPoints = ToExpression[Import[calc["ConductivityZone3Normal.csv"]]];
imagPoints2 = Map[{#[[1]], Im[#[[2]]]} &, normalPoints];
asymptoticHighPoints = ToExpression[Import[calc["ConductivityZone3AsymptoticHighForm.csv"]]];
imagPoints3 = Map[{#[[1]], Im[#[[2]]]} &, asymptoticHighPoints];


imPlot = ListLogLogPlot[{imagPoints1, imagPoints2, imagPoints3}, ImageSize->Large, AxesLabel -> {"u", "Im[\[CapitalSigma]]"}, PlotLabels -> {"small k approx", "Nam form", "high k approx"}];
Export[figure["ConductivityZone3Imag.jpg"], imPlot, ImageResolution -> 1200];
