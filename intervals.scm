(define (make-interval a b) (cons a b))
(define (upper-bound interval) (max (car interval) (cdr interval)))
(define (lower-bound interval) (min (car interval) (cdr interval)))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))
    )
)

(define (mul-interval x y)
    (let (
        (p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y)))
    )
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4)
        ) 
    )
)

(define (div-interval x y)
    (if (= (lower-bound y) (upper-bound y))
        (error "Division by interval that spans zero")
        (mul-interval x
            (make-interval (/ 1.0 (upper-bound y))
                        (/ 1.0 (lower-bound y))
            ) 
        )
    )
)

(define (sub-interval x y)
        (make-interval (- (lower-bound x) (upper-bound y))
                    (- (upper-bound x) (lower-bound y))
        )
)


(define (make-center-width c w)
    (make-interval (- c w) (+ c w))
)

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2)
)

(define (width i)
    (/ (- (upper-bound i) (lower-bound u)) 2)
)


(define (make-center-percent c p)
    (make-interval (- c (* c p)) (+ c (* c p)))
)

; center selector is unchanged

(define (percent i)
    (/ (width i) (center i))
)


(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2)
                  (add-interval r1 r2)
    )
)

(define (par2 r1 r2)
    (let (
        (one (make-interval 1 1))
    )
        (div-interval one
                      (add-interval (div-interval one r1)
                                    (div-interval one r2)
                      ) 
        )
    )
)

(define r1 (make-center-percent 100 0.1))
(define r2 (make-center-percent 200 0.1))

(par1 r1 r2)
(par2 r1 r2)

(div-interval r1 r1)
(div-interval r1 r2)

; The problem is that by dividing A/A we get as a result an interval and not 1.
; The method does not know that (div-interval A A) represents the same number and
; that it should return one, instead it assumes the first argument is some number
; from range of A and the second argument is some other number from range of A
; and computes the interval accordingly.

; Moreover, a lot of algebraic laws that are true for numbers do not hold in
; this interval arithmetic system.
