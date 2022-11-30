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

(* This should reach ~99% accuracy. *)
let batch_size = 256
let epochs = 400
let learning_rate = 0.001

let device = Device.cuda_if_available () 
let mnist = Mnist_helper.read_files () 
let vs = Var_store.create ~name:"cnn" ~device () 
let conv2d1 = Layer.conv2d_ vs ~ksize:5 ~stride:1 ~input_dim:1 32 
let conv2d2 = Layer.conv2d_ vs ~ksize:5 ~stride:1 ~input_dim:32 64 
let linear1 = Layer.linear vs ~activation:Relu ~input_dim:1024 1024 
let linear2 = Layer.linear vs ~input_dim:1024 Mnist_helper.label_count 
let adam = Optimizer.adam vs ~learning_rate 
let model xs ~is_training =
  Tensor.reshape xs ~shape:[ -1; 1; 28; 28 ]
  |> Layer.forward conv2d1
  |> Tensor.max_pool2d ~ksize:(2, 2)
  |> Layer.forward conv2d2
  |> Tensor.max_pool2d ~ksize:(2, 2)
  |> Tensor.reshape ~shape:[ -1; 1024 ]
  |> Layer.forward linear1
  |> Tensor.dropout ~p:0.5 ~is_training
  |> Layer.forward linear2

let train_model = model ~is_training:true 
let test_model = model ~is_training:false 



let () =
  for batch_idx = 1 to epochs do
    let batch_images, batch_labels =
      Dataset_helper.train_batch mnist ~device ~batch_size ~batch_idx in
    (* Compute the cross-entropy loss. *)
    let loss =
      Tensor.cross_entropy_for_logits (train_model batch_images) ~targets:batch_labels
    in
    Optimizer.backward_step adam ~loss;
    if batch_idx % 50 = 0
    then (
      (* Compute the validation error. *)
      let test_accuracy =
        Dataset_helper.batch_accuracy mnist `test ~device ~batch_size ~predict:test_model
      in
      Stdio.printf
        "%d %f %.2f%%\n%!"
        batch_idx
        (Tensor.float_value loss)
        (100. *. test_accuracy));
    Caml.Gc.full_major ()
  done

  
let test_model = model ~is_training:false 
let () = Serialize.save_multi ~named_tensors:(Var_store.all_vars vs) ~filename:"weights"
(* let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"heyo" *)
let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"weights"
let test_accuracy_on_image =
  (* (model (Tensor.unsqueeze t2 ~dim:0 )) |> Tensor.squeeze |> Tensor.to_float1_exn |> Array.to_list *)
  Tensor.(argmax ~dim:(-1)  (test_model (Tensor.unsqueeze t2 ~dim:0 ))) |> Tensor.to_float0_exn 
  let () = printf "\n Neural Network predicts: %i \n" (int_of_float test_accuracy_on_image);


