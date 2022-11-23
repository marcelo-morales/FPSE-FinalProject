
[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch




let strings_from_file filename = 
  let strings = In_channel.read_all filename in  (* Cannot test files *)
  strings;;

(* let sanitize (s : string) : string =
  Str.global_replace (Str.regexp "[^a-zA-Z0-9.]+") " " s |> String.lowercase;; *)

let sanitize (s : string) : string option =
  match String.length s with
  | 0 -> None
  | _ -> (
      let new_string =
        Str.global_replace (Str.regexp "[^a-zA-Z0-9.]+") " " s |> String.lowercase
      in
      match String.length new_string with 0 -> None | _ -> Some new_string)


let sanitize_list stringlist =
  List.fold stringlist ~init:[] ~f:(fun accum x ->
      match sanitize x with
      | None -> accum
      | Some sanitized -> accum @ [ sanitized ]);;

let remove_first_character str =
  String.slice str 1 (String.length str);;

let apply_remove_first ls =
  List.map ls ~f:(fun x -> remove_first_character x)

let make_biglist ls =
  List.fold ls ~init:[] ~f:(fun accum x -> accum @ [(String.split_on_chars x ~on:[' '])] )





(* let () =

  let mylist = strings_from_file "handwrittenImage.txt" |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat in
  
  let mylist2 = List.map mylist ~f:(fun x -> float_of_string x)  in
  print_endline "";
  printf "%i" (List.length mylist2);
  List.iter ~f:(printf "%f ") (mylist2);
  let t2 =  Array.of_list mylist2 |> Tensor.of_float1 in
  print_endline "" *)



  

  

  
(* |> List.iter ~f:(printf "%s ") ; *)



