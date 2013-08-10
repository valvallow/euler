;; from 0008.scm
;; (number->list 12345)
;;  => (1 2 3 4 5)
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(print (apply + (number->list (expt 2 1000))))
