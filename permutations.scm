(load "remove.scm")
(load "flatmap.scm")

(define (permutations s)
    (if (null? s)
        (list '())
        (flatmap (lambda (x)
                    (map (lambda (p) (cons x p)) (permutations (remove x s)))
                 )
         s
        )
    )
)

(permutations (list 1 2 3))
