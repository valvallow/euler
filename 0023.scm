(use math.prime) ; mc-factorize
(use util.combinations) ; power-set*

;; from 0021.scm
;; https://twitter.com/SaitoAtsushi/statuses/366083877002948608
(define (sum-of-divisor x)
  (apply + (map (apply$ *)
                (power-set* (mc-factorize x)))))

;; from 0021.scm
(define (sum-of-proper-divisor x)
  (- (sum-of-divisor x) x))

(define (abundant-number n)
  (and (< n (sum-of-proper-divisor n))
       n))

(define (collect-abundant-numbers limit)
  (filter-map abundant-number (iota limit 1)))

(let* ((n 28123)
       (ls (collect-abundant-numbers n))
       (vect (list->vector (iota n 1))))
  (dolist (i ls)
    (let/cc break
      (dolist (j ls)
        (let1 sum (+ i j)
          (when (< n sum)
            (break))
          (vector-set! vect (- sum 1) 0)))))
  (print (apply + (vector->list vect))))
