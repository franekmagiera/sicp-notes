; code has to be run from parent directory
(load "fast-prime.scm")

(define (fermat-test2 a n)
    (= (expmod a n n) a)
)

(define (test n)
    (define (test-inner a n)
        (cond ((= a n) true)
              ((fermat-test2 a n) (test-inner (+ a 1) n))
              (else false)
        )
    )
    (test-inner 1 n)
)

(test 561)
(test 1105)
(test 1729)
(test 2465)
(test 2821)
(test 6601)

(load "prime.scm")

(prime? 561)
(prime? 1105)
(prime? 1729)
(prime? 2465)
(prime? 2821)
(prime? 6601)
