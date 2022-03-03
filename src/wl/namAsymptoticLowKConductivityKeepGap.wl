BeginPackage["namAsymptoticLowKConductivityKeepGap`"];
(* Exported symbols added here with SymbolName::usage *)

\[CapitalSigma]alkKG::usage = "function of (omega, k, v, t) in dimensionless units";

Begin["`Private`"];

g[w_, wp_, d_] := (wp*(w + wp) + d^2) / (Sqrt[wp^2 - d^2] * Sqrt[(w + wp)^2 - d^2]);
F[k_, e_, v_] := ((4 / 3) * 1 / (e - I * v)) + (4/ 15) * (1 / ((e - I * v)^3)) * k^2;


I1[w_, wp_, k_, v_, d_] := With[
	{
		gv = g[w, wp, d],
		e1 = Sqrt[(w + wp)^2 - d^2],
		e2 = Sqrt[wp^2 - d^2]
	}, (F[k, Re[e1 - e2], Im[e1 + e2] + 2 * v] * (gv + 1)) + (F[k, Re[-e1 - e2], Im[e1 + e2]  + 2 * v] * (gv - 1))
];

I2[w_, wp_, k_, v_, d_] := With[
	{
		gv = g[w, wp, d],
		e1 = Sqrt[(w + wp)^2 - d^2],
		e2 = Sqrt[wp^2 - d^2]
	}, (F[k, Re[e1 - e2], Im[e1 + e2]  + 2 * v] * (gv + 1)) + (F[k, Re[e1 + e2], Im[e1 + e2]  + 2 * v] * (gv - 1))
];

A[w_, k_, v_, t_, d_] := NIntegrate[
	Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v, d],
	{wp, d - w, d}, MaxRecursion -> 15
];

Bint[w_, wp_, k_, v_, t_, d_] := Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v, d] - Tanh[(wp) / (2 t)] * I2[w, wp, k, v, d];

B[w_, k_, v_, t_, d_, max_] := NIntegrate[Bint[w, wp, k, v, t, d], {wp, d, max}, MaxRecursion -> 15];

\[CapitalSigma]alkKG[w_, k_, v_, t_, d_] := -I * (3 / 4) * (v / w) * (-A[w, k, v, t, d] + B[w, k, v, t, d, 1000000]);

End[]; (* `Private` *)

EndPackage[];