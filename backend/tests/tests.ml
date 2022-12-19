
[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]


(* open Core *)
open OUnit2

open Core
open Predict_conv
open Readfile
open Extradigit
open Operate



(* Needs to be in float format and 28x28 that is squeezed to 784 *)
let imagearray = [|0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 |]


let testarray1 = [|[|0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0|]; 
                   [|0.0; 0.0; 1.0; 1.0; 1.0; 0.0; 0.0; 1.0; 1.0; 0.0|]; 
                   [|0.0; 0.0; 1.0; 0.0; 1.0; 0.0; 0.0; 1.0; 1.0; 0.0|]; 
                   [|0.0; 0.0; 1.0; 1.0; 1.0; 0.0; 0.0; 1.0; 1.0; 0.0|];
                   [|0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0|]|]


let testarray2 = [| [|0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0|]; 
                    [|0.0; 0.0; 1.0; 0.0; 1.0; 0.0; 0.0; 0.0; 0.0; 0.0|]; 
                    [|0.0; 0.0; 1.0; 0.0; 1.0; 0.0; 0.0; 0.0; 0.0; 0.0|]; 
                    [|0.0; 0.0; 1.0; 1.0; 1.0; 0.0; 0.0; 0.0; 0.0; 0.0|];
                    [|0.0; 0.0; 1.0; 1.0; 1.0; 0.0; 0.0; 0.0; 0.0; 0.0|];
                    [|0.0; 0.0; 0.0; 0.0; 1.0; 0.0; 0.0; 0.0; 0.0; 0.0|];
                    [|0.0; 0.0; 0.0; 0.0; 1.0; 0.0; 0.0; 0.0; 0.0; 0.0|];
                    [|0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0|]|]



(* This IO testing  *)
(* Paths to all testing files *)
let image_name_and_path_for_one = "../../../../backend/tests/data/handwrittenImageOfOne.txt"
let image_name_and_path_for_four = "../../../../backend/tests/data/handwrittenImageOfFour.txt"
let weights_name_and_path = "../../../../backend/tests/data/weights"



let array1D_of_image_one = load_1d_array image_name_and_path_for_one
let array1D_of_image_four = load_1d_array image_name_and_path_for_four
let array2D_of_image_four = load_2d_array image_name_and_path_for_four

let eximages = extractimages array2D_of_image_four
(* let eximages = extractimages testarray2 *)

(* let padimg = padimages eximages *)




let () = print_array_auto array2D_of_image_four

let () = List.iter eximages ~f:(fun elt -> print_array_auto elt; print_endline "")
 

let prediction_for_one_from_file = (predictImageFromFileName image_name_and_path_for_one weights_name_and_path)
let prediction_for_one_from_1D_array_directly = (predictImageFrom1DArray imagearray weights_name_and_path)
let prediction_of_four_from_file = (predictImageFromFileName image_name_and_path_for_four weights_name_and_path)
let prediction_of_one_from_load = predictImageFrom1DArray array1D_of_image_one weights_name_and_path
let prediction_of_four_from_load = predictImageFrom1DArray array1D_of_image_four weights_name_and_path



let miscellaneous_tests _ =
  assert_equal 1 prediction_for_one_from_file;
  assert_equal 1 prediction_for_one_from_1D_array_directly;
  assert_equal 1 prediction_of_one_from_load;
  assert_equal 4 prediction_of_four_from_load;
  (* assert_equal 1 prediction3; *)
  (* assert_equal testarray1_after_extract (extractimages testarray1); *)
  assert_equal 4 prediction_of_four_from_file


let math_operation1 = (performMath array1D_of_image_four array1D_of_image_one "+" weights_name_and_path) 
let math_operation2 = (performMath array1D_of_image_four array1D_of_image_one "-" weights_name_and_path) 
let math_operation3 = (performMath array1D_of_image_four array1D_of_image_one "*" weights_name_and_path) 
let math_operation4 = (performMath array1D_of_image_one array1D_of_image_four "/" weights_name_and_path) 


let math_operation_test _ =
  assert_equal 5.0 math_operation1;
  assert_equal (3.0) math_operation2;
  assert_equal 4.0 math_operation3;
  assert_equal (0.25) math_operation4





let ml_tests =
  "Part 1" >: test_list [ 
    "miscellaneous_ml_tests" >:: miscellaneous_tests;
    "math_operation_tests" >:: math_operation_test
  ]

 let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series



