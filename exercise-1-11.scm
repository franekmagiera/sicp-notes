; recursive process
(define (frec n)
    (if (< n 3)
        n 
        (+
            (frec (- n 1))
            (* 2 (frec (- n 2)))
            (* 3 (frec (- n 3)))
        )
    )
)

(frec 11)

; iterative process
(define (fiter-helper a b c count)
    (if (= count 0)
        c
        (fiter-helper (+ a (* 2 b) (* 3 c)) a b (- count 1))
    )
)

(define (fiter n)
    (fiter-helper 2 1 0 n)
)

(fiter 11)
