let thread_1 =
  Lwt.return "hello world"

let _ =
  Lwt.(
    thread_1
    >>= (fun s -> print_endline s; return s))
