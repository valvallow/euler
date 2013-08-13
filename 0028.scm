(use gauche.collection)
(use gauche.lazy)

(define (spiral-diagonal-numbers limit)
  (lmap-accum
   (^(edge-len prev)
     (let1 diagonals (lmap-accum
                      (^(i acc)
                        (let1 r (+ acc (- edge-len 1))
                          (values r r)))
                      prev
                      (iota 4))
       (values diagonals (last diagonals))))
   1 ; seed
   (lrange 3 (+ limit 1) 2)))

(print (apply + 1 (apply append (spiral-diagonal-numbers 1001))))
