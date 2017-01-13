type pixel = int * int * int;;

type exp =
		Ide of string
	|  	Pixel of pixel
	| 	Lighten of exp
	| 	Darken of exp
	(*| 	Let of exp * exp * exp*)
;;

type eal = Unbound | Pix of pixel;;

let ext env (x:exp) v = fun y -> if x=y then v else env y;;


let check e = if e >= 0 && e <= 255 then true else false;;

let inc p = match p with
		255 -> 255
	|  	n -> n + 1
;;

let dec p = match p with
		0 -> 0
	| 	n -> n - 1
;;

let increase n = match n with
	Pix (r,g,b) -> Pix(inc r, inc g, inc b);;

let decrease n = match n with
	Pix (r,g,b) -> Pix(inc r, inc g, inc b);;



let rec evol (e:exp) env = match e with
 		Ide	i -> env i
	| 	Pixel (r, g, b) -> if ((check r) && (check g) && (check b)) then Pix (r, g, b) else Unbound
	| 	Lighten s -> let v = (evol s env) in increase v
	| 	Darken s -> let v = (evol s env) in decrease v
	(*| 	Let (i, exp1, exp2 ) -> let v = (evol (exp1 env)) in let c = ext(env i v) in evol (exp2 c)*)
	;;
