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

eps[u_?NumericQ] := 1 + I * 4 * Pi * 10^7 * \[CapitalSigma][.0073, 4.87*^-5 * u, 730, 0.58];

epsDataZone1 = ParallelTable[{u, eps[u]}, {u, 0, 1, .05}];
Export[calc["epsDataZone1.csv"], epsDataZone1];

Quit[];