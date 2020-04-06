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

label = AxesLabel -> {"z", ""};
data = ToExpression[Import[calc["LSB2.csv"]]];
getExps[pts_] := With[{},
	ct = {
		Map[#[[1]] &, pts],
		MapThread[
				#2 / #1 &, {
				Map[Log, Ratios[Map[#[[1]] &, pts ]]],
				Map[Log, Ratios[Map[#[[2]] &, pts]]]
			}
		] (* This MapThread generates ratios of logs of ratios of successive points  *)
	};
	Transpose[Take[ct, All, Min[Length /@ ct]]]
];

expData = Map[getExps, data];

plot1 = ListLogLinearPlot[expData, ImageSize->Large, label, PlotLegends -> PointLegend[Automatic, Table[Superscript[10, j], {j, -15, -13, .5}], LegendLabel -> "\[Tau]"]];
Export[figure["LSB2.jpg"], plot1, ImageResolution -> 1200];
