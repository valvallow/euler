(define (infinite-continued-fraction limit)
  (define (calc1 n)
    (/ 1 (+ 2 n)))
  (let rec ((n 1/2)(count 0)(acc (list (+ 1 1/2))))
    (if (= count limit)
        (reverse (cons (+ 1 (calc1 n)) acc))
        (let1 r (calc1 n)
          (rec r (+ count 1)(cons (+ 1 r) acc))))))

(let1 denom<nume
    (filter (^n (< (string-length
                    (number->string (denominator n)))
                   (string-length
                    (number->string (numerator n)))))
            (infinite-continued-fraction 1000))
  (print (length denom<nume)))
