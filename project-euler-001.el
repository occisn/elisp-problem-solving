
(defun project-euler-1 (n)
  "Solve Project Euler 1."
  (let ((res 0))
    (dotimes (i n)
      (when (or (= 0 (mod i 3)) (= 0 (mod i 5)))
        (setq res (+ res i))))
    res))

(project-euler-1 10) ; 23
(project-euler-1 1000)
