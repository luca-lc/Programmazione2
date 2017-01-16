(*
-----------------------------
::: DEFINITIONS TEST CASE :::
-----------------------------
*)
(*::: TEST 1 :::*)
if (
      prog(Int(5), [] ) = PInt(5)
   )
then true
else false;;
(*- : bool = true*)



(*::: TEST 2 :::*)
if (
      prog(Bool(true), [] ) = PBool(true)
   )
then true
else false;;
(*- : bool = true*)



(*::: TEST 3 :::*)
if (
      prog((Op(Int 5, Plus, Int 4)), [] ) = PInt(9)
   )
then true
else false;;
(*- : bool = true*)



(*::: TEST 4 :::*)
if (
      prog(If(Bool(false),Op(Int 5, Plus, Int 4), Int (-404)), [] ) = PInt(9)
   )
then true
else false;;
(*- : bool = false*)



(*::: TEST 5 :::*)
if (
      prog(IsZero( Int 0 ), [] ) = PBool( false )
   )
then true
else false;;
(*- : bool = false*)



(*::: TEST 6 :::*)
if (
      prog(Let("foo", Funz("p", Op(Ide "p", Eq, Int 1)), App(Ide "foo", Int 1)), [] ) = PBool( false )
    )
then true
else false;;
(*- : bool = false*)



(*::: TEST 7 :::*)
if (
      prog(
           Let("double", Funz("p", Op(Ide "p", Mul, Int 2)),
           Let("halve", Funz("p", Op(Ide"p", Div, Int 2)),
           App( Pipe( Seq( Ide "double", Seq( Ide "halve", Nil))), Int 8))),
           []) = PInt( 8 )
    )
then true
else false;;
(*- : bool = true*)



(*::: TEST 8 :::*)
if (
      prog(
           Let("double", Funz("p", Op(Ide "p", Mul, Int 2)),
           Let("halve", Funz("p", Op(Ide"p", Div, Int 2)),
           Let("many", Pipe( Seq( Ide "double", Seq( Ide "halve", Seq(ManyTimes(3, Ide "halve"), Nil)))),
           App( Ide "many", Int 8)))),
           []) = PInt( 1 )
    )
then true
else false;;
(*- : bool = true*)



(*::: TEST 9 :::*)
if (
      prog(
            ETup( Seq( Op(Int 1, Plus, Int 2), Seq( Op(Int 1, GThan, Int 5), Seq( IsZero( Int 0), Nil)))), []
          ) = Tup((PInt 3)::(PBool false)::(PBool true)::[])
   )
then true
else false;;
(*- : bool = true*)
