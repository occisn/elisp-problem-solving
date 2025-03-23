
(defun project-euler-6 (n)
  "Solve Project Euler 6."
  (let ((res 0))
    (dotimes (i (+ n 1))
      (setq res (+ res i)))
    (setq res (* res res))
    (dotimes (i (+ n 1))
      (setq res (- res (* i i))))
    res))

(project-euler-6 10) ; 2640
(project-euler-6 100)
