BeginPackage["ewjnNoise`", {(*{"namConductivity`", "namAsymptoticLowKConductivity`"}*)}];

T1EzzNam::usage = "T1EzzNam[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Nam calculation with interpolation.";
T1EzzLin::usage = "T1EzzLin[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Lindhard calculation.";

Begin["`Private`"];

requiredLinParams = {"omegaSI", "omegaPSI", "tauSI", "vFSI", "TSI", "dipoleMomentSI"};
requiredNamParams = {"omegaSI", "omegaPSI", "tauSI", "vFSI", "TSI", "TcSI", "dipoleMomentSI"};
requiredConstants = {"epsilon0SI", "hbarSI", "cLightSI"};

T1EzzLin[zSI_?NumericQ
	, parameters_?AssociationQ /; AllTrue[requiredLinParams, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
] := T1EzzLinINTERNAL[zSI
	, parameters["omegaSI"], parameters["omegaPSI"], parameters["tauSI"], parameters["vFSI"], parameters["TSI"], parameters["dipoleMomentSI"]
	, constants["epsilon0SI"], constants["hbarSI"], constants["cLightSI"]
];

T1EzzLinINTERNAL[zSI_?NumericQ
	, omegaSI_?NumericQ
	, omegaPSI_?NumericQ
	, tauSI_?NumericQ
	, vFSI_?NumericQ
	, TSI_?NumericQ
	, dipoleMomentSI_?NumericQ
	, epsilon0SI_?NumericQ
	, hbarSI_?NumericQ
	, cLightSI_?NumericQ
] := 3;

T1EzzNam[zSI_?NumericQ
	, parameters_?AssociationQ /; AllTrue[requiredNamParams, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
] := T1EzzNamINTERNAL[zSI
	, parameters["omegaSI"], parameters["omegaPSI"], parameters["tauSI"], parameters["vFSI"], parameters["TSI"], parameters["TcSI"], parameters["dipoleMomentSI"]
	, constants["epsilon0SI"], constants["hbarSI"], constants["cLightSI"]
];

T1EzzNamINTERNAL[zSI_?NumericQ
	, omegaSI_?NumericQ
	, omegaPSI_?NumericQ
	, tauSI_?NumericQ
	, vFSI_?NumericQ
	, TSI_?NumericQ
	, TcSI_?NumericQ
	, dipoleMomentSI_?NumericQ
	, epsilon0SI_?NumericQ
	, hbarSI_?NumericQ
	, cLightSI_?NumericQ
] := 3;

(* TODO: Include default SI constants! Also include default Pb parameters *)

EndPackage[];