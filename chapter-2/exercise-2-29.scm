(define (make-mobile left right)
    (list left right)
)

(define (make-branch length structure)
    (list length structure)
)

(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (car (cdr mobile)))

(define (branch-length branch) (car branch))
(define (branch-structure branch) (car (cdr branch)))

(define (total-weight mobile)
    (cond ((not (pair? mobile)) mobile)
          (else (+ (total-weight (branch-structure (left-branch mobile)))
                   (total-weight (branch-structure (right-branch mobile)))
                )
          )
    )
)


(define mobile (make-mobile (make-branch 22 (make-mobile (make-branch 5 5) (make-branch 5 5))) (make-branch 5 22)))
(total-weight mobile)

(total-weight (make-mobile (make-branch 1 2) (make-branch 3 4)))

(define mobile (make-mobile (make-branch 6 (make-mobile (make-branch 5 3) (make-branch 5 7))) (make-branch 2 4)))
(total-weight mobile)


(define (torque branch) (* (branch-length branch) (total-weight (branch-structure branch))))

(define (balanced? mobile)
    (if (not (pair? mobile))
        #t
        (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
             (balanced? (branch-structure (left-branch mobile)))
             (balanced? (branch-structure (right-branch mobile)))
        ) 
    )
)


(balanced? (make-mobile (make-branch 10 (make-mobile (make-branch 5 5) (make-branch 5 5))) (make-branch 10 10)))
(balanced? (make-mobile (make-branch 8 8) (make-branch 2 (make-mobile (make-branch 3 8) (make-branch 1 24)))))

; Suppose we change the representation of mobiles so that the constructors are:
(define (make-mobile left right)
    (cons left right)
)

(define (make-branch length structure)
    (cons length structure)
)

; because of abstraction barriers, only selectors need change:
(define (right-branch mobile) (cdr mobile))

(define (branch-structure branch) (cdr branch))

(balanced? (make-mobile (make-branch 10 (make-mobile (make-branch 5 5) (make-branch 5 5))) (make-branch 10 10)))
(balanced? (make-mobile (make-branch 8 8) (make-branch 2 (make-mobile (make-branch 3 8) (make-branch 1 24)))))
(balanced? (make-mobile (make-branch 7 9) (make-branch 2 (make-mobile (make-branch 3 8) (make-branch 1 24)))))
