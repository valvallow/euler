(let1 ls (iota 100 1)
  (print (- (expt (apply + ls) 2)
            (apply + (map (cut expt <> 2) ls)))))
