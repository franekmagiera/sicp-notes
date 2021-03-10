(load "flatmap.scm")
(load "enumerate.scm")

(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; represent positions by a list of (queen_row, queen_col) pairs

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
    (cons (list new-row k) rest-of-queens)
)

(define (safe? k positions)
    ; adjoin-position always prepends the position of the queen in the k-th column
    (define (in-check? queen1 queen2)
        (let (
            (r1 (car queen1))
            (r2 (car queen2))
            (c1 (cadr queen1))
            (c2 (cadr queen2))
        )
            (cond ((= r1 r2) #f)
                  ((= c1 c2) #f)
                  ((= (abs (- r1 r2)) (abs (- c1 c2))) #f)
                  (else #t)
            ) 
        )
    )
    (let (
        (queen-to-check (car positions))
        (rest (cdr positions))
    )
        (accumulate (lambda (queen others) (and (in-check? queen-to-check queen) others)) #t rest)
    )
)

(load "for-each.scm")

(define (display-solution solution)
    (newline)
    (display solution)
)

(for-each display-solution (queens 8))
