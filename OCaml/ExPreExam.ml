cdlet reverse list = let rec rev s t = match s with
                        [] -> t
                    | x::xs -> (rev xs (x::t))
        in rev list [];;

let is_palindrome s = (s = reverse s []);;



let rec insert x n lst = match lst with
        [] when n > 0 -> [x]
      | y::ys -> if n > 0 then y::(insert x (n-1) ys) else x::y::ys;;


let s = "\n";;
let clear x =
  let rec c1 x = if x > 0 then (c1 (x-1)); print_string(s);;


let clear = fun c -> Sys.command "clear";;


let range x y = let rec aux r t = if r > t then [] else r::(aux (r+1) t)
                    in if x > y then (reverse (aux y x))
                                else (aux x y)
;;

(* ========================================================================================================================================================================================== *)

type ide = string;;

type exp = Int of int
        |  Ide of ide
        |  Add of exp * exp
        |  Sub of exp * exp
        |  Mul of exp * exp
        |  Ug of exp * exp
        |  MinUg of exp * exp
        |  And of exp * exp
        |  Or of exp * exp
        |  Not of exp
        |  IfThenElse of exp * exp * exp
        |  Call of ide * exp
;;

type dec = Dec of ide * ide * exp;;
type prog = DecProg of (dec list) * exp;;


exception EmptyEnv;;
let fenv0 = fun x -> raise EmptyEnv;;
let env0 = fenv0;;
let ext env (x:ide) v = fun y -> if x = y then v else env y;;


let rec eval (e:exp) env fenv = match e with
                Int n -> n
            |   Ide i -> env i
            |   Add (e1,e2) -> (eval e1 env fenv) + (eval e2 env fenv)
            |   Sub (e1,e2) -> (eval e1 env fenv) - (eval e2 env fenv)
            |   Mul (e1,e2) -> (eval e1 env fenv) * (eval e2 env fenv)
            |   Ug (e1,e2) -> if((eval e1 env fenv) = (eval e2 env fenv)) then 1 else 0
            |   MinUg (e1,e2) -> if ((eval e1 env fenv) <= (eval e2 env fenv)) then 1 else 0
            |   And (e1,e2) -> if ((eval e1 env fenv) != 0) then (eval e2 env fenv) else 0
            |   Or (e1,e2) -> if ((eval e1 env fenv) = 0) then (eval e2 env fenv) else 1
            |   Not e -> if ((eval e env fenv) = 0) then 1 else 0
            |   IfThenElse (e1,e2,e3) -> if ((eval e1 env fenv) = 1) then (eval e2 env fenv) else (eval e3 env fenv)
            |   Call (i,e) -> let (x,ex) = (fenv i) in (eval ex (ext env x (eval e env fenv)) fenv)

and
decval (e:dec list) = match e with
            [] -> fenv0
        |   Dec (x,y,e)::lst -> ext (decval lst) x (y,e)


and
progval (p:prog) = match p with
            DecProg (declist, e) -> let fenv = (decval declist) in eval e env0 fenv;;

(* ========================================================================================================================================================================================== *)

type ide = string;;

type exp = Int of int
        |  Ide of ide
        |  Let of ide * exp * exp
        |  Record of (ide * exp) list
        |  Select of exp * ide
;;

type denexp = Dint of int
           |  Drec of (ide * denexp) list
;;

exception EmptyEnv;;

let env0 = f x -> raise EmptyEnv;;
let ext env (x:ide) v = f y -> if x = y then v else env y;;

let sem (e:exp) env = match e with
          Int n -> Dint n
        | Ide i -> env i
        | Let (x,e1,e2) -> let v =  sem e1 env in
                            let env1 = ext env x v
                        in sem e2 env1
        | Record lst -> let v = semli lst env in Drec v
        | Select (e,i) ->   match e with
                     Ide x -> match env x with
                            Drec c -> look i c
                         |  _ -> failwith "wrong ide"
                    | _ -> failwith "wrong exp"
and
look i c = match c with
           [] -> failwith "wrong selection"
         | (x,y)::z -> if x = i then y else look x z
and
semli li env = match li with
            [] -> []
          | (i,e)::l -> (i,(eval e env))::(semli l env)
;;

(*-----------------------------------------*)

val n : int = 5
val h : int -> int = <fun>
val f : (int -> int) -> int -> int = <fun>ex

(* ========================================================================================================================================================================================== *)

type exp = DecFun of ide * exp * exp
      |   App of ide * exp
      |   Call of ide
;;
type decval = Dfunval of ide * exp * exp * eval env;;


let rec sem e env = match e with
        DecFun (x,e1,e2) -> Dfunval (x,e1,e2 env)
      | App (x,e) -> match (sem x env) with
                          Dfunval (a,b,c,d) -> sem(c, bind(d, a, sem(e, d)))
                        | _ -> failwith "wrong"
      | Call x -> match (sem x env) with
                          Dfunval (a,b,c,d) -> sem(c, bind(d, a, sem(b, d)))
                        | _ -> failwith "wrong"
;;

(*-----------------------------------------*)

val iterate : int -> ('a -> 'a ) -> 'a -> 'a = <fun>
val power : int -> int -> int = <fun>

(*-----------------------------------------*)
(*
16 bit a carattere
26 + 16 + 15 = 57 caratteri
 1 +  1 +  1 = 3 caratteri terminatori
60 caratteri
54 + 34 + 32 = 120 byte = 960 bit

64 blocchi totali
4 blocchi per la prima frase
3 blocchi per la seconda frase
2 blocchi per la terza frase

64 - 4 - (3+2) <= 0

5x ≤ 60

C'è frammentazione interna perché lo spazio per la prima e seconda frase è minore rispetto al blocco totale.
*)
