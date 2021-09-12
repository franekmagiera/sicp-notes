#lang sicp
(define (make-table)
  (define (assoc key records)
    (cond ((null? records) false)
          ((equal? key (caar records)) (car records))
          (else (assoc key (cdr records)))))
  
  (let ((local-table (list '*table*)))
    (define (lookup keys subtable)
      (cond ((null? keys) '())
            ((null? (cdr keys)) (cdr (assoc (car keys) (cdr subtable))))
            (else (lookup (cdr keys) (assoc (car keys) (cdr subtable))))))

    (define (insert! keys value subtable)
      (if (null? keys)
          (error "Keys not specified")
          (let ((records (assoc (car keys) (cdr subtable))))
            (if (null? (cdr keys))
                (if records
                    (set-cdr! records value)
                    (set-cdr! subtable
                              (cons (cons (car keys) value)
                                    (cdr subtable))))
                (if records
                    (if (not (pair? (cdr records)))
                        (begin
                          (set-cdr! records
                                    (cons (list (car keys))
                                          '()))
                          (insert! (cdr keys) value records))
                        (insert! (cdr keys) value records))
                    (begin
                      (set-cdr! subtable
                                (cons (list (car keys))
                                      (cdr subtable)))
                      (insert! keys value subtable)))))))
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) (lambda (keys) (lookup keys local-table)))
            ((eq? m 'insert-proc!) (lambda (keys value) (insert! keys value local-table)))
            (else (error "Unknown operation -- TABLE" m))))
    
    dispatch))


(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put (list 1 1) 'val)

(get (list 1 1))

(put (list 1 2) 'new-val)

(get (list 1 2))

(put (list 1) 'newest-val)
(get (list 1))

(put (list 1 2 3) 'a)
(put (list 1 2 2) 'b)
(put (list 2 3) 'c)

(get (list 1 2 3))
(get (list 1 2 2))
(get (list 2 3))

(put (list 2 3) 'd)
(get (list 2 3))
