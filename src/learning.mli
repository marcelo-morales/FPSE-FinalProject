(* Machine Learning Classifcation *)

open Torch

(* Read all contents from a file and outputs it as a string  *)
val strings_from_file: string -> string


(* Sanitizing removes everything that is not a number or decimalpoint *)
val sanitize:  string -> string option

(* There is an unwanted space when splitting the list by, this function just removes this space *)
val remove_first_character: string -> string

(*  *)
val apply_remove_first: string list -> string list

(*  *)
val make_biglist: string list -> string list list

(* This function combines all auxillary functions to just read image from file and convert it into tensor *)
val read_image_from_file: string -> Tensor.t

(* This function predict image that is in an tensor format and outputs the number it is *)
val predictImageFromTensor: Tensor.t -> int

(* This function takes filename where the image is located and outputs the number it is. - So "testImageWithTwo.txt" -> 2 try with absolute path if it aint working *)
val predictImageFromFileName: string -> int


(* This save the neural network model as a file. This can be used later such that we do not need train the model each we use it *)
val save_model: Tensor.t -> unit

(* This loades the nueral network model *)
val load_model: unit



