(define (for-each procedure xs)
    (if (null? xs)
        #t
        (and (procedure (car xs))
             (for-each procedure (cdr xs))
        )
    )
)

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
