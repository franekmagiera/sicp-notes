#lang sicp
(#%require sicp-pict)

(define (split painter1 painter2)
  (define (helper painter n)
    (if (= n 0)
        painter
        (let ((smaller (helper painter (- n 1))))
              (painter1 painter (painter2 smaller smaller))
        )
    )
  )
  helper
)

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 2))
(paint (up-split einstein 2))
