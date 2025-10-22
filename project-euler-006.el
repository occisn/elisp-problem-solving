;;; -*- lexical-binding: t; -*-

(defun project-euler-6 (&optional lim)
  (cl-loop for i from 1 to (or lim 100)
	   sum i into sum1
	   sum (* i i) into sum2
	   finally return (- (* sum1 sum1) sum2)))

(defun project-euler-6--traditional ()
  "Solve Project Euler 6."
  (let ((n 100)
        (res 0))
    (dotimes (i (+ n 1))
      (setq res (+ res i)))
    (setq res (* res res))
    (dotimes (i (+ n 1))
      (setq res (- res (* i i))))
    res))

;;; end
