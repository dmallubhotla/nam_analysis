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

label = AxesLabel -> {"B0 (T)", "T1^-1 (Hz)"};
data = ToExpression[Import[calc["T1BzzComparison.csv"]]];

plot1 = ListLogLogPlot[Map[{#[[1]], 1/#[[2]]} &, data, {2}], ImageSize->Large, label, PlotLegends -> {"Lindhard", "Lindhard variant", "Nam", "Nam variant"}];
Export[figure["T1BzzComparison.jpg"], plot1, ImageResolution -> 1200];
