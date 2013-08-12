(print (apply + (filter (^x (or (zero? (modulo x 5))
                                (zero? (modulo x 3))))
                        (iota 999 1))))
