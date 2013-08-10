(use srfi-19)

;; =======================================================================
;; Gauche:カレンダー計算 http://practical-scheme.net/wiliki/wiliki.cgi?Gauche%3A%E3%82%AB%E3%83%AC%E3%83%B3%E3%83%80%E3%83%BC%E8%A8%88%E7%AE%97
;;
(define (inc n) (+ n 1))
(define (dec n) (- n 1))

(define (make-date-lite y m d)
  (make-date 0 0 0 0 d m y (date-zone-offset (current-date))))

(define (make-month-lite y m)
  (make-date 0 0 0 0 1 m y (date-zone-offset (current-date))))

(define (next-month date)
  (if (= (date-month date) 12)
      (make-month-lite (inc (date-year date)) 1)
      (make-month-lite (date-year date) (inc (date-month date)))))

(define (first-date-of-month date)
  (make-date-lite (date-year date) (date-month date) 1))

;; =======================================================================

(let ((base-date (make-date-lite 1901 1 1))
      (limit-date (make-date-lite 2000 12 31)))
  (let ((current-date base-date)
        (count 0))
    (until (and (= 2000 (date-year current-date))
                (= 12 (date-month current-date)))
      ;; sunday?
      (when (zero? (date-week-day current-date))
        (inc! count))
      ;; move to first day of next month
      (set! current-date (next-month current-date)))
    (print count)))

