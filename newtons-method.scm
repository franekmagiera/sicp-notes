(define dx 0.00001)

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
            dx)
    )
)

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x))) 
    )
)

(load "fixed-point.scm")

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess)
)

(define (square x) (* x x))
(define (sqrt x)
    (newtons-method (lambda (y) (- (square y) x)) 1.0)
)

(sqrt 9)

; Exercise 1.40.

(define (cube x) (* x x x))
(define (cubic a b c)
    (lambda (x)
        (+ (cube x)
            (* a (square x)) 
            (* b x)
            c
        ) 
    )
)

(newtons-method (cubic 1 2 3) 1.0)
