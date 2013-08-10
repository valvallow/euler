(use math.prime)
(use util.combinations)

;; https://twitter.com/SaitoAtsushi/statuses/366083877002948608
(define (sum-of-divisor x)
  (apply + (map (apply$ *)
                (power-set* (mc-factorize x)))))

(define (sum-of-proper-divisor x)
  (- (sum-of-divisor x) x))

(print
 (apply + (filter-map (^n (and-let* ((sod (sum-of-proper-divisor n))
                                     ((not (= n sod)))
                                     ((= (sum-of-proper-divisor sod) n))
                                     (n))))
                      (iota 10000))))

