BeginPackage["namDielectricFunctionCoefficientApproximator`", {"namConductivity`", "namAsymptoticLowKConductivity`"}];

namDielectricFunctionCoefficients::usage = "function of (omega, sigma_n, tau, vf, T_, Tc_), in SI units (or in units compatible with de-dimensionalisation";
piecewiseEps::usage = "takes in coefficients, spits out epsilon";
Begin["`Private`"];

makeParams[\[Omega]_, \[Sigma]n_, \[Tau]_, vf_, T_, Tc_] := With[
	{\[CapitalDelta] = 3.06 * Sqrt[Tc * (Tc - T)]},
	<|
		\[Xi] -> \[Omega] / \[CapitalDelta],
		\[Nu] -> 1 / (\[CapitalDelta] * \[Tau]),
		A -> \[Omega] * vf / (3*^8 * \[CapitalDelta]),
		t -> T / \[CapitalDelta],
		B -> \[Sigma]n / \[Omega]
	|>
];

smallMomentumCoefficients[params_] := With[
	{},
	s = \[CapitalSigma]alk[params[\[Xi]], 0, params[\[Nu]],
		params[t]] * 4 * Pi * I * params[B];
	<|
		a -> -Re[s],
		b -> Im[s]
	|>
];

bigMomentumCoefficients[params_] := With[
	{},
	s = \[CapitalSigma][params[\[Xi]], 10^8, params[\[Nu]],
		params[t]] * 4 * Pi * I * params[B] * 10^8 / params[A];
	<|
		c -> -Re[s],
		d -> Im[s]
	|>
];

namDielectricFunctionCoefficients[\[Omega]_, \[Sigma]n_, \[Tau]_, vf_, T_, Tc_] := With[
	{params = makeParams[\[Omega], \[Sigma]n, \[Tau], vf, T, Tc]},
	smallC = smallMomentumCoefficients[params];
	bigC = bigMomentumCoefficients[params];
	pa = smallC[a];
	pb = smallC[b];
	pc = bigC[c];
	pd = bigC[d];
	cutoff = Re[((-pc + I * pd)/(-pa + I * pb) )];
	<|
		"a" -> pa,
		"b" -> pb,
		"c" -> pc,
		"d" -> pd,
		"uL" -> cutoff
	|>
];

piecewiseEps[coefficients_] := With[
	{
		a = coefficients["a"],
		b = coefficients["b"],
		c = coefficients["c"],
		d = coefficients["d"],
		uL = coefficients["uL"]
	},
	Function[{u, ufCutoff},
		Piecewise[
			{
				{-a + b * I, u <  uL},
				{1 + (- c  + d * I) / u, u >=  uL&& u < ufCutoff}
			}, 1
			]
	]
];

End[];

EndPackage[];