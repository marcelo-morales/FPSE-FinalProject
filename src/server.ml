(* let () =
  Dream.run (fun _ ->
    Dream.html "Good morning, world!") *)

(* Middleware *)
(* let () =
  Dream.run
    (Dream.logger (fun _ ->
      Dream.html "Good morning, world!")) *)

(* Actual code... *)
let () =
  Dream.run
  @@ Dream.logger
  @@ fun _ -> Dream.html "Good morning, world!"


(* routing *)
(* let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.router [

    Dream.get "/"
      (fun _ ->
        Dream.html "Good morning, world!");

    Dream.get "/echo/:word"
      (fun request ->
        Dream.html (Dream.param request "word"));

  ] *)

  