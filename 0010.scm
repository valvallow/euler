(use math.prime)
(use gauche.sequence)

(cond ((find-index (pa$ <= (* (expt 10 6) 2)) *primes*)
       => (.$ print (apply$ +)(pa$ take *primes*))))
