(* file: babyloniansqrt.ml
 * author: Bob Muller

   CSCI 1103 Computer Science 1 Honors

   Computing an approximation of the square root, Babylonian style.
 *)
let show i lo hi guess error =
  Lib.pfmt
    "try=%d: lo=%.10f, hi=%.10f, guess=%.10f, error=%.10f\n"
    i lo hi guess error

(* sqrt : float -> int -> float option
 *
 * The call (sqrt x n) will return an (option of) approximation
 * of the square root of x such that the square of the result is within
 * epsilon of x. The algorithm computes approximations iteratively and
 * returns None if it cannot compute the approximation within n iterations.
*)
let sqrt ?n:(n=50) x =
  let rec iterate i lo hi =
    match i > n with
    | true  -> None
    | false ->
      let guess = (lo +. hi) /. 2.0 in
      let guessSquared = guess ** 2.0 in
      let error = abs_float(x -. guessSquared) in
      let _ = show i lo hi guess error
      in
      match Lib.closeEnough guessSquared x with
      | true -> Some guess
      | false ->
        (match guessSquared < x with
		     | true  -> iterate (i + 1) guess hi
		     | false -> iterate (i + 1) lo guess)
  in
  iterate 1 0.0 x

let _ = sqrt ~n:23 2.0
