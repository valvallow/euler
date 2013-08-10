;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(print (apply + (number->list (fold * 1 (iota 100 1)))))
