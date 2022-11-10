(* Linear model for the MNIST dataset.
   The 4 following dataset files can be downloaded from http://yann.lecun.com/exdb/mnist/
   These files should be extracted in the 'data' directory.
     train-images-idx3-ubyte.gz
     train-labels-idx1-ubyte.gz
     t10k-images-idx3-ubyte.gz
     t10k-labels-idx1-ubyte.gz

   This should reach ~92% accuracy on the test dataset.
*)

[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-33"]

open Base
open Torch
open Core
open Npy


(* let strings_from_file filename =
  let strings = In_channel.read_all filename in
  strings;;

let count_newlines s =
  let rec go n i =
    try
      let i' = String.index_from_exn s i '\n' in
      go (n + 1) (i' + 1)
      with _ -> n in
  go 0 0;;

 *)


 let npz_test ~use_python_generated_file =
  let array1_v = [|1.; 2.; 3.|] in
  let array2_v = [|[|4.; 5.; 6.|]; [|7.; 8.; 9.|]|] in
  let npz_file =
    if use_python_generated_file
    then "test.npz"
    else
      let tmp_file = Filename.temp_file "handwrittenImage" ".tmp" in
      let npz_out = Npy.Npz.open_out tmp_file in
      Npy.Npz.write
        npz_out
        "test1"
        ( Bigarray.Array1.of_array Float32 C_layout array1_v
        |> Bigarray.genarray_of_array1 );
      Npy.Npz.write
        npz_out
        "test2"
        ( Bigarray.Array2.of_array Float32 C_layout array2_v
        |> Bigarray.genarray_of_array2 );
      Npy.Npz.close_out npz_out;
      tmp_file



let () =
  strings_from_file "handwrittenImage.txt" |> count_newlines |> printf "%i"

(* let () =
  strings_from_file "handwrittenImage.txt" |> print_string; *)
