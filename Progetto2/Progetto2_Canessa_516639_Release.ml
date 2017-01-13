(*!!! DEFINITION OF MY TYPES !!!*)
type ide = string;; (* definition of identifies *)

(* definition of binary operators *)
type binop = Plus
          | Minus
          | Mul
          | Div
          | Eq
          | LThan
          | LEq
          | MThan
          | MEq
;;

(* definition of expressions *)
type exp =  Int of int
        |  Ide of ide
        |  App of ide * exp
        |  Op of exp * binop * exp
        |  If of exp * exp * exp
        |  Etup of tuple
        |  Pipe of tuple
        |  ManyTime of int * exp
(* definition of tuple *)
and tuple = Nil
          | Seq of exp * tuple
;;

(*!!! DEFINITION OF FUNCTIONS FOR INTERPRETER !!!*)

(* definition of starter ambience *)
exception EmptyEnv;;
let env0 = fun x -> raise EmptyEnv;;

(* type checker for expressions *)
let checker (t, v) = match (t: exp) with
                    Int v ->( match v with
                              int -> true
                            | _ -> false)
                  | Ide x -> (match v with
                              Ide u -> true
                            | _ -> false)
                  | Etup v -> (match (v:tuple) with
                              Nil -> true
                            | Seq(e,_) -> (match e with
                                              (x: exp) -> true
                                            | _ -> false)
                            | _ -> false)
                  | Pipe v -> (match v with
                              Nil -> true
                            | Seq(e,_) -> (match e with
                                            (x: exp) -> if(x = (x: 'a -> 'b)) then true else false
                                          | _ -> false)
                            | _ -> false)
;;

(* function to extend ambience *)
let ext env e v = fun y -> if e = y then v else env y;;

(* function to evaluate expressions *)
let rec eval (e:exp) env = match e with
                    Int n -> if checker(Int, n)
                                then i
                                else failwith "wrong type"
                  | Ide i -> if checker(Ide, i)
                                then env i
                                else failwith "wrong type"
                  | App (s, e2) -> if checker(Ide, e2)
                                      then let (par,body) = (fenv s) in (eval body (ext env par (eval e2 env fenv)) fenv)
                                      else  failwith "wrong type"
                  | Op (e1, o, e2) -> if checker(exp, e1) && checker(exp, e2)
                                          then match o with
                                              Plus -> (eval e1 env) + (eval e2 env)
                                            | Minus -> (eval e1 env) - (eval e2 env)
                                            | Mul -> (eval e1 env) * (eval e2 env)
                                            | Div -> (eval e1 env) / (eval e2 env)
                                            | Eq ->  if (eval e1 env) = (eval e2 env) then 1 else 0
                                            | LThen -> if (eval e1 env) < (eval e2 env) then 1 else 0
                                            | LEq -> if (eval e1 env) <= (eval e2 env) then 1 else 0
                                            | MThen -> if (eval e1 env) > (eval e2 env) then 1 else 0
                                            | MThen -> if (eval e1 env) >= (eval e2 env) then 1 else 0
                                            | _ -> failwith "wrong operators"
                                          else failwith "wrong type"
                  | If (e1,e2,e3) -> if (eval e1 env fenv) = 1
                                        then (eval e2 env fenv)
                                          else (eval e3 env fenv)
                  | Etup e -> if checker(tuple, e)
                                 then evalTup e env
                                 else failwith "wrong type"
                  | Pipe t -> if checker(tuple, e)
                                 then evalTup e env fenv
                                 else failwith "wrong type"
                  | ManyTime (n,e) -> if checker(Int n) && checker()
                                         then let rec f n e = if n > 0 then (f (n - 1) (eval e env fenv))
                                         else failwith "wrong type"
(* function to evaluate tuples *)
and evalTup (t:tuple) env = match t with
                  |  Nil -> ()
                  |  Seq (e, Nil) -> (eval e env)
                  |  Seq (e, tp) when tp != Nil -> ((eval e env), (evalTup tp env))
;;
