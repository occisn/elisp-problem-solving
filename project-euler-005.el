;;; -*- lexical-binding: t; -*-

(defun project-euler-5a ()
  "Solve Project Euler 5.
Requires cl-lib."
  (cl-lcm 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

(defun project-euler-5b ()
  "Solve Project Euler 5.
Requires cl-lib."
  (let ((res 1))
    (dotimes (i 20)
      (setq res (cl-lcm res (+ i 1))))
    res))

(defun my/gcd--traditional (a b)
  "Return gcd of A and B.
Traditional equivalent of cl-gcd.
(v1, available in occisn/elisp-utils GitHub repository)"
  (if (zerop b)
      (abs a)
    (my/gcd--traditional b (mod a b))))

(defun my/lcm--traditional (a b)
  "Return lcm of A and B.
Traditional equivalent of cl-lcm.
Requires my/gcd--traditional.
(v1, available in occisn/elisp-utils GitHub repository)"
  (/ (abs (* a b)) (my/gcd--traditional a b)))

(defun project-euler-5--traditional ()
  "Solve Project Euler 5."
  (let* ((res 1))
    (dotimes  (i 20)
      (setq res (my/lcm--traditional res (+ i 1))))
    res))

;;; end
