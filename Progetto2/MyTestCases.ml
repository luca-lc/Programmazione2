# peval(Program([], (Int 5)));;
- : int = 5

# peval(Program([IdeName("i", Int 5)], App("i", Int 2000)));;
- : int = 5

# peval(Program([Fun("Sum", "n", Op(ETup( Seq(Int 5, Nil)), Plus, ETup( Seq(Int 5, Nil))))], Op(Int 2, Plus, Int 4)));;
- : int = 7

# peval(Program([Fun("Sum", "n", Op(Ide "n", Plus, Int 5))], App(ETup(Seq(Int 2, Nil)), Int 2)));;
- : int = 7

# peval(Program([Fun("Sum", "n", Op(Ide "n", Plus, Int 5))], App("Sum",(Op(Int 4, Plus, Int 3)))));;
- : int = 12

# peval(Program([Fun("Min", "n", Op(Ide "n", Minus, Int 5))], App("Min", Int 1)));;
- : int = -4

# peval(Program([Fun("Prod", "n", Op(Ide "n", Mul, Int 12))], App("Prod", Int (-1))));;
- : int = -12

# peval(Program([Fun("Prod", "n", Op(Ide "n", Mul, Int 12))], App("Mod", Int (-1))));;
Exception: EmptyEnv.

# peval(Program([Fun("Div", "n", Op(Ide "n", Div, Int 3))], App("Div", Int 9)));;
- : int = 3

# peval(Program([Fun("Div", "n", Op(Ide "n", Div, Int 0))], App("Div", Int 9)));;
Exception: CannotDividBy_0.

# peval(Program([Fun("eq", "n", Op(Ide "n", Eq, Int 3))], App("eq", Int 9)));;
- : int = 0

# peval(Program([Fun("eq", "n", Op(Ide "n", Eq, Int 9))], App("eq", Int 9)));;
- : int = 1

# peval(Program([Fun("less", "n", Op(Ide "n", LThan, Int 9))], App("less", Int 12)));;
- : int = 0

# peval(Program([Fun("less", "n", Op(Ide "n", LThan, Int 9))], App("less", Int 2)));;
- : int = 1

# peval(Program([Fun("le", "n", Op(Ide "n", LEq, Int 9))], App("le", Int 2)));;
- : int = 1

# peval(Program([Fun("le", "n", Op(Ide "n", LEq, Int 9))], App("le", Int 9)));;
- : int = 1

# peval(Program([Fun("le", "n", Op(Ide "n", LEq, Int 9))], App("le", Int 12)));;
- : int = 0

# peval(Program([Fun("gt", "n", Op(Ide "n", GThan, Int 9))], App("gt", Int 12)));;
- : int = 1

# peval(Program([Fun("gt", "n", Op(Ide "n", GThan, Int 9))], App("gt", Int 9)));;
- : int = 0

# peval(Program([Fun("gt", "n", Op(Ide "n", GThan, Int 9))], App("gt", Int 8)));;
- : int = 0

# peval(Program([Fun("ge", "n", Op(Ide "n", GEq, Int 9))], App("ge", Int 8)));;
- : int = 0


# peval(Program([Fun("ge", "n", Op(Ide "n", GEq, Int 9))], App("ge", Int 9)));;
- : int = 1

# peval(Program([Fun("ge", "n", Op(Ide "n", GEq, Int 9))], App("ge", Int 10)));;
- : int = 1

# peval(Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 0), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int 200)));;
- : int = 199

# peval(Program([Fun("f", "x", (If(Op(Ide "x", GEq, Int 0), Op(Ide "x", Minus, Int 1), Op(Ide "x", Plus, Int 1))))], App("f", Int (-200))));;
- : int = -199
