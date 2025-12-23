;;; -*- lexical-binding: t; -*-

;;; Table of contents:
;;;   1) cl-xxx version
;;;   2) traditional version


;;; 1) cl-xxx version
;;; -----------------

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

(defun pe007--next-prime (n)
  "Return next prime after fixnum N.
Note: if N is prime, the result is not N.
(v1, available in occisn/elisp-utils GitHub repository)"
  (if (<= n 1)
      2
    (cl-loop for i from (+ n (if (cl-evenp n) 1 2)) by 2 
             when (pe007--primep i) return i)))

(defun pe007--nth-prime (rank)
  "Return RANK-th prime.
For instance: 1 --> 2 ; 2 --> 3 ; 6 --> 13.
The argument is supposed to be an integer >= 1.
(v1, available in occisn/elisp-utils GitHub repository)"
  (cl-loop for n = 2 then (pe007--next-prime n)
           and count = 1 then (+ count 1)
           when (= count rank) return n))

(defun project-euler-7 (&optional target0)
  "Solve Project Euler 7."
  (let ((target (or target0 10001)))
    (pe007--nth-prime target)))

(ert-deftest test-project-euler-7 ()
  :tags '(elisp-problem-solving)
  (should (= 13 (project-euler-7 6)))
  (should (= 104743 (project-euler-7))))


;;; 2) traditional version
;;; ----------------------

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

(defun pe007--next-prime--traditional (n)
  "Return next prime after fixnum N.
Note: if N is prime, the result is not N.
(v1, available in occisn/elisp-utils GitHub repository)"
  (if (<= n 1)
      2
      (let ((i (+ n (if (zerop (mod n 2)) 1 2))))
        (while (not (pe007--primep--traditional i))
          (setq i (+ i 2)))
        i)))

(defun pe007--nth-prime--traditional (rank)
  "Return RANK-th prime.
For instance: 1 --> 2 ; 2 --> 3 ; 6 --> 13.
The argument is supposed to be an integer >= 1.
(v1, available in occisn/elisp-utils GitHub repository)"
  (let ((n 2)
        (count 1))
    (while (< count rank)
      (setq n (pe007--next-prime--traditional n))
      (setq count (1+ count)))
    n))


(defun project-euler-7--traditional ()
  "Solve Project Euler 7.
Traditional Emacs Lisp, without cl-lib"
  (pe007--nth-prime--traditional 10001))

(ert-deftest test-project-euler-7--traditional ()
  :tags '(elisp-problem-solving)
  (should (= 104743 (project-euler-7--traditional))))

;;; end
