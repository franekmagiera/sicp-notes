(load "append.scm")
(load "accumulate-list.scm")

(define (flatmap proc seq)
    (accumulate append '() (map proc seq))
)
