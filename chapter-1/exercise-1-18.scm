(define (double n) (+ n n))

(define (halve n) (/ n 2))

(define (even? n) (= (remainder n 2) 0))

; a * b + c is invariant
(define (fast-mult-iter a b c)
    (if (= b 0)
        c 
        (if (even? b)
            (fast-mult-iter (double a) (halve b) c)
            (fast-mult-iter a (- b 1) (+ a c))
        )
    )
)

(fast-mult-iter 5 7 0)
(fast-mult-iter 4 8 0)
(fast-mult-iter 3 9 0)
(fast-mult-iter 8 3 0)
