;; from sicp 1.19
(define (fib n)
  (let rec ((a 1)(b 1)(p 0)(q 1)(count n))
    (cond ((= count 0) b)
          ((even? count)
           (rec a
                b
                (+ (* p p) (* q q))
                (+ (* 2 p q) (* q q))
                (/ count 2)))
          (else (rec (+ (* b q) (* a q) (* a p))
                     (+ (* b p) (* a q))
                     p
                     q
                     (- count 1))))))

(print
 (apply + (filter-map
           (^x (and-let* ((n (fib x))
                          ((<= n (* 4 (expt 10 6))))
                          ((even? n)))
                 n))
           (iota 33 1))))
