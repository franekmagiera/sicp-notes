(load "fast-expt.scm")

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
            (if (same-variable? exp var) 1 0)
          )
          ((sum? exp)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var)
            )
          )
          ((product? exp)
            (make-sum
                (make-product (multiplier exp)
                              (deriv (multiplicand exp) var)
                )
                (make-product (deriv (multiplier exp) var)
                              (multiplicand exp) 
                )
            ) 
          )
          ((exponentiation? exp)
            (make-product (deriv (base exp) var)
                          (make-product (exponent exp)
                                        (make-exponentiation (base exp) (- (exponent exp) 1))
                          )
            )
          )
          (else
            (error "unknown expression type -- DERIV" exp) 
          )
    )
)

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2))
)

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

(define (make-exponentiation base exp)
    (cond ((=number? base 0) 0)
          ((=number? base 1) 1)
          ((=number? exp 0) 1)
          ((=number? exp 1) base)
          ((and (number? base) (number? exp)) (fast-expt base exp))
          (else (list '** base exp))
    )
)

(define (sum? x)
    (and (pair? x) (eq? (car x) '+))
)

(define (addend s)
    (cadr s)
)

(define (augend s)
    (caddr s)
)

(define (product? x)
    (and (pair? x) (eq? (car x) '*))
)

(define (multiplier p)
    (cadr p)
)

(define (multiplicand p)
    (caddr p)
)

(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '**))
)

(define (base e)
    (cadr e)
)

(define (exponent e)
    (caddr e)
)

(deriv '(+ (** x 3) (* x y)) 'x)


;;;; Exercise 2.57
(define (multiplicand p)
    (if (null? (cdddr p))
        (caddr p)
        (cons '* (cddr p))
    )
)

(define (augend s)
    (if (null? (cdddr s))
        (caddr s)
        (cons '+ (cddr s))
    )
)

(deriv '(* x y z) 'x)
(deriv '(* x y (+ x 3)) 'x)
(deriv '(+ (* 2 3 x) (* x y z) (** x 2)) 'x)


;;;; Exercise 2.58a
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list a1 '+ a2))
    )
)

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list m1 '* m2))
    )
)

(define (make-exponentiation base exp)
    (cond ((=number? base 0) 0)
          ((=number? base 1) 1)
          ((=number? exp 0) 1)
          ((=number? exp 1) base)
          ((and (number? base) (number? exp)) (fast-expt base exp))
          (else (list base '** exp))
    )
)

(define (sum? x)
    (and (pair? x) (eq? (cadr x) '+))
)

(define (addend s)
    (car s)
)

(define (augend s)
    (caddr s)
)

(define (product? x)
    (and (pair? x) (eq? (cadr x) '*))
)

(define (multiplier p)
    (car p)
)

(define (multiplicand p)
    (caddr p)
)

(define (exponentiation? x)
    (and (pair? x) (eq? (cadr x) '**))
)

(define (base e)
    (car e)
)

(define (exponent e)
    (caddr e)
)

(deriv '(x + (3 * (x + (y + 2)))) 'x)


;;;;
