BeginTestSection["UtilTestB.wlt"];

ps = <| "omegaSI" -> 2.63708929*^11
	, "omegaPSI" -> 22*^15
	, "tauSI" -> 3.15*^-15
	, "vFSI" -> 2*^6
	, "TRel" -> .9999
	, "TcSI" -> 1*^11
	, "dipoleMomentSI" -> 9.27*^-24
|>;
cs= <| "epsilon0SI" -> 8.854*^-12
	, "hbarSI" -> 1.05*^-34
	, "cLightSI" -> 3*^8
	, "electronMassSI" -> 9.10938356*10^-31
|>;

VerificationTest[
	getFermiWavevectorB[ps, cs]
	,
	1.727599*^10
	, SameTest -> approxEqual
	, TestID -> "Fermi Wavevector check B"
];

(* For speed reasons slower *)
VerificationTest[
	findCutoffB[ps, cs, AccuracyGoal -> 1, PrecisionGoal -> 1, MaxIterations -> 5]
	,
	5.7860963238968725*^9
	, {NIntegrate::ncvb, NIntegrate::slwcon}
	, SameTest -> approxEqual
	, TestID -> "Cutoff Numerical Solver B"
];

EndTestSection[];
