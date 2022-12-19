[@@@ocaml.warning "-33"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-26"]

open Core
open Torch
open Readfile
open Predict_conv




(* Summing all floats in a list *)
let sum l =
  List.fold ~f:(+.) ~init:0.0 l;;
                    

  (* Find indexs for where to split *)
let find_index_for_split (imgarray : float array array) =
  let listarray = Array.to_list (Array.transpose_exn imgarray) in
  List.foldi listarray ~init:([]) ~f:(fun i accum elt -> 
    if Float.equal (sum @@ Array.to_list elt) 0.0  then
      accum @ [i]
    else
      accum
)

(* Extracts subarrays of big array to only get the numbers *)
let extractimages (imgarray : float array array) =
  let indexlist = find_index_for_split imgarray in
  let arraylist, tempvar = List.fold indexlist ~init:([],0) ~f:(fun (ls,prev) elt -> 
    
    if ((elt-prev)>2) then
      (ls @ [Array.transpose_exn (Array.sub (Array.transpose_exn imgarray) ~pos:prev ~len:(elt-prev))],elt)
    else
      (ls,elt)

    
    ) in
    arraylist



(* Pads the images to a selected dimension - This is needed because the neural network has been trained on 28x28 matrixs *)
let padimages (dim1 : int) (arraylist : float array array list)  =
  let padded_arraylist = List.fold arraylist ~init:[] ~f:(fun accum (elt : float array array) -> 
    let zeromatrix = Array.make_matrix ~dimx:dim1 ~dimy:dim1 0.0 in
    let dim2 = Array.length @@ Array.get (elt) 0 in
    let () = List.iteri (Array.to_list elt) ~f:(fun i elt ->
      let padding_needed =  ((Float.of_int dim1) -. (Float.of_int dim2))/. 2.0 in
      let padleft = Float.round_up padding_needed in
      let padright= Float.round_down padding_needed in
      let paddedarray = List.to_array ((List.init (Int.of_float padleft) ~f:(fun elt -> 0.0)) @ (Array.to_list elt) @ (List.init (Int.of_float padright) ~f:(fun elt -> 0.0))) in
      Array.fill zeromatrix ~pos:(i) ~len:1 paddedarray

      ) in
    accum @ [zeromatrix]
  ) in
  padded_arraylist


(* This function recognizes multiple numbers drawn on an image and outputs the numbers as a string *)
let recognize_multiple_digits (matrix : float array array ) (weights_name_and_path : string) =
  let list_of_padded_28x28_images = extractimages matrix |> (padimages 28) in
  let long_string = List.fold list_of_padded_28x28_images ~init:"" ~f:(fun accum elt -> accum ^ (Int.to_string (predictImageFrom2DArray elt weights_name_and_path))) in
  long_string


