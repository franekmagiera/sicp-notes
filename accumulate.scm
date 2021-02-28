; recursive accumulate
(define (rec-accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a) (rec-accumulate combiner null-value term (next a) next b))
    )
)

(define (id n) n)
(define (inc n) (+ n 1))
(rec-accumulate + 0 id 1 inc 10) ; 55
(rec-accumulate * 1 id 1 inc 10) ; 3628800

; iterative accumulate
(define (accumulate combiner null-value term a next b)
    (define (iter a accumulator)
        (if (> a b)
            accumulator
            (iter (next a) (combiner (term a) accumulator))
        )
    )
    (iter a null-value)
)

(accumulate + 0 id 1 inc 10) ; 55
(accumulate * 1 id 1 inc 10) ; 3628800

(define (sum term a next b) (accumulate + 0 term a next b))
(define (product term a next b) (accumulate * 1 term a next b))

(sum id 1 inc 10)
(product id 1 inc 10)

(define (filtered-accumulate combiner null-value term a next b filter)
    (define (iter a accumulator)
        (if (> a b)
            accumulator 
            (if (filter a)
                (iter (next a) (combiner (term a) accumulator)) 
                (iter (next a) accumulator)
            )
        ) 
    )
    (iter a null-value)
)
