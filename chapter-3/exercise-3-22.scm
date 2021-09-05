#lang sicp
(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define empty-queue?
      (lambda () (null? front-ptr)))

    (define front-queue
        (lambda ()
          (if (null? front-ptr)
              (error "FRONT called with an empty queue" front-ptr)
              (car front-ptr))))
      
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))

    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((null? front-ptr)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               front-ptr)
              (else
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)
               front-ptr))))

    (define delete-queue!
      (lambda ()
        (cond ((null? front-ptr)
               (error "DELETE! called with an empty queue"))
              (else
               (set-front-ptr! (cdr front-ptr))
               front-ptr))))
    
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
      )
    )
    dispatch)
)

(define q (make-queue))

((q 'empty-queue?))

((q 'insert-queue!) 10)

((q 'insert-queue!) 20)

((q 'delete-queue!))

((q 'delete-queue!))
