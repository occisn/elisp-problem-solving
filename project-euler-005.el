
(defun project-euler-5 (n)
  "Solve Project Euler 5."
  (let* ((gcd (lambda (a b)
                (if (zerop b)
                    (abs a)
                  (gcd b (mod a b)))))
         (lcm (lambda (a b)
               (/ (abs (* a b)) (gcd a b))))
         (res 1))
    (dotimes  (i n)
      (setq res (lcm res (+ i 1))))
    res))

(project-euler-5 10) ; 2520
(project-euler-5 20)
