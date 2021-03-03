; We can represent pairs of nonnegative integers using only numbers and arithmetic
; operations if we use the pair a and b as the integer that is the product 2^a * 3^b.
; This is because for any (a1, b1) and (a2, b2) 2^a1 * 3^b1 == 2^a2 * 3^b2 only if
; a1 == a2 and b1 == b2.
;
; 1st case: a1 <= a2 and b1 <= b2
; 2^a1 * 3^b1 = 2^a2 * 3^b2
; 1 = 2^(a2-a1) * 3^(b2-b1)
; In order for this to be true a2-a1 has to equal 0
; and b2-b1 has to equal 0 as well.
;
; 2nd case: a1 <= a2 and b1 >= b2
; 2^a1 * 3^b1 = 2^a2 * 3^b2
; 3^(b1-b2) = 2^(a2-a1)
; Left and right side don't have any common factors.
; In order for L = R they have to equal 1
; so again a2-a1 has to equal 0 and b2-b1 has to equal 0.
;
; So we can represent pairs (a, b) using 2^a * 3^b.

; script has to be run from the parent directory
(load "fast-expt.scm")

(define (cons a b)
    (* (fast-expt 2 a) (fast-expt 3 b))
)

(define (divide-until-not-possible number divisor)
    (if (= (remainder number divisor) 0)
        (divide-until-not-possible (/ number divisor) divisor)
        number
    )
)

(define (count-divisions number divisor)
    (define (iter number divisor accumulator)
        (if (= (remainder number divisor) 0)
            (iter (/ number divisor) divisor (+ 1 accumulator))
            accumulator
        )
    )
    (iter number divisor 0)
)

(define (car c)
    (count-divisions (divide-until-not-possible c 3) 2)
)

(define (cdr c)
    (count-divisions (divide-until-not-possible c 2) 3)
)

(define pair (cons 13 17))
pair
(car pair)
(cdr pair)

(define pair (cons 0 11))
pair
(car pair)
(cdr pair)

(define pair (cons 7 0))
pair
(car pair)
(cdr pair)

(define pair (cons 0 0))
pair
(car pair)
(cdr pair)
