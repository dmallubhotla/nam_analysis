Needs["namConductivity`"];
Needs["namAsymptoticLowKConductivity`"];
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
qUsed = 0;
tau = 10^-14;
vf = 2 * 10^6;
omegap = 3.5 * 10^15;
cLight = 3 * 10^8;
hbar = 1.05 * 10^-34;
e0 = 8.854^-12;
tau = 10^-14;
tempC = 10^11;
(*T in Hz*)
temp = .1 * tempC;

sigmaN = omegap^2 * tau	 / (4 * Pi);


(* NORMAL METAL *)
(*epsL[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[*)
	(*{*)
		(*u = (vfP * qP) / omegaP,*)
		(*s = 1/(tauP * omegaP),*)
		(*prefactor = 3 * (omegapP^2) / (omegaP^2)*)
	(*},*)
	(*1 + ((prefactor) / (u^2)) * (1 + ((1 + I * s) / (2 * u)) * Log[(1 - u + I * s) / (1 + u + I * s)]) / (1 + ((I * s) / (2 * u)) * Log[(1 - u + I * s) / (1 + u + I * s)])*)
(*];*)
epsSeries[qP_?NumericQ, omegaP_?NumericQ, vfP_?NumericQ, omegapP_?NumericQ, tauP_?NumericQ] := With[
	{
		u = (vfP * qP) / omegaP,
		s = 1/(tauP * omegaP),
		prefactor = 3 * (omegapP^2) / (omegaP^2)
	},
	1 + ((prefactor)) ((I / (3 * (s - I))) + u^2 * (-9 * I + 5 * s)/ (45 * (-I + s)^3))
];
epsEf[w_?NumericQ] := Piecewise[
	{
		{epsSeries[qUsed, w, vf, omegap, tau], qUsed < 10^4},
		{epsL[qUsed, w, vf, omegap, tau], q >= 10^4}
	}
];


getu[q_?NumericQ] := q * cLight / omega;
epsInterpolatedInternal[q_?NumericQ, ufCutoff_?NumericQ, coefficients] := With[{
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
epsInterpolated[w_?NumericQ] := With[{
	coefficients = namDielectricFunctionCoefficients[w, sigmaN, tau, vf, temp, tempC]
},
	- coefficients["a"] + I * coefficients["b"]
];

dataLindhard = ParallelTable[{i * 10^11, Re[epsEf[i * 10^11]]}, {i, 10, 20, 1}, DistributedContexts -> All];
dataNamInterp = ParallelTable[{i * 10^11, Re[epsInterpolated[i * 10^11]]}, {i, 10, 20, 1}, DistributedContexts -> All];

data = {dataLindhard, dataNamInterp};
Export[calc["local2.csv"], data];