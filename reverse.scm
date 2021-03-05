(load "append.scm")

(define (range n)
    (if (= n 0)
        '()
        (cons n (range (- n 1)))
    )
)

(range 10)

(define (report elapsed-time)
    (display " *** ")
    (display elapsed-time)
)

(define (start-reverse-test n start-time)
    (reverse (range n))
    (report (- (runtime) start-time)))
)

(define (timed-reverse-test n)
    (newline)
    (display n)
    (start-reverse-test n (runtime))
)

(define (reverse xs)
    (if (null? xs)
        xs
        (append (reverse (cdr xs)) (cons (car xs) '()))
    )
)

(reverse (list 1 4 9 16 25))

; First implementation. O(n^2)

(timed-reverse-test 100)
(timed-reverse-test 1000)
(timed-reverse-test 10000)

(define (reverse xs)
    (define (iter ys accumulator)
        (if (null? ys)
            accumulator 
            (iter (cdr ys) (cons (car ys) accumulator))
        ) 
    )
    (iter xs '())
)

(reverse (list 1 4 9 16 25))

; Second implementation.
(timed-reverse-test 100)
(timed-reverse-test 1000)
(timed-reverse-test 10000)
