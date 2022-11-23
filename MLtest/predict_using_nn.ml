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

(* let () = Tensor.shape t2 |> List.iter ~f:(printf "%i ") *)


(* |> List.iter ~f:(printf "%s ") ; *)






let hidden_nodes = 128
let epochs = 50
let learning_rate = 1e-3

let mnist = Mnist_helper.read_files () 
let { Dataset_helper.train_images; train_labels; _ } = mnist 
let vs = Var_store.create ~name:"nn" () 



let linear1 =
  Layer.linear vs hidden_nodes ~activation:Relu ~input_dim:Mnist_helper.image_dim
let linear2 = Layer.linear vs Mnist_helper.label_count ~input_dim:hidden_nodes 
let adam = Optimizer.adam vs ~learning_rate 
let model xs = Layer.forward linear1 xs |> Layer.forward linear2 




let () =

  for index = 1 to epochs do
    (* Compute the cross-entropy loss. *)
    let loss =
      Tensor.cross_entropy_for_logits (model train_images) ~targets:train_labels
    in
    Optimizer.backward_step adam ~loss;
    if index % 50 = 0
    then (
      (* Compute the validation error. *)
      let test_accuracy =
        Dataset_helper.batch_accuracy mnist `test ~batch_size:1000 ~predict:model
      in
      Stdio.printf
        "%d %f %.2f%%\n%!"
        index
        (Tensor.float_value loss)
        (100. *. test_accuracy));
    Caml.Gc.full_major ()
  done
  

let () = Serialize.save_multi ~named_tensors:(Var_store.all_vars vs) ~filename:"weights"
(* let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"heyo" *)
let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"weights"
let test_accuracy_on_image =
  (* (model (Tensor.unsqueeze t2 ~dim:0 )) |> Tensor.squeeze |> Tensor.to_float1_exn |> Array.to_list *)
  Tensor.(argmax ~dim:(-1)  (model (Tensor.unsqueeze t2 ~dim:0 ))) |> Tensor.to_float0_exn 
  let () = printf "\nNeural Network predicts: %i \n" (int_of_float test_accuracy_on_image);


