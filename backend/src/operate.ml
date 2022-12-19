

[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile
open Predict_conv
open Extradigit


(* Main math performing function *)
let performMath (matrix1 : 'a array ) (matrix2 : 'a array ) (op: string) (weight_file_and_path : string) = 
  let num1 = Float.of_int (predictImageFrom1DArray matrix1 weight_file_and_path) in
  let num2 = Float.of_int (predictImageFrom1DArray matrix2 weight_file_and_path) in
  let result = match op with
  | "+" ->  Float.to_string (num1 +. num2)
  | "-" -> Float.to_string (num1 -. num2)
  | "*" -> Float.to_string (num1 *. num2)
  | "/" -> Float.to_string (num1 /. num2)
  | _ -> "Invalid operation"
  in
  result

let performMath_Multiple_Digits (matrix1 : 'a array array ) (matrix2 : 'a array array) (op: string) (weight_file_and_path : string) = 
  let num1 = Float.of_string (recognize_multiple_digits matrix1 weight_file_and_path) in
  let num2 = Float.of_string (recognize_multiple_digits matrix2 weight_file_and_path) in
  let result = match op with
  | "+" ->  Float.to_string (num1 +. num2)
  | "-" -> Float.to_string (num1 -. num2)
  | "*" -> Float.to_string (num1 *. num2)
  | "/" -> Float.to_string (num1 /. num2)
  | _ -> "Invalid operation"
  in
  result





  


