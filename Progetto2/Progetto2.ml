(*
--- Type definitions ------
*)
type exp =  Int of int;;
type defin = Funz of string * string * exp;;
type prog = Program of (defin list) * exp;;



(*
--- Function definitions ------
*)
exception EmptyEnv;;
let fenv0 = fun x -> raise EmptyEnv;;
let env0 = fenv0;;
let ext env e v = fun y -> if e = y then v else env y;;



let rec eval (e:exp) env fenv = match e with
                    Int n -> n;;
let rec dval (decls: defin list) = match decls with
            [ ] -> fenv0
         |  Funz (fname, par, body)::rest -> ext (dval rest) fname (par, body);;
let peval (p: prog) = match p with
            Program (decls, expr) -> let fenv = dval(decls) in eval expr env0 fenv;;



(*
--- Test Cases ------
# peval(Program([], (Int 5)));;
- : int = 5
*)
