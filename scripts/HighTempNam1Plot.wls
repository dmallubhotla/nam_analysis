
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

label = AxesLabel -> {"z", "T"};
data = ToExpression[Import[calc["HighTempNam1.csv"]]];

plot1 = ListLogLogPlot[data, ImageSize->Large, label, PlotLegends -> {"Nam .9", "Lindhard .9", "Nam .995", "Lindhard .995", "Nam .9995", "Lindhard .9995"}];
Export[figure["HighTempNam1.jpg"], plot1, ImageResolution -> 1200];
