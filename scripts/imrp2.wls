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

eps[u_?NumericQ, ufCutoff_?NumericQ] := Piecewise[
	{
		{-3.812449252701156`*^10 + 3.244107501348158`*^8 I, u <  7*^7},
		{1 + ((-2.66909*10^18) + (2.29079*10^16) * I) / u, u >=  7*^7 && u < ufCutoff}
	}, 1 +  ufCutoff^2/(u^2)
];

zetaP[u_?NumericQ, ufCutoff_?NumericQ] := 2 * I *
	NIntegrate[
		(1/(u^2 + y^2)) * (((y^2) / (eps[Sqrt[u^2 + y^2], ufCutoff] - u^2 - y^2)) + ((u^2) / (eps[Sqrt[u^2 + y^2], ufCutoff]))), {y, 0, Infinity}
	];

imrp[u_?NumericQ, ufCutoff_?NumericQ] := With[
	{zp = zetaP[u, ufCutoff]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];

figure[filename_] := FileNameJoin[{figuresDirectory, filename}];



label = AxesLabel -> {"u", "u^2 * imrp(u)"};

data = ParallelTable[{10^i, 10^(2 * i) * Quiet[imrp[10^i, 10^j]]}, {j, 15, 27, 3}, {i, 4, 30, .5}];

plot1 = ListLogLogPlot[data, ImageSize->Large, PlotLegends -> PointLegend[Automatic, Table[Superscript[10, j], {j, 15, 27, 3}], LegendLabel -> Subscript["u", "uc"]], label];
Export[figure["imrp2.jpg"], plot1, ImageResolution -> 1200];
