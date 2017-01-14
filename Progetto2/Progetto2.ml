(*
------------------------
--- TYPE DEFINITIONS ---
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
--- ENVIROMENT DEFINITIONS ---
------------------------------
*)
exception EmptyEnv;;

let fenv0 = fun x -> raise EmptyEnv;;

let env0 = fenv0;;

let ext env e v = fun y -> if e = y then v else env y;;



(*
-----------------------------
--- EXPRESSION EVALUATION ---
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
--- DECLARETION EVALUATION ---
------------------------------
*)
let rec dval (decls: defin list) = match decls with
            [ ] -> fenv0
         |  Fun (fname, par, body)::rest -> ext (dval rest) fname (par, body)
         |  IdeName (i, v)::rest -> ext (dval rest) i (i,v)
;;



(*
--------------------------
--- PROGRAM EVALUATION ---
--------------------------
*)
let peval (p: prog) = match p with
            Program (decls, expr) -> let fenv = dval(decls) in eval expr env0 fenv;;



(*
------------------
--- TEST CASES ---
------------------

# peval(Program([], (Int 5)));;
- : int = 5

#peval(Program([IdeName("i", Int 5)], App("i", Int 2000)));;
- : int = 5

#peval(Program([Fun("sum", "n", Op(Ide "n", Plus, Int 5))], Op(Int 4, Plus, Int 3)));;
- : int = 7

# peval(Program([Fun("sum", "n", Op(Ide "n", Plus, Int 5))], App("sum", Int 2)));;
- : int = 7

# peval(Program([Fun("sum", "n", Op(Ide "n", Plus, Int 5))], App("sum",(Op(Int 4, Plus, Int 3)))));;
- : int = 12

# peval(Program([Fun("Min", "n", Op(Ide "n", Minus, Int 5))], App("Min", Int 1)));;
- : int = -4

# peval(Program([Fun("Prod", "n", Op(Ide "n", Mul, Int 12))], App("Prod", Int (-1))));;
- : int = -12

# peval(Program([Fun("Prod", "n", Op(Ide "n", Mul, Int 12))], App("Mod", Int (-1))));;
Exception: EmptyEnv.

# peval(Program([Fun("Div", "n", Op(Ide "n", Div, Int 3))], App("Div", Int 9)));;
- : int = 3

# peval(Program([Fun("Div", "n", Op(Ide "n", Div, Int 0))], App("Div", Int 9)));;
Exception: CannotDividBy_0.

# peval(Program([Fun("eq", "n", Op(Ide "n", Eq, Int 3))], App("eq", Int 9)));;
- : int = 0

# peval(Program([Fun("eq", "n", Op(Ide "n", Eq, Int 9))], App("eq", Int 9)));;
- : int = 1

# peval(Program([Fun("less", "n", Op(Ide "n", LThan, Int 9))], App("less", Int 12)));;
- : int = 0

# peval(Program([Fun("less", "n", Op(Ide "n", LThan, Int 9))], App("less", Int 2)));;
- : int = 1

# peval(Program([Fun("le", "n", Op(Ide "n", LEq, Int 9))], App("le", Int 2)));;
- : int = 1

# peval(Program([Fun("le", "n", Op(Ide "n", LEq, Int 9))], App("le", Int 9)));;
- : int = 1

# peval(Program([Fun("le", "n", Op(Ide "n", LEq, Int 9))], App("le", Int 12)));;
- : int = 0

# peval(Program([Fun("gt", "n", Op(Ide "n", GThan, Int 9))], App("gt", Int 12)));;
- : int = 1

# peval(Program([Fun("gt", "n", Op(Ide "n", GThan, Int 9))], App("gt", Int 9)));;
- : int = 0

#peval(Program([Fun("gt", "n", Op(Ide "n", GThan, Int 9))], App("gt", Int 8)));;
- : int = 0

# peval(Program([Fun("ge", "n", Op(Ide "n", GEq, Int 9))], App("ge", Int 8)));;
- : int = 0


#peval(Program([Fun("ge", "n", Op(Ide "n", GEq, Int 9))], App("ge", Int 9)));;
- : int = 1

# peval(Program([Fun("ge", "n", Op(Ide "n", GEq, Int 9))], App("ge", Int 10)));;
- : int = 1

# peval(Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 0), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int 200)));;
- : int = 199

# peval(Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 0), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int (-200))));;
- : int = -199

*)
