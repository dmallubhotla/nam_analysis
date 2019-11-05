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

epsSimple[u_] = Piecewise[{{1 + (-2.66909*10^18 + 2.29079*10^16*I)/u, u >= 7*^7}}, -3.812449252701156`*^10 + 3.244107501348158`*^8 I];
zpSimple[u_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (epsSimple[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (epsSimple[Sqrt[u^2 + y^2]])))
	, {y, 0, Infinity},
	MaxRecursion -> 25, WorkingPrecision -> 20, PrecisionGoal -> 6
];

rp[u_?NumericQ] := With[
	{z = zpSimple[u]},
	(Pi * I * u - z) / (Pi * I * u + z)
];

(* TODO PLOT Rp in zone 3!!!!!!! *)
(* gp args lambda and relative dielectric constant *)
gs[l_?NumericQ] := (3/2) * NIntegrate[
	(u^2) * E^(-2 * l * u) * Im[(rp[u])]
	, {u, 10, 10^40}, MaxRecursion -> 15, AccuracyGoal -> 6
];


eps1 = -3.81245193475268*^11+3.244109788820867*^9*I;
v1[u_?NumericQ] = Sqrt[1 - u^2];
(* gp args lambda and relative dielectric constant *)
gs1[l_?NumericQ] := (3/2) * NIntegrate[
	Re[
		(u^3 / v1[u]) * E^(2 * I * l * v1[u]) * (rp[u])
	]
	, {u, 0, 1}
];


Print[{gs1[10^-5], gs[10^-5]}];
Print[{gs1[0], gs[0]}];
Quit[];
data = ParallelTable[{l, Quiet[gs[l]]}, {l, 0, 1*^-4, 25*^-6}, DistributedContexts -> All];
Print[data];
plot1 = ListPlot[{
	data
	}, ImageSize->Large, AxesLabel -> {"z/\[Lambda]", "g\[Perpendicular],z3(z/\[Lambda])"}, AxesOrigin -> {0, 0}];
Export[figure["gPerp_piecewise.jpg"], plot1, ImageResolution -> 1600];
