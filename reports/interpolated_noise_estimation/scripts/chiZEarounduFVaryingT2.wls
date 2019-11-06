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


zetaP[u_?NumericQ, ufCutoff_?NumericQ, eps_] := 2 * I *
NIntegrate[
	(1/(u^2 + y^2)) * (((y^2) / (eps[Sqrt[u^2 + y^2], ufCutoff] - u^2 - y^2)) + ((u^2) / (eps[Sqrt[u^2 + y^2], ufCutoff]))), {y, 0, Infinity}
];

imrp[u_?NumericQ, ufCutoff_?NumericQ, eps_] := With[
	{zp = zetaP[u, ufCutoff, eps]},
	Im[(Pi * I * u - zp) / (Pi * I * u + zp)]
];

chiZZEUnitLess[z_?NumericQ, ufCutoff_?NumericQ, eps_] := NIntegrate[
	u^2 * imrp[u, ufCutoff, eps] * E^(-2 * u * z)
	, {u, 10, Infinity}
];

e[T_] := piecewiseEps[namDielectricFunctionCoefficients[omega, sigmaN, tau, vf, T, Tc]];



label = AxesLabel -> {"z", "chiZE(z, T)"};

data = ParallelTable[{10^i, Quiet[chiZZEUnitLess[10^i, 10^8, e[j * Tc]]]}, {j, .65, .9, .05}, {i, -10, -2, .5}, DistributedContexts -> All];

plot1 = ListLogLogPlot[data, ImageSize->Large, PlotLegends -> PointLegend[Automatic, Table[ToString[j] <> " T_c", {j, .65, .9, .05}], LegendLabel -> "T"], label];
Export[figure["chiZEarounduFVaryingT2.jpg"], plot1, ImageResolution -> 1200];
