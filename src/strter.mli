open Torch_core

type 'a t (* hide the type 'a list here by not giving it in signature *)
val emptyset : 'a t
val add: 'a -> 'a t ->'a t
val remove : 'a -> 'a t ->  ('a -> 'a -> bool) -> 'a t
val contains: 'a -> 'a t ->  ('a -> 'a -> bool) -> bool    

val predictImage: Torch_core.Wrapper.Tensor.t -> int




