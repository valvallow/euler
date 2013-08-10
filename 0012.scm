(use gauche.generator) ; generate
(use gauche.sequence) ; group-collection
(use math.prime) ; naive-factorize

(define (make-gtriangular)
  (define (triangular n)
    (/ (* n (+ n 1)) 2))
  (let1 i 0
    (generate
     (^(yield)
       (while #t
         (yield (triangular (inc! i))))))))

(define (count-divisor n)
  (apply * (map (.$ (pa$ + 1) length)
                (group-collection (naive-factorize n)))))

(let/cc break
  (let1 gtriangular (make-gtriangular)
    (while (gtriangular) => n
           (when (<= 500 (count-divisor n))
             (print n)
             (break)))))
