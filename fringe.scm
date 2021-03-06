(load "append.scm")

; not very efficient...
(define (fringe tree)
    (cond ((null? tree) '())
          ((not (pair? tree)) (cons tree '()))
          (else (append (fringe (car tree)) (fringe (cdr tree))))
    )

)


(define x (list (list 1 2) (list 3 4)))

(fringe x)
