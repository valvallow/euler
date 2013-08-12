(use gauche.lazy)

;; http://zacharydenton.com/project-euler-solutions/26/
(define (recurring-cycle d)
  (find (^t (= 1 (modulo (expt 10 t) d)))
        (lrange 1 d)))

(print
 (car (fold (^(i acc)
              (if-let1 c (and-let*
                             ((r (recurring-cycle i))
                              ((< (cdr acc) r))
                              ((cons i r))))
                       c
                       acc))
            (cons 0 0)
            (iota 1000))))
