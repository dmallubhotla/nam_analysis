Needs["namDielectricFunctionCoefficientApproximator`"];

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

omega = 10^9;
tau = 10^-14;
vf = 2 * 10^6;
omegap = 3.5 * 10^15;
cLight = 3 * 10^8;
hbar = 1.05 * 10^-34;
e0 = 8.854*^-12;
tau = 10^-14;
Tc = 10^11;
(*T in Hz*)
temp = .8 * Tc;
dipoleMoment = 8.4 * 10^-30;

sigmaN[tauP_?NumericQ] := omegap^2 * tauP / (4 * Pi);

getq[u_?NumericQ] := u * omega / cLight;
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
epsEf[q_?NumericQ] := Piecewise[
	{
		{epsSeries[q, omega, vf, omegap, tau], q < 10^4},
		{epsL[q, omega, vf, omegap, tau], q >= 10^4}
	}
];

zetaPL[u_?NumericQ] := 2 * I *
		NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (epsEf[getq[u]] - u^2 - y^2)) + ((u^2) / (epsEf[getq[u]]))), {y, 0, Infinity}
		];
imrpL[u_?NumericQ] := With[
	{zp = zetaPL[u]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];
chiZZEUnitLessL[z_?NumericQ] := NIntegrate[
	u^2 * imrpL[u] * E^(-2 * u * z)
	, {u, 10, Infinity}
];

eps[u_?NumericQ, ufCutoff_?NumericQ, a_?NumericQ,
	b_?NumericQ, c_?NumericQ, d_?NumericQ, uL_?NumericQ] := Piecewise[
	{
		{-a + b *I, u < uL},
		{1 + ((-c) + (d)*I)/u, u >= uL && u < ufCutoff}
	},
	1
];
zetaP[u_?NumericQ, ufCutoff_?NumericQ, coeffs_] := 2 * I *
NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (eps[Sqrt[u^2 + y^2], ufCutoff, coeffs["a"], coeffs["b"], coeffs["c"],
				coeffs["d"], coeffs["uL"]] - u^2 - y^2)) + ((u^2) / (eps[Sqrt[u^2 + y^2], ufCutoff, coeffs["a"], coeffs["b"], coeffs["c"],
				coeffs["d"], coeffs["uL"]]))), {y, 0, Infinity}
		];
imrp[u_?NumericQ, ufCutoff_?NumericQ, coeffs_] := With[
	{zp = zetaP[u, ufCutoff, coeffs]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];
chiZZEUnitLess[z_?NumericQ, ufCutoff_?NumericQ, coeffs_] := NIntegrate[
	u^2 * imrp[u, ufCutoff, coeffs] * E^(-2 * u * z)
	, {u, 10, Infinity}
];

T1[c_?NumericQ] := (( hbar * e0 * cLight^3) / (dipoleMoment^2 * omega^3)) * (1/( c * Coth[omega/(2* temp)]));

dataNam1 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i, 10^25, namDielectricFunctionCoefficients[omega, sigmaN[10^(-18)], 10^(-18), vf, temp, Tc]]]]}, {i, -9, -5, .2}, DistributedContexts -> All];
dataNam2 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i, 10^25, namDielectricFunctionCoefficients[omega, sigmaN[10^(-16)], 10^(-16), vf, temp, Tc]]]]}, {i, -9, -5, .2}, DistributedContexts -> All];
dataNam3 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i, 10^25, namDielectricFunctionCoefficients[omega, sigmaN[10^(-14)], 10^(-14), vf, temp, Tc]]]]}, {i, -9, -5, .2}, DistributedContexts -> All];
dataNam4 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i, 10^25, namDielectricFunctionCoefficients[omega, sigmaN[10^(-12)], 10^(-12), vf, temp, Tc]]]]}, {i, -9, -5, .2}, DistributedContexts -> All];
data = {dataNam1, dataNam2, dataNam3, dataNam4};
Export[calc["NoCutT1ZE4.csv"], data];
