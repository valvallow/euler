(use rfc.http)
(use text.csv)

(define (get-names-source)
  (values-ref (http-get "projecteuler.net"
                        "/project/names.txt")
              2))

(define (name-score name)
  (apply + (map (^c (- (char->integer c) 64))
                (string->list name))))

;; body
(let* ((names-csv (call-with-input-string (get-names-source)
                    (make-csv-reader #\,)))
       (name-scores (map (^(index name)
                           (* index (name-score name)))
                         (iota (length names-csv) 1)
                         (sort names-csv string<?))))
  (print (apply + name-scores)))

