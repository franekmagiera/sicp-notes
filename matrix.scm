(load "accumulate-list.scm")
(load "accumulate-n.scm")

(define (dot-product v w)
    (accumulate + 0 (map * v w))
)

(define (matrix-*-vector m v)
    (map (lambda (row) (dot-product row v)) m)
)

(define (transpose mat)
    (accumulate-n cons '() mat)
)

(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (row) (matrix-*-vector cols row)) m)
    )
)

(define matrix (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))

(transpose matrix)

(matrix-*-vector matrix (list 2 1 0))

(matrix-*-matrix matrix (list (list 2 0 0) (list 0 1 0) (list 0 0 1)))
