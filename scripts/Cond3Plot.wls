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

label = AxesLabel -> {"q", StringForm["Im[\[Epsilon](q, \[Omega] = ``)]", Superscript[10, 6]]};
data = ToExpression[Import[calc["Cond3.csv"]]];
plot1 = ListLogLogPlot[data, ImageSize->Large, label, PlotLegends -> {"Lindhard", "Nam", "Nam Small k"}, ImagePadding -> {{50, Automatic}, {Automatic, Automatic}}];

Export[figure["Cond3.jpg"], plot1, ImageResolution -> 1200];
