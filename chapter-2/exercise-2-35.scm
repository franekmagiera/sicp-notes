; run from parent directory
(load "accumulate-list.scm")

(define (count-leaves t)
    (accumulate + 0 (map (lambda (subtree) (if (pair? subtree) (count-leaves subtree) 1)) t))
)

(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)
(count-leaves (list x x))
