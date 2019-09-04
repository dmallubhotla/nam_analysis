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

Print[TemplateApply["Will output figures to directory ``", figuresDirectory]];

asymptoticPoints = ToExpression[Import[calc["ConductivityZone3AsymptoticForm.csv"]]];
realPoints1 = Map[{#[[1]], Re[#[[2]]]} &, asymptoticPoints];
imagPoints1 = Map[{#[[1]], Im[#[[2]]]} &, asymptoticPoints];
normalPoints = ToExpression[Import[calc["ConductivityZone3Normal.csv"]]];
realPoints2 = Map[{#[[1]], Re[#[[2]]]} &, normalPoints];
imagPoints2 = Map[{#[[1]], Im[#[[2]]]} &, normalPoints];

realPlot = ListLogLogPlot[{realPoints1, realPoints2}, ImageSize->Large, AxesLabel -> {"u", "Re[\[CapitalSigma]]"}, PlotLabels -> {"small k approx", "Nam form"}];
Export[figure["ConductivityZone3Real.jpg"], realPlot, ImageResolution -> 1200];

imPlot = ListLogLogPlot[{imagPoints1, imagPoints2}, ImageSize->Large, AxesLabel -> {"u", "Im[\[CapitalSigma]]"}, PlotLabels -> {"small k approx", "Nam form"}];
Export[figure["ConductivityZone3Imag.jpg"], imPlot, ImageResolution -> 1200];