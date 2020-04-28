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
	6.21952*10^9
	, SameTest -> approxEqual
	, TestID -> "Cutoff Numerical Solver"
];

EndTestSection[];
