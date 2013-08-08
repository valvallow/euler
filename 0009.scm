(use gauche.generator)
(use srfi-42)

;; https://github.com/shirok/Gauche/blob/master/test/srfi.scm
(define (pythagoras n)
  (list-ec
   (:let sqr-n (* n n))
   (:range a 1 (+ n 1))
   (:let sqr-a (* a a))
   (:range b a (+ n 1))
   (:let sqr-c (+ sqr-a (* b b)))
   (if (<= sqr-c sqr-n))
   (:range c b (+ n 1))
   (if (= (* c c) sqr-c))
   (list a b c)))

(let/cc break
  (dolist (ls (pythagoras 500))
    (when (= 1000 (apply + ls))
      (print (apply * ls))
      (break))))

