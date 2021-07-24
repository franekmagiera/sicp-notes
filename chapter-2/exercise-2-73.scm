#lang sicp
(#%require "../table.scm")

; ----- TYPE TAGS -----
(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))
; -----

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))
)

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))

(define (=number? exp num)
    (and (number? exp) (= exp num))
)

(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))
    )
)

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))
    )
)

(define (addend s)
    (car s)
)

(define (augend s)
    (cadr s)
)

(define (multiplier p)
    (car p)
)

(define (multiplicand p)
    (cadr p)
)

(define (sum-deriv operands var)
  (make-sum (deriv (addend operands) var) (deriv (augend operands) var))
)

(define (product-deriv operands var)
  (make-sum
     (make-product (multiplier operands) (deriv (multiplicand operands) var))
     (make-product (deriv (multiplier operands) var) (multiplicand operands))
  )
)

(put 'deriv '+ sum-deriv)
(put 'deriv '* product-deriv)

(deriv '(+ (* 3 x) (* x y)) 'x)
