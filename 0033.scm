 ;; その4個の分数の積が約分された形で与えられたとき, 分母の値を答えよ.

(use srfi-1)

;; from 0008.scm
(define (number->list num)
  (map (.$ string->number string)
       (string->list (number->string num))))

(define (make-rational nume deno)
  (cons nume deno))

(define (rational-denominator rat)
  (cdr rat))

(define (rational-numerator rat)
  (car rat))

(define (rational->built-in-rational rat)
  (/ (rational-numerator rat)
     (rational-denominator rat)))

(define (rational-trivial-solution? rat)
  (zero? (mod (rational-denominator rat) 10)))

(define (rational-extract-same-digit rat)
  (let ((n-ls (number->list
               (rational-numerator rat)))
        (d-ls (number->list
               (rational-denominator rat))))
    (let1 r (lset-intersection = n-ls d-ls)
      (and (not (null? r)) r))))

(define (rational-remove-same-digit rat same-digit)
  (define (drop-same-digit n)
    (let1 ls (number->list n)
      (if (= (car ls) same-digit)
          (cadr ls)
          (car ls))))
  (make-rational (drop-same-digit
                  (rational-numerator rat))
                 (drop-same-digit
                  (rational-denominator rat))))

(define (denominator&numerator-2digit? rat)
  (every identity
         (map (.$ (pa$ = 2)
                  string-length
                  number->string)
              (list (rational-numerator rat)
                    (rational-denominator rat)))))

(define (commensurable? rat)
  (let1 r (rational->built-in-rational rat)
    (not (and (= (rational-denominator rat)
                 (denominator r))
              (= (rational-numerator rat)
                 (numerator r))))))

(define (digit-canceling-fraction-candidates rationals)
  (filter-map
   (^r (and-let* (((< (rational->built-in-rational r) 1))
                  ((not (rational-trivial-solution? r)))
                  ((commensurable? r))
                  ((denominator&numerator-2digit? r))
                  (sames (rational-extract-same-digit r)))
         (cons r sames)))
   rationals))

(define (create-candidates)
  (let1 base-candidates
      (append-map (^i (map (^j (make-rational i j))
                           (lrange 10 100)))
                  (lrange 10 100))
    (digit-canceling-fraction-candidates base-candidates)))

(define (digit-canceling-fractions candidates)
  (append-map
   (^x (filter-map
        (^s (and-let*
                ((r (rational-remove-same-digit (car x) s))
                 (r (rational->built-in-rational r))
                 (br (rational->built-in-rational (car x)))
                 ((= r br)))
              br))
        (cdr x)))
   candidates))


(print
 (denominator
  (apply * (digit-canceling-fractions
            (create-candidates)))))
