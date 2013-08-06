;; http://projecteuler.net/problem=3
;; The prime factors of 13195 are 5, 7, 13 and 29.
;; What is the largest prime factor of the number 600851475143 ?

;; http://odz.sakura.ne.jp/projecteuler/index.php?cmd=read&page=Problem%203
;; 3195 の素因数は 5, 7, 13, 29 である.
;; 600851475143 の素因数のうち最大のものを求めよ.

(use math.prime)
(print (mc-factorize 600851475143))
