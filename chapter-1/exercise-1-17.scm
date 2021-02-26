(define (double n) (+ n n))

(define (halve n) (/ n 2))

(define (even? n) (= (remainder n 2) 0))

(define (fast-mult a b)
    (if (= b 0)
        0 
        (if (even? b)
            (double (fast-mult a (halve b)))
            (+ a (fast-mult a (- b 1)))
        )
    )
)

(fast-mult 5 7)
(fast-mult 4 8)
(fast-mult 3 9)
(fast-mult 8 3)
