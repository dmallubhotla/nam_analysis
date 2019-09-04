Needs["namAsymptoticLowKConductivity`"];


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

(* Manually calculated sigma from 0 to 10, pretty constant in that range *)
eps[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma]alk[.0073, u * .0000487161, 730, 0.58];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := (Pi * I * u / eps[u]) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (eps[u] - y^2 - u^2))
	, {y, 0, Infinity}
]);

rp[u_?NumericQ] := With[
	{z = zp[u]},
	(Pi * u - z) / (Pi * u + z)
];

data = ParallelTable[{10^j, Quiet[Im[rp[10^j]]]}, {j, 1, 9, .5}, DistributedContexts -> All];
Print[data];
plot1 = ListLogLogPlot[{
	data
	}, ImageSize->Large, AxesLabel -> {"u", "Im[rp[u],z3"}];
Export[figure["ImRpZone3Plot.jpg"], plot1, ImageResolution -> 1600];
