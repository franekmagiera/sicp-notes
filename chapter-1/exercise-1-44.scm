; run from parent directory
(load "repeated.scm")

(define dx 0.00001)

(define (smooth f)
    (lambda (x)
        (/ (+ (f (- x dx))
           (f x)
           (f (+ x dx)))
           3
        )
    )
)

(define (n-fold-smooth f n)
    ((repeated smooth n) f)
)

((n-fold-smooth square 3) 2)
((smooth square) 2)
