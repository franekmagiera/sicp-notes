(define (rec-length items)
    (if (null? items)
        0
        (+ 1 (rec-length (cdr items)))    
    )
)

(define (length items)
    (define (iter a count)
        (if (null? a)
            count
            (iter (cdr a) (+ 1 count))
        )
    )
    (iter items 0)
)
