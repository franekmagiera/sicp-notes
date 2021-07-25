#lang sicp
(define global 10)
(define (f x)
  (set! global (* x global))
  global)

(+ (f 1) (f 0))

(set! global 10)

(+ (f 0) (f 1))
