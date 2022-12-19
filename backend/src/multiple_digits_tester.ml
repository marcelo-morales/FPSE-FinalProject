[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile
open Extradigit
open Predict_conv
open Operate
open Sys_unix




(* This needs to be called from the outer directory for it to run *)
(* Provide the path to image of handwritten numbers you want to have predicted  *)
(* The commented out paths are examples you can test for your self *) (* For fun you should find the file linked to in the directory and see the png associated with it *)
let image_name_and_path = "backend/tests/data/bignumber1.txt"
(* let image_name_and_path = "backend/tests/data/bignumber2.txt" *)
(* let image_name_and_path = "backend/tests/data/2287.txt" *)
(* let image_name_and_path = "backend/tests/data/7519.txt" *)
(* let image_name_and_path = "backend/tests/data/handwrittenImageOfOne.txt" *)


(* Do not configure this - this path stores the neural network training *)
let weights_name_and_path = "backend/tests/data/weights"

(* Loading image *)
let array2D_of_image = load_2d_array image_name_and_path


(* prints out what the neural network believes the number is *)
let () = print_endline "Neural Networks Predicts:"
let () = printf "%s \n" (recognize_multiple_digits array2D_of_image weights_name_and_path)
 

