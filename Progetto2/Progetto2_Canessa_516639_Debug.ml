type exp =  Int of int
        | ETup of tuple
and tuple = Nil
          | Seq of exp * tuple
;;

type rospo = PInt of exp
      | Teval of exp * exp

let rec eval (e:exp) env fenv = match e with
                | ETup t -> let(x,y) = evalTup t env fenv in Teval (x,y)
and evalTup (t:tuple) env fenv = match t with
             Seq(x,y) -> ((eval x env fenv), (evalTup y env fenv))
;;
