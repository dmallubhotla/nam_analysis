BeginTestSection["T1EzzLindhardTest.wlt"];

VerificationTest[(* 1 *)
	With[{
		params = <| "omegaSI" -> 10^9
			, "omegaPSI" -> 3.5*^15
			, "tauSI" -> 1*^-14
			, "vFSI" -> 2*^6
			, "TRel" -> .8
			, "TcSI" -> 1*^11
			, "dipoleMomentSI" -> 8.4*^-30
		|>,
		constants = <| "epsilon0SI" -> 8.854*^-12
			, "hbarSI" -> 1.05*^-34
			, "cLightSI" -> 3*^8
		|>
	},
		T1EzzLin[10^-8, params, constants]
	]
	,
	1.14558*10^-7 (* Manually calculated via similar but separately written script *)
	, NIntegrate::ncvb
	, SameTest -> approxEqual
	, TestID -> "Lindhard T1"
];

EndTestSection[];
