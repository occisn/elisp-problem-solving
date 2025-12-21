;;; -*- lexical-binding: t; -*-

(defun pe010--eratosthenes-sieve (lim)
  "Return a boolean vector representing the result of Eratosthenes sieve on |[ 0 ; LIM |[.
In this vector, t = prime ; nil = non prime.
(v1, available in occisn/elisp-utils GitHub repository)"
  (let ((bv (make-bool-vector lim t)))
    (aset bv 0 nil) ; 0 is not prime
    (aset bv 1 nil) ; 1 is not prime
    ;; 2 is prime, so change nothing in the vector
    ;; 4 and subsequent even numbers are not prime:
    (cl-loop for i from 4 below lim by 2
	     do (aset bv i nil))
    ;; Sieve:
    (cl-loop for i from 3
	     while (<= (* i i) lim)
	     when (aref bv i)
	     do (cl-loop for j from (* i i) below lim by (* 2 i)
			 do (aset bv j nil)))
    bv))

(defun pe010--eratosthenes-sieve--traditional (lim)
  "Return a boolean vector representing the result of Eratosthenes sieve on |[ 0 ; LIM |[.
In this vector, t = prime ; nil = non prime.
Written in traditional Emacs Lisp, without cl-lib.
(v1, available in occisn/elisp-utils GitHub repository)"
  (let ((bv (make-bool-vector lim t)))
    (aset bv 0 nil)    ; 0 is not prime
    (aset bv 1 nil)    ; 1 is not prime
    ;; 2 is prime, so change nothing in the vector
    ;; 4 and subsequent even numbers are not prime:
    (let ((i 4))
      (while (< i lim)
        (aset bv i nil)
        (setq i (+ i 2))))
    ;; Sieve:
    (let ((i 3))
      (while (<= (* i i) lim)
        (when (aref bv i)
          (let ((j (* i i)))
            (while (< j lim)
              (aset bv j nil)
              (setq j (+ j (* 2 i))))))
        (setq i (1+ i)))
      bv)))

(defun project-euler-10 (&optional lim0)
  "Solve Project Euler 10.
Requires pe010--eratosthenes-sieve"
  (let* ((lim (or lim0 2000000))
	 (bv (pe010--eratosthenes-sieve lim)))
    (cl-loop for i from 0 below lim
	     when (aref bv i)
	     sum i)))

;;; the above is quicker than:
(when nil
  (cl-loop for n from 2 to 2000000
	   when (pe010--primep n)
	   sum n))

(defun project-euler-10--traditional (&optional lim0)
  "Solve Project Euler 10
Written in traditional Emacs Lisp, without cl-lib.
Requires pe010--eratosthenes-sieve--traditional"
  (let* ((lim (or lim0 2000000))
	 (bv (pe010--eratosthenes-sieve--traditional lim)))
    (let ((res 0)
          (i 0))
      (while (< i lim)
        (when (aref bv i)
          (setq res (+ res i)))
        (setq i (1+ i)))
      res)))

(ert-deftest test-project-euler-10 ()
  :tags '(elisp-problem-solving)
  (should (= 17 (project-euler-10 10)))
  (should (= 17 (project-euler-10--traditional 10)))
  (should (= 142913828922 (project-euler-10)))
  (should (= 142913828922 (project-euler-10--traditional))))

;;; end
