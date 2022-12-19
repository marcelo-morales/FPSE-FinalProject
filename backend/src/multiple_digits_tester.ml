[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile
open Extradigit
open Predict_conv

open Sys_unix

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


(* This needs to be called from the outer directory for it to run *)
(* Provide the path to image of handwritten numbers you want to have predicted  *)
(* The commented out paths are examples you can test for your self *) (* For fun you should find the file linked to in the directory and see the png associated with it *)

(* let image_name_and_path = "backend/src/data/bignumber.txt" *)
(* let image_name_and_path = "backend/src/data/bignumber2.txt" *)
let image_name_and_path = "backend/src/data/2287.txt"
(* let image_name_and_path = "backend/src/data/handwrittenImageOfOne.txt" *)


(* Do not configure this - this path stores the neural network training *)
let weights_name_and_path = "backend/src/weights"

(* Loading image *)
let array2D_of_image = load_2d_array image_name_and_path

let recognize_multiple_digits (matrix : float array array ) =
  let list_of_padded_28x28_images = extractimages matrix |> padimages in
  let long_string = List.fold list_of_padded_28x28_images ~init:"" ~f:(fun accum elt -> accum ^ (Int.to_string (predictImageFrom2DArray elt weights_name_and_path))) in
  print_endline long_string


let performMath (matrix1 : 'a array ) (matrix2 : 'a array ) (op: string) (weight_file_and_path : string) = 
  let num1 = Float.of_int (predictImageFrom1DArray matrix1 weight_file_and_path) in
  let num2 = Float.of_int (predictImageFrom1DArray matrix2 weight_file_and_path) in
  match op with
  | "+" -> num1 +. num2
  | "-" -> num1 -. num2
  | "*" -> num1 *. num2
  | "/" -> num1 /. num2
  | _ -> failwith "Something went wrong"


(* let () = print_endline (Core_unix.getcwd ()) *)
let () = print_endline "Neural Networks Predicts:"
let () = recognize_multiple_digits array2D_of_image

let p1 = "backend/tests/data/handwrittenImageOfFour.txt"
let p2 = "backend/tests/data/handwrittenImageOfOne.txt"

let a1 = load_1d_array p1
let a2 = load_1d_array p2

let () = printf "%f" (performMath a1 a2 "/" weights_name_and_path)
