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
e0 = 8.854^-12;
tau = 10^-14;
Tc = 10^11;
(*T in Hz*)
temp = .8 * Tc;
dipoleMoment = 8.4 * 10^-30;

sigmaN = omegap^2 * tau / (4 * Pi);

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

T1[c_?NumericQ, omega_?NumericQ] := (( hbar * e0 * cLight^3) / (dipoleMoment^2 * omega^3)) * (1/( c * Coth[omega/(2* temp)]));

dataNam1 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i * 10^6 / cLight, 10^25, namDielectricFunctionCoefficients[10^6, sigmaN, tau, vf, temp, Tc]], 10^6]]}, {i, -9, -5, .2}, DistributedContexts -> All];
dataNam2 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i * 10^8 / cLight, 10^25, namDielectricFunctionCoefficients[10^8, sigmaN, tau, vf, temp, Tc]], 10^8]]}, {i, -9, -5, .2}, DistributedContexts -> All];
dataNam3 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i * 10^9 / cLight, 10^25, namDielectricFunctionCoefficients[10^9, sigmaN, tau, vf, temp, Tc]], 10^9]]}, {i, -9, -5, .2}, DistributedContexts -> All];
dataNam4 = ParallelTable[{10^i, Quiet[T1[chiZZEUnitLess[10^i * 10^12 / cLight, 10^25, namDielectricFunctionCoefficients[10^12, sigmaN, tau, vf, temp, Tc]], 10^12]]}, {i, -9, -5, .2}, DistributedContexts -> All];
data = {dataNam1, dataNam2, dataNam3, dataNam4};
Export[calc["T1ZE3.csv"], data];
