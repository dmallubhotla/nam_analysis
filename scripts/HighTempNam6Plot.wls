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

label = AxesLabel -> {"z (\[Mu]\[Lambda])", "T (ns)"};
data = ToExpression[Import[calc["HighTempNam6.csv"]]];
scaledData = Map[{10^6 * #[[1]], 10^9 * #[[2]]} &, data, {2}];
plot1 = ListLogLogPlot[scaledData, ImageSize->Large, label, PlotLegends -> {"Nam T=.9", "Nam T=.99", "Nam T=.999", "Lindhard"}, Joined -> True];
Export[figure["HighTempNam6.jpg"], plot1, ImageResolution -> 1200];
