(use math.prime)
(use gauche.generator)
(use srfi-1)

;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(define (list->number ls)
  (string->number
   (apply string-append (map x->string ls))))

(define (make-list-roller ls)
  (let* ((len (length ls))
         (count len)
         (cls (apply circular-list ls)))
    (generate (^(yield)
                (until (zero? count)
                  (yield (take cls len))
                  (set! cls (cdr cls))
                  (dec! count))))))

(define (make-circular-primes limit)
  (let1 pls (take-while (cut < <> limit) *primes*)
    (filter-map
     (^p (let1 roll (make-list-roller (number->list p))
           (call/cc
            (^c (while (roll) => n
                       (when (eof-object? n)
                         (c p))
                       (unless (bpsw-prime? (list->number n))
                         (c #f)))))))
     pls)))

(print (length (make-circular-primes (expt 10 6))))

