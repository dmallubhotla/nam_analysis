BeginTestSection["UtilTest.wlt"];

VerificationTest[
	getFermiWavevector[namEwjnPbBasicParameters, namEwjnConstants]
	,
	1.727599*^10
	, SameTest -> approxEqual
	, TestID -> "Fermi Wavevector check"
];

EndTestSection[];
