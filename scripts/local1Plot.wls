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

label = AxesLabel -> {"\[Omega]", "Im[\[Epsilon](q = 0, \[Omega])]"};
data = ToExpression[Import[calc["local1.csv"]]];
plot1 = ListLogLogPlot[data, ImageSize->Large, label, PlotLegends -> {"Lindhard", "Nam Interpolated"}, ImagePadding -> {{50, Automatic}, {Automatic, Automatic}}];
Export[figure["local1.jpg"], plot1, ImageResolution -> 1200];
