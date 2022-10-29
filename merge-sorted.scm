(define (merge-sorted xs ys)
    (if (null? xs)
        ys
        (if (null? ys)
            xs
            (if (< (car xs) (car ys))
                (cons (car xs) (merge (cdr xs) ys))
                (cons (car ys) (merge xs (cdr ys)))))))

(display "\n\n;;;\n\n")
(display (merge-sorted '(1 3 7 11) '(5 9)))
(display "\n\n")
