open Java

let use_B (x : 'a Extends.b) = ();;
let use_D (x : 'a Extends.d) = ();;
let use_C (x : 'a Extends.c) = ();;

(* Error *)
let use_B_and_D x =
  begin
    use_B x;
    use_D x
  end;;


let use_B_and_C x =
  begin
    use_B x;
    use_C x
  end;;

let use_iter (x : 'a Implements.iterable) = ();;
let use_run (x : 'a Implements.runnable) = ();;

let test1 (b: Instance.b) (c: Instance.c) (d: Instance.d) (e: Instance.e) = 
  use_iter b;
  use_iter c;
  use_iter e;
  use_run d;
  use_run e;;

let test2 (b: 'b Extends.b) (c: 'c Extends.c) (d: 'd Extends.d) (e: 'e Extends.e) = 
  use_iter b;
  use_iter c;
  use_iter e;
  use_run d;
  use_run e;;

let test3 (i: Intf_instance.iterable) (r: Intf_instance.runnable) =
  use_iter i;
  use_run r;;

(* Error *)
let use_D_iterable (d: Instance.d) = use_iter d;;

let use_extends_D_iterable (d: 'a Extends.d) = use_iter d;;

(* Error *)
let use_C_runnable (c: Instance.c) = use_run c;;

let use_extends_C_runnable (c: 'a Extends.c) = use_run c;;

(* Error *)
let use_iterable_runnable (i: Intf_instance.iterable) = use_run i;;


let subtype_E_D (x: Instance.e): Instance.d = (x :> Instance.d);;

let subtype_E_A (x: Instance.e): Instance.a = (x :> Instance.a);;

let subtype_E_iterable (x: Instance.e): Intf_instance.iterable = (x :> Intf_instance.iterable);;

(* Error *)
let subtype_E_B (x: Instance.e): Instance.b = (x :> Instance.b);;

(* Error *)
let subtype_A_iterable (x: Instance.a): Intf_instance.iterable = (x :> Intf_instance.iterable);;
