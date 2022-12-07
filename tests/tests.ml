
(* open Core *)
open OUnit2


open Predict_conv



let image_name_and_path = "/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/tests/handwrittenImageOfOne.txt"
let weights_name_and_path = "/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/tests/weights"


let miscellaneous_tests _ =
  assert_equal 1 (predictImageFromFileName image_name_and_path weights_name_and_path)


let ml_tests =
  "Part 1" >: test_list [ "miscellaneous_ml_tests" >:: miscellaneous_tests ]

let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series