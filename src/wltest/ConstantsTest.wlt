BeginTestSection["ConstantsTest.wlt"];

VerificationTest[(* 1 *)
	namEwjnConstants["cLightSI"]
	,
	3 * 10^8
	, TestID -> "SI speed of light default check."
];

VerificationTest[(* 1 *)
	namEwjnPbBasicParameters["omegaSI"]
	,
	10^9
	, TestID -> "Check that our default omega is 1 GHz."
];

EndTestSection[];
