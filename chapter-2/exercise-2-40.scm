; run from parent directory
(load "flatmap.scm")
(load "enumerate.scm")

(define (unique-pairs n)
    (flatmap (lambda (i) (map (lambda (j) (list i j)) (enumerate 1 (- i 1)))) (enumerate 1 n))
)

(unique-pairs 6)


(load "prime.scm")
(define (prime-sum-pairs n)
    (map (lambda (pair) (list (car pair) (cadr pair) (+ (car pair) (cadr pair)))) (filter (lambda (pair) (prime? (+ (car pair) (cadr pair)))) (unique-pairs n)))
)

(prime-sum-pairs 6)
