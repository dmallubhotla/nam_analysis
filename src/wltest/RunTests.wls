PrependTo[$Path, FileNameJoin[{FileNameDrop[ExpandFileName[First[$ScriptCommandLine]],-2], "wl"}]];
testDir = FileNameDrop[ExpandFileName[First[$ScriptCommandLine]],-1];
testFiles = FileNames["*.wlt", testDir];

<< "ewjnNoise`";

reports = TestReport /@ testFiles;

numTestsSucceeded = Total[#["TestsSucceededCount"] & /@ reports];
numTestsFailed    = Total[#["TestsFailedCount"]& /@ reports];
numTests          = numTestsSucceeded + numTestsFailed;

If[0 < numTestsFailed,
	failedReports = Select[reports, #["TestsFailedCount"] >0 &];
	failedReportText[report_] :=
		StringTrim[report["Title"], "Test Report: "] <> " failures:\n---------------\n" <> StringRiffle[#["TestID"] & /@ Select[Values[report["TestResults"]], #["Outcome"] == "Failure" &], "\n"];
	failedWrongText[report_] := With[{wrongResults = Values[report]},
		#["TestID"] & /@ wrongResults
	];
	Print[StringRiffle[failedReportText /@ failedReports, {"************************\n\n", "\n\n", "\n\n************************"}]];
	Print[""];
];

time = QuantityMagnitude[Total[(#["TimeElapsed"] & /@ reports)], "Seconds"];
Print[ToString@StringForm["Tests took `` seconds.", time]];
Print[ToString@StringForm["Succeeded: `` out of ``", numTestsSucceeded, numTests]];
Print[ToString@StringForm["Failed: `` out of ``", numTestsFailed, numTests]];

If[0 == numTestsFailed,
	Print["\nPhew..."];
];