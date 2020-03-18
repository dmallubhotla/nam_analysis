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

label = AxesLabel -> {"z (micro-wavelengths)", "T1(z, \[Omega]) (ns)"};
data = ToExpression[Import[calc["NoCutT1ZE4.csv"]]];
scaledData = Map[{10^6 * #[[1]], 10^9 * #[[2]]} &, data, {2}];

plot1 = ListLogLogPlot[scaledData, ImageSize->Large, label, PlotLegends -> PointLegend[Automatic, Map[Superscript[10, #] &, {-18, -16, -14, -12}], LegendLabel -> "\[Tau]"]];
Export[figure["NoCutT1ZE4.jpg"], plot1, ImageResolution -> 1200];
