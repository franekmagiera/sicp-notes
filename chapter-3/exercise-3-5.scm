#lang sicp
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))
(define (cesaro-test)
   (= (gcd (random 1000) (random 1000)) 1))
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(estimate-pi 1000)

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random (* 1.0 range)))))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (test)
    (P (random-in-range x1 x2) (random-in-range y1 y2)))
  (* 4.0 (monte-carlo trials test)))

(define (in-unit-circle x y) (< (+ (* x x) (* y y)) 1))

(estimate-integral in-unit-circle -1 1 -1 1 1000)
