(use srfi-13)

(define (palindrome? str)
  (equal? str (string-reverse str)))

(define (palindrome-number-of-decimal&binary limit)
  (filter-map
   (^i (and (palindrome? (number->string i))
            (palindrome? (number->string i 2))
            i))
   (lrange 0 limit)))

(print
 (apply + (palindrome-number-of-decimal&binary (expt 10 6))))
