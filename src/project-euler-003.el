;;; -*- lexical-binding: t; -*-

(defun pe003--isqrt--traditional (n)
  "Return the integer square root of N (largest integer <= sqrt(N)).
N is supposed to be >= 0.
This code is written in traditional Emacs Lisp, without cl-lib (where the equivalent exists: cl-isqrt).
(v1, available in occisn/elisp-utils GitHub repository)"
  (cond
   ((= n 0) 0)
   ((< n 4) 1)
   (t
    ;; Newton's method
    (let* ((x n)
           (y (/ (+ x (/ n x)) 2)))
      (while (< y x)
        (setq x y)
        (setq y (/ (+ x (/ n x)) 2)))
      x))))

(defun pe003--largest-prime-factor--traditional (n)
  "Return the largest prime factor of N. N is supposed to be an integer > 1.
Requires isqrt--traditional
(v2, available in occisn/elisp-utils GitHub repository)"
  (let ((largest 0))
    ;; Remove factors of 2
    (while (= 0 (mod n 2))
      (setf largest 2)
      (setf n (/ n 2)))

    ;; Remove factors of 3
    (while (= 0 (mod n 3))
      (setf largest 3)
      (setf n (/ n 3)))

    ;; Test divisors of the form 6k-1 and 6k+1
    (let ((i 5)
          (isqrt-n (pe003--isqrt--traditional n)))
      (while (<= i isqrt-n)
        (cond
         ((= 0 (mod n i))
          (setf largest i)
          (setf n (/ n i)))
         ((= 0 (mod n (+ i 2)))
          (setf largest (+ i 2))
          (setf n (/ n (+ i 2))))
         (t
          (setf i (+ i 6))))))

    ;; If n is still > 1, it is prime
    (if (> n 1)
        (setf largest n))

    largest))

(defun project-euler-3 (&optional n)
  "Solve Project Euler 3.
Require pe003--largest-prime-factor--traditional"
  (pe003--largest-prime-factor--traditional (or n 600851475143)))

(ert-deftest test-project-euler-3 ()
  :tags '(elisp-problem-solving)
  (should (= 29 (project-euler-3 13195)))
  (should (= 6857 (project-euler-3))))

;;; end
