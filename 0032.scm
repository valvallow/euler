;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))


(define (pandigital-products)
  (delete-duplicates
   (append-map
    (^(product)
      (filter-map
       (^i (and-let*
               (((zero? (mod product i)))
                (nums (list product i (div product i)))
                (numstr (apply string-append (map number->string nums)))
                ((equal? (sort (number->list (string->number numstr)))
                         (iota 9 1))))
             product))
       (lrange 2 (sqrt product))))
    (lrange 1000 10000))))

(print (apply + (pandigital-products)))
