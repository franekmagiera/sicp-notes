(define (square x) (* x x))
(define (sum-squares x y) (+ (square x) (square y)))

(define (procedure x y z)
    (cond ((and (>= x z) (>= y z)) (sum-squares x y))
          ((and (>= x y) (>= z y)) (sum-squares x z))
          (else (sum-squares y z))
    )
)

(procedure 1 1 1)

(procedure 1 1 2)

(procedure 1 2 1)

(procedure 2 1 1)

(procedure 1 2 2)
