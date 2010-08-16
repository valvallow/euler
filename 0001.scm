;; 001

;; http://projecteuler.net/index.php?section=problems&id=1
;; If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
;; Find the sum of all the multiples of 3 or 5 below 1000.

;; http://odz.sakura.ne.jp/projecteuler/index.php?Problem%201
;; 10未満の自然数のうち、3 もしくは 5 の倍数になっているものは 3, 5, 6, 9 の4つがあり、 これらの合計は 23 になる。
;; 同じようにして、1,000 未満の 3 か 5 の倍数になっている数字の合計を求めよ。


(use srfi-1)

(apply + (filter (lambda (e)
                   (or (zero? (remainder e 3))
                       (zero? (remainder e 5))))
                 (iota 10)))
;; 23


(define (filter-sum pred ls)
  (apply + (filter pred ls)))

(filter-sum (lambda (e)
              (or (zero? (remainder e 3))
                  (zero? (remainder e 5))))
            (iota 1000))
;; 233168


(let1 f (compose zero? (pa$ remainder))
  (filter-sum (lambda (e)
                (or (f e 3)
                    (f e 5)))
              (iota 1000)))


(define (aliquant? n d)
  (zero? (remainder n d)))


(filter-sum (lambda (e)
              (or (aliquant? e 3)
                  (aliquant? e 5)))
            (iota 1000))
;; 233168


(define (aliquant-any? n d . ds)
  (any (lambda (d)
         (aliquant? n d))(cons d ds)))

(filter-sum (cut aliquant-any? <> 3 5)
            (iota 1000))
;; 233168

