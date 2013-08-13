(use gauche.collection)
(use gauche.lazy)
(use gauche.generator)
(use math.prime)

;; from 0028.scm
(define (lazy-spiral-diagonal-numbers limit)
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

(define (make-g-spiral-diagonal-numbers)
  (let ((counter 0)
        (lsdn (lazy-spiral-diagonal-numbers +inf.0)))
    (generate
     (^(yield)
       (while (list-ref lsdn counter) => r
              (yield r)
              (inc! counter))))))

(define prime-percentage
  (let1 cache (make-hash-table 'equal?)
    (^(pre new)
      (if-let1 pre-prime-count (hash-table-get cache pre #f)
               (let1 prime-count (+ pre-prime-count
                                    (length (filter small-prime? new)))
                 (rlet1 r (/ prime-count (length (append pre new)))
                        (hash-table-put! cache pre pre-prime-count)))
               (let* ((diagonals (append pre new))
                      (prime-count (length (filter small-prime? diagonals))))
                 (rlet1 r (/ prime-count (length (append pre new)))
                        (hash-table-put! cache diagonals prime-count)))))))

(define (edge-of-prime-percentage lower-limit-percentage
                                  :optional (start-edge 3))
  (let1 gdiagonal (make-g-spiral-diagonal-numbers)
    (let rec ((edge-len 3)(acc '(1)))
      (let* ((new (gdiagonal))
             (d (append acc new)))
        ;; === debug code ===
        (when (zero? (modulo edge-len 15))
          (print edge-len " " (exact->inexact
                               (prime-percentage acc new))))
        ;; ==================
        (cond ((<= edge-len start-edge)
               (rec (+ edge-len 2) d))
              ((< (prime-percentage acc new)
                  lower-limit-percentage)
               edge-len)
              (else (rec (+ edge-len 2) d)))))))

(edge-of-prime-percentage 13/100 3500)
(edge-of-prime-percentage 12/100 6500)
(edge-of-prime-percentage 11/100 12100)

(time
 (print
  (edge-of-prime-percentage 1/10 24000)))
