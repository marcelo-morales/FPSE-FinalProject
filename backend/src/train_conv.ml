[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile

(* This executable trains the model *) (* Will not be codecoverage as it outputs unit*)
(* This should reach ~99% accuracy. *)

(* Testing this has shown me the following facts for *)
let batch_size = 256 (* Increase this to get better accuracy *)
let epochs = 200 (* Increase this to get better accuracy *)
let learning_rate = 0.001 (* Lower this to get better accuracy - but not much - if you lower this then up the number of epochs*)

let device = Device.cuda_if_available () 
let mnist = Mnist_helper.read_files () 
let vs = Var_store.create ~name:"cnn" ~device () 

(* Defines all the layers in the convolutional neural network*)
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


(* Main loop that trains the neural network *)
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


(* Saving the model!! *)
let test_model = model ~is_training:false 

let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"weights"



