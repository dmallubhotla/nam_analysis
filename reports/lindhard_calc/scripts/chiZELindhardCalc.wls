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
c = 3 * 10^8;

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

getq[u_?NumericQ] := u * omega / c;

zetaP[u_?NumericQ, ufCutoff_?NumericQ, coeffs_] := 2 * I *
		NIntegrate[
			(1/(u^2 + y^2)) * (((y^2) / (epsEf[getq[u]] - u^2 - y^2)) + ((u^2) / (epsEf[getq[u]]))), {y, 0, Infinity}
		];

imrp[u_?NumericQ, ufCutoff_?NumericQ, coeffs_] := With[
	{zp = zetaP[u, ufCutoff, coeffs]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];

chiZZEUnitLess[z_?NumericQ, ufCutoff_?NumericQ, coeffs_] := NIntegrate[
	u^2 * imrp[u, ufCutoff, coeffs] * E^(-2 * u * z)
	, {u, 10, Infinity}
];


data = ParallelTable[{10^i, Quiet[chiZZEUnitLess[10^i, 10^j, coeffs ]]}, {j, 8, 12, .5}, {i, -10, -2, .5}, DistributedContexts -> All];

Export[calc["chiZELindhard.csv"], data];