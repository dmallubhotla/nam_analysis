Needs["namAsymptoticLowKConductivity`"];
Needs["namConductivity`"];

(* Populates the figures directory as ../calc *)
calculatedDirectory = FileNameJoin[{
	ParentDirectory[
		DirectoryName[
			FileNameJoin[{
				Directory[],
				$ScriptCommandLine[[1]]
			}]
		]
	], "calc"
}];

calc[filename_] := FileNameJoin[{calculatedDirectory, filename}];

eps1[u_?NumericQ] := 1 + I*4*Pi*10^7*\[CapitalSigma]alk[.0073, u*.0000487161, 730, 0.58];
eps2[u_?NumericQ] := 1 + I*4*Pi*10^7*\[CapitalSigma][.0073, u*.0000487161, 730, 0.58];
eps3[u_?NumericQ] := 1 + (-2.66909*10^18 + 2.29079*10^16 * I) / u;
eps[u_?NumericQ] = Piecewise[{{eps1[u], u < 10^6}, {eps3[u], u >= 10^16}}, eps2[u]];


zpIntegrand[u_, y_] = (1/(u^2 + y^2)) * ((y^2 / (eps[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (eps[Sqrt[u^2 + y^2]])));
(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (eps[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (eps[Sqrt[u^2 + y^2]])))
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
		, u^2 <= 10^32
	}
}]];

epsSimple[u_] = Piecewise[{{1 + (-2.66909*10^19 + 2.29079*10^17*I)/u, u >= 7*^7}}, -3.812449252701156`*^11 + 3.244107501348158`*^9 I];
zpSimple[u_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (epsSimple[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (epsSimple[Sqrt[u^2 + y^2]])))
	, {y, 0, Infinity}
];
(*data = ParallelTable[{10^j, Quiet[zp[10^j]]}, {j, 1, 30, .5}, DistributedContexts -> All];
Print[data];
Export[calc["zpDataZone3.csv"], data];

dataAlt = ParallelTable[{10^j, Quiet[zpAlt[10^j]]}, {j, 1, 30, .5}, DistributedContexts -> All];
Print[dataAlt];
Export[calc["zpDataAltZone3.csv"], dataAlt];*)

Print["simple calc..."];
dataSimple = ParallelTable[{10^j, Quiet[zpSimple[10^j]]}, {j, 1, 28, .5}, DistributedContexts -> All];
Print[dataSimple];
Export[calc["zpDataSimpleZone3.csv"], dataSimple];
