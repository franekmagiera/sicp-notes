; script has to be run from parent directory
(load "accumulate.scm")
(load "prime.scm")

(define (square x) (* x x))
(define (inc n) (+ n 1))
(define (sum-of-square-primes-in-range a b)
    (filtered-accumulate + 0 square a inc b prime?)
)
(sum-of-square-primes-in-range 2 23) ; 1556

(load "gcd.scm")

(define (id n) n)
(define (product-of-all-relatively-prime-smaller-than-n n)
    (define (relatively-prime? a)
        (if (= (gcd a n) 1)
            true
            false 
        )
    )
    (filtered-accumulate * 1 id 2 inc (- n 1) relatively-prime?)
)

(product-of-all-relatively-prime-smaller-than-n 16)
