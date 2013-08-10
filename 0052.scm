(use gauche.generator)

(define (sort-digit n)
  (list->string (sort (string->list (number->string n)))))

(define (gcounter)
  (let1 counter 0
    (generate
     (^(yield)
       (while #t
         (yield (rlet1 r counter
                       (inc! counter))))))))

(let1 cnt (gcounter)
  (let rec ((n (cnt)))
    (let1 s (sort-digit n)
      (if (and (not (zero? n))
               (equal? s (sort-digit (* 2 n)))
               (equal? s (sort-digit (* 3 n)))
               (equal? s (sort-digit (* 4 n)))
               (equal? s (sort-digit (* 5 n)))
               (equal? s (sort-digit (* 6 n))))
          (print n)
          (rec (cnt))))))
