[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile


let mylist = strings_from_file "handwrittenImage.txt" |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat ;;

let mylist2 = List.map mylist ~f:(fun x -> float_of_string x) ;; 

let t2 =  Array.of_list mylist2 |> Tensor.of_float1 ;;

let hidden_nodes = 1284
let epochs = 50
let learning_rate = 1e-3

let mnist = Mnist_helper.read_files () 
let { Dataset_helper.train_images; train_lagibels; _ } = mnist 
let vs = Var_store.create ~name:"nn" () 
let linear1 =
  Layer.linear vs hidden_nodes ~activation:Relu ~input_dim:Mnist_helper.image_dim
let linear2 = Layer.linear vs Mnist_helper.label_count ~input_dim:hidden_nodes 
let adam = Optimizer.adam vs ~learning_rate 
let model xs = Layer.forward linear1 xs |> Layer.forward linear2   


let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"weights"


let test_accuracy_on_image =
  (* (model (Tensor.unsqueeze t2 ~dim:0 )) |> Tensor.squeeze |> Tensor.to_float1_exn |> Array.to_list *)
  Tensor.(argmax ~dim:(-1)  (model (Tensor.unsqueeze t2 ~dim:0 ))) |> Tensor.to_float0_exn 
  let () = printf "\nNeural Network predicts: %i \n" (int_of_float test_accuracy_on_image);


