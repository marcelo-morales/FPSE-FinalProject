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
  
  print_array hey;;

  

let t1 = Tensor.of_float2 hey 
(* |> List.iter ~f:(printf "%s ") ; *)




  



let learning_rate = Tensor.f 1. 

let () =
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
    
    let test_accuracy_on_image =
      Tensor.(argmax ~dim:(-1) (model t1) )
      (* |> Tensor.to_kind ~kind:(T Float)
      |> Tensor.float_value *)
    in
    Stdio.printf "%f" test_accuracy_on_image;


    Caml.Gc.full_major ()
  
  


  done

