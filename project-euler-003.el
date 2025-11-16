;;; -*- lexical-binding: t; -*-

(defun my/largest-prime-factor--traditional (n)
  "Return the largest prime factor of N. N is supposed to be an integer > 1.
Requires my/isqrt--traditional
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
          (isqrt-n (my/isqrt--traditional n)))
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
Require my/largest-prime-factor--traditional"
  (my/largest-prime-factor--traditional (or n 600851475143)))

;;; end
