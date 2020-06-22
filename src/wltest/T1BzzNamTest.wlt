BeginTestSection["T1BzzNamTest.wlt"];

VerificationTest[(* 1 *)
	With[{
		params = <| "omegaSI" -> 2.63708929*^11
			, "omegaPSI" -> 22*^15
			, "tauSI" -> 3.15*^-15
			, "vFSI" -> 2*^6
			, "TRel" -> .9999
			, "TcSI" -> 1*^11
			, "dipoleMomentSI" -> 9.27*^-24
		|>,
		constants = <| "epsilon0SI" -> 8.854*^-12
			, "hbarSI" -> 1.05*^-34
			, "cLightSI" -> 3*^8
		|>
	},
		T1BzzNam[2*10^-8, 7.155733215264628*^8, params, constants]
	]
	,
	0.00053031 (* Manually calculated via similar but separately written script *)
	, NIntegrate::ncvb
	, SameTest -> approxEqual
	, TestID -> "Nam T1B"
];

EndTestSection[];
