[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile

let predictImageFromFileName (filename : string ) =
  let mylist = strings_from_file filename |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat in
  let mylist2 = List.map mylist ~f:(fun x -> float_of_string x)  in
  let t2 =  Array.of_list mylist2 |> Tensor.of_float1 in


  (* This should reach ~99% accuracy. *)
  let batch_size = 256 in
  let epochs = 100 in
  let learning_rate = 0.001 in


  let device = Device.cuda_if_available ()  in
  let mnist = Mnist_helper.read_files ()  in
  let vs = Var_store.create ~name:"cnn" ~device ()  in
  let conv2d1 = Layer.conv2d_ vs ~ksize:5 ~stride:1 ~input_dim:1 32  in
  let conv2d2 = Layer.conv2d_ vs ~ksize:5 ~stride:1 ~input_dim:32 64  in
  let linear1 = Layer.linear vs ~activation:Relu ~input_dim:1024 1024  in
  let linear2 = Layer.linear vs ~input_dim:1024 Mnist_helper.label_count  in
  let adam = Optimizer.adam vs ~learning_rate  in
  let model xs ~is_training =
    Tensor.reshape xs ~shape:[ -1; 1; 28; 28 ]
    |> Layer.forward conv2d1
    |> Tensor.max_pool2d ~ksize:(2, 2)
    |> Layer.forward conv2d2
    |> Tensor.max_pool2d ~ksize:(2, 2)
    |> Tensor.reshape ~shape:[ -1; 1024 ]
    |> Layer.forward linear1
    |> Tensor.dropout ~p:0.5 ~is_training
    |> Layer.forward linear2 in


  let test_model = model ~is_training:false   in

  let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"weights" in

  let test_accuracy_on_image  =
    (* (model (Tensor.unsqueeze t2 ~dim:0 )) |> Tensor.squeeze |> Tensor.to_float1_exn |> Array.to_list *)
    Tensor.(argmax ~dim:(-1)  (test_model (Tensor.unsqueeze t2 ~dim:0 ))) |> Tensor.to_float0_exn in
    (* let () = printf "\nNeural Network predicts: %i \n" (int_of_float test_accuracy_on_image); *)
    int_of_float test_accuracy_on_image




let predictImageFromFileName (filename : string ) =
  let mylist = strings_from_file filename |> String.split_on_chars ~on:['\n']  |> sanitize_list |> apply_remove_first |> make_biglist |> List.concat in
  let mylist2 = List.map mylist ~f:(fun x -> float_of_string x)  in
  let t2 =  Array.of_list mylist2 |> Tensor.of_float1 in


  (* This should reach ~99% accuracy. *)
  let batch_size = 256 in
  let epochs = 100 in
  let learning_rate = 0.001 in


  let device = Device.cuda_if_available ()  in
  let mnist = Mnist_helper.read_files ()  in
  let vs = Var_store.create ~name:"cnn" ~device ()  in
  let conv2d1 = Layer.conv2d_ vs ~ksize:5 ~stride:1 ~input_dim:1 32  in
  let conv2d2 = Layer.conv2d_ vs ~ksize:5 ~stride:1 ~input_dim:32 64  in
  let linear1 = Layer.linear vs ~activation:Relu ~input_dim:1024 1024  in
  let linear2 = Layer.linear vs ~input_dim:1024 Mnist_helper.label_count  in
  let adam = Optimizer.adam vs ~learning_rate  in
  let model xs ~is_training =
    Tensor.reshape xs ~shape:[ -1; 1; 28; 28 ]
    |> Layer.forward conv2d1
    |> Tensor.max_pool2d ~ksize:(2, 2)
    |> Layer.forward conv2d2
    |> Tensor.max_pool2d ~ksize:(2, 2)
    |> Tensor.reshape ~shape:[ -1; 1024 ]
    |> Layer.forward linear1
    |> Tensor.dropout ~p:0.5 ~is_training
    |> Layer.forward linear2 in


  let test_model = model ~is_training:false   in

  let () = Serialize.load_multi_ ~named_tensors:(Var_store.all_vars vs) ~filename:"weights" in

  let test_accuracy_on_image  =
    Tensor.(argmax ~dim:(-1)  (test_model (Tensor.unsqueeze t2 ~dim:0 ))) |> Tensor.to_float0_exn in
    int_of_float test_accuracy_on_image

let () = printf "\nNeural Network predicts: %i \n" (predictImageFromFileName "handwrittenImage.txt")  (* ExampleTest *)


