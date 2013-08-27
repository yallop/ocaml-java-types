type etc = [`Etc]

type iterable = [`Iterable]

type runnable = [`Runnable]

module Class : sig
  type 'a a = [ `A of 'a | etc]   (* A is the root *)
  type 'a b = [ `B of 'a | etc] a (* B extends A *)
  type 'a c = [ `C of 'a | etc] b (* C extends B *)
  type 'a d = [ `D of 'a | etc] a (* D extends A *)
  type 'a e = [ `E of 'a | etc] d (* E extends D *)
end

type -'a java

module Instance : sig
  type a = etc Class.a java
  type b = [etc Class.b | iterable] java (* B implements Iterable *)
  type c = [etc Class.c | iterable] java (* C implements Iterable *)
  type d = [etc Class.d | runnable] java (* D implements Runnable *)
  type e = [etc Class.e | iterable | runnable] java
  (* E implements Iterable and Runnable *)
end

module Extends : sig
  (* Instance with open types *)
  type 'a a = 'a java constraint 'a = [> 'b Class.a]
  type 'a b = 'a java constraint 'a = [> 'b Class.b | iterable]
  type 'a c = 'a java constraint 'a = [> 'b Class.c | iterable]
  type 'a d = 'a java constraint 'a = [> 'b Class.d | runnable]
  type 'a e = 'a java constraint 'a = [> 'b Class.e | iterable | runnable]
end
