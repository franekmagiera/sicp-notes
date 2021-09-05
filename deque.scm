#lang sicp
(define (make-node val prev next) (list val prev next))
(define (val node) (car node))
(define (prev node) (cadr node))
(define (next node) (caddr node))
(define (set-prev! node item) (set-car! (cdr node) item))
(define (set-next! node item) (set-car! (cddr node) item))


(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))


(define (empty-deque? deque) (null? (front-ptr deque)))

(define (make-deque) (cons '() '()))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (front-ptr deque)))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque" deque)
      (rear-ptr deque)))

(define (rear-insert-deque! deque item)
  (let ((new-node (make-node item '() '()))) 
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-node)
           (set-rear-ptr! deque new-node)
           (print-deque deque))
          (else
           (set-next! (rear-ptr deque) new-node)
           (set-prev! new-node (rear-ptr deque))
           (set-rear-ptr! deque new-node)
           (print-deque deque)))))

(define (front-insert-deque! deque item)
    (let ((new-node (make-node item '() '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-node)
           (set-rear-ptr! deque new-node)
           (print-deque deque))
          (else
           (set-prev! (front-ptr deque) new-node)
           (set-next! new-node (front-ptr deque))
           (set-front-ptr! deque new-node)
           (print-deque deque)))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" (print-deque deque)))
        (else
         (if (null? (prev (rear-ptr deque)))
             (begin
               (set-front-ptr! deque '())
               (set-rear-ptr! deque '()))
             (begin
               (set-rear-ptr! deque (prev (rear-ptr deque)))
               (set-next! (rear-ptr deque) '())))
         (print-deque deque))))
         

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" (print-deque deque)))
        (else
         (if (null? (next (front-ptr deque)))
             (begin
               (set-front-ptr! deque '())
               (set-rear-ptr! deque '()))
             (begin
               (set-front-ptr! deque (next (front-ptr deque)))
               (set-prev! (front-ptr deque) '())))
         (print-deque deque))))

(define (print-deque deque)
  (define (print-list head)
    (if (null? head)
        '()
        (if (null? (next head))
            (cons (val head) '())
            (cons (val head) (print-list (next head))))))
  (print-list (front-ptr deque)))

(define q1 (make-deque))
(print-deque q1)
(rear-insert-deque! q1 3)
(front-insert-deque! q1 2)
(front-insert-deque! q1 1)
(rear-insert-deque! q1 4)

(front-delete-deque! q1)
(rear-delete-deque! q1)
(front-delete-deque! q1)
(rear-delete-deque! q1)

; -----

(front-insert-deque! q1 3)
(rear-insert-deque! q1 2)
(rear-insert-deque! q1 1)
(front-insert-deque! q1 4)

(rear-delete-deque! q1)
(front-delete-deque! q1)
(rear-delete-deque! q1)
(front-delete-deque! q1)
