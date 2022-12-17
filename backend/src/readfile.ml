
[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch


let strings_from_file filename = 
  let strings = In_channel.read_all filename in  (* Cannot test files *)
  strings;;


let sanitize (s : string) : string option =
  match String.length s with
  | 0 -> None
  | _ -> (
      let new_string =
        Str.global_replace (Str.regexp "[^0-9.]+") " " s |> String.lowercase
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




let make_2d_array ls =
  List.to_array @@ List.fold ls ~init:[] ~f:(fun accum elt -> accum @ [List.to_array elt])



let print_array theArray =
  for i=0 to 27 do
    print_endline "";
    for j=0 to 27 do
      (* printf "%s" (string_of_float theArray.(i).(j)); *)
      printf "%s " (theArray.(j).(i))
    done
  done;;

(* let print_array theArray =
  for i=0 to 27 do
    print_endline "";
    for j=0 to 27 do
      (* printf "%s" (string_of_float theArray.(i).(j)); *)
      printf "%s" (sprintf "%.0f " theArray.(j).(i))
    done
  done;; *)
  







