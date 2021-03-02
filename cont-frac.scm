; Exercise 1.37

(define (rec-cont-frac n d k)
    (define (inner n d i)
        (if (= i k)
            (/ (n i) (d i))
            (/ (n i) (+ (d i) (inner n d (+ i 1))))
        )
    )
    (inner n d 1)
)

(rec-cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)

(define (cont-frac n d k)
    (define (iter i accumulator)
        (if (= i 0)
            accumulator
            (iter (- i 1) (/ (n i) (+ accumulator (d i))))
        )
    )
    (iter (- k 1) (/ (n k) (d k)))
)

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)

; (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 1000000) ; works fine because of tail recursion
; (rec-cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 1000000) ; recursive process results in an error - maximum recursion depth exceeded

; Exercise 1.38

(define (d i)
    (cond ((= i 1) 1)
          ((= i 2) 2)
          ((= (remainder i 3) 2) (* 2 (+ 1 (/ (- i 2) 3))))
          (else 1)
    )
)

(+ 2 (cont-frac (lambda (i) 1.0) d 1000))

; Exercise 1.39

(define (square x) (* x x))
(define (id x) x)

(define (tan-cf x k)
    (define (n i)
        (if (= i 1)
            x 
            (* -1.0 (square x))
        )
    )
    (define (d i)
        (- (* 2 i) 1) 
    )
    (cont-frac n d k)
)

(tan-cf 45 100)
