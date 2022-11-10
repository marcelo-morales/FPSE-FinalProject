(* Linear model for the MNIST dataset.
   The 4 following dataset files can be downloaded from http://yann.lecun.com/exdb/mnist/
   These files should be extracted in the 'data' directory.
     train-images-idx3-ubyte.gz
     train-labels-idx1-ubyte.gz
     t10k-images-idx3-ubyte.gz
     t10k-labels-idx1-ubyte.gz

   This should reach ~92% accuracy on the test dataset.
*)


open Base
open Torch
(* open Npy *)

let npz_tensors ~filename ~f =
  let npz_file = Npy.Npz.open_in filename in
  let named_tensors =
    Npy.Npz.entries npz_file
    |> List.map ~f:(fun tensor_name -> f tensor_name (Npy.Npz.read npz_file tensor_name))
  in
  Npy.Npz.close_in npz_file;
  named_tensors;;



let ls files =
  List.iter files ~f:(fun filename ->
      Stdio.printf "%s:\n" filename;
      let tensor_names_and_shapes =
        if String.is_suffix filename ~suffix:".npz"
        then
          npz_tensors ~filename ~f:(fun tensor_name packed_tensor ->
              match packed_tensor with
              | Npy.P tensor ->
                let tensor_shape = Bigarray.Genarray.dims tensor |> Array.to_list in
                tensor_name, tensor_shape)
        else
          Serialize.load_all ~filename
          |> List.map ~f:(fun (tensor_name, tensor) -> tensor_name, Tensor.shape tensor)
      in
      List.iter tensor_names_and_shapes ~f:(fun (tensor_name, shape) ->
          let shape = List.map shape ~f:Int.to_string |> String.concat ~sep:", " in
          Stdio.printf "  %s (%s)\n" tensor_name shape))



          
let () = ls ["/mnt/c/Users/Rawstone/OneDrive/Dokumenter/Skole/Universitet/5Semester/FunctionalProgramming/FPSE-FinalProject/MLtest/handwrittenImage.npz"];;
    

(* let learning_rate = Tensor.f 1. *)
(* let () =
  let { Dataset_helper.train_images; train_labels; test_images; test_labels } =
    Mnist_helper.read_files ()
  in
  let ws = Tensor.zeros Mnist_helper.[ image_dim; label_count ] ~requires_grad:true in
  let bs = Tensor.zeros [ Mnist_helper.label_count ] ~requires_grad:true in
  let model xs = Tensor.(mm xs ws + bs) in
  for index = 1 to 200 do
    (* Compute the cross-entropy loss. *)
    let loss =
      Tensor.cross_entropy_for_logits (model train_images) ~targets:train_labels
    in
    Tensor.backward loss;
    (* Apply gradient descent, [no_grad f] runs [f] with gradient tracking disabled. *)
    Tensor.(
      no_grad (fun () ->
          ws -= (grad ws * learning_rate);
          bs -= (grad bs * learning_rate)));
    Tensor.zero_grad ws;
    Tensor.zero_grad bs;
    (* Compute the validation error. *)
    let test_accuracy =
      Tensor.(argmax ~dim:(-1) (model test_images) = test_labels)
      |> Tensor.to_kind ~kind:(T Float)
      |> Tensor.sum
      |> Tensor.float_value
      |> fun sum -> sum /. Float.of_int (Tensor.shape test_images |> List.hd_exn)
    in
    Stdio.printf "%d %f %.2f%%\n%!" index (Tensor.float_value loss) (100. *. test_accuracy);
    Caml.Gc.full_major ()
  
  


  done
 *)
