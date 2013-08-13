(use gauche.lazy)
(use math.prime)
(use srfi-1)

;; http://tsumuji.cocolog-nifty.com/tsumuji/2009/02/problem-27.html
;; http://tsumuji.cocolog-nifty.com/tsumuji/2010/06/project-euler-p.html

(let ((a-max 0)
      (b-max 0)
      (n-max 0))
  (dolist (b (take-while (cut < <> 1000) *primes*))
    (let/cc break
      (let1 a (- (quotient (- b) 40) 40)
        (let rec ((a a))
          (unless (< a 1000)
            (break))
          (if (even? a)
              (rec (+ a 1))
              (dolist (n (lrange 0))
                (let1 v (+ (* n n)(* a n) b)
                  (unless (and (positive? v)
                               (bpsw-prime? v))
                    (when (< n-max (- n 1))
                      (set! n-max (- n 1))
                      (set! a-max a)
                      (set! b-max b))
                    (rec (+ a 1))))))))))
  (print (* a-max b-max)))
