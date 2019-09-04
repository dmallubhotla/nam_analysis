(* :Title: namConductivity *)
(* :Context: namConductivity` *)
(* :Author: Deepak *)
(* :Date: 2019-05-23 *)

(* :Package Version: 0.1 *)
(* :Mathematica Version: *)
(* :Copyright: (c) 2019 Deepak *)
(* :Keywords: *)
(* :Discussion: *)

BeginPackage["namConductivity`"];
(* Exported symbols added here with SymbolName::usage *)

\[CapitalSigma]::usage = "function of (omega, k, v, t) in dimensionless units";
\[CapitalSigma]ZeroTemp::usage = "function of (omega, k, v, t = 0) in dimensionless units";

Begin["`Private`"];

g[w_, wp_] := (wp*(w + wp) + 1) / (Sqrt[wp^2 - 1] * Sqrt[(w + wp)^2 - 1]);
S[k_, e0_, v_] := (1 / k) * (e0 - I * v);
F[k_, e_, v_] := With[
	{
		s = S[k, e, v]
	}, (1 / k) * (2 * s + ((1 - s^2) * Log[(s + 1) / (s - 1)]))
];


I1[w_, wp_, k_, v_] := With[
	{
		gv = g[w, wp],
		e1 = Sqrt[(w + wp)^2 - 1],
		e2 = Sqrt[wp^2 - 1]
	}, (F[k, Re[e1 - e2], Im[e1 + e2] + 2 * v] * (gv + 1)) + (F[k, Re[-e1 - e2], Im[e1 + e2]  + 2 * v] * (gv - 1))
];

I2[w_, wp_, k_, v_] := With[
	{
		gv = g[w, wp],
		e1 = Sqrt[(w + wp)^2 - 1],
		e2 = Sqrt[wp^2 - 1]
	}, (F[k, Re[e1 - e2], Im[e1 + e2]  + 2 * v] * (gv + 1)) + (F[k, Re[e1 + e2], Im[e1 + e2]  + 2 * v] * (gv - 1))
];

A[w_, k_, v_, t_] := NIntegrate[
	Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v],
	{wp, 1 - w, 1}, MaxRecursion -> 15
];

Bint[w_, wp_, k_, v_, t_] := Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v] - Tanh[(wp) / (2 t)] * I2[w, wp, k, v];

B[w_, k_, v_, t_, max_] := NIntegrate[Bint[w, wp, k, v, t], {wp, 1, max}, MaxRecursion -> 15];

(* Zero K variants *)
(*
S[k_, e0_, v_] := (1 / k) * (e0 - I * v);
F[k_, e_, v_] := With[
	{
		s = S[k, e, v]
	}, (1 / k) * (2 * s + ((1 - s^2) * Log[(s + 1) / (s - 1)]))
];


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
	{wp, 1 - w, 1}
];

Bint[w_, wp_, k_, v_, t_] := Tanh[(w + wp) / (2 t)] * I1[w, wp, k, v] - Tanh[(wp) / (2 t)] * I2[w, wp, k, v];

B[w_, k_, v_, t_, max_] := NIntegrate[Bint[w, wp, k, v, t], {wp, 1, max}, MaxRecursion -> 15];
*)

(* Zero Temp variants *)
AZeroTemp[w_, k_, v_] := NIntegrate[
	I1[w, wp, k, v],
	{wp, 1 - w, 1}, MaxRecursion -> 15
];

BintZeroTemp[w_, wp_, k_, v_] := I1[w, wp, k, v] - I2[w, wp, k, v];

BZeroTemp[w_, k_, v_, max_] := NIntegrate[BintZeroTemp[w, wp, k, v], {wp, 1, max}, MaxRecursion -> 15];
(* end zero temp variants *)

\[CapitalSigma][w_, k_, v_, t_] := -I * (3 / 4) * (v / w) * (-A[w, k, v, t] + B[w, k, v, t, 1000000]);

\[CapitalSigma]ZeroTemp[w_, k_, v_] := -I * (3 / 4) * (v / w) * (-AZeroTemp[w, k, v] + BZeroTemp[w, k, v, 1000000]);

End[]; (* `Private` *)

EndPackage[];