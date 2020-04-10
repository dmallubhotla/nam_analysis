Needs["namConductivity`"];
(*Needs["namAsymptoticLowKConductivity`"];*)
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
tempC = 10^11;
(*T in Hz*)
temp = .8 * tempC;

sigmaN = omegap^2 * tau	 / (4 * Pi);


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


getu[q_?NumericQ] := q * cLight / omega;
coefficients = namDielectricFunctionCoefficients[omega, sigmaN, tau, vf, temp, tempC];
epsInterpolated[q_?NumericQ, ufCutoff_?NumericQ] := With[{
	a = coefficients["a"],
	b = coefficients["b"],
	c = coefficients["c"],
	d = coefficients["d"],
	uL = coefficients["uL"],
	u = getu[q]
}, Piecewise[{
	{-a + b *I, u < uL},
	{1 + ((-c) + (d)*I)/u, u >= uL && u < ufCutoff}
}, 1]
];

makeParams[\[Omega]_, \[Sigma]n_, \[Tau]_, vfp_, T_, Tc_] := With[
	{\[CapitalDelta] = 3.06 * Sqrt[Tc * (Tc - T)]},
	<|
		\[Xi] -> \[Omega] / \[CapitalDelta],
		\[Nu] -> 1 / (\[CapitalDelta] * \[Tau]),
		kc -> vfp / \[CapitalDelta],
		t -> T / \[CapitalDelta],
		B -> \[Sigma]n / \[Omega]
	|>
];
epsNam[q_?NumericQ] := With[
	{params = makeParams[omega, sigmaN, tau, vf, temp, tempC]},
	1 + 4 * Pi * I * params[B] * \[CapitalSigma][params[\[Xi]], q * params[kc], params[\[Nu]], params[t]]
];
epsNamSmallK[q_?NumericQ] := With[
	{params = makeParams[omega, sigmaN, tau, vf, temp, tempC]},
	1 + 4 * Pi * I * params[B] * \[CapitalSigma]alk[params[\[Xi]], q * params[kc], params[\[Nu]], params[t]]
];

dataLindhard = ParallelTable[{10^i, Re[epsEf[10^i]]}, {i, 2, 12, .5}, DistributedContexts -> All];
dataNamInterp = ParallelTable[{10^i, Re[epsInterpolated[10^i, 10^15]]}, {i, 2, 12, .5}, DistributedContexts -> All];
dataNam = ParallelTable[{10^i, Re[epsNam[10^i]]}, {i, 2, 12, .5}, DistributedContexts -> All];
(*dataNamSmallK = ParallelTable[{10^i, Re[epsNamSmallK[10^i]]}, {i, 2, 12, .5}, DistributedContexts -> All];*)

data = {dataLindhard, dataNamInterp, dataNam};
Export[calc["Cond4.csv"], data];