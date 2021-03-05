(define (same-parity first . rest)
    (define (parity-as-first? number)
        (= (remainder first 2) (remainder number 2))
    )
    (define (iter xs)
        (cond ((null? xs) xs)
              ((parity-as-first? (car xs))
                (cons (car xs) (iter (cdr xs)))
              )
              (else (iter (cdr xs)))
        ) 
    )
    (iter (cons first rest))
)

(same-parity 1 2 3 4 5 6 7)

(same-parity 2 3 4 5 6 7)
