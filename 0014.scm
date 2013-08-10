;; memoized collatz
(define collatz
  (let1 cache (make-hash-table)
    (^i (let rec ((n i)(acc (list i)))
          (cond ((<= n 1)
                 (rlet1 r (reverse acc)
                        (hash-table-put! cache i acc)))
                ((hash-table-get cache n #f)
                 => (^r (reverse (append r (cdr acc)))))
                (else (let1 n (cond ((even? n)(/ n 2))
                                    ((odd? n)(+ (* n 3) 1))
                                    (else n))
                        (rec n (cons n acc)))))))))


;; body
(print
 (car (fold (^(i acc)
              (let1 len (length (collatz i))
                (if (< (cdr acc) len)
                    (cons i len)
                    acc)))
            (cons 0 0)
            (iota (expt 10 6) 1))))
