(use util.combinations)

(define cache
  (sort (map (.$ (apply$ string-append)
                 (map$ number->string))
             (permutations (iota 10)))))

(print (list-ref cache (- (expt 10 6) 1)))
