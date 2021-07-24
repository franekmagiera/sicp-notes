#lang sicp
(define (make-vect x y) (list x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cadr v))

(define (add-vect a b)
  (make-vect
    (+ (xcor-vect a) (xcor-vect b))
    (+ (ycor-vect a) (ycor-vect b))
  )
)

(define (sub-vect a b)
  (make-vect
    (- (xcor-vect a) (xcor-vect b))
    (- (ycor-vect a) (ycor-vect b))
  )
)

(define (scale-vect s a)
  (make-vect
    (* (xcor-vect a) s)
    (* (ycor-vect a) s)
  )
)

(add-vect (make-vect -1 0) (make-vect 1 1))
(sub-vect (make-vect 2 1) (make-vect 1 3))
(scale-vect 8 (make-vect 3 4))