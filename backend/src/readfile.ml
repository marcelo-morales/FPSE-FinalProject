
[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch

(* Reads string from file *)
let strings_from_file filename = 
  let strings = In_channel.read_all filename in  (* Cannot test files *)
  strings;;

(* Removes everything but float numbers *)
let sanitize (s : string) : string option =
  match String.length s with
  | 0 -> None
  | _ ->  Some (Str.global_replace (Str.regexp "[^0-9.]+") " " s |> String.lowercase)


(* Santizes lists of strings and removes everything but float numbers *)
let sanitize_list stringlist =
  List.fold stringlist ~init:[] ~f:(fun accum x ->
      match sanitize x with
      | None -> accum
      | Some sanitized -> accum @ [ sanitized ]);;

(* Removes first character from string *)
let remove_first_character str =
  String.slice str 1 (String.length str);;

(* Removes first character from a string list *)
let apply_remove_first ls =
  List.map ls ~f:(fun x -> remove_first_character x)

(* Changes string list to float list *)
let change_to_float ls =
  List.map ls ~f:(fun x -> Float.of_string x)

  (* converts list of strings to a list of lists of strings  *)
let make_biglist ls =
  List.fold ls ~init:[] ~f:(fun accum x -> accum @ [(change_to_float (String.split_on_chars x ~on:[' ']))] )

(* Converts string of lits of lists to float array array *)
let make_2d_array ls =
  List.to_array @@ List.fold ls ~init:[] ~f:(fun accum elt -> accum @ [List.to_array elt])

(* Loads image as 1D array *)
let load_1d_array name_and_path =
  strings_from_file name_and_path |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat |> Array.of_list

  (* Loads image as 2D array *)
let load_2d_array name_and_path =
  strings_from_file name_and_path |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> make_2d_array



(* This function is only for visualisation purposes, therefore it cannot be tested *) (* Two for loop has been used since this the canonical way of doing it in data science*)
[@@@coverage off]
let print_array_auto theArray =
  let dim1 = Array.length theArray in
  let dim2 = Array.length @@ Array.get theArray 0 in
  for i=0 to (dim1-1) do
    print_endline "";
    for j=0 to (dim2-1) do
      printf "%s" (sprintf "%.0f " theArray.(i).(j));
    done;
  done;
  print_endline "\n";;
  
  [@@@coverage on]
  (* let () = print_endline ""; *)











