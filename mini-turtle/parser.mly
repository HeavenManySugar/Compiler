
/* Parsing for mini-Turtle */

%{
  open Ast

%}

/* Declaration of tokens */

%token EOF
/* To be completed */
%token FORWARD
%token <int> INT
%token ADD SUB MUL DIV
%token LPAREN RPAREN

/* Priorities and associativity of tokens */

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
;

expr:
  | c = INT { Econst c }
  | e1 = expr op = binop e2 = expr { Ebinop (op, e1, e2) }
  | LPAREN e = expr RPAREN  { e }
;

%inline binop:
  | ADD { Add }
  | SUB { Sub }
  | MUL { Mul }
  | DIV { Div }
;