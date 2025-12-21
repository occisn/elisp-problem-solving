;;; -*- lexical-binding: t; -*-

(defun project-euler-9 ()
  "Solve Project Euler 9."
  (let ((n 1000))
    (cl-loop for c from n downto 3
             append 
             (cl-loop with bmax = (min (- c 1) (- n c 1))
                      with bmin = (max 2 (/ (- n c) 2))
                      for b from bmax downto bmin
                      for a = (- n b c)
                      when (= (* c c) (+ (* a a) (* b b)))
                      collect (list (* a b c) :abc a b c)))))

(defun project-euler-9--traditional ()
  "Solve Project Euler 9."
  (let ((n 1000)
        (res nil))
    (let ((c n))
      (while (>= c 3)
        ;; upper limit for b:
        ;;   (i) b < c
        ;;   (ii) b = 1000-c-a with a >= 1 thus b <= 1000-c-1
        ;; lower limit for b:
        ;;   (i) 1 <= a < b thus b > 1
        ;;   (ii) 1000-c = a+b with a < b thus 1000-c < 2b  
        (let* ((bmax (min (- c 1) (- n c 1)))
               (bmin (max 2 (/ (- n c) 2)))
               (b bmax))
          (while (>= b bmin)
            (let ((a (- n b c)))
              (when (= (* c c) (+ (* a a) (* b b)))
                (push (list (* a b c) :abc a b c) res)))
            (setq b (- b 1))))
        (setq c (- c 1))))
    res))

;;; end
