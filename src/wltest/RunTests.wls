(* Quick hacky driver script to get tests to run. *)

(* Stolen from: https://mathematica.stackexchange.com/questions/206278/how-to-set-a-tolerance-level-for-equality-constraints *)
approxTolerance = .001;
approxEqual[a_, b_] := Chop[N@(Abs[a - b]/Min[a, b]), approxTolerance] == 0;

PrependTo[$Path, FileNameJoin[{FileNameDrop[ExpandFileName[First[$ScriptCommandLine]],-2], "wl"}]];
testDir = FileNameDrop[ExpandFileName[First[$ScriptCommandLine]],-1];
(*testFiles = FileNames["*.wlt", testDir];*)
testFiles = FileNames[{"T1BzzLindhardTest.wlt", "T1BzzNamTest.wlt"}, testDir];

<< "ewjnNoise`";
<< "ewjnNoiseT1Bzz`";

reports = TestReport /@ testFiles;

numTestsSucceeded = Total[#["TestsSucceededCount"] & /@ reports];
numTestsFailed    = Total[#["TestsFailedCount"]& /@ reports];
numTests          = numTestsSucceeded + numTestsFailed;

failedTestText[test_] := ToString@test["TestID"] <> "\nOutcome: " <> ToString@test["Outcome"] <> "\n" <> Switch[test["Outcome"],
	"Failure",
		"\tExpected:\n\t\t" <> ToString[test["ExpectedOutput"], InputForm] <> "\n\tActual:\n\t\t" <> ToString[test["ActualOutput"], InputForm],
	"MessagesFailure",
		"\tExpected Messages:\n\t\t" <> TextString[test["ExpectedMessages"]] <> "\n\tActual\n\t\t" <> TextString[test["ActualMessages"]],
	"Success",
		"All good champ",
	"Error",
			ToString@test,
	_,
		"Can't report on this error type, for some reason."
];
failedReportText[report_] := StringTrim[report["Title"], "Test Report: "] <> " failures:\n---------------\n" <> StringRiffle[failedTestText /@ Select[Values[report["TestResults"]], #["Outcome"] != "Success" &], "\n"];

If[0 < numTestsFailed,
	failedReports = Select[reports, #["TestsFailedCount"] >0 &];
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
