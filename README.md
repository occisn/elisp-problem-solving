# elisp-problem-solving

This hobby project uses Emacs Lisp to solve numeric puzzles as those proposed by Project Euler.

## Table of contents

**Project Euler problems:**
[1](#project-euler-001-multiples-of-3-or-5)

## Project Euler 001: Multiples of 3 or 5

_If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000._
[(source)](https://projecteuler.net/problem=1)

``` elisp
(defun project-euler-1 (n)
  "Solve Project Euler 1."
  (let ((res 0))
    (dotimes (i n)
      (when (or (= 0 (mod i 3)) (= 0 (mod i 5)))
        (setq res (+ res i))))
    res))

(project-euler-1 10) ; 23
(project-euler-1 1000)
```

(end of README)
