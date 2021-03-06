(define (iterative-improve good-enough? improve)
    (define (iter guess)
        (if (good-enough? guess)
            guess
            (iter (improve guess))
        ) 
    )
    iter
)

(define tolerance 0.00001)

(define (average a b) (/ (+ a b) 2.0))

(define (sqrt x)
    ((iterative-improve
        (lambda (guess) (< (abs (- (square guess) x)) tolerance))
        (lambda (guess) (average guess (/ x guess)))
    ) x)
)

(sqrt 9)
(sqrt 25)

(define (fixed-point f first-guess)
    ((iterative-improve
        (lambda (guess) (< (abs (- guess (f guess))) tolerance)) 
        f
    ) first-guess)
)

(fixed-point cos 1.0)
