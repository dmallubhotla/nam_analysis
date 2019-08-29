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

rp[u_, e_] := With[{V = v[u]}, (e* V - Sqrt[e - u^2]) / (e * V + Sqrt[e - u^2])];
rs[u_, e_] := With[{V = v[u]}, (V - Sqrt[e - u^2]) / (V + Sqrt[e - u^2])];

(* gp args lambda and relative dielectric constant *)
gp[l_, e_] := (3/4) * NIntegrate[
	Re[
		(u / v[u]) * E^(2 * I * l * v[u]) * (rs[u, e] + (u^2 - 1 ) * rp[u, e])
	]
	, {u, 0, Infinity}
];

plot1 = Plot[{
	gp[l, 1 + 10 * I],
	gp[l, 1 + 100 * I],
	gp[l, 1 + 10000 * I],
	((3/2)/ ((2*l)^3)) * (Sin[2*l] - (2*l) * Cos[2*l] - (2*l)^2 Sin[2*l])
}, {l, 0, 5}, ImageSize->Large, PlotLegends -> {"10i", "100i", "10000i", "Analytic"}, AxesLabel -> {"\[Lambda]", "g\[DoubleVerticalBar](\[Lambda])"}];
Export[figure["SampleElectricNoiseFresnelPerfectConductor.jpg"], plot1, ImageResolution -> 1600];
