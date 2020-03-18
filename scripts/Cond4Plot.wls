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

label = AxesLabel -> {"q", StringForm["Re[\[Epsilon](q, \[Omega] = ``)]", Superscript[10, 9]]};
data = ToExpression[Import[calc["Cond4.csv"]]];
plot1 = ListLogLinearPlot[data, ImageSize->Large, label, PlotLegends -> {"Lindhard", "Nam Interpolated", "Nam Full"	}, ImagePadding -> {{50, Automatic}, {Automatic, Automatic}}];

Export[figure["Cond4.jpg"], plot1, ImageResolution -> 1200];
