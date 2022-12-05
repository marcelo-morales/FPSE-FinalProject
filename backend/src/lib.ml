
  This file contains specifications to our project, which is separated into
[@@@warning "-27"]

open Core
open Lwt.Infix
open Cohttp_lwt_unix

let get (url : string) : string Lwt.t =
  Client.get (Uri.of_string url) >>= fun (_res, body) -> body |> Cohttp_lwt.Body.to_string
  [@@coverage off]
;;