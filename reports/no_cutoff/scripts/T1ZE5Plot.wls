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

label = AxesLabel -> {"z (um)", "T1(z, \[Omega]) (ns)"};
data = ToExpression[Import[calc["T1ZE5.csv"]]];
scaledData = Map[{10^6 * #[[1]], 10^9 * #[[2]]} &, data, {2}];

plot1 = ListLogLogPlot[scaledData, ImageSize->Large, label, PlotLegends -> { StringJoin["Lindhard, \[Omega]=", ToString[Superscript[10, 7], StandardForm]], StringJoin["Nam, \[Omega]=", ToString[Superscript[10, 7], StandardForm]], StringJoin["Lindhard, \[Omega]=", ToString[Superscript[10, 12], StandardForm]], StringJoin["Nam, \[Omega]=", ToString[Superscript[10, 12], StandardForm]]}];
Export[figure["T1ZE5.jpg"], plot1, ImageResolution -> 1200];
