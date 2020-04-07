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

label = AxesLabel -> {"z", "T1"};
data = ToExpression[Import[calc["LSB2.csv"]]];

plot1 = ListLogLogPlot[data, ImageSize->Large, label, PlotLegends -> PointLegend[Automatic, Table[Superscript[10, j + 14], {j, -15, -13, .5}], LegendLabel -> "\[Tau]"]];
Export[figure["LSB2_2.jpg"], plot1, ImageResolution -> 1200];
