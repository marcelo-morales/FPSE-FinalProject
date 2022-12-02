
[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile



(* let sanitize (s : string) : string =
  Str.global_replace (Str.regexp "[^a-zA-Z0-9.]+") " " s |> String.lowercase;; *)







let () =

  let mylist = strings_from_file "handwrittenImage.txt" |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first in
  (*  |> make_biglist |> List.concat in *)
  
  List.iter ~f:(printf "%s ") (mylist);

  let mylist2 = List.map mylist ~f:(fun x -> float_of_string x)  in
  print_endline "";
  (* printf "%i" (List.length mylist2); *)
  (* List.iter ~f:(printf "%.2f ") (mylist2); *)
  (* let t2 =  Array.of_list mylist2 |> Tensor.of_float1 in *)
  print_endline ""



  

  

  
(* |> List.iter ~f:(printf "%s ") ; *)



