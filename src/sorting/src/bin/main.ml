(* CSCI 1103 Computer Science 1 Honors
   Robert Muller

   Sorting -- insertion sort

   insertionSort: 'a list -> 'a list

   (sort [8; 10; 2]) ==>
   (insert 2 (insert 10 (insert 8 []))) ==>
   [10; 8; 2]

   insert : 'a -> 'a list -> 'a list
*)
let rec insert x xs =
  match xs with
  | [] -> [x]
  | y :: ys ->
    (match x > y with
     | true  -> x :: xs
     | false -> y :: insert x ys)

(* insertionSort : 'a list -> 'a list

   A few notes:
   1. The proposition: "result is descending" is invariant wrt repeat;
   2. insertionSort is quadratic in the worst case;
   3. insertionSort is linear in the best case. (!) *)
let insertionSort ns =
  let rec repeat ms result =
    match ms with
    | [] -> result
    | q :: qs -> repeat qs (insert q result)
  in
  repeat ns []
