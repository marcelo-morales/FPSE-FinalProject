
[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]

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

let get_value ls a b  =
  List.nth_exn (List.nth_exn ls a) b;;


let hey = Array.make_matrix ~dimx:28 ~dimy:28 0.0;;


let populate_array theArray strlist =
  for i=0 to 27 do
    for j=0 to 27 do
      theArray.(i).(j) <- Float.of_string (get_value strlist j i)
    done
  done;;

let print_array theArray =
  for i=0 to 27 do
    print_endline "";
    for j=0 to 27 do
      (* printf "%s" (string_of_float theArray.(i).(j)); *)
      printf "%s" (sprintf "%.0f " theArray.(j).(i))
    done
  done;;



let () =
  (* let mylist = strings_from_file "handwrittenImage.txt" |> String.split_on_chars ~on:['\n'] |> sanitize_list in *)

  let mylist = strings_from_file "handwrittenImage.txt" |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist in
  populate_array hey mylist;
  let _t1 = Tensor.of_float2 hey in
  print_array hey;

  

  
(* |> List.iter ~f:(printf "%s ") ; *)



