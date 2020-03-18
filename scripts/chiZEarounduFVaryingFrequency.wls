Needs["namDielectricFunctionCoefficientApproximator`"];

figuresDirectory = FileNameJoin[{
	ParentDirectory[
		DirectoryName[
			FileNameJoin[{
				Directory[],
				$ScriptCommandLine[[1]]
			}]
		]
	], "figures"
}];

figure[filename_] := FileNameJoin[{figuresDirectory, filename}];

omega = 10^9;
sigmaN = 10^16;
tau = 10^-14;
vf = 2 * 10^6;
Tc = 10^11;

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

label = AxesLabel -> {"z", "chiZE(z, \[Omega], T = .8 Tc)"};

data = ParallelTable[{10^i, Quiet[chiZZEUnitLess[10^i, 10^10, namDielectricFunctionCoefficients[10^j, sigmaN, tau, vf, .8 * Tc, Tc] ]]}, {j, 6, 11, .5}, {i, -10, -2, .5}, DistributedContexts -> All];

plot1 = ListLogLogPlot[data, ImageSize->Large, PlotLegends -> PointLegend[Automatic, Table[Superscript[10, j], {j, 6, 11, .5}], LegendLabel -> "\[Omega]"], label];
Export[figure["chiZEarounduFVaryingFrequency.jpg"], plot1, ImageResolution -> 1200];
