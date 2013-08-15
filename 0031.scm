
;; from SICP p.58
(define (count-change amount coins)
  (cond ((zero? amount) 1)
        ((or (< amount 0)(null? coins)) 0)
        (else (+ (count-change amount (cdr coins))
                 (count-change (- amount (car coins))
                               coins)))))

(time
(print
 (count-change 200 (list 1 2 5 10 20 50 100 200)))
)
