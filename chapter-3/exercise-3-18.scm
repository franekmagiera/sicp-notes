#lang sicp
(define (in? x xs)
    (if (null? xs)
        #f
        (if (eq? x (car xs))
            #t
            (in? x (cdr xs)))))

(define (cycle? xs)
  (let ((visited '()))
    (define (inner xs)
      (if (null? xs)
          #f
          (if (in? (car xs) visited)
              #t
              (begin
                (set! visited (cons (car xs) visited))
                (inner (cdr xs))
              )
          )
      )
    )
    (inner xs)
  )
)

(define x (list 1 2 3 4))
(cycle? x)

(set-cdr! (cdddr x) x)
x
(cycle? x)
