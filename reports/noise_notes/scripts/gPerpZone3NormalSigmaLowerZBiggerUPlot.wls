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

(* Manually calculated sigma from 0 to 10, pretty constant in that range *)
eps1[u_?NumericQ] := 1 + I * 4 * Pi * 10^7 * \[CapitalSigma]alk[.0073, u * .0000487161, 730, 0.58];
eps2[u_?NumericQ] := 1 + I * 4 * Pi * 10^7 * \[CapitalSigma][.0073, u * .0000487161, 730, 0.58];
(* Only plugging in constants so we can do that one term analytically*)
zp1[u_?NumericQ] := (Pi * I * u / eps1[u]) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (eps1[u] - y^2 - u^2))
	, {y, 0, Infinity}
]);
zp2[u_?NumericQ] := (Pi * I * u / eps2[u]) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (eps2[u] - y^2 - u^2))
	, {y, 0, Infinity}
]);

rp1[u_?NumericQ] := With[
	{z = zp1[u]},
	(Pi * u - z) / (Pi * u + z)
];
rp2[u_?NumericQ] := With[
	{z = zp2[u]},
	(Pi * u - z) / (Pi * u + z)
];
(* TODO PLOT Rp in zone 3!!!!!!! *)
(* gperp args lambda and relative dielectric constant *)
gs1[l_?NumericQ] := (3/2) * NIntegrate[
	(u^2) * E^(-2 * l * u) * Im[(rp1[u])]
	, {u, 10, 10^4}
];

gs2[l_?NumericQ] := (3/2) * NIntegrate[
	(u^2) * E^(-2 * l * u) * Im[(rp2[u])]
	, {u, 10^4, 10^12}
];

gs[l_?NumericQ] := gs1[l] + gs2[l];

data = ParallelTable[{l, Quiet[gs[l]]}, {l, 0, 25*^-7, 25*^-8}, DistributedContexts -> All];
Print[data];
plot1 = ListPlot[{
	data
	}, ImageSize->Large, AxesLabel -> {"z/\[Lambda]", "g\[Perpendicular],z3(z/\[Lambda])"}, AxesOrigin -> {0, 0}];
Export[figure["gPerpZone3NormalKLowerZPlotBiggerU.jpg"], plot1, ImageResolution -> 1600];
