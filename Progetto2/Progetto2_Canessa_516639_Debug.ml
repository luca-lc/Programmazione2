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
        |  Op of (exp * binop * exp)
        |  If of exp * exp * exp
        |  ETup of tuple
        |  Pipe of tuple
        |  ManyTime of int * tuple
and tuple = Nil
          | Seq of exp * tuple
;;

type eval =
	|DInt of int
	|Funval of ide*exp*eval env
	|Tup of eval list
;;


type defin = Fun of string * string * exp;;

type prog = Program of (defin list) * exp;;



exception EmptyEnv;;

let fenv0 = fun x -> raise EmptyEnv;;

let env0 = fenv0;;

let ext env e v = fun y -> if e = y then v else env y;;


let rec check (t, v) =  match t with
                    "exp" -> ( match (v:exp) with
                                Int n -> true
                              | Ide i -> true
                              | App (z,q) -> check("string", Ide z) && check("exp", q)
                              | Op(e1,o,e2) -> check("exp", e1) && check("exp", e2)
                              | If(e1,e2,e3) -> check("exp", e1) && check("exp", e2) && check("exp", e3)
                              | _ -> false
                             )
                  | _ -> false
;;


let rec eval (e:exp) env fenv = match e with
                    Int n -> check( "int", Int n )
                  | Ide i -> check( "string", Ide i )
                  | App (s, e) -> check("string", Ide s) && check("exp", e)
                  | Op(e1,o,e2) -> check("exp", e1) && check("exp", e2)
                  | If(e1,e2,e3) -> check("exp", e1) && check("exp", e2) && check("exp", e3)
                  | ETup t -> check("tuple", t)
;;

let rec dval (decls: defin list) = match decls with
            [ ] -> fenv0
         |  Fun (fname, par, body)::rest -> if check("exp", Ide par) && check("exp", body) then ext (dval rest) fname (par, body) else failwith "puppa2"
;;

let peval (p: prog) = match p with
            Program (decls, expr) -> let fenv = dval(decls) in eval expr env0 fenv ;;
