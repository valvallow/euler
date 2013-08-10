(use rfc.http)
(use text.csv)

(define (get-words-source)
  (values-ref (http-get "projecteuler.net"
                        "/project/words.txt")
              2))

(define (words->csv words)
  (call-with-input-string words
    (make-csv-reader #\,)))

(define csv-cache (words->csv (get-words-source)))

;; from 0022.scm
(define (name-score name)
  (apply + (map (^c (- (char->integer c) 64))
                (string->list name))))

(define (triangular? n)
  (let1 x (/ (+ 1 (sqrt (+ 1 (* 8 n)))) 2)
    (integer? x)))

;; body
(let1 words-csv csv-cache
  (print
   (length (filter-map (.$ triangular? name-score)
                       words-csv))))
