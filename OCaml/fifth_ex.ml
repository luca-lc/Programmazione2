(*========= DICHIARAZIONI TIPI =========*)
type exp =
          Int of int
        | Ide of string
        | Add of exp * exp
        | Sub of exp * exp
        | Mul of exp * exp
        | Equ of exp * exp
        | Mequ of exp * exp
        | Not of exp
        | And of exp * exp
        | Or of exp * exp
        | IF of exp * exp * exp
        | AppFun of string * exp

type defin = Funz of string * string * exp;;
type prog = Program of (defin list) * exp;;

(* ambiente globale iniziale *)
exception EmptyEnv;;
let fenv0 = fun x -> raise EmptyEnv;;
(* ambiente locale iniziale *)
let env0 = fenv0;;
(* enstensione ambiente *)
let ext env (x: string) v = fun y -> if x=y then v else env y

(* valutazione espressioni *)
let rec eval (e:exp) env fenv = match e with
      Int i -> i
    | Ide x -> env x
    | Add (e1,e2) -> ( eval e1 env fenv ) + ( eval e2 env fenv )
    | Sub (e1,e2) -> ( eval e1 env fenv ) - ( eval e2 env fenv )
    | Mul (e1,e2) -> ( eval e1 env fenv ) * ( eval e2 env fenv )
    | Equ (e1,e2) -> if ( (eval e1 env fenv) = (eval e2 env fenv) ) then 1 else 0
    | Mequ (e1,e2) -> if ( (eval e1 env fenv) <= (eval e2 env fenv) ) then 1 else 0
    | Not e1 -> if( (eval e env fenv) = 0) then 1 else 0
    | And (e1,e2) -> if ( (eval e1 env fenv) = 0) then 0 else (eval e2 env fenv)
    | Or (e1,e2) -> if ( (eval e1 env fenv) = 0 ) then (eval e2 env fenv) else 1
    | IF (e1,e2,e3) -> if ( (eval e1 env fenv) = 1) then (eval e2 env fenv) else (eval e3 env fenv)
    | AppFun (s,e) -> let (par,esp) = (fenv s) in (eval esp ( ext env par (eval e env fenv) ) fenv)
;;

(* valutazione dichiarazioni *)
let rec dval ( decls: defin list ) = match decls with
    [] -> fenv0
    | Funz (fn, par, body)::rl -> ext ( dval rl ) fn (par,body)
;;

(* valutazione programma *)
let pval (p:prog) = match p with
    Program (dec, e) -> let fenv = dval( dec ) in (eval e env0 (fenv) )
;;





(*================ TEST ==============*)
let prog1 = Program ([], Add(Int 4, Int 5) );;
print_int (pval prog1);;

let prog2 = Program ([], AppFun("prova", Int 5) );;
print_int (pval prog2);;
(*
let prog1 = Program ([], Add(Int 4, Int 5) );;
print_int (pval prog1);;

let prog1 = Program ([], Add(Int 4, Int 5) );;
print_int (pval prog1);;
*)
