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

zone1Points = ToExpression[Import[calc["epsDataZone1.csv"]]];
realPoints = Map[{#[[1]], Re[#[[2]]]} &, zone1Points];
imagPoints = Map[{#[[1]], Im[#[[2]]]} &, zone1Points];

realPlot = ListPlot[realPoints, ImageSize->Large, AxesLabel -> {"u", "Re[\[CapitalSigma]]"}];
Export[figure["epsZone1RealPlot.jpg"], realPlot, ImageResolution -> 1200];

imPlot = ListPlot[imagPoints, ImageSize->Large, AxesLabel -> {"u", "Im[\[CapitalSigma]]"}];
Export[figure["epsZone1ImagPlot.jpg"], imPlot, ImageResolution -> 1200];