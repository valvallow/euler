(use rfc.http)
(use srfi-1)

;; from 0008.scm
(define (shift-slices ls len)
  (unfold (^s (or (null? s)
                  (< (length s) len)))
          (cut take <> len) cdr ls))

;; from 0018.scm
(define (sum-of-minimum-triangles above-row bottom-row)
  (map (^(a b)
         (+ a (max (car b)(cadr b))))
       above-row
       (shift-slices bottom-row 2)))

;; from 0018.scm
(define (sum-max-root datum)
  (let rec ((lol (reverse datum)))
    (if (null? (cdr lol))
        (caar lol)
        (rec (cons (sum-of-minimum-triangles (cadr lol)(car lol))
                   (cddr lol))))))

;;
;; 67 body
;;

(define (get-triangle-source)
  (values-ref (http-get "projecteuler.net"
                        "/project/triangle.txt")
              2))

(define triangles (get-triangle-source))

(let1 datum (call-with-input-string triangles
              (pa$ port->list (^p (let1 r (read-line p)
                                    (if (eof-object? r)
                                        r
                                        (map string->number
                                             (string-split r " ")))))))
  (print (sum-max-root datum)))
