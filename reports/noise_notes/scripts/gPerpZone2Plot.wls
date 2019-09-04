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
eps[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * (2.5815805439630966 + 303.36948179845047*I);

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := (Pi * I * u / eps[u]) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (eps[u] - y^2 - u^2))
	, {y, 0, Infinity}
]);

rp[u_?NumericQ] := With[
	{z = zp[u], vv = Sqrt[u^2 - 1]},
	(Pi * vv - z) / (Pi * vv + z)
];

(* gp args lambda and relative dielectric constant *)
gs[l_?NumericQ] := (3/2) * NIntegrate[
	(u^3 / (Sqrt[u^2 - 1])) * E^(-2 * l * Sqrt[u^2 - 1]) * Im[(rp[u])]
	, {u, 1, 1.00000000078492467899909633937620063358570413059034365232946584001, 10}
];

plot1 = ListPlot[{
	ParallelTable[{l, Quiet[gs[l]]}, {l, 0, 1*^-4, 5*^-6}]
	}, ImageSize->Large, AxesLabel -> {"z/\[Lambda]", "g\[Perpendicular],z2(z/\[Lambda])"}, AxesOrigin -> {0, 0}];
Export[figure["gPerpZone2Plot.jpg"], plot1, ImageResolution -> 1600];
