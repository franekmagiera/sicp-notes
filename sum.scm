; recursive process
(define (rec-sum term a next b)
    (if (> a b)
        0
        (+ (term a) (rec-sum term (next a) next b)) 
    )
)

; iterative process
(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (+ result (term a))) 
        ) 
    )
    (iter a 0)
)
