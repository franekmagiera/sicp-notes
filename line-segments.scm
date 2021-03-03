(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment start end) (cons start end))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (average x y) (/ (+ x y) 2))

(define (midpoint-segment segment)
    (make-point (average (x-point (start-segment segment)) (x-point (end-segment segment)))
                (average (y-point (start-segment segment)) (y-point (end-segment segment)))
    )
)

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ", ")
    (display (y-point p))
    (display ")")
)

(print-point (midpoint-segment (make-segment (make-point 1 1) (make-point 1 3)))) ; (1, 2)

(print-point (midpoint-segment (make-segment (make-point 1 1) (make-point 3 1)))) ; (2, 1)

(print-point (midpoint-segment (make-segment (make-point 1 1) (make-point 3 3)))) ; (2, 2)

(define (length segment)
    (sqrt (+ (square (- (x-point (end-segment segment)) (x-point (start-segment segment))))
             (square (- (y-point (end-segment segment)) (y-point (start-segment segment))))
          ) 
    )
)
