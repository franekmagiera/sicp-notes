; run from parent dir
(load "append.scm")
(load "binary-tree.scm")


(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))


(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


; tree->list-1 traverses the tree in order
; tree->list-2 traverses the tree basically in reverse order but results are consed so the list is returned in order

; tree->list-2 grows more slowly - it grows as O(n) whereas tree->list-1 grows as O(n log n) because of calls to append

(define (create-tree xs)
    (if (null? xs)
        '()
        (adjoin-set (car xs) (create-tree (cdr xs)))
    )
)

(define tree1 (create-tree (list 11 5 1 9 3 7)))

(define tree2 (create-tree (list 11 9 5 7 1 3)))

(define tree3 (create-tree (list 11 7 9 1 3 5)))

(tree->list-1 tree1)
(tree->list-2 tree1)

(tree->list-1 tree2)
(tree->list-2 tree2)

(tree->list-1 tree3)
(tree->list-2 tree3)
