(*
------------------------------
::: ENVIROMENT DEFINITIONS :::
------------------------------
*)
exception Unbound of string;;

type 'a env = (string * 'a) list;;

let rec appenv (_w, e) = match e with
	               [] -> raise ( Unbound _w )
              | (_w1, v1)::r1 -> if _w = _w1 then v1 else appenv(_w, r1)
;;

let bind (x, v, r) = (x, v)::r;;



(*
------------------------
::: TYPE DEFINITIONS :::
------------------------
*)
type ide = string;;

type binop = Plus
					|  Minus
					|  Mul
					|  Div
					|  Eq
					|  LThan
					|  LEq
					|  GThan
					|  GEq
;;

type exp =  Int of int
         |  Bool of bool
         |  Ide of ide
         |  App of exp * exp
				 |  Op of exp * binop * exp
				 |  IsZero of exp
				 |  If of exp * exp * exp
				 | 	Let of ide * exp * exp
				 |  Funz of ide * exp
         |  ETup of tuple
         |  Pipe of tuple
         |  ManyTimes of int * exp
and tuple = Nil
         | Seq of exp * tuple
;;

type eva = PInt of int
	       | PBool of bool
         | Fun of ide * exp * eva env
	       | Tup of eva list
;;



(*
-----------------------------
::: EXPRESSION EVALUATION :::
-----------------------------
*)
exception CannotApplyPipe;;
exception Error;;

let rec check (t, v) =  match t with
                    "exp" -> ( match (v:exp) with
                                Int n -> true
                              | Ide i -> true
                              | App (z,q) -> check("exp", z) && check("exp", q)
                              | If(e1,e2,e3) -> check("exp", e1) && check("exp", e2) && check("exp", e3)
                              | _ -> false
                             )
                  | _ -> false
;;

let plus ((x), (y)) = match (x,y) with
							( PInt(u), PInt(v) ) -> PInt(u+v)
							|_ -> failwith ("Error")
;;

let minus (x, y) = match (x,y) with
							( PInt(u), PInt(v) ) -> PInt(u-v)
							|_ -> failwith ("Error")
;;

let mul (x, y) = match (x,y) with
							( PInt(u), PInt(v) ) -> PInt(u*v)
							|_ -> failwith ("Error")
;;

let div (x, y) = match (x,y) with
							( PInt(u), PInt(v) ) -> PInt(u/v)
							|_ -> failwith ("Error")
;;

let eq (x, y) = match (x,y) with
								(PInt(u),PInt(v)) -> if u = v then PBool( true ) else PBool( false )
							| _ -> failwith "Error"
;;

let lthan (x, y) = match (x,y) with
								(PInt(u),PInt(v)) -> if u < v then PBool( true ) else PBool( false )
							| _ -> failwith "Error"
;;

let leq (x, y) = match (x,y) with
								(PInt(u),PInt(v)) -> if u <= v then PBool( true ) else PBool( false )
							| _ -> failwith "Error"
;;

let gthan (x, y) = match (x,y) with
								(PInt(u),PInt(v)) -> if u > v then PBool( true ) else PBool( false )
							| _ -> failwith "Error"
;;

let geq (x, y) = match (x,y) with
								(PInt(u),PInt(v)) -> if u >= v then PBool( true ) else PBool( false )
							| _ -> failwith "Error"
;;

let is_zero x = match (x) with
								PInt(u) -> PBool( u = 0 )
							| _ -> failwith "Error"
;;

let rec gen_tup l = match l with
											[] -> []
										| t::tl -> ( match t with
															     Fun(x, y, z) -> gen_tup tl@[t]
																 | Tup( x ) -> (gen_tup tl)@(gen_tup x)
																 | _ -> raise Error
																)
;;

let rec eval ((e:exp),(en:eva env)) = match e with
                    Int n -> if check( "exp", Int n ) then PInt n else failwith "wrong type1"
									| Bool x -> PBool x
									| Ide i ->  if check( "exp", Ide i ) then appenv(i, en) else failwith "wrong type2"
                  | App (s, ex) -> ( match eval(s,en) with
																								Fun(k, j, en1) -> eval(j, bind(k, eval(ex, en), en1))
																							| Tup t -> let rec sem(ls, v) = ( match ls with
																																									Fun(x, b, en1)::[] -> eval(b, bind(x, eval(v, en), en1))
																																								|	Fun(x, b, en1)::tl -> eval(b, bind(x, sem(tl, v), en1))
																																								| _ -> raise Error
																																							)
																																				in sem( gen_tup(t), ex)
																							| _ -> raise Error
																					)
										| Op (e1, op, e2) -> if (check("exp", e1) && check("exp", e2)) then ( match op with
																																													Plus  ->  plus(eval(e1,en),eval(e2,en))
																																		                    | Minus -> minus(eval(e1,en),eval(e2,en))
																																		                    | Mul -> mul(eval(e1,en),eval(e2,en))
																																		                    | Div -> div(eval(e1,en),eval(e2, en))
																																		                    | Eq ->  eq(eval(e1,en),eval(e2,en))
																																		                    | LThan -> lthan(eval(e1,en),eval(e2,en))
																																		                    | LEq -> leq(eval(e1,en),eval(e2,en))
																																		                    | GThan -> gthan(eval(e1,en),eval(e2,en))
																																		                    | GEq -> geq(eval(e1,en),eval(e2,en))
																																											)
																																									else failwith "wrong type4"
                    | IsZero z -> is_zero(eval(z,en))
                  	| If (e1,e2,e3) -> if (eval (e1,en)) = PBool(true)
                                              then (eval(e2,en))
                                                else (eval(e3, en))
										| Let (i, p, v) -> eval(v, bind(i, eval(p,en),en))
										| Funz (i, p) -> Fun(i, p, en)
        						| ETup t  -> let rec listtup t = match t with
                			                       Nil -> []
          			                           | Seq(e1, tl) -> (eval (e1,en))::listtup(tl)
                                       in Tup(listtup t)
                    | Pipe t  -> let rec listtup t = match t with
                			                       Nil -> []
                			                     | Seq(Ide f, tl) -> (eval (Ide f, en))::listtup(tl)
            			                         | Seq(ManyTimes(n, f), tl) -> (eval (ManyTimes(n, f),en))::listtup(tl)
            			                         | Seq(_,_) -> raise CannotApplyPipe
        			                         in Tup (listtup t )
                    | ManyTimes(n, f) -> let rec manytimes(n, fz) = match n with
                				                      0 -> []
          				                          | _ -> (eval(fz, en))::manytimes(n-1, fz)
        				                        in Tup(manytimes(n, f))
;;



(*
--------------------------
::: PROGRAM EVALUATION :::
--------------------------
*)
let prog = fun p -> eval p;;
