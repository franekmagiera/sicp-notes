; Always left to right.
(define (list-of-values exps env)
  (if (no-operands? exps)
    '() 
    (let (
      (first (eval (first-operand exps) env))
    )
    (cons first
          (list-of-values (rest-operands exps) env)))
  )
)

; Always right to left.
(define (list-of-values-right-to-left exps env)
  (if (no-operands? exps)
    '() 
    (let (
      (rest (list-of-values (cdr exps) env))
    )
      (cons (eval (first-operand exps) env) rest)
    )
  )
)

; Code that can be used to test evaluation order.
(define global 10)

(define (f a b) (+ a b))

(define (dec-global amt)
(begin
(set! global (- global amt))
global))

(define (mul-global amt)
(begin
(set! global (* global amt))
global))

(f (dec-global 10) (mul-global 2))

; Experiments to play with let and lambda.
(define (plus-two x)
  (let ((inc (+ x 1))) (+ inc 1))
)

(define (plus-three x)
  ((lambda (y) (+ y 1)) (+ x 2))
)
