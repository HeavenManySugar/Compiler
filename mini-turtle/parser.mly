
/* Parsing for mini-Turtle */

%{
  open Ast

  let neg e = Ebinop (Sub, Econst 0, e)
%}

/* Declaration of tokens */

%token EOF
/* To be completed */
%token FORWARD
%token PENUP, PENDOWN, TURNLEFT, TURNRIGHT, SETCOLOR
%token IF, ELSE, REPEAT
%token <Turtle.color> COLOR
%token <int> INT
%token <string> IDENT
%token ADD SUB MUL DIV
%token LPAREN RPAREN, LBRACE, RBRACE, COMMA


/* Priorities and associativity of tokens */
%left ADD SUB
%left MUL DIV
/* To be completed */

/* Axiom of the grammar */
%start prog

/* Type of values ​​returned by the parser */
%type <Ast.program> prog

%%

/* Production rules of the grammar */

prog:
  main = stmt*
  /* To be completed */ EOF
    { { defs = []; main = Sblock main } (* To be modified *) }
;


stmt:
  | FORWARD e = expr
    { Sforward e }
  | PENUP
    { Spenup }
  | PENDOWN
    { Spendown }
  | TURNLEFT e = expr
    { Sturn e }
  | TURNRIGHT e = expr
    { Sturn (neg e) }
  | SETCOLOR c = COLOR
    { Scolor c } 
  | IF e = expr s = stmt
    { Sif (e, s, Sblock []) }
  | IF e = expr s1 = stmt ELSE s2 = stmt
    { Sif (e, s1, s2) }
  | REPEAT e = expr s = stmt
    { Srepeat (e, s) }
  | LBRACE s = stmt* RBRACE
    { Sblock s }
;

expr:
  | c = INT { Econst c }
  | id = IDENT  { Evar id }
  | e1 = expr op = binop e2 = expr { Ebinop (op, e1, e2) }
  | LPAREN e = expr RPAREN  { e }
;

%inline binop:
  | ADD { Add }
  | SUB { Sub }
  | MUL { Mul }
  | DIV { Div }
;