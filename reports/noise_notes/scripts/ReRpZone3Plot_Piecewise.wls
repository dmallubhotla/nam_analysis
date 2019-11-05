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

eps1[u_?NumericQ] := 1 + I*4*Pi*10^7*\[CapitalSigma]alk[.0073, u*.0000487161, 730, 0.58];
eps2[u_?NumericQ] := 1 + I*4*Pi*10^7*\[CapitalSigma][.0073, u*.0000487161, 730, 0.58];
eps3[u_?NumericQ] := 1 + (-2.66909*10^18 + 2.29079*10^16*I)/u;
eps[u_?NumericQ] = Piecewise[{{eps1[u], u < 10^6}, {eps3[u], u >= 10^16}}, eps2[u]];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (eps[u] - y^2 - u^2)) + (u^2 / (eps[u])))
	, {y, 0, Infinity}
];

zpUl[u_?NumericQ, ul_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (eps[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (eps[Sqrt[u^2 + y^2]])))
	, {y, 0, ul}
];

zpAlt[u_?NumericQ] := With[{ul = N[Sqrt[10^16 - u^2]]},
	2 * I * Piecewise[{
		{
			(u^2 (\[Pi] - 2 ArcTan[((-2.66909*10^19) + I (2.29079*10^17))/Sqrt[-((-2.66909*10^19) + I (2.29079*10^17))^2 + u^2]]))/(2 Sqrt[-((-2.66909*10^19) + I (2.29079*10^17))^2 + u^2])
			, u^2 > 10^32
		}, {
			(1/(2 Sqrt[-((-2.66909*10^19) + I (2.29079*10^17))^2 + u^2]))u^2 (\[Pi] - 2 ArcTan[((-2.66909*10^19) + I (2.29079*10^17))/Sqrt[-((-2.66909*10^19) + I (2.29079*10^17))^2 + u^2]] - 2 ArcTan[Sqrt[100000000000000000000000000000000 - u^2]/ Sqrt[-((-2.66909*10^19) + I (2.29079*10^17))^2 + u^2]] + 2 ArcTan[(((-2.66909*10^19) + I (2.29079*10^17)) Sqrt[100000000000000000000000000000000 - u^2])/(10000000000000000 Sqrt[-((-2.66909*10^19) + I (2.29079*10^17))^2 + u^2])])
					+ zpUl[u, ul]
			, 10^14 < u^2 <= 10^32
		}
	}, zp[u]
	]
];

rp[u_?NumericQ] := With[
	{z = zpAlt[u]},
	(Pi * I * u - z) / (Pi * I * u + z)
];

data = ParallelTable[{10^j, Quiet[Re[rp[10^j]]]}, {j, 1, 24, .5}, DistributedContexts -> All];
Print[data];

Print[TemplateApply["Will output figures to directory ``", figuresDirectory]];

plot1 = ListLogLogPlot[{
	data
}, ImageSize->Large, AxesLabel -> {"u", "Re[rp[u],z3"}];
Export[figure["ReRpZone3PiecewisePlot.jpg"], plot1, ImageResolution -> 1600];
