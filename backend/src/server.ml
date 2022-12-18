[@@@warning "-27"]

open Core



    type error_response =
    { msg : string
    ; code : int
    }
    (* pixel represented in canvas *)
    type pixel = {x : int; y : int}
  [@@deriving yojson]

(*
  Welcome page.
  localhost:8080/
*)
let welcome : Dream.route =
  Dream.get "/" (fun request -> Dream.html "Welcome to Numerade")
;;
    
(*
get result, callback, instead of responding with html, respondg with a json
  Get result of math operation.
  e.g., localhost:8080/result
*)

(*  

   GET localhost:8080/result/? pass in sequence of zeros and ones

   pass in 2d array as query parameter of get request

first_input -> one_2d_array
second_input -> one_2d_array
   
   *)
let result : Dream.route =
  Dream.get "/result/" (fun req ->
    match Dream.all_queries req with
    | [ ("first_input", first); ("second_input", second); ("operation", operation)] ->
      let first_param, second_paramm =  Int64.of_string first ,  Int64.of_string second  in
      Math.compute ~input_a:first_param  ~input_b: second_param ~op: operation
    
      (* call function to do math
      want - flattened 1d array
      [ [ 0 , 1]
       [0, 1]
      ]

      [1, 2, 3, 4]

      e.g.    Math.compute ~input_a ~price:!real_price ~transaction_time:timestamp
      *)

      |> Dream.json
           ~status:(Dream.int_to_status 200)
           ~headers:[ "Access-Control-Allow-Origin", "*" ]
    | _ ->
      Dream.json ~status:`Bad_Request ~headers:[ "Access-Control-Allow-Origin", "*" ] "")
;;

