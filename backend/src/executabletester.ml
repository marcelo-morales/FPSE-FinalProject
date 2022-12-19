[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile
open Extradigit
open Predict_conv
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



let image_name_and_path_for_four = "/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/backend/tests/handwrittenImageOfFour.txt"
let weights_name_and_path = "/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/backend/tests/weights"
let image_name_and_path_for_0000 = "/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/backend/src/data/7519.txt"
let image_name_and_path_for_0000 = "/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/backend/src/0000.txt"

let array2D_of_image_four = load_2d_array image_name_and_path_for_four

let array2D_of_image_13 = load_2d_array image_name_and_path_for_0000

let eximages = extractimages array2D_of_image_13


(* let () = print_array_auto array2D_of_image_four *)


(* let eximages = extractimages testarray2 *)

let numbers = extract_digit_index array2D_of_image_four

(* let () = List.iter numbers ~f:(fun elt -> printf "%.0f " elt) *)

let pdimages = padimages eximages

(* let () = List.iter pdimages ~f:(fun elt -> print_array_auto elt; print_endline "") *)

let recognize_multiple_digits (matrix : float array array ) =
  let list_of_padded_28x28_images = extractimages matrix |> padimages in
  let long_string = List.fold list_of_padded_28x28_images ~init:"" ~f:(fun accum elt -> accum ^ (Int.to_string (predictImageFrom2DArray elt weights_name_and_path))) in
  print_endline long_string

let () = recognize_multiple_digits array2D_of_image_13
