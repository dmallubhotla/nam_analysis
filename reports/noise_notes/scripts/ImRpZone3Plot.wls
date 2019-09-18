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

(* Only plugging in constants so we can do that one term analytically*)
zp1[u_?NumericQ] := (Pi * I * u / eps1[u]) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (eps1[u] - y^2 - u^2))
	, {y, 0, Infinity}
]);

rp1[u_?NumericQ] := With[
	{z = zp1[u]},
	(Pi * u - z) / (Pi * u + z)
];

eps2[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma][.0073, u * .0000487161, 730, 0.58];

(* Only plugging in constants so we can do that one term analytically*)
zp2[u_?NumericQ] := (Pi * I * u / eps2[u]) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (eps2[u] - y^2 - u^2))
	, {y, 0, Infinity}
]);

rp2[u_?NumericQ] := With[
	{z = zp2[u]},
	(Pi * u - z) / (Pi * u + z)
];

data1 = ParallelTable[{10^j, Quiet[Im[rp1[10^j]]]}, {j, 1, 16, .5}, DistributedContexts -> All];
Print[data1];
data2 = ParallelTable[{10^j, Quiet[Im[rp2[10^j]]]}, {j, 1, 16, .5}, DistributedContexts -> All];
Print[data2];

plot1 = ListLogLogPlot[{
	data1,
	data2
	}, ImageSize->Large, AxesLabel -> {"u", "Im[rp[u],z3"}, PlotLabels -> {"asymptotic", "normal"}];
Export[figure["ImRpZone3Plot.jpg"], plot1, ImageResolution -> 1600];
