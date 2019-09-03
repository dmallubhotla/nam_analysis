BeginPackage["namAsymptoticLowKConductivity`"];
(* Exported symbols added here with SymbolName::usage *)

\[CapitalSigma]alk::usage = "function of (omega, k, v, t) in dimensionless units";

Begin["`Private`"];

g[w_, wp_] := (wp*(w + wp) + 1) / (Sqrt[wp^2 - 1] * Sqrt[(w + wp)^2 - 1]);
F[k_, e_, v_] := ((4 / 3) * 1 / (e - I * 2 * v)) + (4/ 15) * (1 / ((e - I * 2 * v)^2)) * k^2;


I1[w_, wp_, k_, v_] := With[
	{
		gv = g[w, wp],
		e1 = Sqrt[(w + wp)^2 - 1],
		e2 = Sqrt[wp^2 - 1]
	}, (F[k, Re[e1 - e2], Im[e1 + e2] + v] * (gv + 1)) + (F[k, Re[-e1 - e2], Im[e1 + e2]  + v] * (gv - 1))
];

I2[w_, wp_, k_, v_] := With[
	{
		gv = g[w, wp],
		e1 = Sqrt[(w + wp)^2 - 1],
		e2 = Sqrt[wp^2 - 1]
	}, (F[k, Re[e1 - e2], Im[e1 + e2]  + v] * (gv + 1)) + (F[k, Re[e1 + e2], Im[e1 + e2]  + v] * (gv - 1))
];

A[w_, k_, v_, t_] := NIntegrate[
	Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v],
	{wp, 1 - w, 1}, MaxRecursion -> 15
];

Bint[w_, wp_, k_, v_, t_] := Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v] - Tanh[(wp) / (2 t)] * I2[w, wp, k, v];

B[w_, k_, v_, t_, max_] := NIntegrate[Bint[w, wp, k, v, t], {wp, 1, max}, MaxRecursion -> 15];

\[CapitalSigma]alk[w_, k_, v_, t_] := -I * (3 / 4) * (v / w) * (-A[w, k, v, t] + B[w, k, v, t, 1000000]);

End[]; (* `Private` *)

EndPackage[];