(use srfi-13)

(let1 ls (iota 1000 1)
  (string-take-right (number->string (apply + (map expt ls ls))) 10))
