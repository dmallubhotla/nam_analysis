Needs["namAsymptoticLowKConductivity`"];
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

dataAsymptoticLowK = ParallelTable[{10^j, Quiet[\[CapitalSigma]alk[.0073, 10^j * .0000487161, 730, 0.58]]}, {j, 1, 9, .5}, DistributedContexts -> All];
Print[dataAsymptoticLowK];
Export[calc["ConductivityZone3AsymptoticForm.csv"], dataAsymptoticLowK];

dataNormal = ParallelTable[{10^j, Quiet[\[CapitalSigma][.0073, 10^j * .0000487161, 730, 0.58]]}, {j, 1, 9, .5}, DistributedContexts -> All];
Print[dataNormal];
Export[calc["ConductivityZone3Normal.csv"], dataNormal];
