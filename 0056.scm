;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

;; body
(let ((ls (iota 100))
      (max 0))
  (dolist (a ls)
    (dolist (b ls)
      (let1 sum (apply + (number->list (expt a b)))
        (when (< max sum)
          (set! max sum)))))
  (print max))
