[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]


open Torch
open Base
open Sexplib.Conv

let t = Tensor.of_int2 [| [| 3; 1; 4 |]; [| 1; 5; 9 |] |]

(* let () = Tensor.to_list t |> List.iter ~f:(fun t -> Tensor.to_int1_exn t |> Stdio.printf !"%{sexp:int array}\n"); *)



(* Array.to_list (Tensor.(to_float1_exn t));; *)
