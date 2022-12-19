
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

let change_to_float ls =
  List.map ls ~f:(fun x -> Float.of_string x)

let make_biglist ls =
  List.fold ls ~init:[] ~f:(fun accum x -> accum @ [(change_to_float (String.split_on_chars x ~on:[' ']))] )



let make_2d_array ls =
  List.to_array @@ List.fold ls ~init:[] ~f:(fun accum elt -> accum @ [List.to_array elt])


let load_1d_array name_and_path =
  strings_from_file name_and_path |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat |> Array.of_list

let load_2d_array name_and_path =
  strings_from_file name_and_path |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> make_2d_array




(* let print_array_string theArray =
  for i=0 to 27 do
    print_endline "";
    for j=0 to 27 do
      (* printf "%s" (string_of_float theArray.(i).(j)); *)
      printf "%s " (theArray.(j).(i))
    done
  done;; *)


let print_array_auto theArray =
  let dim1 = Array.length theArray in
  let dim2 = Array.length @@ Array.get theArray 0 in
  for i=0 to (dim1-1) do
    print_endline "";
    for j=0 to (dim2-1) do
      (* printf "%s" (string_of_float theArray.(i).(j)); *)
      printf "%s" (sprintf "%.0f " theArray.(i).(j));
    done;
  done;
  print_endline "\n";;
  
  
  (* let () = print_endline ""; *)



;;

let print_array theArray dim1 dim2 =
  for i=0 to dim1 do
    print_endline "";
    for j=0 to dim2 do
      (* printf "%s" (string_of_float theArray.(i).(j)); *)
      printf "%s" (sprintf "%.0f " theArray.(i).(j))
    done
  done;;
  







