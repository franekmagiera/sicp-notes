#lang sicp
(define (make-account balance init-password)
  (define attempts-threshold 3)
  (define incorrect-attempts 0)
  (define call-the-cops "Ioioioioio\n")
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch password m)
    (if (eq? password init-password)
        (set! incorrect-attempts 0)
        (set! incorrect-attempts (inc incorrect-attempts)))
    (if (> incorrect-attempts attempts-threshold) (display call-the-cops))
    (cond ((not (eq? password init-password)) (lambda (_) "Incorrect password"))
          ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'deposit) 50)
((acc 'p4ssw0rd 'deposit) 50)
((acc 'admin 'deposit) 50)
((acc 'pswd 'deposit) 50)