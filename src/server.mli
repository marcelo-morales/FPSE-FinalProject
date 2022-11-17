open Core;;

val close : (_, _) t -> unit Async_kernel.Deferred.t
val close_finished : (_, _) t -> unit Async_kernel.Deferred.t
val is_closed : (_, _) t -> bool
val listening_on : (_, 'listening_on) t -> 'listening_on
val num_connections : (_, _) t -> int

type response = Http.Response.t * Body.t [@@deriving sexp_of]



module BackeEnd : sig
    
    (*
        Get result from math operation
    *)
    val get_result : num_one -> num_two -> (int) result

       (*
        What operaiton is currently being computed
    *)
    val get_operation ->  (char) operation

end

