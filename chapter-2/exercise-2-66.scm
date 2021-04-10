(define (make-record id name surname) (list id name surname))
(define (get-key record) (car record))


(define records (list
    (make-record 1 'Jimmy 'McNulty)
    (make-record 2 'Shakima 'Greggs)
    (make-record 3 'Bunk 'Moreland)
    (make-record 4 'Cedric 'Daniels)
    (make-record 5 'Lester 'Freamon)
    (make-record 6 'Stringer 'Bell)
    (make-record 7 'Clay 'Davis)
))


(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
    (list entry left right))


(define (add-record get-key record set)
    (let (
        (record-key (get-key record))
        (entry-key (if (null? set) '() (get-key (entry set))))
    )
    
    (cond ((null? set) (make-tree record '() '()))
          ; If key is present overwrite.
          ((= record-key entry-key) (make-tree record (left-branch set) (right-branch set)))
          ((< record-key entry-key) (make-tree (entry set) (add-record get-key record (left-branch set)) (right-branch set)))
          (else (make-tree (entry set) (left-branch set) (add-record get-key record (right-branch set))))
    )
    )
)


(load "binary-tree.scm")

(define set-of-records (list->tree records))
(display set-of-records)
(tree->list set-of-records)


(define (lookup get-key key set-of-records)
    (let (
        (entry-key (if (null? set-of-records) '() (get-key (entry set-of-records))))
    )

    (cond ((null? set-of-records) false)
          ((= key entry-key) (entry set-of-records))
          ((< key entry-key) (lookup get-key key (left-branch set-of-records)))
          (else (lookup get-key key (right-branch set-of-records)))
    )
    )
)


(lookup get-key 6 set-of-records)
(define set-of-records (add-record get-key (make-record 6 'Marlo 'Steinfield) set-of-records))
(tree->list set-of-records)
(lookup get-key 6 set-of-records)
(lookup get-key 8 set-of-records)
(define set-of-records (add-record get-key (make-record 8 'Beadie 'Russell) set-of-records))
(lookup get-key 8 set-of-records)
(tree->list set-of-records)
