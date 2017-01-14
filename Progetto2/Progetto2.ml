(*
------------------------
::: TYPE DEFINITIONS :::
------------------------
*)
    (*
      Boolean values are evaluated like integer:
      -  1 as true
      -  0 as false
    *)
type binop = Plus
           | Minus
           | Mul
           | Div
           | Eq
           | LThan
           | LEq
           | GThan
           | GEq
;;

type exp =  Int of int
        |  Ide of string
        |  App of string * exp
        |  Op of exp * binop * exp
        |  If of exp * exp * exp
;;

type defin = Fun of string * string * exp
            | IdeName of string * exp
;;

type prog = Program of (defin list) * exp;;



(*
------------------------------
::: ENVIROMENT DEFINITIONS :::
------------------------------
*)
exception EmptyEnv;;

let fenv0 = fun x -> raise EmptyEnv;;

let env0 = fenv0;;

let ext env e v = fun y -> if e = y then v else env y;;



(*
-----------------------------
::: EXPRESSION EVALUATION :::
-----------------------------
*)
exception CannotDividBy_0;;

let rec eval (e:exp) env fenv = match e with
                    Int n -> n
                  | Ide i ->  env i
                  | App (s, e) -> let (par,body) = (fenv s)
                                    in (eval body (ext env par (eval e env fenv)) fenv)
                  | Op (e1, o, e2) -> (
                                        match o with
                                          Plus -> (eval e1 env fenv) + (eval e2 env fenv)
                                        | Minus -> (eval e1 env fenv) - (eval e2 env fenv)
                                        | Mul -> (eval e1 env fenv) * (eval e2 env fenv)
                                        | Div -> if ((eval e2 env fenv) != 0) then (eval e1 env fenv) / (eval e2 env fenv) else raise CannotDividBy_0
                                        | Eq ->  if (eval e1 env fenv) = (eval e2 env fenv) then 1 else 0
                                        | LThan -> if (eval e1 env fenv) < (eval e2 env fenv) then 1 else 0
                                        | LEq -> if (eval e1 env fenv) <= (eval e2 env fenv) then 1 else 0
                                        | GThan -> if (eval e1 env fenv) > (eval e2 env fenv) then 1 else 0
                                        | GEq -> if (eval e1 env fenv) >= (eval e2 env fenv) then 1 else 0
                                      )
                  | If (e1,e2,e3) -> if (eval e1 env fenv) = 1
                                          then (eval e2 env fenv)
                                          else (eval e3 env fenv)
;;



(*
------------------------------
::: DECLARETION EVALUATION :::
------------------------------
*)
let rec dval (decls: defin list) = match decls with
            [ ] -> fenv0
         |  Fun (fname, par, body)::rest -> ext (dval rest) fname (par, body)
         |  IdeName (i, v)::rest -> ext (dval rest) i (i,v)
;;



(*
--------------------------
::: PROGRAM EVALUATION :::
--------------------------
*)
let peval (p: prog) = match p with
            Program (decls, expr) -> let fenv = dval(decls) in eval expr env0 fenv;;
