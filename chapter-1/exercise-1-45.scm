(define (average a b) (/ (+ a b) 2))

(define (average-damp f)
    (lambda (x) (average x (f x)))
)

(load "fixed-point.scm")
(load "fast-expt.scm")
(load "repeated.scm")

(define (nth-root n x damps)
    (fixed-point ((repeated average-damp damps) (lambda (y) (/ x (fast-expt y (- n 1))))) 1.0)
)

(nth-root 8 6561 10)
