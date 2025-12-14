;;; -*- lexical-binding: t; -*-

(defun project-euler-002 ()
  "Solve Project Euler 2."
  (let ((n 4000000)
        (f1 1)
        (f2 2)
        (sum 2))
    (while (<= f2 n)
      (let ((tmp f2))
        (setq f2 (+ f1 f2))
        (setq f1 tmp)
        (when (= (% f2 2) 0)
          (setq sum (+ sum f2)))))
    sum))

;; end
