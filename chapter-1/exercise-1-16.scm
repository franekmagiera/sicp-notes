(define (even? n)
    (= (remainder n 2) 0)
)

(define (fast-expt-inner b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-inner (* b b) (/ n 2) a))
          (else (fast-expt-inner b (- n 1) (* a b)))
    )
)

(define (fast-expt-iter b n) (fast-expt-inner b n 1))

(fast-expt-iter 4 0)
(fast-expt-iter 2 16)
(fast-expt-iter 2 17)
