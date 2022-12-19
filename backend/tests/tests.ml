
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


(* Note 
I had issues with testing ocaml-torch when doing all the testing on one line - for some weird reason it would not compile - Christian

So instead of doing this:
assert_equal y (some_fun x)

I do this for ocaml-torch:
let y2 = (some_fun x)

assert_equal y1 y2;

  
*)


(* Example of the format that can be used - this is a 1D array of 784 elements which is just the 2D array of 28x28 elements flatterns *)
let imagearray_of_one = [|0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;1.0 ;1.0 ;1.0 ;1.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 ;0.0 |]


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



let testarray1_after_extract = [
[|[|0.; 0.; 0.; 0.|]; 
  [|0.; 1.; 1.; 1.|]; 
  [|0.; 1.; 0.; 1.|];
  [|0.; 1.; 1.; 1.|]; 
  [|0.; 0.; 0.; 0.|]|];
[|[|0.; 0.; 0.|]; 
  [|0.; 1.; 1.|]; 
  [|0.; 1.; 1.|]; 
  [|0.; 1.; 1.|];
  [|0.; 0.; 0.|]|]]

let testarray2_after_extract = [
[|[|0.; 0.; 0.; 0.|]; 
  [|0.; 1.; 0.; 1.|]; 
  [|0.; 1.; 0.; 1.|];
  [|0.; 1.; 1.; 1.|]; 
  [|0.; 1.; 1.; 1.|]; 
  [|0.; 0.; 0.; 1.|];
  [|0.; 0.; 0.; 1.|]; 
  [|0.; 0.; 0.; 0.|]|]]


let testarray2_after_padding_10x10 = [
[|[|0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 1.; 0.; 1.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 1.; 0.; 1.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 1.; 1.; 1.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 1.; 1.; 1.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 0.; 0.; 1.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 0.; 0.; 1.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.|];
  [|0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.|]|]]


(* Testing multiple digits auxillary file *)
let test_multiple_digit_auxillary_functions _ =
  assert_equal 10.0 (sum [1.0;2.0;3.0;4.0]);
  assert_equal [0; 1; 5; 6; 9] (find_index_for_split testarray1);
  assert_equal [0; 1; 5; 6; 7; 8; 9] (find_index_for_split testarray2);
  assert_equal testarray1_after_extract (extractimages testarray1);
  assert_equal testarray2_after_extract (extractimages testarray2);
  assert_equal testarray2_after_padding_10x10 ((padimages 10) @@ extractimages testarray2)


 (* Testing the Readfile *)
let test_readfile_aux_functions _ =
  assert_equal (Some "12331 ") (sanitize "12331ab "); (* The space behind the number is on purpose in order to read the values as a space separated file*)
  assert_equal (Some " 12331 1241 ") (sanitize "  12331 1241 ");
  assert_equal (None) (sanitize "");
  assert_equal [" 1214 "; "3242 "] (sanitize_list ["  1214 "; "3242 "]);
  assert_equal "1234" (remove_first_character " 1234");
  assert_equal [1234.; 123.] (change_to_float ["1234";"123"]);
  assert_equal [[12312.]; [123414.]] (make_biglist ["12312"; "123414"])
(* loading arrays are tested below *)

(* This IO testing  *)
(* Paths to all testing files *)
let image_name_and_path_for_one = "../../../../backend/tests/data/handwrittenImageOfOne.txt"
let image_name_and_path_for_four = "../../../../backend/tests/data/handwrittenImageOfFour.txt"
let weights_name_and_path = "../../../../backend/tests/data/weights"



let array1D_of_image_one = load_1d_array image_name_and_path_for_one
let array1D_of_image_four = load_1d_array image_name_and_path_for_four
let array2D_of_image_four = load_2d_array image_name_and_path_for_four
let eximages = extractimages array2D_of_image_four

 

let prediction_for_one_from_file = (predictImageFromFileName image_name_and_path_for_one weights_name_and_path)
let prediction_for_one_from_1D_array_directly = (predictImageFrom1DArray imagearray_of_one weights_name_and_path)
let prediction_of_four_from_file = (predictImageFromFileName image_name_and_path_for_four weights_name_and_path)
let prediction_of_one_from_load = predictImageFrom1DArray array1D_of_image_one weights_name_and_path
let prediction_of_four_from_load = predictImageFrom1DArray array1D_of_image_four weights_name_and_path
let prediction_of_four_from_load_2D = predictImageFrom2DArray array2D_of_image_four weights_name_and_path

(* Testing I/O *)
let iotesting _ =
  assert_equal 1 prediction_for_one_from_file;
  assert_equal 1 prediction_for_one_from_1D_array_directly;
  assert_equal 1 prediction_of_one_from_load;
  assert_equal 4 prediction_of_four_from_load;
  assert_equal 4 prediction_of_four_from_file;
  assert_equal 4 prediction_of_four_from_load_2D


let math_operation1 = (performMath array1D_of_image_four array1D_of_image_one "+" weights_name_and_path) 
let math_operation2 = (performMath array1D_of_image_four array1D_of_image_one "-" weights_name_and_path) 
let math_operation3 = (performMath array1D_of_image_four array1D_of_image_one "*" weights_name_and_path) 
let math_operation4 = (performMath array1D_of_image_one array1D_of_image_four "/" weights_name_and_path) 
let math_operation5 = (performMath array1D_of_image_one array1D_of_image_four "?" weights_name_and_path) 

(* Testing math operation - see multiple_digits_test for math_operation test with multiple digits *)
let math_operation_test _ =
  assert_equal "5." math_operation1;
  assert_equal "3." math_operation2;
  assert_equal "4." math_operation3;
  assert_equal "0.25" math_operation4;
  assert_equal "Invalid operation" math_operation5


let bignumber_path1 = "../../../../backend/tests/data/bignumber1.txt"
let bignumber_path2 = "../../../../backend/tests/data/bignumber2.txt"
let number_2287_path = "../../../../backend/tests/data/2287.txt"

let bignumber1_prediction = (recognize_multiple_digits (load_2d_array bignumber_path1) weights_name_and_path)
let bignumber2_prediction = (recognize_multiple_digits (load_2d_array bignumber_path2) weights_name_and_path)

let math_operation6 = (performMath_Multiple_Digits (load_2d_array bignumber_path1) (load_2d_array number_2287_path) "/" weights_name_and_path) 

(* Testing recognizing multiple digits and using operations on them - Definitely recommend to look at the paths and confirm that the numbers are correctly identified. *)
(* The convolutional neural network is 99% accurate, so it will statistically make a mistake once every 100 digit - however those digits will us humans also have trouble with *)
let multiple_digits_test _ =
  assert_equal "5424937279" bignumber1_prediction;
  assert_equal "997073645380142690390262898297" bignumber2_prediction;
  assert_equal "2372075.7669435944" math_operation6


let ml_tests =
  "ml_tests" >: test_list [ 
    "iotesting" >:: iotesting;
    "math_operation_tests" >:: math_operation_test;
    "test_multiple_digit_auxillary_functions" >:: test_multiple_digit_auxillary_functions;
    "multiple_digits_test" >:: multiple_digits_test;
    "test_readfile_aux_functions" >:: test_readfile_aux_functions
  ]


 let series = "FinalProject Tests" >::: [ ml_tests ]
let () = run_test_tt_main series



