(* CSCI 1103 Computer Science 1 Honors
   Robert Muller

   Primality and Factoring

   isPrime : int -> bool

   (isPrime 7) ==> true
   (isPrime 25) ==> false

isFactor : int -> int -> bool *)
let isFactor m n = n mod m = 0

(* isPrime : int -> bool

   A naive version. Problems:
   1. No need to check numbers 2 .. n/2, only need to check 2 .. sqrt(n);
   2. The inner variable named n is -invariant- with respect to the repeat
      function. We should omit it.

   Both problems fixed below. *)
let isPrime n =
  let rec repeat i n =
    match i > n / 2 with
    | true  -> true
    | false ->
      (match isFactor i n with
       | true  -> false
       | false -> repeat (i + 1) n)
  in
  repeat 2 n

(* isPrime : int -> bool

   An improved version, checks possible factors in range 2 .. sqrt(n). *)
let isPrime n =
  let top = int_of_float(sqrt(float n)) in
  let rec repeat i =
    match i > top with
    | true  -> true
    | false ->
      (match isFactor i n with
       | true  -> false
       | false -> repeat (i + 1))
  in
  repeat 2

(* Multiplying and Factoring --- the former is "easy", the latter is "hard".
   NB: A proper factor of N is a factor of N other than 1 or N. *)

(* multiply : int * int -> int *)
let multiply (m, n) = m * n

(* Finding factors: find the minimum proper factor and its co-factor. This is
   hard. If n is the product of 2 prime numbers, there are only two proper
   factors. How to compute them? We have to root around looking for them!

   searchForFactors : int -> (int * int) option *)
let searchForFactors n =
  let top = int_of_float(sqrt(float n)) in
  let rec loop i =
    match i > top with
    | true  -> None
    | false ->
      (match isFactor i n with
       | true  -> Some (i, n / i)
       | false -> loop (i + 1))
  in
  loop 2
