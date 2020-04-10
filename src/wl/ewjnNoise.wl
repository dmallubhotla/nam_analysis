BeginPackage["ewjnNoise`", {(*{"namConductivity`", "namAsymptoticLowKConductivity`"}*)}];

T1EzzNam::usage = "T1EzzNam[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Nam calculation with interpolation.";
T1EzzLin::usage = "T1EzzLin[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Lindhard calculation.";

Begin["`Private`"];

requiredParams = {"omegaSI", "omegaPSI", "tauSI", "vFSI", "TRel", "TcSI", "dipoleMomentSI"};
requiredConstants = {"epsilon0SI", "hbarSI", "cLightSI"};

T1EzzLin[zSI_?NumericQ
	, parameters_?AssociationQ /; AllTrue[requiredParams, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
] := T1EzzLinINTERNAL[zSI
	, parameters["omegaSI"], parameters["omegaPSI"], parameters["tauSI"], parameters["vFSI"], parameters["TRel"], parameters["TcSI"], parameters["dipoleMomentSI"]
	, constants["epsilon0SI"], constants["hbarSI"], constants["cLightSI"]
];

T1EzzLinINTERNAL[zSI_?NumericQ
	, omegaSI_?NumericQ
	, omegaPSI_?NumericQ
	, tauSI_?NumericQ
	, vFSI_?NumericQ
	, TRel_?NumericQ
	, TcSI_?NumericQ
	, dipoleMomentSI_?NumericQ
	, epsilon0SI_?NumericQ
	, hbarSI_?NumericQ
	, cLightSI_?NumericQ
] := 3; (* TODO Implement this *)

T1EzzNam[zSI_?NumericQ
	, parameters_?AssociationQ /; AllTrue[requiredParams, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
] := T1EzzNamINTERNAL[zSI
	, parameters["omegaSI"], parameters["omegaPSI"], parameters["tauSI"], parameters["vFSI"], parameters["TRel"], parameters["TcSI"], parameters["dipoleMomentSI"]
	, constants["epsilon0SI"], constants["hbarSI"], constants["cLightSI"]
];

T1EzzNamINTERNAL[zSI_?NumericQ
	, omegaSI_?NumericQ
	, omegaPSI_?NumericQ
	, tauSI_?NumericQ
	, vFSI_?NumericQ
	, TRel_?NumericQ
	, TcSI_?NumericQ
	, dipoleMomentSI_?NumericQ
	, epsilon0SI_?NumericQ
	, hbarSI_?NumericQ
	, cLightSI_?NumericQ
] := 3; (* TODO finish this *)

(* Default parameters for typical usage *)
namewjnPbParameters = <| "omegaSI" -> 10^9
	, "omegaPSI" -> 3.5 * 10^15
	, "tauSI" -> 10^-14
	, "vFSI" -> 2 * 10^6
	, "TRel" -> .8
	, "TcSI" -> 10^11
	, "dipoleMomentSI" -> 8.4 * 10^-30
|>;

namewjnConstants = <| "epsilon0SI" -> 8.854* 10^-12
	, "hbarSI" -> 1.05 * 10^-34
	, "cLightSI" -> 3 * 10^8
|>;


EndPackage[];
