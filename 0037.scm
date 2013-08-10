(use srfi-13)
(use math.prime)

(define (truncatable-prime? p)
  (define (tp? p n dropper)
    (bpsw-prime?
     (string->number
      (dropper (number->string p) n))))
  (let rec ((llen 0)
            (rlen (- (string-length
                      (number->string p))
                     1))
            (acc #t))
    (if (or (negative? rlen)
            (not acc))
        acc
        (rec (+ llen 1)(- rlen 1)
             (and (tp? p rlen string-drop-right)
                  (tp? p llen string-drop))))))

;; (truncatable-prime? 3797)

(define next-prime
  (let1 count 0
    (^ (:optional (reset #f))
       (if reset
           (set! count 0)
           (rlet1 r (list-ref *primes* count)
                  (inc! count))))))

(define (reset-next-prime)
  (next-prime #t))

(define (collect-truncatable-primes)
  (reset-next-prime)
  (let rec ((p (next-prime))(acc '()))
    (if (= (length acc) 11)
        (reverse acc)
        (rec (next-prime)(if (and (< 7 p)
                                  (truncatable-prime? p))
                             (cons p acc)
                             acc)))))

(print (apply + (collect-truncatable-primes)))
