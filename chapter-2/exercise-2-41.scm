; run from parent directory
(load "enumerate.scm")
(load "flatmap.scm")

(define (unique-triplets n)
    (flatmap (lambda (i) (flatmap (lambda (j) (map (lambda (k) (list k j i)) (enumerate 1 (- j 1)))) (enumerate 1 (- i 1)))) (enumerate 1 n))
)

(unique-triplets 5)

(define (triplets-sum n s)
    (filter (lambda (triple) (= s (+ (car triple) (cadr triple) (caddr triple)))) (unique-triplets n))
)

(triplets-sum 5 9)
