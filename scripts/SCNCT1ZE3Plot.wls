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

label = AxesLabel -> {"z", "T1(z, \[Omega])"};
data = ToExpression[Import[calc["SCNCT1ZE3.csv"]]];
plot1 = ListLogLogPlot[data, ImageSize->Large, label, PlotLegends -> {"Lindhard", "Nam 1", "Nam 2", "Nam 3"}];
Export[figure["SCNCT1ZE3.jpg"], plot1, ImageResolution -> 1200];
