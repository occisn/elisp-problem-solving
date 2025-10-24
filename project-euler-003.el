;;; -*- lexical-binding: t; -*-

(defun my/largest-prime-factor (n)
  "Return the largest prime factor of N. N is supposed to be an integer > 1.
(v1, available in occisn/elisp-utils GitHub repository)"
  (let ((i 2))
    (while (> n 1)
      (if (= 0 (mod n i)) ; n multiple of i
	  (setq n (/ n i))
	(setq i (+ i 1))))
    i))

(defun project-euler-3 (&optional n)
  "Solve Project Euler 3.
Require my/largest-prime-factor"
  (my/largest-prime-factor (or n 600851475143)))

;;; end
