(use gauche.lazy)
(use math.prime)
(use srfi-1)

;; http://tsumuji.cocolog-nifty.com/tsumuji/2009/02/problem-27.html
;; http://tsumuji.cocolog-nifty.com/tsumuji/2010/06/project-euler-p.html

(define (make-b-candidates limit)
  (take-while (pa$ > limit) *primes*))

(define (make-lazy-a-candidates limit a-start)
  (lfilter odd?
           (ltake-while (pa$ > limit)
                        (lrange a-start))))

(let* ((b-list (make-b-candidates 1000))
       (a-lists (map (^b (make-lazy-a-candidates
                          1000
                          (- (quotient (- b) 40) 40)))
                     b-list)))
  (let ((a-max 0)
        (b-max 0)
        (n-max 0))
    (for-each (^(b als)
                (dolist (a als)
                  (let/cc break
                    (dolist (n (lrange 0))
                      (let1 v (+ (* n n)(* a n) b)
                        (unless (and (positive? v)
                                     (bpsw-prime? v))
                          (when (< n-max (- n 1))
                            (set! n-max (- n 1))
                            (set! a-max a)
                            (set! b-max b))
                          (break)))))))
              b-list a-lists)
    (print (* a-max b-max))))
