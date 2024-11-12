
(* Lexical analyser for mini-Turtle *)

{
  open Lexing
  open Parser

  (* raise exception to report a lexical error *)
  exception Lexing_error of string
  
  let keywords = function
    | "if" -> IF
    | "else" -> ELSE
    | "def" -> DEF
    | "repeat" -> REPEAT
    | "penup" -> PENUP
    | "pendown" -> PENDOWN
    | "forward" -> FORWARD
    | "turnleft" -> TURNLEFT
    | "turnright" -> TURNRIGHT
    | "color" -> SETCOLOR
    | "black" -> COLOR Turtle.black
    | "white" -> COLOR Turtle.white
    | "red" -> COLOR Turtle.red
    | "green" -> COLOR Turtle.green
    | "blue" -> COLOR Turtle.blue
    | id -> IDENT id
  (* note : remember to call the Lexing.new_line function
at each carriage return ('\n' character) *)

}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let ident = letter (letter | digit | '_')*


rule token = parse
  | "//" [^ '\n']* '\n'
  | '\n' { new_line lexbuf; token lexbuf }
  | [' ' '\t' '\r'] { token lexbuf }
  | "(*" { comment lexbuf }
  | ident as id { keywords id }
  | digit+ as s { INT (int_of_string s) }
  | '+' { ADD }
  | '-' { SUB }
  | '*' { MUL }
  | '/' { DIV }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | '{' { LBRACE }
  | '}' { RBRACE }
  | ',' { COMMA }
  | eof { EOF }
  | _ { assert false (* To be completed *) }
and comment = parse
  | "*)" { token lexbuf }
  | _ { comment lexbuf }