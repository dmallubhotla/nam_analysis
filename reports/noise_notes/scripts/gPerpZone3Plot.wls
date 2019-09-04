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
(* TODO PLOT Rp in zone 3!!!!!!! *)
(* gp args lambda and relative dielectric constant *)
gs[l_?NumericQ] := (3/2) * NIntegrate[
	(u^2) * E^(-2 * l * u) * Im[(rp[u])]
	, {u, 10, 10^7}
];

plot1 = ListPlot[{
	ParallelTable[{l, Quiet[gs[l]]}, {l, 0, 1*^-4, 5*^-6}, DistributedContexts -> All]
	}, ImageSize->Large, AxesLabel -> {"z/\[Lambda]", "g\[Perpendicular],z3(z/\[Lambda])"}, AxesOrigin -> {0, 0}];
Export[figure["gPerpZone3Plot.jpg"], plot1, ImageResolution -> 1600];
