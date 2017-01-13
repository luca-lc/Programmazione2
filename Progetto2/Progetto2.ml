type exp =  Int of int;;

let rec eval (e:exp) env fenv = match e with
                    Int n -> n;;
exception EmptyEnv;;
let fenv0 = fun x -> raise EmptyEnv;;
let env0 = fenv0;;exception EmptyEnv;;

(
*TEST
# eval (Int 5) env0 fenv0;;
- : int = 5
*)
