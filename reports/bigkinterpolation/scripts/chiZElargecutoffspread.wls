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
	}, 1
];


zetaP[u_?NumericQ, ufCutoff_?NumericQ] := 2 * I *
	NIntegrate[
		(1/(u^2 + y^2)) * (((y^2) / (eps[Sqrt[u^2 + y^2], ufCutoff] - u^2 - y^2)) + ((u^2) / (eps[Sqrt[u^2 + y^2], ufCutoff]))), {y, 0, Infinity}
	];

imrp[u_?NumericQ, ufCutoff_?NumericQ] := With[
	{zp = zetaP[u, ufCutoff]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];

chiZZEUnitLess[z_?NumericQ, ufCutoff_?NumericQ] := NIntegrate[
	u^2 * imrp[u, ufCutoff] * E^(-2 * u * z)
	, {u, 10, Infinity}
];

figure[filename_] := FileNameJoin[{figuresDirectory, filename}];



label = AxesLabel -> {"z", "chiZE(z)"};

data = ParallelTable[{10^i, Quiet[chiZZEUnitLess[10^i, 10^j]]}, {j, 5, 15, 2.5}, {i, -10, -4, 1}];

plot1 = ListLogLogPlot[data, ImageSize->Large, PlotLegends -> Table[j, {j, 5, 15, 2.5}], label];
Export[figure["chiZElargecutoffspread.jpg"], plot1, ImageResolution -> 1200];
