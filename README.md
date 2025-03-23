# elisp-problem-solving

This hobby project uses Emacs Lisp to solve numeric puzzles as those proposed by Project Euler.

o## Table of contents

**Project Euler problems:**
[1](#project-euler-001-multiples-of-3-or-5), ..., [6](#project-euler-006-sum-square-difference).

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

## Project Euler 006: Sum Square Difference

_The sum of the squares of the first ten natural numbers is  
1^2 + 2^2 + ... + 10^2 = 385  
The square of the sum of the first ten natural numbers is  
(1 + 2 + ... + 10)^2 = 552 = 3025  
Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.  
Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum._  
[(source)](https://projecteuler.net/problem=6)

``` elisp
(defun project-euler-6 (n)
  "Solve Project Euler 6."
  (let ((res 0))
    (dotimes (i (+ n 1))
      (setq res (+ res i)))
    (setq res (* res res))
    (dotimes (i (+ n 1))
      (setq res (- res (* i i))))
    res))
```

(end of README)
