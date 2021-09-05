#lang sicp
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

; a convoluted solution to Exercise 3.17. that doesn't use `set!` which I learned about after writing this:
(define (correct-count-pairs x)
  ; does xs contain a pointer to x?
  (define (in? x xs)
    (if (null? xs)
        #f
        (if (eq? x (car xs))
            #t
            (in? x (cdr xs)))))

  (define visited (cons x '()))

  (define (count-pairs x)
    (if (not (pair? x))
        0
        (if (in? x visited)
            0
            (begin
              (let (
                    (temp (car visited))
                    )(
                      begin 
                       (set-car! visited x)
                       (set-cdr! visited (cons temp (cdr visited)))
                      )
              )
              (+ (count-pairs (car x))
                 (count-pairs (cdr x))
                  1)
            )
        )
    )
  )

  (if (pair? x)
      (+ 1 (count-pairs (car x)) (count-pairs (cdr x)))
      0
  )
)

(define x (cons 1 (cons 2 (cons 3 '()))))
(count-pairs x)
(correct-count-pairs x)
x
(display "---\n")

(set-car! (cdr x) (cddr x))
(count-pairs x)
(correct-count-pairs x)
x
(display "---\n")

(set-car! x (cdr x))
(count-pairs x)
(correct-count-pairs x)
x
(display "---\n")

(define y (list 1 2 3 4))
(set-cdr! (cdddr y) y)
(correct-count-pairs y)
y
; (count-pairs y) ; infinite loop
