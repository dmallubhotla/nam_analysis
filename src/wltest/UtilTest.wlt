BeginTestSection["UtilTest.wlt"];

VerificationTest[
	getFermiWavevector[namEwjnPbBasicParameters, namEwjnConstants]
	,
	1.727599*^10
	, SameTest -> approxEqual
	, TestID -> "Fermi Wavevector check"
];

VerificationTest[
	findCutoff[namEwjnPbBasicParameters, namEwjnConstants]
	,
	5.7860963238968725`*^9;
	, SameTest -> approxEqual
	, TestID -> "Cutoff Numerical Solver"
];

EndTestSection[];
