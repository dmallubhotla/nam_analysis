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

label = AxesLabel -> {"z", "chiZE(z, \[Omega], T = .8 Tc)"};
data = ToExpression[Import[calc["chiZBarounduFVaryingFrequency.csv"]]];
Print[data];
plot1 = ListLogLogPlot[data, ImageSize->Large, PlotLegends -> PointLegend[Automatic, Table[Superscript[10, j], {j, 6, 11, .5}], LegendLabel -> "\[Omega]"], label];
Export[figure["chiZBarounduFVaryingFrequency.jpg"], plot1, ImageResolution -> 1200];
