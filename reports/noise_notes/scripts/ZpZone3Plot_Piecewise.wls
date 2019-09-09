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


eps1[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma]alk[.0073, u * .0000487161, 730, 0.58];
eps2[u_?NumericQ] := 1 + I * 4 * Pi * 10*^7 * \[CapitalSigma][.0073, u * .0000487161, 730, 0.58];

eps[u_?NumericQ] = Piecewise[{{eps1[u], u < 10^4}, {eps2[u], u >= 10^4}}];

(* Only plugging in constants so we can do that one term analytically*)
zp[u_?NumericQ] := 2 * I * NIntegrate[
	(1/(u^2 + y^2)) * ((y^2 / (eps[Sqrt[u^2 + y^2]] - y^2 - u^2)) + (u^2 / (eps[Sqrt[u^2 + y^2]])))
	, {y, 0, Infinity}
];

data = ParallelTable[{10^j, Quiet[zp[10^j]]}, {j, 1, 30, .5}, DistributedContexts -> All];
Print[data];
Export[calc["zpDataZone3.csv"], data];
