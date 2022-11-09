(* let () =
  Dream.run (fun _ ->
    Dream.html "Good morning, world!") *)

(* Middleware *)
let () =
  Dream.run
    (Dream.logger (fun _ ->
      Dream.html "Good morning, world!"))

(* Actual code... *)
let () =
  Dream.run
  @@ Dream.logger
  @@ fun _ -> Dream.html "Good morning, world!"