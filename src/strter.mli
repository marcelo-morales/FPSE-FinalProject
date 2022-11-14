open Torch




val strings_from_file: string -> string
val sanitize:  string -> string option
val remove_first_character: string -> string
val apply_remove_first: string list -> string list
val make_biglist: string list -> string list list


val read_image_from_file: string -> Tensor.t
val predictImage: Tensor.t -> int

(* Maybe if time *)
val save_model: Tensor.t -> unit
val load_model: unit



