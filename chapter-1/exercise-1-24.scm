; code has to be run from parent directory
(load "fast-prime.scm")

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
)

(define (start-prime-test n start-time)
    (if (fast-prime? n 100)
        (report-prime (- (runtime) start-time)))
)

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(timed-prime-test 100000000000031)

(timed-prime-test 1000000000000037)

; by increasing the input 10x 
; log(n*10) = log(n) + log(10) ; expect small constant increase
