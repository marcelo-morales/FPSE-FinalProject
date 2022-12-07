
(* open Core *)
open OUnit2


open Predict_conv


(* let path = Core_unix.getcwd () *)

let folder_path = "../../../tests/"


let image_name_and_path = folder_path^"handwrittenImageOfOne.txt"
let weights_name_and_path = folder_path^"weights"




let miscellaneous_tests _ =
  assert_equal 1 (predictImageFromFileName image_name_and_path weights_name_and_path)


let ml_tests =
  "Part 1" >: test_list [ "miscellaneous_ml_tests" >:: miscellaneous_tests ]

let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series