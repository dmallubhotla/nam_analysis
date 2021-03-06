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
(*T in Hz*)
temp = 10^11;
dipoleMoment = 8.4 * 10^-30;
eps1 = 1 + (1.25 * 10^8 * I);

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

getq[u_?NumericQ] := u * omega / cLight;

zetaP[u_?NumericQ] := 2 * I *
		NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (epsEf[getq[u]] - u^2 - y^2)) + ((u^2) / (epsEf[getq[u]]))), {y, 0, Infinity}
		];

imrp[u_?NumericQ] := With[
	{zp = zetaP[u]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];

chiZZEUnitLess[z_?NumericQ] := NIntegrate[
	u^2 * imrp[u] * E^(-2 * u * z)
	, {u, 10, Infinity}
];

zetaPLocal[u_?NumericQ] := 2 * I *
		NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (eps1 - u^2 - y^2)) + ((u^2) / (eps1))), {y, 0, Infinity}
		];
imrpLocal[u_?NumericQ] := With[
	{zp = zetaPLocal[u]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];
chiZZEUnitLessLocal[z_?NumericQ] := NIntegrate[
	u^2 * imrpLocal[u] * E^(-2 * u * z)
	, {u, 10, Infinity}
];


T1[c_?NumericQ] := (( hbar * e0 * cLight^3) / (dipoleMoment^2 * omega^3)) * (1/( c * Coth[omega/(2* temp)]));

dataLocal = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLessLocal[10^i]]]}, {i, -11, -2, .25}, DistributedContexts -> All];
dataLindhard = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i]]]}, {i, -11, -2, .25}, DistributedContexts -> All];
data = {dataLocal, dataLindhard};

Export[calc["T1ZELindhard.csv"], data];