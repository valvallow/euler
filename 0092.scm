;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(define (sum-square-digit n)
  (apply + (map (cut expt <> 2)
                  (number->list n))))

(define (fold-square-digit n)
  (let1 r (sum-square-digit n)
    (cond ((or (zero? r)(= r 1)) => not)
          ((= r 89) n)
          (else (fold-square-digit r)))))

(let1 counter 0
  (dotimes (i (expt 10 7))
    (when (zero? (modulo i (expt 10 5)))
      (print i))
    (and (fold-square-digit i)
         (inc! counter)))
  (print counter))
