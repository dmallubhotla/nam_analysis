Needs["namConductivity`"];
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

eps1 = 1 + I * 4 * Pi * 10*^7 * (2.5815805439630966 + 303.36948179845047*I);
eps2[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma][.0073, u * .0000487161, 730, 0.58];

eps[u_?NumericQ] = Piecewise[{{eps1, u < 10^4}}, eps2[u]];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := 2 * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (eps[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (eps[Sqrt[u^2 + y^2]])))
	, {y, 0, Infinity}
];

rp[u_?NumericQ] := With[
	{z = zp[u]},
	(Pi * u - z) / (Pi * u + z)
];

(* gperp args lambda and relative dielectric constant *)
gs[l_?NumericQ] := (3/2) * NIntegrate[
	(u^2) * E^(-2 * l * u) * Im[(rp[u])]
	, {u, 10, 10^16}
	, MinRecursion -> 15, MaxRecursion -> 30
];
(* gperp args lambda and relative dielectric constant *)
gsShorter[l_?NumericQ] := (3/2) * NIntegrate[
	(u^2) * E^(-2 * 10^(-5) * u) *  Quiet[Im[rp[u]]]
	, {u, 10, 10^9}
];

Print[gsShorter[10^(-5)]];
Quit[];
data = ParallelTable[{l, Quiet[gs[l]]}, {l, 0, 1*^-4, 25*^-7}, DistributedContexts -> All];
Print[data];
plot1 = ListPlot[{
	data
	}, ImageSize->Large, AxesLabel -> {"z/\[Lambda]", "g\[Perpendicular],z3(z/\[Lambda])"}, AxesOrigin -> {0, 0}];
Export[figure["gPerpZone3_piecewise.jpg"], plot1, ImageResolution -> 1600];
