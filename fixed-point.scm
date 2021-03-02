(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (newline)
      (display next)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
 
(fixed-point (lambda (x) (+ 1.0 (/ 1.0 x))) 1.0)

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)

(define (average a b) (/ (+ a b) 2))

(fixed-point (lambda (x) (average (/ (log 1000) (log x)) x)) 2.0)
