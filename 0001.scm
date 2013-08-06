;; 0001 Sum of squares of divisors

;; http://projecteuler.net/index.php?section=problems&id=1
;; If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
;; Find the sum of all the multiples of 3 or 5 below 1000.

;; http://odz.sakura.ne.jp/projecteuler/index.php?Problem%201
;; 10未満の自然数のうち、3 もしくは 5 の倍数になっているものは 3, 5, 6, 9 の4つがあり、 これらの合計は 23 になる。
;; 同じようにして、1,000 未満の 3 か 5 の倍数になっている数字の合計を求めよ。

(print (apply + (filter (^x (or (zero? (modulo x 5))
                                (zero? (modulo x 3))))
                        (iota 999 1))))
