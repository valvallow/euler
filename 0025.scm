(use gauche.generator)

;; from 0002.scm
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

(define (make-gfibonacci)
  (let1 i 0
    (generate
     (^(yield)
       (while #t
         (yield (rlet1 r (fib i)(inc! i))))))))

(define gfib (make-gfibonacci))

(let/cc break
  (let1 index 0
    (while (gfib) => n
           (inc! index)
           (when (<= 1000 (string-length (number->string n)))
             (print index)
             (break)))))
