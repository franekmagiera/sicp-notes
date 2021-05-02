(load "append.scm")

(define (make-leaf symbol weight)
    (list 'leaf symbol weight)
)

(define (leaf? object)
    (eq? (car object) 'leaf)
)

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))


(define (make-code-tree left right)
    (list left
          right
          (append (symbols left) (symbols right)) 
          (+ (weight left) (weight right))
    )
)

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree)) 
        (caddr tree)
    )
)

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree) 
        (cadddr tree)
    )
)


(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))


; Exercise 2.67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(decode sample-message sample-tree)
; (a d a b b c a)


; Exercise 2.68
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

; returns bits in reverse order
(define (encode-symbol symbol tree)
    (define (acc-bits symbol branch bits)
        (cond ((leaf? branch) bits)
              ((contains? (symbols (left-branch branch)) symbol) (acc-bits symbol (left-branch branch) (cons 0 bits)))
              ((contains? (symbols (right-branch branch)) symbol) (acc-bits symbol (right-branch branch) (cons 1 bits)))
              (else (error "symbol cannot be encoded"))
        )
    )
    (acc-bits symbol tree '())
)

(define (encode-symbol symbol tree)
    (cond ((leaf? tree) '())
            ((contains? (symbols (left-branch tree)) symbol) (cons 0 (encode-symbol symbol (left-branch tree))))
            ((contains? (symbols (right-branch tree)) symbol) (cons 1 (encode-symbol symbol (right-branch tree))))
            (else (error "symbol cannot be encoded"))
    )
)

(define (contains? list symbol)
    (cond ((null? list) #f)
          ((eq? symbol (car list)) #t)
          (else (contains? (cdr list) symbol))
    )
)

(encode-symbol 'A sample-tree)

(load "flatmap.scm")

(define (encode-message message tree)
    (flatmap (lambda (symbol) (encode-symbol symbol tree)) message)
)

(encode-message '(a d a b b c a) sample-tree)


; Exercise 2.69
(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs))
)

(define (successive-merge pairs)
    (if (null? (cdr pairs))
        (car pairs)
        (successive-merge (adjoin-set (make-code-tree (car pairs) (cadr pairs)) (cddr pairs)))
    )
)

(define pairs '((A 4) (B 2) (C 1) (D 1)))

(define huffman-tree (generate-huffman-tree pairs))

(encode-message '(a d a b b c a) huffman-tree)


; Exercise 2.70
(define pairs '((A 2) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1)))
(define huffman-tree (generate-huffman-tree pairs))

(define message '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom))

(define encoded (encode-message message huffman-tree))
encoded

(load "length.scm")
(length encoded)
(length message)

; 84 bits are required for the encoding.
; There are 36 words.
; If we used a fixed-length code for the eight-symbol alphabet, each word would have to be encoded with 3 bits.
; The whole message would then need 3 * 36 = 108 bits. Using Huffman encoding saved ~22% in space.
