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

eps = -3.81245193475268*^10+3.244109788820867*^8*I;

v[u_] = Sqrt[1 - u^2];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ, e_?NumericQ] := (Pi * I * u / e) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (e - y^2 - u^2))
	, {y, 0, Infinity}
]);

rp[u_?NumericQ, e_?NumericQ] := With[
	{z = zp[u, e], vv = v[u]},
	(Pi * vv - z) / (Pi * vv + z)
];

(* gp args lambda and relative dielectric constant *)
gs[l_] := (3/2) * NIntegrate[
	Re[
		(u^3 / v[u]) * E^(2 * I * l * v[u]) * (rp[u, eps])
	]
	, {u, 0, 1}
];

Print[rp[.5, eps]];

plot1 = ListPlot[{
	ParallelTable[{l, Quiet[gs[l]]}, {l, 0, 1*^-4, 1*^-6}]
	}, ImageSize->Large, AxesLabel -> {"z/\[Lambda]", "g\[Perpendicular],z1(z/\[Lambda])"}];
Export[figure["gPerpZone1Plot.jpg"], plot1, ImageResolution -> 1600];
