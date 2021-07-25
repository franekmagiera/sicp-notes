#lang sicp
(define (make-account balance init-password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch password m)
    (cond ((not (eq? password init-password)) (lambda (_) "Incorrect password"))
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          ((eq? m 'join) dispatch)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define (make-joint account original-password new-password)
  (define (dispatch password m)
    (if (eq? password new-password) ((account original-password 'join) original-password m) "Incorrect password"))
  dispatch)

(define peter-acc (make-account 100 'open-sesame))
((peter-acc 'open-sesame 'withdraw) 10)

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'rosebud 'withdraw) 20)
((peter-acc 'open-sesame 'deposit) 100)
((paul-acc 'rosebud 'withdraw) 50)


((peter-acc 'rosebud 'withdraw) 30)
(paul-acc 'open-sesame 'withdraw)
