;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(let1 limit (* 5 (expt 9 5))
  (print
   (apply + (filter-map
             (^i (and-let* ((i^5 (apply + (map (cut expt <> 5)
                                               (number->list i))))
                            (( = i i^5))
                            i^5)))
             (iota limit 2)))))
