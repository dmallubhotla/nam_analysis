(* Quick hacky driver script to get tests to run. *)

(* Stolen from: https://mathematica.stackexchange.com/questions/206278/how-to-set-a-tolerance-level-for-equality-constraints *)
approxTolerance = .001;
approxEqual[a_, b_] := Chop[N@(Abs[a - b]/Min[a, b]), approxTolerance] == 0;

PrependTo[$Path, FileNameJoin[{FileNameDrop[ExpandFileName[First[$ScriptCommandLine]],-2], "wl"}]];
testDir = FileNameDrop[ExpandFileName[First[$ScriptCommandLine]],-1];
testFiles = FileNames["*.wlt", testDir];

<< "ewjnNoise`";

reports = TestReport /@ testFiles;

numTestsSucceeded = Total[#["TestsSucceededCount"] & /@ reports];
numTestsFailed    = Total[#["TestsFailedCount"]& /@ reports];
numTests          = numTestsSucceeded + numTestsFailed;

failedTestText[test_] := ToString@StringForm["``. Outcome: ``.", test["TestID"], test["Outcome"]] <> "\n\t" <> Switch[test["Outcome"],
	"Failure",
		ToString@StringForm["Expected `` and got ``.", ToString[test["ExpectedOutput"], InputForm], ToString[test["ActualOutput"], InputForm]],
	"MessagesFailure",
		"Expected Messages: " <> ToString[test["ExpectedMessages"], InputForm] <> "\n" <> "Actual Messages: " <> ToString[test["ActualMessages"], InputForm],
	"Success",
		"All good champ",
	_,
		"Can't report on this error type, for some reason."
];
(*failedWrongTestText[wrongTest_] := ToString@StringForm["`` outcome: ``.", wrongTest["TestID"], wrongTest["Outcome"]] <> "\n" <> ToString@StringForm["Expected `` and got ``.", ToString[wrongTest["ExpectedOutput"], InputForm], ToString[wrongTest["ActualOutput"], InputForm]];*)
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