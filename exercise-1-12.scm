(define (pascal i j)
    (cond ((= i j) 1) ; ones on diagonal
          ((= j 0) 1) ; ones in the first column
          (else (+ (pascal (- i 1) j) (pascal (- i 1) (- j 1))))
    )
)

(pascal 0 0) ;; 1
(pascal 1 1) ;; 1
(pascal 3 1) ;; 3
(pascal 3 2) ;; 3
(pascal 4 2) ;; 6
(pascal 5 2) ;; 10
(pascal 5 3) ;; 10
(pascal 5 4) ;; 5
