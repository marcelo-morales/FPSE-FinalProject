[@@@warning "-27"]

open Lib
open Core

(* let () =
  Dream.run (fun _ ->
    Dream.html "Good morningg, Christian! I got this to work! Lets create a cool project") *)

    type error_response =
    { msg : string
    ; code : int
    }
  [@@deriving yojson]

(*
  Welcome page.
  localhost:8080/
*)
let welcome : Dream.route =
  Dream.get "/" (fun request -> Dream.html "Welcome to numerade")
;;
    
(*
  Get result of math operation.
  e.g., localhost:8080/result
*)
let result : Dream.route =
  Dream.get "/result" (fun _ ->
    Dream.get "/" (fun request -> Dream.html "get result")
;;

(* Template for catching error statuses and forwarding errors to the client *)
let my_error_template debug_info suggested_response =
  let status = Dream.status suggested_response in
  let code = Dream.status_to_int status
  and msg = Dream.status_to_string status in
  suggested_response
  |> Dream.with_header "Content-Type" Dream.application_json
  |> Dream.with_header "Access-Control-Allow-Origin" "*"
  |> Dream.with_body @@ Yojson.Safe.to_string @@ error_response_to_yojson { msg; code }
  |> Lwt.return
;;

let () =
  Dream.run ~error_handler:(Dream.error_template my_error_template)
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router [ welcome; result ]
  @@ Dream.not_found
;;

