; recursive process
(define (rec-product term a next b)
    (if (> a b)
        1
        (* (term a) (rec-product term (next a) next b)) 
    )
)

; iterative process
(define (product term a next b)
    (define (iter a accumulator)
        (if (> a b)
            accumulator
            (iter (next a) (* accumulator (term a))) 
        )
    )
    (iter a 1)
)
