open Lwt

let ping_cond : unit Lwt_condition.t =
  Lwt_condition.create ()

let pong_cond : unit Lwt_condition.t =
  Lwt_condition.create ()

let rec ping () =
  Lwt_condition.wait ping_cond >>= begin fun () ->
    print_endline "O\t->";
    Lwt_condition.broadcast pong_cond ();
    ping ()
  end

let rec pong () =
  Lwt_condition.wait pong_cond >>= begin fun () ->
    print_endline "\t<-\tO";
    Lwt_condition.broadcast ping_cond ();
    pong ()
  end

let _ =
  Lwt_main.run @@ join [
    ping ();
    pong ();

    (* fire condition *)
    wrap (fun () -> Lwt_condition.broadcast ping_cond ())
  ]
