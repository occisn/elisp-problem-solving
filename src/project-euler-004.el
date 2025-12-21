;;; -*- lexical-binding: t; -*-

(defun pe004--reverse-number (n &optional acc0)
  "Reverse the N, which is supposed to be an integer >= 0.
For instance: 123 --> 321.
ACC0 is an accumulator used during recursion.
(v1, available in occisn/elisp-utils GitHub repository)"
  (let ((acc (or acc0 0)))
    (if (= n 0)
	acc
      (let ((f (floor n 10))
	    (r (mod n 10)))
	(pe004--reverse-number f (+ (* 10 acc) r))))))

(defun project-euler-4 ()
  "Solve Project Euler 4.
Emacs Lisp with cl-lib"
  (cl-loop with max-palindrome = 0
           for i from 999 downto 100
           do (cl-loop for j from i downto 100
                       for product = (* i j)
                       while (> product max-palindrome)
                       when (= product (pe004--reverse-number product))
                       do (setq max-palindrome product))
           finally return max-palindrome))

(defun project-euler-4--traditional ()
  "Solve Project Euler 4. 
Traditional Emacs Lisp without cl-lib"
  (let ((max-palindrome 0)
        (i 999))
    (while (>= i 100)
      (let ((j i))
        (while (>= j 100)
          (let ((product (* i j)))
            (if (<= product max-palindrome)
                (setq j 99)  ; Break out of inner loop
              (when (= product (pe004--reverse-number product))
                (setq max-palindrome product))))
          (setq j (1- j))))
      (setq i (1- i)))
    max-palindrome))

(ert-deftest test-project-euler-4 ()
  :tags '(elisp-problem-solving)
  (should (= 906609 (project-euler-4)))
  (should (= 906609 (project-euler-4--traditional))))

;;; end
