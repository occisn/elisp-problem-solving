;;; -*- lexical-binding: t; -*-

(defun pe007--primep (n)
  "Return t if and only if N is prime. N is supposed to be an integer >= 1.
(v1, available in occisn/elisp-utils GitHub repository)"
  (cond ((= 1 n) nil)
	((member n '(2 3 5 7)) t)
	((cl-evenp n) nil)
	((zerop (mod n 3)) nil)
	(t (cl-loop for factor from 5 by 6
		    with root-n = (cl-isqrt n)
		    while (<= factor root-n)
		    never (or (zerop (mod n factor))
			      (zerop (mod n (+ factor 2))))))))

(defun project-euler-7 (&optional target0)
  "Solve Project Euler 7."
  (let ((target (or target0 10001)))
    (cl-loop for n from 2 
	     when (pe007--primep n)
	     count t into counter
	     until (= counter target)
	     finally return n)))

(defun pe007--isqrt--traditional (n)
  "Return the integer square root of N (largest integer <= sqrt(N)).
N is supposed to be >= 0.
This code is written in traditional Emacs Lisp, without cl-lib (where the equivalent exists: cl-isqrt).
(v1, available in occisn/elisp-utils GitHub repository)"
  (cond
   ((= n 0) 0)
   ((< n 4) 1)
   (t
    ;; Newton's method
    (let* ((x n)
           (y (/ (+ x (/ n x)) 2)))
      (while (< y x)
        (setq x y)
        (setq y (/ (+ x (/ n x)) 2)))
      x))))

(defun pe007--primep--traditional (n)
  "Return t if and only if N is prime. N is supposed to be an integer >= 1.
This code is written in traditional Emacs Lisp, without cl-lib.
Requires pe007--isqrt--traditional.
(v1, available in occisn/elisp-utils GitHub repository)"
  
  (cond ((= 1 n) nil)
	((member n '(2 3 5 7)) t)
	((zerop (mod n 2)) nil)
	((zerop (mod n 3)) nil)
	(t (let ((factor 5)
                 (root-n (pe007--isqrt--traditional n))
                 (result t))
             (while (<= factor root-n)
               (when (or (zerop (mod n factor))
			 (zerop (mod n (+ factor 2))))
                 (setq result nil))
               (setq factor (+ factor 6))) ; end of while
             result))))

(defun project-euler-7--traditional ()
  "Solve Project Euler 7.
Traditional Emacs Lisp, without cl-lib"
  (let ((n 2)
        (counter 1) ; 2 is first prime
        (continue t))
    (while continue
      (setq n (1+ n))
      (when (pe007--primep--traditional n)
        (setq counter (1+ counter))
        (when (= counter 10001)
          (setq continue nil))))
    n))

(ert-deftest test-project-euler-7 ()
  :tags '(elisp-problem-solving)
  (should (= 13 (project-euler-7 6)))
  (should (= 104743 (project-euler-7)))
  (should (= 104743 (project-euler-7--traditional))))

;;; end
