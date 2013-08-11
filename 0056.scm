;; a, b < 100 について自然数 ab を考える. 桁の和の最大値を答えよ.

;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

;; boxy
(let ((ls (iota 100))
      (max 0))
  (dolist (a ls)
    (dolist (b ls)
      (let1 sum (apply + (number->list (expt a b)))
        (when (< max sum)
          (set! max sum)))))
  (print max))
