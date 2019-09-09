Needs["namAsymptoticLowKConductivity`"];
Needs["namConductivity`"];

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

eps1[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma]alk[.0073, u * .0000487161, 730, 0.58];
eps2[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma][.0073, u * .0000487161, 730, 0.58];

eps[u_?NumericQ] = Piecewise[{{eps1[u], u < 10^4}, {eps2[u], u >= 10^4}}];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (eps[u] - y^2 - u^2)) + (u^2 / (eps[u])))
	, {y, 0, Infinity}
];

rp[u_?NumericQ] := With[
	{z = zp[u]},
	(Pi * I * u - z) / (Pi * I * u + z)
];

data = ParallelTable[{10^j, Quiet[Re[rp[10^j]]]}, {j, 1, 40, .5}, DistributedContexts -> All];
Print[data];

plot1 = ListLogLogPlot[{
	data
	}, ImageSize->Large, AxesLabel -> {"u", "Re[rp[u],z3"}];
Export[figure["ReRpZone3PiecewisePlot.jpg"], plot1, ImageResolution -> 1600];
