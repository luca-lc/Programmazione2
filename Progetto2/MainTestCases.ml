(*
-----------------------------
::: DEFINITIONS TEST CASE :::
-----------------------------
*)

let tc1 = (Program([], (Int 5)));;
let tc2 = (Program([Fun("Sum", "n", Op(Ide "n", Plus, Int 5))], App("Sum",(Op(Int 4, Plus, Int 3)))));;
let tc3 = (Program([Fun("Prod", "n", Op(Ide "n", Mul, Int 12))], App("Prod", Int (-1))));;
let tc4 = (Program([Fun("Div", "n", Op(Ide "n", Div, Int 0))], App("Div", Int 9)));;
let tc5 = (Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 0), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int 200)));;
let tc6 = (Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 0), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int (-200))));;
let tc7 = (Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 46), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int 46)));;

(*
---------------------
::: MAIN FUNCTION :::
---------------------
*)

peval tc<number>;;
