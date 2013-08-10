(use math.prime)

;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(define (pandigital? n)
  (let1 numstr (number->string n)
    (and (string-scan numstr "1")
         (not (string-scan numstr "0"))
         (print n)
         (let1 ls (sort (number->list n))
           (equal? ls (iota (length ls) 1))))))

(define (make-previous-prime max-count)
  (let1 count max-count
    (^ (:optional (reset #f))
       (cond (reset (set! count max-count))
             ((negative? count)(eof-object))
             (else (rlet1 r (list-ref *primes* count)
                          (dec! count)))))))

(define (max-pandigital-prime limit)
  (define previous-prime
    (make-previous-prime limit))
  (let rec ((p (previous-prime)))
    (if (pandigital? p)
        p
        (rec (previous-prime)))))

(print (max-pandigital-prime 664578))
