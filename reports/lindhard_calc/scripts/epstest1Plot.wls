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

mkrl[lst_] := Map[{#[[1]], Re[#[[2]]]} &, lst];
mkim[lst_] := Map[{#[[1]], Im[#[[2]]]} &, lst];

label = AxesLabel -> {"q", "eps(q)"};
data = ToExpression[Import[calc["epstest1.csv"]]];
realPoints = mkrl[data];
(*Print[realPoints];*)
plot1 = ListLogLinearPlot[realPoints, ImageSize->Large, label];
Export[figure["epstest1.jpg"], plot1, ImageResolution -> 1200];
