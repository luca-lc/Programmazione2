(*
--- Type definitions ------
*)
type exp =  Int of int
        |  Ide of string
;;
type defin = Fun of string * string * exp
            | IdeName of string * exp
;;
type prog = Program of (defin list) * exp;;



(*
--- Function definitions ------
*)
exception EmptyEnv;;
let fenv0 = fun x -> raise EmptyEnv;;
let env0 = fenv0;;
let ext env e v = fun y -> if e = y then v else env y;;



let rec eval (e:exp) env fenv = match e with
                    Int n -> n
                  | Ide i -> env i
;;
let rec dval (decls: defin list) = match decls with
            [ ] -> fenv0
         |  Fun (fname, par, body)::rest -> ext (dval rest) fname (par, body)
         |  IdeName (i, v)::rest -> ext (dval rest) i (i,v)
;;
let peval (p: prog) = match p with
            Program (decls, expr) -> let fenv = dval(decls) in eval expr env0 fenv;;



(*
--- Test Cases ------
# peval(Program([], (Int 5)));;
- : int = 5
*)

peval(Program([], (Ide "i")));;
peval(Program([j 8], (Ide "i")));;
peval(Program([i 8], (Ide "i")));;
peval(Program([IdeName("i", Int 5); IdeName("v", Int 50)], Ide "i"));;
