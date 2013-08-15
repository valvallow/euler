;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))


(define (multiplier-exists? product multiplicand)
  (zero? (mod product multiplicand)))

(define (concat-numbers . nums)
  (string->number (apply string-append (map number->string nums))))

(define (pandigital-product? n)
  (equal? (sort (number->list n))
          (iota 9 1)))

(define (pandigital-products)
  (delete-duplicates
   (append-map
    (^(product)
      (filter-map
       (^i (and-let*
               (((multiplier-exists? product i))
                (num (apply concat-numbers
                            (list product i (div product i))))
                ((pandigital-product? num)))
             product))
       (lrange 2 (sqrt product))))
    (lrange 1000 10000))))

(print (apply + (pandigital-products)))
