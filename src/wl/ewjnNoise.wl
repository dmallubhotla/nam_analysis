BeginPackage["ewjnNoise`"(*, {(*{"namConductivity`", "namAsymptoticLowKConductivity`"}*)}*)];

T1EzzNam::usage = "T1EzzNam[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Nam calculation with interpolation.";
T1EzzLin::usage = "T1EzzLin[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Lindhard calculation.";

namEwjnConstants::usage = "Constants that represent common universal constants in SI units.";
namEwjnPbBasicParameters::usage = "Values of some common realistic parameters that could change experiment to experiment.";

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
] := With[{
	chiSI = chiZZEUnitLessL[zSI, omegaSI, vFSI, omegaPSI, tauSI, cLightSI]
},
	((hbarSI * epsilon0SI * cLightSI^3) / (dipoleMomentSI^2 * omegaSI^3)) * (1/(chiSI * Coth[omegaSI/(2 * TRel * TcSI)]))
];


(* Lindhard internal functions *)
(* FIXME: later got stuff *)
getq[u_?NumericQ, omega_?NumericQ, cLight_?NumericQ] := getq[u, omega, cLight] = u * omega / cLight;
(* NORMAL METAL *)
epsL[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[
	{
		u = (vfP * qP) / omegaP,
		s = 1/(tauP * omegaP),
		prefactor = 3 * (omegapP^2) / (omegaP^2)
	},
	1 + ((prefactor) / (u^2)) * (1 + ((1 + I * s) / (2 * u)) * Log[(1 - u + I * s) / (1 + u + I * s)]) / (1 + ((I * s) / (2 * u)) * Log[(1 - u + I * s) / (1 + u + I * s)])
];
epsSeries[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[
	{
		u = (vfP * qP) / omegaP,
		s = 1/(tauP * omegaP),
		prefactor = 3 * (omegapP^2) / (omegaP^2)
	},
	1 + ((prefactor)) ((I / (3 * (s - I))) + u^2 * (-9 * I + 5 * s)/ (45 * (-I + s)^3))
];
epsEf[q_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ] := epsEf[q, omega, vf, omegap, tau] = Piecewise[
	{
		{epsSeries[q, omega, vf, omegap, tau], q < 10^4},
		{epsL[q, omega, vf, omegap, tau], q >= 10^4}
	}
];

zetaPL[u_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ, cLight_?NumericQ] := zetaPL[u, omega, vf, omegap, tau, cLight] = With [{q = getq[u, omega, cLight]},
	2 * I *
		NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (epsEf[q, omega, vf, omegap, tau] - u^2 - y^2)) + ((u^2) / (epsEf[q, omega, vf, omegap, tau]))), {y, 0, Infinity}
		]];
imrpL[u_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ, cLight_?NumericQ] := imrpL[u, omega, vf, omegap, tau, cLight] = With[
	{zp = zetaPL[u, omega, vf, omegap, tau, cLight]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];
chiZZEUnitLessL[z_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ, cLight_?NumericQ] := NIntegrate[
	u^2 * imrpL[u, omega, vf, omegap, tau, cLight] * E^(-2 * u * z)
	, {u, 10, Infinity}
];


(* Nam Implementation *)
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
namEwjnPbBasicParameters = <| "omegaSI" -> 10^9
	, "omegaPSI" -> 3.5 * 10^15
	, "tauSI" -> 10^-14
	, "vFSI" -> 2 * 10^6
	, "TRel" -> .8
	, "TcSI" -> 10^11
	, "dipoleMomentSI" -> 8.4 * 10^-30
|>;

namEwjnConstants = <| "epsilon0SI" -> 8.854* 10^-12
	, "hbarSI" -> 1.05 * 10^-34
	, "cLightSI" -> 3 * 10^8
|>;

End[]; (* `Private` *)

EndPackage[];