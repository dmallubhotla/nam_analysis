Needs["ewjnNoise`"];

calcDirectory = FileNameJoin[{
	ParentDirectory[
		DirectoryName[
			FileNameJoin[{
				Directory[],
				$ScriptCommandLine[[1]]
			}]
		]
	], "calc"
}];

calc[filename_] := FileNameJoin[{calcDirectory, filename}];

rangespec = {zi, -8, -6, .2};
constants = namEwjnConstants;

(* Derived this in NB file, testing code *)
cutoff = 5.7860963238968725`*^9;

params1 = AssociateTo[namEwjnPbBasicParameters, "TRel" -> .9];
dataNam1 = ParallelTable[{10^zi, T1EzzNam[10^zi, cutoff, params1, constants]}, rangespec, DistributedContexts -> All];

params2 = AssociateTo[params1, "TRel" -> .99];
dataNam2 = ParallelTable[{10^zi, T1EzzNam[10^zi, cutoff, params2, constants]}, rangespec, DistributedContexts -> All];

params3 = AssociateTo[params2, "TRel" -> .999];
dataNam3 = ParallelTable[{10^zi, T1EzzNam[10^zi, cutoff, params3, constants]}, rangespec, DistributedContexts -> All];

dataLindhard = ParallelTable[{10^zi, T1EzzLin[10^zi, params3, constants]}, rangespec, DistributedContexts -> All];

data = {dataNam1, dataNam2, dataNam3, dataLindhard};
Export[calc["HighTempNam4.csv"], data];
