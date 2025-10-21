;;; -*- lexical-binding: t; -*-

(defun project-euler-4a ()
  "Solve Project Euler 4.
Emacs Lisp with cl-lib"

  (cl-labels ((reverse-number (n &optional acc0)
                "Reverse the N, which is supposed to be an integer >= 0.
For instance: 123 --> 321.
ACC0 is an accumulator used during recursion.
(v1, available in occisn/elisp-utils GitHub repository)"
                (let ((acc (or acc0 0)))
                  (if (= n 0)
	              acc
                    (let ((f (floor n 10))
	                  (r (mod n 10)))
	              (reverse-number f (+ (* 10 acc) r)))))))
    
    (cl-loop for a from 100 to 998
	     for c = (cl-loop for b from a to 999
			      for prod = (* a b)
			      when (= prod (reverse-number prod))
			      maximize prod)
	     when (not (null c))
	     maximize c)))

(defun project-euler-4b ()
  "Solve Project Euler 4. 
Traditional Emacs Lisp without cl-lib"
  
  (letrec (
           ;; 'reverse-number'
           ;; Reverse the N, which is supposed to be an integer >= 0.
           ;; For instance: 123 --> 321.
           ;; ACC0 is an accumulator used during recursion.
           ;; (v1, available in occisn/elisp-utils GitHub repository)
           (sub-reverse-number (lambda (n acc0)
                                 
                                 (let ((acc (or acc0 0)))
                                   (if (= n 0)
	                               acc
                                     (let ((f (floor n 10))
	                                   (r (mod n 10)))
	                               (funcall sub-reverse-number f (+ (* 10 acc) r)))))))
           (reverse-number (lambda (n)
                             (funcall sub-reverse-number n 0))))
    
    (let ((a 100)
          (c-max 0))
      (while (<= a 998)
        (let ((b a)
              (c -1))
          (while (<= b 999)
            (let ((prod (* a b)))
              (when (and (= prod (funcall reverse-number prod)) (> prod c))
                (setq c prod)))
            (setq b (1+ b)))
          (when (> c c-max)
            (setq c-max c)))
        (setq a (1+ a)))
      c-max)))

;;; end
