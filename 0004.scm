
(use srfi-13)

(define (palindrome? n)
  (let1 str (number->string n)
    (equal? str (string-reverse str))))

(let ((ls (reverse (iota 900 100)))
      (p 0))
  (dolist (i ls)
    (dolist (j ls)
      (let1 candidate (* i j)
        (when (and (palindrome? candidate)
                   (< p candidate))
          (set! p candidate)))))
  (print p))
