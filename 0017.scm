;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(define 0-9
  (map symbol->string
       '(zero one two three four
         five six seven eight nine)))

(define 10-19
  (map symbol->string
       '(ten eleven twelve thirteen fourteen
             fifteen sixteen seventeen eighteen nineteen)))

(define 20-90
  (map symbol->string
       '(dummy dummy
          twenty thirty forty fifty
          sixty seventy eighty ninety)))

(define (number->name-of-number n)
  (let* ((ls (number->list n))
         (len (length ls)))
    (cond ((= len 1)
           (~ 0-9 n))
          ((and (= len 2)(<= 10 n 19))
           (~ 10-19 (- n 10)))
          ((= len 2)
           (string-append
            (~ 20-90 (car ls))
            (if (zero? (cadr ls))
                ""
                (number->name-of-number (cadr ls)))))
          ((= len 3)
           (string-append
            (number->name-of-number (car ls))
            "hundred"
            (if (and (zero? (caddr ls))
                     (zero? (cadr ls)))
                ""
                (string-append
                 "and"
                 (number->name-of-number
                  (string->number
                   (apply string-append
                          (map number->string (cdr ls)))))))))
          ((= len 4) "onethousand")
          (else ""))))

(print (string-length (apply string-append (map number->name-of-number (iota 1000 1)))))
