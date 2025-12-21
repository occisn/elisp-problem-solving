;;; -*- lexical-binding: t; -*-

(defun project-euler-1 (&optional lim)
  "Solve Project Euler 1"
  (cl-loop for n from 0 below (or lim 1000)
	   when (or (= 0 (mod n 3)) (= 0 (mod n 5)))
	   sum n))

(defun project-euler-1--traditional ()
  "Solve Project Euler 1."
  (let ((n 1000)
        (res 0))
    (dotimes (i n)
      (when (or (= 0 (mod i 3)) (= 0 (mod i 5)))
        (setq res (+ res i))))
    res))

;;; end
