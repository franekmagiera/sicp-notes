; Sets as binary trees.

; Represent trees in terms of lists.
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
    (list entry left right))


; Represent sets in terms of trees.
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))


(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))


; Convert a tree to an ordered list with O(n) complexity.
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))


; Convert an ordered list to balanced tree with O(n) complexity.
(define (list->tree elements)
  (car (partial-tree elements (length elements))))


(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))


(load "ordered-set.scm")

(define (union-bt-set tree1 tree2)
    (let (
        (list1 (tree->list tree1))
        (list2 (tree->list tree2))
    )
    (list->tree (union-set list1 list2))
    )
)


(define tree1 (list 2 (list 1 '() '()) (list 3 '() '())))
(define tree2 (list 5 (list 4 (list 3 '() '()) '()) (list 6 '() '())))
(tree->list (union-bt-set tree1 tree2))


(define (intersection-bt-set tree1 tree2)
    (let (
        (list1 (tree->list tree1))
        (list2 (tree->list tree2))
    )
    (list->tree (intersection-set list1 list2))
    )
)

(tree->list (intersection-bt-set tree1 tree2))
