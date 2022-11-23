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

(* let () = Tensor.shape t2 |> List.iter ~f:(printf "%i ")

let () = print_endline "" *)

(* |> List.iter ~f:(printf "%s ") ; *)




  


let ws = Tensor.zeros Mnist_helper.[ image_dim; label_count ] ~requires_grad:true 
let bs = Tensor.zeros [ Mnist_helper.label_count ] ~requires_grad:true 
let model xs = Tensor.(mm xs ws + bs) 

let learning_rate = Tensor.f 1. 

let () =
  let { Dataset_helper.train_images; train_labels; test_images; test_labels } =
    Mnist_helper.read_files ()
  in

  for index = 1 to 50 do
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
    (* let () = printf "\n" in
    let () = List.iter ~f:(printf "%i ") (Tensor.shape test_images) in *)


    (* let () = List.iter test_accuracy_on_image ~f:(printf "%f ")  in *)


    Caml.Gc.full_major ();
    

  


  done
  
  

let test_accuracy_on_image =
  (* (model (Tensor.unsqueeze t2 ~dim:0 )) |> Tensor.squeeze |> Tensor.to_float1_exn |> Array.to_list *)
  Tensor.(argmax ~dim:(-1)  (model (Tensor.unsqueeze t2 ~dim:0 ))) |> Tensor.to_float0_exn 
  let () = printf "\nNeural Network predicts: %i \n" (int_of_float test_accuracy_on_image);


