; run from parent directory
(load "fold-left.scm")

(define (append-n xs n)
    (if (null? xs)
        (cons n '()) 
        (cons (car xs) (append-n (cdr xs) n))
    )
)

; Inefficient O(n^2)
(define (reverse sequence)
    (fold-right (lambda (x y) (append-n y x)) '() sequence)
)

(reverse (list 1 2 3 4 5))

(define (reverse sequence)
    (fold-left (lambda (x y) (cons y x)) '() sequence)
)

(reverse (list 1 2 3 4 5))
