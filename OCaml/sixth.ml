type ide = string;;
type exp = Ide of ide
		| 	Int of int
		| 	Record of (ide * exp) list
		| 	Select of exp * ide
		| 	Let ide * exp * exp
;;

type dexp = DInt of int
			| DRec of (ide * dexp) list
;;

exception EnvEmpty;;
let env0 = fun x -> raise EnvEmpty;;
let ext env (x:ide) v = fun y -> if x = y then v else env y;;

let rec evallist l env = match l with
			[] -> []
		| (i,e)::minl -> (i, (eval e env))::(evallist minl env)
;;

let rec look id l = match l with
			[] -> failwith "wrong list"
		| (x,y)::z -> if x == id then y else look id z
;;

let rec eval (e:exp) env = match e with
		Ide i -> env i
	| Int n -> DInt n
	| Record e -> let v = (evallist e env) in DRec v
	| Select (e, id) -> match e with
					Ide i -> match env i with
												DRec c -> look i c
											| _ -> failwith "wrong ide"
					| _ -> failwith "wrong exp"
	| Let (i, exp1, exp2) -> let v = (eval (exp1 env)) in (let newenv = (ext env i v)) in eval exp2 newenv
;;
