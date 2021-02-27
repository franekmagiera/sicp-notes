; code has to be run from parent directory
(load "prime.scm")

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
)

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time)))
)

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime))
)

(define (even? n) (= (remainder n 2) 0))

; Search for primes in <a,b> range.
(define (search-for-primes a b)
    (if (even? a)
        (search-for-primes (+ a 1) b)
        (
            if (<= a b)
               (
                   begin
                   (timed-prime-test a)
                   (search-for-primes (+ a 2) b)
               )
        )
    )
)

; (search-for-primes 1001 1019)
; (search-for-primes 10001 10037)
; (search-for-primes 100001 100043)
; (search-for-primes 1000001 1000037)

(timed-prime-test 100000000000031) ; For one of the runs it took 7.16s

(timed-prime-test 1000000000000037) ; For one of the runs it took 22.83s

; 22.83 / 7.16 ~= 3.19 ~= sqrt(10) ~= 3.16

; now after completing exercise 1. 23.
; (timed-prime-test 100000000000031) ; took 4.46s
; (timed-prime-test 1000000000000037) ; took 14.1s
; so the speedup was not exactly 2x, it was about 1.6x faster
; probably evaluating the `if` statement creates some slow down
; also there is one more function call
