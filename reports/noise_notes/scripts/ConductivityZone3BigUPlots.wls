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

points = ToExpression[Import[calc["ConductivityZone3BigU.csv"]]];
realPoints = Map[{#[[1]], Re[#[[2]]]} &, points];
imagPoints = Map[{#[[1]], Im[#[[2]]]} &, points];

realPlot = ListLogLogPlot[realPoints, ImageSize->Large, AxesLabel -> {"u", "Re[\[CapitalSigma]]"}];
Export[figure["ConductivityZone3BigUReal.jpg"], realPlot, ImageResolution -> 1200];

imPlot = ListLogLogPlot[imagPoints, ImageSize->Large, AxesLabel -> {"u", "Im[\[CapitalSigma]]"}];
Export[figure["ConductivityZone3BigUImag.jpg"], imPlot, ImageResolution -> 1200];