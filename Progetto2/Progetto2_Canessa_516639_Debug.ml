(* DEBUG FILE *)


type ide = string;;

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
        |  Ide of ide
        |  App of ide * exp
        |  Op of exp * binop * exp
        |  If of exp * exp * exp
        |  Etup of tuple
        |  Pipe of tuple
        |  ManyTime of int * exp
and tuple = Nil
          | Seq of exp * tuple
;;

exception EmptyEnv;;
let fenv0 = fun x -> raise EmptyEnv;;
let env0 = fenv0;;
let ext env e v = fun y -> if e = y then v else env y;;


let rec eval (e:exp) env fenv = match e with
                    Int n -> n
                  | Ide i -> env i
                  | App (s, e2) -> let (par,body) = (fenv s)
                                    in (eval body (ext env par (eval e2 env fenv)) fenv)
                  | Op (e1, o, e2) -> (
                                        match o with
                                          Plus -> (eval e1 env fenv) + (eval e2 env fenv)
                                        | Minus -> (eval e1 env fenv) - (eval e2 env fenv)
                                        | Mul -> (eval e1 env fenv) * (eval e2 env fenv)
                                        | Div -> (eval e1 env fenv) / (eval e2 env fenv)
                                        | Eq ->  if (eval e1 env fenv) = (eval e2 env fenv) then 1 else 0
                                        | LThan -> if (eval e1 env fenv) < (eval e2 env fenv) then 1 else 0
                                        | LEq -> if (eval e1 env fenv) <= (eval e2 env fenv) then 1 else 0
                                        | GThan -> if (eval e1 env fenv) > (eval e2 env fenv) then 1 else 0
                                        | GEq -> if (eval e1 env fenv) >= (eval e2 env fenv) then 1 else 0
                                        | _ -> failwith "wrong operators"
                                      )
                  | If (e1,e2,e3) -> if (eval e1 env fenv) = 1
                                        then (eval e2 env fenv)
                                          else (eval e3 env fenv)
                  | Etup ex -> evalTup ex env fenv
                  | Pipe t -> evalTup t env fenv
and evalTup (t:tuple) env fenv = match t with
                     Seq (e, Nil) -> ((eval e env fenv))
                  |  Seq (e, tp) when tp != Nil -> let rec  ((eval e env fenv), (evalTup tp env fenv))
;;


(*
| ManyTime (n, e) -> let rec foo (n, e) = if (n > 1)
                                            then foo ((n - 1),(eval e env fenv))
                                            else (eval e env fenv)
*)
