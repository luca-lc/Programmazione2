let rec insert_at x n lst = match lst with
                           [] -> x::[]
                        |  z::zs when n = 0 -> x::z::zs
                        |  z::zs when n != 0 -> z::(insert_at x (n-1) (zs));;




let rec range a b = if a>b then a::(range (a - 1) b )
                     else
                        if a < b then (range a (b - 1))@[b]
                           else
                              [a]
                              ;;



let size l = 
    let rec s1 l n = match l with
        [] -> 0
    |   x::xs -> s1 xs n+1
in
    s1 l 0;;
