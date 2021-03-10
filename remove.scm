(define (remove item sequence)
    (filter (lambda (x) (not (= x item))) sequence)
)
