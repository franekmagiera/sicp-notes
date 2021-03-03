(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
    (lambda (f) (lambda (x) (f ((n f) x))))
)

; (add-1 zero)
; (lambda (f) (lambda (x) (f ((zero f) x))))
; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))
; (lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))

; (add-1 one)
; (lambda (f) (lambda (x) (f ((one f) x))))
; (lambda (f) (lambda (x) (f (f x))))

(define two (lambda (f) (lambda (x) (f (f x)))))

; Church encoding represents integers as functions that take in a function as parameter
; and return a function that applies that function passed in as a parameter n times to an argument x.

(define (add a b)
    (lambda (f) (lambda (x) ((b f) ((a f) x))))
)

(define (inc n) (+ n 1))

((zero inc) 0)
((one inc) 0)
((two inc) 0)

(((add one two) inc) 0)
