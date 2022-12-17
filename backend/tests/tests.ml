[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]


(* open Core *)
open OUnit2

open Core
open Predict_conv

(* Needs to be in float format and 28x28 that is squeezed to 784 *)
let imagearray = [|0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 |]



let test_2darray = Array.make_matrix ~dimx:28 ~dimy:28 0.0


let image_name_and_path = "../../../../backend/tests/handwrittenImageOfOne.txt"
let weights_name_and_path = "../../../../backend/tests/weights"


let prediction1 = (predictImageFromFileName image_name_and_path weights_name_and_path)
let prediction2 = (predictImageFrom1DArray imagearray weights_name_and_path)
let prediction3 = (predictImageFrom2DArray test_2darray weights_name_and_path )

let () = printf "%i" prediction1
let () = printf "%i" prediction2
let () = printf "%i" prediction3




let miscellaneous_tests _ =
  assert_equal 1 prediction1;
  assert_equal 1 prediction2;
  assert_equal 1 prediction3



let ml_tests =
  "Part 1" >: test_list [ "miscellaneous_ml_tests" >:: miscellaneous_tests ]

 let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series



