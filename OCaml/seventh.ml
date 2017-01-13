type ide = string;;

type exp = 	Int of int
		|	Ide of ide
		|	Rec of (ide * exp) list
		|	Let of ide * exp * exp
		|	Sec of ide * exp
;;

type dexp = Dint of int
		| Drec of (ide * dexp) list
;;

exception EmptyEnv;;

let env0 = fun x -> raise EmptyEnv;;

let ext env (x:ide) v = fun y -> if x = y then v else env y;;

let rec sem (e:exp) env = match e with
				Int i -> Dint i
			|	Ide i -> env i
			|	Rec l -> let v = (evalList l env) in Drec v
			|	Sec (x,e) -> match e with
			  			Den x -> match env x with
								Drec l -> look i l
							| 	_ -> failwith "wrong ide"
						|	_ -> failwith "wrong exp"
			|	Let(x,e1,e2) -> let v = sem e1 env in
									let c = ext env x v in
								sem e2 c
and
evalList list env = match list with
			[] -> []
		|	(e1,e2)::rli -> (e1, sem(e2 env))::(evalList rli env)

and
look i list = match list with
			[] -> failwith "ciaone"
		|	(x,e)::rl -> if x = i then e then (look i rl)
;;

let inttoint di = match di with
			Dint i -> i
		|	_ -> failwith "ciaone2"
;;
