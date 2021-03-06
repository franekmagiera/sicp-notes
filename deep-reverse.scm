(load "reverse.scm")

(define (deep-reverse xs)
    (cond ((null? xs) xs)
          ((not (pair? xs)) xs)
          (else (reverse (map deep-reverse xs)))
    )
)

(define x (list (list 1 2) (list 3 4)))

(reverse x)
(deep-reverse x)

(deep-reverse (list 1 2 3 4))

(deep-reverse (list 1 (list 2) (list 3 4)))
(reverse (list 1 (list 2 (list 3 4))))
