(define (double proc)
    (lambda (x) (proc (proc x)))
)

(define (inc x) (+ 1 x))

((double inc) 1)

(((double (double double)) inc) 5) ; 5 + 16 = 21
