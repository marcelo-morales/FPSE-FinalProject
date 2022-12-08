
(* open Core *)
open OUnit2

(* open Core *)
open Predict_conv


(* Predict_conv.ml is the only file we are testing *)

(* let path = Core_unix.getcwd () 

let () = print_endline path *)

(*


let fixedpath = String.slice path (0) (-28 + String.length path);;

let image_name_and_path = fixedpath^"backend/tests/"^"handwrittenImageOfOne.txt"
let weights_name_and_path = fixedpath^"backend/tests/"^"weights" *)



let image_name_and_path = "../../../../backend/tests/handwrittenImageOfOne.txt"
let weights_name_and_path = "../../../../backend/tests/weights"


let miscellaneous_tests _ =
  assert_equal 1 (predictImageFromFileName image_name_and_path weights_name_and_path)




let ml_tests =
  "Part 1" >: test_list [ "miscellaneous_ml_tests" >:: miscellaneous_tests ]

let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series



