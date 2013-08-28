type empty = [`Empty]

module Class : sig
  type 'a a = < name: [`A]; next: 'a >   (* A is the root *)
  type 'a b = < name: [`B]; next: 'a > a (* B extends A *)
  type 'a c = < name: [`C]; next: 'a > b (* C extends B *)
  type 'a d = < name: [`D]; next: 'a > a (* D extends A *)
  type 'a e = < name: [`E]; next: 'a > d (* E extends D *)
end

module Interface : sig
  type iterable = [ `Iterable | empty ]
  type runnable = [ `Runnable | empty ]
end

type -'a neg

type +'a java

module Instance : sig
  (* A doesn't implement anything *)
  type a = < cls: < > Class.a; intf: empty neg > java
  (* B implements Iterable *)
  type b = < cls: < > Class.b; intf: Interface.iterable neg > java
  (* C implements Iterable *)
  type c = < cls: < > Class.c; intf: Interface.iterable neg > java
  (* D implements Runnable *)
  type d = < cls: < > Class.d; intf: Interface.runnable neg > java
  (* E implements Iterable and Runnable *)
  type e = < cls: < > Class.e; intf: [ Interface.runnable | Interface.iterable ] neg > java
end

module Extends : sig
  (* Instance with open types *)
  type 'a a = 'a java 
    constraint 'a = < cls: 'b Class.a; intf: [> empty] neg >
  type 'a b = 'a java 
    constraint 'a = < cls: 'b Class.b; intf: [> Interface.iterable ] neg >
  type 'a c = 'a java 
    constraint 'a = < cls: 'b Class.c; intf: [> Interface.iterable ] neg >
  type 'a d = 'a java 
    constraint 'a = < cls: 'b Class.d; intf: [> Interface.runnable ] neg >
  type 'a e = 'a java 
    constraint 'a = < cls: 'b Class.e; intf: [> Interface.runnable | Interface.iterable ] neg >
end

module Intf_instance : sig
  type iterable = < cls: < >; intf: Interface.iterable neg > java
  type runnable = < cls: < >; intf: Interface.runnable neg > java
end

module Implements : sig
  type 'a iterable = 'a java
    constraint 'a = < cls: 'b; intf: [> Interface.iterable ] neg >
  type 'a runnable = 'a java
    constraint 'a = < cls: 'b; intf: [> Interface.runnable ] neg >
end
