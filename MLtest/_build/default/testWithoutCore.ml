[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]


open Torch
open Base
open Sexplib.Conv
open Readfile
open Core

let mylist = strings_from_file "handwrittenImage.txt" |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat ;;

let mylist2 = List.map mylist ~f:(fun x -> float_of_string x) ;; 

let t2 =  Array.of_list mylist2 |> Tensor.of_float1 ;;



