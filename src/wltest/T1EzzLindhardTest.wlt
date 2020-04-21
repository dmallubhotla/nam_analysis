BeginTestSection["T1EzzLindhardTest.wlt"];

VerificationTest[(* 1 *)
	With[{
		params = <| "omegaSI" -> 1
			, "omegaPSI" -> 1
			, "tauSI" -> 1
			, "vFSI" -> 1
			, "TRel" -> 10^-5
			, "TcSI" -> 1
			, "dipoleMomentSI" -> 1
		|>,
		constants = <| "epsilon0SI" -> 1
			, "hbarSI" -> 1
			, "cLightSI" -> 1
		|>
	},
		T1EzzLin[1, params, constants]
	]
	,
	1/3
	, TestID -> "Checking that a very simple Lindhard calculation gives the expected results for T1 if we force chi to equal 3."
	, SameTest -> (Abs[#1 - #2] < 10^-4 &)
];

EndTestSection[];
