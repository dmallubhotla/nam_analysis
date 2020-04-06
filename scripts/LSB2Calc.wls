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
(*tau = 10^-14;*)
vf = 2 * 10^6;
omegap = 3.5 * 10^15;
cLight = 3 * 10^8;
hbar = 1.05 * 10^-34;
e0 = 8.854^-12;
(*tau = 10^-14;*)
Tc = 10^11;
(*T in Hz*)
temp = .8 * Tc;
dipoleMoment = 8.4 * 10^-30;

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
epsEf[q_?NumericQ, tauIn_?NumericQ] := Piecewise[
	{
		{epsSeries[q, omega, vf, omegap, tauIn], q < 10^4},
		{epsL[q, omega, vf, omegap, tauIn], q >= 10^4}
	}
];

zetaPL[u_?NumericQ, tauIn_?NumericQ] := 2 * I *
		NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (epsEf[getq[u], tauIn] - u^2 - y^2)) + ((u^2) / (epsEf[getq[u], tauIn]))), {y, 0, Infinity}
		];
imrpL[u_?NumericQ, tauIn_?NumericQ] := With[
	{zp = zetaPL[u, tauIn]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];
chiZZEUnitLessL[z_?NumericQ, tauIn_?NumericQ] := NIntegrate[
	u^2 * imrpL[u, tauIn] * E^(-2 * u * z)
	, {u, 10, Infinity}
];

T1[c_?NumericQ] := (( hbar * e0 * cLight^3) / (dipoleMoment^2 * omega^3)) * (1/( c * Coth[omega/(2* temp)]));

data = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLessL[10^i, 10^j]]]}, {j, -15, -13, .5}, {i, -11, 0, .07}, DistributedContexts -> All];
Export[calc["LSB2.csv"], data];
