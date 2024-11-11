
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
  | "forward" { FORWARD }
  | ['0'-'9']+ as s { INT (int_of_string s) }
  | '+' { ADD }
  | '-' { SUB }
  | '*' { MUL }
  | '/' { DIV }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | eof { EOF }
  | _ { assert false (* To be completed *) }
and comment = parse
  | "*)" { token lexbuf }
  | _ { comment lexbuf }