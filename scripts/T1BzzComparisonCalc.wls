Needs["ewjnNoiseT1Bzz`"];

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


(* somewhat arbitrary, but hand-experimenting suggested results weren't sensitive to this.
 * Fermi wavevector is around 10^10.
 *)
cutoff = 5.9`*^9;

(* From paper *)
zValue = 20*^-9;
magRange = {b, 1, 5, .25};
constants = <|
	"epsilon0SI" -> 8.854*^-12
	, "hbarSI" -> 1.05*^-34
	, "cLightSI" -> 3*^8
	, "electronMassSI" -> 9.10938356*10^-31
|>;

getOmega[B0_] := (2 * 9.27*^-24 / 1.05*^-34) * B0

getParams[B0_] := <|
	"omegaSI" -> getOmega[B0]
	, "omegaPSI" -> 22*^15
	, "tauSI" -> 3.15*^-15
	, "vFSI" -> 2*^6
	, "TRel" -> .9999
	, "TcSI" -> 1.6*^11
	, "dipoleMomentSI" -> 9.27*^-24
|>;

linValues = ParallelTable[{b, T1BzzLin[zValue, getParams[b], constants]}, magRange, DistributedContexts -> All]
linValuesDifferent = ParallelTable[{b, T1BzzLin[zValue, AssociateTo[getParams[b], "omegaPSI" -> 3*^15], constants]}, magRange, DistributedContexts -> All]
namValues = ParallelTable[{b, T1BzzNam[zValue, cutoff, getParams[b], constants]}, magRange, DistributedContexts -> All];
namValuesDifferent = ParallelTable[{b, T1BzzNam[zValue, cutoff, AssociateTo[getParams[b], "omegaPSI" -> 3*^15], constants]}, magRange, DistributedContexts -> All];

data = {linValues, linValuesDifferent, namValues, namValuesDifferent};
Export[calc["T1BzzComparison.csv"], data];
