BeginTestSection["UtilTest.wlt"];

VerificationTest[
	getFermiWavevector[namEwjnPbBasicParameters, namEwjnConstants]
	,
	1.727599*^10
	, SameTest -> approxEqual
	, TestID -> "Fermi Wavevector check"
];

(* For speed reasons slower *)
(*VerificationTest[*)
(*	findCutoff[namEwjnPbBasicParameters, namEwjnConstants, AccuracyGoal -> 1, PrecisionGoal -> 1, MaxIterations -> 5]*)
(*	,*)
(*	5.7860963238968725*^9*)
(*	, {NIntegrate::ncvb, NIntegrate::slwcon}*)
(*	, SameTest -> approxEqual*)
(*	, TestID -> "Cutoff Numerical Solver"*)
(*];*)

EndTestSection[];
