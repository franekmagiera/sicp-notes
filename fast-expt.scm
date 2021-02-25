(define (even? n)
    (= (remainder n 2) 0)
)

; iterative process
; ab^n is invariant
(define (fast-expt-inner b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-inner (* b b) (/ n 2) a))
          (else (fast-expt-inner b (- n 1) (* a b)))
    )
)

(define (fast-expt b n) (fast-expt-inner b n 1))
