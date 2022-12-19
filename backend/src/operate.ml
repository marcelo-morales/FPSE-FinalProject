

[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile
open Predict_conv

(* heyo *)

(* TODO: finish this *)
let performMath (matrix1 : 'a array ) (matrix2 : 'a array ) (op: string) (weight_file_and_path : string) = 
  let num1 = Float.of_int (predictImageFrom1DArray matrix1 weight_file_and_path) in
  let num2 = Float.of_int (predictImageFrom1DArray matrix2 weight_file_and_path) in
  match op with
  | "" -> num1 +. num2
  | "-" -> num1 -. num2
  | "*" -> num1 *. num2
  | "/" -> num1 /. num2
  | _ -> failwith "wrong"




