BeginPackage["ewjnNoiseT1Bzz`", {"namDielectricFunctionCoefficientApproximator`"}];

T1BzzNam::usage = "T1BzzNam[z, qCutoff, parameters, constants] takes in SI units, returns T1 in SI units. Uses Nam calculation with interpolation.";
T1BzzLin::usage = "T1BzzLin[z, parameters, constants] takes in SI units, returns T1 in SI units. Uses Lindhard calculation.";

namEwjnConstantsB::usage = "Constants that represent common universal constants in SI units.";
namEwjnPbBasicParametersB::usage = "Values of some common realistic parameters that could change experiment to experiment.";

getFermiWavevectorB::usage = "getFermiWavevectorB[parameters, constants] returns the approximate fermi wavevector in inverse meters";
findCutoffB::usage = "findCutoffB[parameters, constants] uses all parameters besides TRel";

Begin["`Private`"];

requiredParams = {"omegaSI", "omegaPSI", "tauSI", "vFSI", "TRel", "TcSI", "dipoleMomentSI"};
requiredParamsWithoutTRel = {"omegaSI", "omegaPSI", "tauSI", "vFSI", "TcSI", "dipoleMomentSI"};
requiredConstants = {"epsilon0SI", "hbarSI", "cLightSI"};

T1BzzLin[zSI_?NumericQ
	, parameters_?AssociationQ /; AllTrue[requiredParams, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
] := T1BzzLinINTERNAL[zSI
	, parameters["omegaSI"], parameters["omegaPSI"], parameters["tauSI"], parameters["vFSI"], parameters["TRel"], parameters["TcSI"], parameters["dipoleMomentSI"]
	, constants["epsilon0SI"], constants["hbarSI"], constants["cLightSI"]
];

T1BzzLinINTERNAL[zSI_?NumericQ
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
	chiSI = chiZZBUnitLessL[zSI * omegaSI / cLightSI, omegaSI, vFSI, omegaPSI, tauSI, cLightSI]
},
	((hbarSI * epsilon0SI * cLightSI^5) / (dipoleMomentSI^2 * omegaSI^3)) * (1/(chiSI * Coth[omegaSI/(2 * TRel * TcSI)]))
];


(* Lindhard internal functions *)
getq[u_?NumericQ, omega_?NumericQ, cLight_?NumericQ] := getq[u, omega, cLight] = u * omega / cLight;
(* NORMAL METAL *)
epsL[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[
	{
		u = (vfP * qP) / omegaP,
		s = 1/(tauP * omegaP),
		prefactor = 3 * (omegapP^2) / (omegaP^2)
	}, With [
	{
			f = (1 + ((1 + I * s) / (2 * u)) * Log[(1 - u + I * s) / (1 + u + I * s)])
	},
	1 + ((prefactor) / (u^2)) * ((1 + I * s) * f) / (1 + (I * s * f))
]];
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
epsT[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[
	{
		u = (vfP * qP) / omegaP,
		s = 1/(tauP * omegaP),
		prefactor = 3 * (omegapP^2) / (omegaP^2)
	}, With [
	{
			ftr = ((1 + I * s) / u) + ((((1 + I * s) / u)^2 - 1) / 2) * Log[(1 - u + I * s) / (1 + u + I * s)]
	},
	1 + (1 / 2) * (prefactor / u) * Conjugate@ftr
]];

(* THIS IS WRONG DO NOT USE *)
epsSeriesT[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[
	{
		u = (vfP * qP) / omegaP,
		s = 1/(tauP * omegaP),
		prefactor = 3 * (omegapP^2) / (omegaP^2)
	},
	1 + ((prefactor)) ((I / (3 * (s - I))) + u^2 * (-9 * I + 5 * s)/ (45 * (-I + s)^3))
];

(* SKIPPING THE SERIES FOR NOW *)
epsEfT[q_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ] := epsEfT[q, omega, vf, omegap, tau] = Piecewise[
	{
		{epsSeries[q, omega, vf, omegap, tau], q < 0},
		{epsT[q, omega, vf, omegap, tau], q >= 0}
	}
];


zetaSL[u_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ, cLight_?NumericQ] := zetaSL[u, omega, vf, omegap, tau, cLight] = With [{q = getq[u, omega, cLight]},
	2 * I *
		NIntegrate[
			 (1 / (epsEfT[q, omega, vf, omegap, tau] - u^2 - y^2)), {y, 0, Infinity}
		]];
imrsL[u_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ, cLight_?NumericQ] := imrsL[u, omega, vf, omegap, tau, cLight] = With[
	{zs = zetaSL[u, omega, vf, omegap, tau, cLight]},
	Im[(zs - (Pi / (I * u))) / (zs + (Pi / (I * u)))]
];
chiZZBUnitLessL[z_?NumericQ, omega_?NumericQ, vf_?NumericQ, omegap_?NumericQ, tau_?NumericQ, cLight_?NumericQ] := NIntegrate[
	u^2 * imrsL[u, omega, vf, omegap, tau, cLight] * E^(-2 * u * z)
	, {u, 10, Infinity}
];


(* Nam Implementation *)
T1BzzNam[zSI_?NumericQ
	, qCutoffSI_?NumericQ
	, parameters_?AssociationQ /; AllTrue[requiredParams, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
] := T1BzzNamINTERNAL[zSI
	, qCutoffSI
	, parameters["omegaSI"], parameters["omegaPSI"], parameters["tauSI"], parameters["vFSI"], parameters["TRel"], parameters["TcSI"], parameters["dipoleMomentSI"]
	, constants["epsilon0SI"], constants["hbarSI"], constants["cLightSI"]
];

T1BzzNamINTERNAL[zSI_?NumericQ
	, qCutoffSI_?NumericQ
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
	chiSI = chiZZBUnitLessNam[zSI * omegaSI / cLightSI, qCutoffSI * cLightSI / omegaSI, omegaSI, omegaPSI^2 * tauSI / (4 * Pi), tauSI, vFSI, TRel * TcSI, TcSI]
},
	((hbarSI * epsilon0SI * cLightSI^5) / (dipoleMomentSI^2 * omegaSI^3)) * (1/(chiSI * Coth[omegaSI/(2 * TRel * TcSI)]))
];


epsNam[u_?NumericQ, ufCutoff_?NumericQ, a_?NumericQ, b_?NumericQ, c_?NumericQ, d_?NumericQ, uL_?NumericQ] := Piecewise[
	{
		{-a + b *I, u < uL},
		{1 + ((-c) + (d)*I)/u, u >= uL && u < ufCutoff}
	},
	1
];
zetaS[u_?NumericQ, ufCutoff_?NumericQ, coeffs_] := 2 * I *
		NIntegrate[
			1 / (epsNam[Sqrt[u^2 + y^2], ufCutoff, coeffs["a"], coeffs["b"], coeffs["c"],
				coeffs["d"], coeffs["uL"]] - u^2 - y^2), {y, 0, Infinity}
		];
imrsNam[u_?NumericQ, ufCutoff_?NumericQ, coeffs_] := With[
	{zs = zetaS[u, ufCutoff, coeffs]},
	Im[(zs - (Pi / (I * u))) / (zs + (Pi / (I * u)))]
];
chiZZBUnitLessNam[z_?NumericQ, ufCutoff_?NumericQ, omega_?NumericQ, sigmaN_?NumericQ, tau_?NumericQ, vf_?NumericQ, temp_?NumericQ, Tc_?NumericQ] := With[{coeffs = namDielectricFunctionCoefficients[omega, sigmaN, tau, vf, temp, Tc]},
		NIntegrate[
			u^2 * imrsNam[u, ufCutoff, coeffs] * E^(-2 * u * z)
		, {u, 10, Infinity}
	]
];

(* Utility functions *)
(* Todo: replace with internal expanded function so that we can better use memoisation *)
getFermiWavevectorB[parameters_?AssociationQ /; AllTrue[{"vFSI"}, KeyExistsQ[parameters, #] &]
	, constants_?AssociationQ /; AllTrue[{"hbarSI", "electronMassSI"}, KeyExistsQ[constants, #] &]
] := getFermiWavevectorB[parameters, constants] = constants["electronMassSI"] * parameters["vFSI"] / constants["hbarSI"];


(* Default parameters for typical usage *)
namEwjnPbBasicParametersB = <| "omegaSI" -> 10^9
	, "omegaPSI" -> 3.5 * 10^15
	, "tauSI" -> 10^-14
	, "vFSI" -> 2 * 10^6
	, "TRel" -> .8
	, "TcSI" -> 10^11
	, "dipoleMomentSI" -> 8.4 * 10^-30
|>;

namEwjnConstantsB = <| "epsilon0SI" -> 8.854* 10^-12
	, "hbarSI" -> 1.0546 * 10^-34
	, "cLightSI" -> 3 * 10^8
	, "electronMassSI" -> 9.10938356 * 10^-31
|>;

(* Todo: replace with internal expanded function so that we can better use memoisation *)
findCutoffB[parameters_?AssociationQ /; AllTrue[requiredParamsWithoutTRel, KeyExistsQ[parameters, #] &]
	,	constants_?AssociationQ /; AllTrue[requiredConstants, KeyExistsQ[constants, #] &]
	, opts: OptionsPattern[{MaxIterations -> 20, PrecisionGoal -> 5, AccuracyGoal -> 5, NMinimize}]
] := findCutoffB[parameters, constants] = Module[{
	highTempParams = Append[parameters, "TRel" -> .9995]
	, fermiWavelength
	, target
	, lCutoff
	, m
},
	fermiWavelength = 1/(2*getFermiWavevectorB[highTempParams, constants]);
	target = T1BzzLin[fermiWavelength, highTempParams, constants];
	lCutoff = -Log[fermiWavelength];
	m = NMinimize[{
		Abs[
			Log[T1BzzNam[fermiWavelength, E^x, highTempParams, constants]] - Log[target]
		],
		(lCutoff - 4) < x < (lCutoff + 4)
	}, x
		, FilterRules[{opts}, Options[NMinimize]]
	];
	Print[m];
	E^x /. (Last[m])
];


End[]; (* `Private` *)

EndPackage[];
