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

figure[filename_] := FileNameJoin[{figuresDirectory, filename}];

(* Calculate *)
v[u_] = Sqrt[1 - u^2];


zs[u_?NumericQ, e_?NumericQ] := 2 * I * NIntegrate[
	1 / (e - u^2 - y^2)
	, {y, 0, Infinity}
];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ, e_?NumericQ] := (Pi * I * u / e) + (2 * I * NIntegrate[
	(1/(u^2 + y^2)) * (y^2 / (e - y^2 - u^2))
	, {y, 0, Infinity}
]);

rs[u_?NumericQ, e_?NumericQ] := With[
	{zv = zs[u, e] * v[u]},
	(zv - Pi) / (zv + Pi)
];

rp[u_?NumericQ, e_?NumericQ] := With[
	{z = zp[u, e], vv = v[u]},
	(Pi * vv - z) / (Pi * vv + z)
];

(* gp args lambda and relative dielectric constant *)
gp[l_, e_] := (3/4) * NIntegrate[
	Re[
		(u / v[u]) * E^(2 * I * l * v[u]) * (rs[u, e] + (u^2 - 1 ) * rp[u, e])
	]
	, {u, 0, Infinity}
];


plot1 = ListPlot[{
	ParallelTable[{l, Quiet[gp[l, 1 + 10 * I]]}, {l, 0, 5, .1}],
	ParallelTable[{l, Quiet[gp[l, 1 + 100 * I]]}, {l, 0, 5, .1}],
	ParallelTable[{l, Quiet[gp[l, 1 + 10000 * I]]}, {l, 0, 5, .1}],
	ParallelTable[{l, ((3/2)/ ((2*l)^3)) * (Sin[2*l] - (2*l) * Cos[2*l] - (2*l)^2 Sin[2*l])}, {l, 0, 5, .05}]
}, ImageSize->Large, PlotLegends -> {"10i", "100i", "10000i", "Fresnelanytic"}, AxesLabel -> {"\[Lambda]", "g\[DoubleVerticalBar](\[Lambda])"}, Joined -> True];
Export[figure["SampleElectricNoiseZetaPerfectConductor.jpg"], plot1, ImageResolution -> 1600];

(*
plot1 = Plot[{
	gp[l, 1 + 10 * I],
	gp[l, 1 + 100 * I],
	gp[l, 1 + 10000 * I],
	((3/2)/ ((2*l)^3)) * (Sin[2*l] - (2*l) * Cos[2*l] - (2*l)^2 Sin[2*l])
}, {l, 0, 5}, ImageSize->Large, PlotLegends -> {"10i", "100i", "10000i", "Fresnelanytic"}, AxesLabel -> {"\[Lambda]", "g\[DoubleVerticalBar](\[Lambda])"}];
Export[figure["SampleElectricNoiseZetaPerfectConductor.jpg"], plot1, ImageResolution -> 1600]; *)
