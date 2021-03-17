(load "append.scm")

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)        
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
    (if (null? set2)
        set1
        (if (element-of-set? (car set2) set1)
            (union-set set1 (cdr set2))
            (cons (car set2) (union-set set1 (cdr set2)))
        )
    )
)

(union-set (list 1 2 3) (list 2 3 4 5 6))

;;;; Exercise 2.60.

(define (adjoin-set x set)
    (cons x set)
)

(define (union-set set1 set2)
    (append set1 set2)
)
