Needs["namConductivity`"];

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

dataNormal = ParallelTable[{10^j, Quiet[\[CapitalSigma][.0073, 10^j * .0000487161, 730, 0.58]]}, {j, 4, 20, .5}, DistributedContexts -> All];
Print[dataNormal];
Export[calc["ConductivityZone3BigU.csv"], dataNormal];
