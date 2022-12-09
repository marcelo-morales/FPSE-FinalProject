[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]


(* open Core *)
open OUnit2

open Core
open Predict_conv


let image_name_and_path = "../../../../backend/tests/handwrittenImageOfOne.txt"
let weights_name_and_path = "../../../../backend/tests/weights"

let prediction1 = (predictImageFromFileName image_name_and_path weights_name_and_path)


let miscellaneous_tests _ =
  assert_equal 1 prediction1



let ml_tests =
  "Part 1" >: test_list [ "miscellaneous_ml_tests" >:: miscellaneous_tests ]

 let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series



