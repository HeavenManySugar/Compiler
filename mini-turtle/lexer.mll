
(* Lexical analyser for mini-Turtle *)

{
  open Lexing
  open Parser

  (* raise exception to report a lexical error *)
  exception Lexing_error of string

  (* note : remember to call the Lexing.new_line function
at each carriage return ('\n' character) *)

}

rule token = parse
  | "//" [^ '\n']* '\n'
  | '\n' { new_line lexbuf; token lexbuf }
  | [' ' '\t' '\r'] { token lexbuf }
  | "(*" { comment lexbuf }
  | eof { EOF }
  | _ { assert false (* To be completed *) }
and comment = parse
  | "*)" { token lexbuf }
  | _ { comment lexbuf }