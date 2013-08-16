;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(define (factorial n)
  (apply * (iota n 1)))

(define (sum-factorials ls)
  (apply + (map factorial ls)))

(define digit-fact=
  (let1 cache (make-hash-table 'equal?)
    (^n (let1 sorted (sort (number->list n))
           (if (hash-table-exists? cache sorted)
               (let1 r (hash-table-get cache sorted)
                 (and (= n r) r))
               (let1 sum (sum-factorials sorted)
                 (hash-table-put! cache sorted sum)
                 (and (= sum n) n)))))))

(print
 (apply + (filter-map digit-fact=
                      (lrange 10 (+ 1 (* (factorial 9) 7))))))
