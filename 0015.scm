(define (fact n)
  (fold * 1 (iota n 1)))

(print (/ (fact 40)(* (fact 20)(fact 20))))
