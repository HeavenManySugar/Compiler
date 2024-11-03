(* exercise1 *)
type ichar = char * int
type regexp =
| Epsilon
| Character of ichar
| Union of regexp * regexp
| Concat of regexp * regexp
| Star of regexp

let rec null : regexp -> bool = function
  | Epsilon -> true
  | Character _ -> false
  | Union (r1, r2) -> null r1 || null r2
  | Concat (r1, r2) -> null r1 && null r2
  | Star _ -> true

  let () =
  let a = Character ('a', 0) in
  assert (not (null a));
  assert (null (Star a));
  assert (null (Concat (Epsilon, Star Epsilon)));
  assert (null (Union (Epsilon, a)));
  assert (not (null (Concat (a, Star a))))

(* exercise2 *)
module Cset = Set.Make(struct type t = ichar let compare = Stdlib.compare end)

let rec first : regexp -> Cset.t = function
  | Epsilon -> Cset.empty
  | Character c -> Cset.singleton c
  | Union (r1, r2) -> Cset.union (first r1) (first r2)
  | Concat (r1, r2) -> if null r1 then Cset.union (first r1) (first r2) else first r1
  | Star r -> first r

let rec last : regexp -> Cset.t = function
  | Epsilon -> Cset.empty
  | Character c -> Cset.singleton c
  | Union (r1, r2) -> Cset.union (last r1) (last r2)
  | Concat (r1, r2) -> if null r2 then Cset.union (last r1) (last r2) else last r2
  | Star r -> last r

let () =
  let ca = ('a', 0) and cb = ('b', 0) in
  let a = Character ca and b = Character cb in
  let ab = Concat (a, b) in
  let eq = Cset.equal in
  assert (eq (first a) (Cset.singleton ca));
  assert (eq (first ab) (Cset.singleton ca));
  assert (eq (first (Star ab)) (Cset.singleton ca));
  assert (eq (last b) (Cset.singleton cb));
  assert (eq (last ab) (Cset.singleton cb));
  assert (Cset.cardinal (first (Union (a, b))) = 2);
  assert (Cset.cardinal (first (Concat (Star a, b))) = 2);
  assert (Cset.cardinal (last (Concat (a, Star b))) = 2)

(* exercise3 *)
let rec follow (c: ichar) : regexp -> Cset.t = function
  | Epsilon -> Cset.empty
  | Character _ -> Cset.empty
  | Union (r1, r2) -> Cset.union (follow c r1) (follow c r2)
  | Concat (r1, r2) ->
    let s = Cset.union (follow c r1) (follow c r2) in
    if Cset.mem c (last r1) then Cset.union s (first r2)
    else s
  | Star r -> 
    if Cset.mem c (last r) then Cset.union (follow c r) (first r)
    else follow c r

let () =
  let ca = ('a', 0) and cb = ('b', 0) in
  let a = Character ca and b = Character cb in
  let ab = Concat (a, b) in
  assert (Cset.equal (follow ca ab) (Cset.singleton cb));
  assert (Cset.is_empty (follow cb ab));
  let r = Star (Union (a, b)) in
  assert (Cset.cardinal (follow ca r) = 2);
  assert (Cset.cardinal (follow cb r) = 2);
  let r2 = Star (Concat (a, Star b)) in
  assert (Cset.cardinal (follow cb r2) = 2);
  let r3 = Concat (Star a, b) in
  assert (Cset.cardinal (follow ca r3) = 2)