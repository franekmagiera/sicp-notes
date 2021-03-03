(load "line-segments.scm")

; First representation - rectangle is a pair of two lines.
; It would be a good idea to enforce parallel segments, but for this exercise I am not going to bother with that.
(define (make-rect a b) (cons a b))
(define (a-length rect) (length (car rect)))
(define (b-length rect) (length (cdr rect)))

(define (perimeter rect)
    (+ (* 2 (a-length rect))
       (* 2 (b-length rect)) 
    )
)

(define (area rect)
    (* (a-length rect) (b-length rect))
)

(define rectangle (make-rect (make-segment (make-point 1 1) (make-point 1 3)) (make-segment (make-point 1 1) (make-point 3 1))))

(perimeter rectangle)
(area rectangle)

; Second representation - rectangle is a pair of two points (diagonal corners).
; Assuming rectangle's sides are parallel to x and y axes.
(define (make-rect a b) (cons a b))
(define (a-length rect) (abs (- (x-point (car rect)) (x-point (cdr rect)))))
(define (b-length rect) (abs (- (y-point (car rect)) (y-point (cdr rect)))))

(define rectangle (make-rect (make-point 1 1) (make-point 3 3)))

(perimeter rectangle)
(area rectangle)
