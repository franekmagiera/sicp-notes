# Applicative order vs normal order
Applicative order - evaluate the arguments and then apply.
```
(square (+ 5 1)) -> (square 6) -> (* 6 6) -> 36
```

Normal order - fully expand and then reduce.
```
(square (+ 5 1)) -> (* (+ 5 1) (+ 5 1)) -> (* 6 6) -> 36
```

Lisp uses applicative order evaluation.
This is why `if` and `cond` have to be special forms (see Exercise 1.6.).

# Conditional expressions
```
(cond (<p1> <e1>)
      (<p2> <e2>))

(cond (<p1> <e1>)
      (else <e2>))

(if <predicate> <consequent> <alternative>)
```

In an if expression, the consequent and alternative must be single expressions.

# Recursion and iteration
Recursive process is characterized by a chain of deferred operations. Carrying out this process requires the interpreter to keep track of the operations to be performed later on.
Recursive process grows and then shrinks.

Iterative process does not grow and shrink. Iterative process can be characterized by a fixed number of state variables and a fixed rule describing how the state variables should be updated as the process moves from state to state. Iterative process can be executed using constant space.

Recursive procedure definition refers to itself. A recursive procedure does not have to describe a recursive process - it can describe an iterative process.

Most implementations of common languages are designed in such a way that the interpretation of any recursive procedure consumes an amount of memory that grows with the number of procedure calls, even when the process described is iterative! Therefore, in those languages (e.g. C) iterative processes can only be described using loops.

Tail-recursive property holds when iterative process described by recursive procedure is executed in constant space. With tail-recursive implementation, iteration can be expressed using ordinary procedure call mechanism.

## Exercise 1. 11.
```
A function f if defined by the rule that f(n) = n if n < 3 and f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.
```

Writing a procedure that computes f by means of a recursive process is quite natural:
```
(define (frec n)
      (if (< n 3)
            n 
            (+
                  (frec (- n 1))
                  (* 2 (frec (- n 2)))
                  (* 3 (frec (- n 3)))
            )
      )
)
```

What is the intuiton behind computing f by means of an iterative process? So, to compute f(n), we need f(n-1), f(n-2) and f(n-3). Looking the other way around, if we have f(n-1), f(n-2) and f(n-3) we can compute f(n). Then, we can compute f(n+1) because we have f(n), f(n-1) and f(n-2) and we no longer need f(n-3). So, we need 3 state variables and a rule to update them. Let's start by what we know and assign:
```
a <- f(2) = 2
b <- f(1) = 1
c <- f(0) = 0
```

Next, we can update them according to the intuiton above:
```
a <- a + 2b + 3c = f(2) + 2f(1) + 3f(0) = f(3)
b <- a = f(2)
c <- b = f(1)
```

Continuing this procedure, we can see that after n steps c = f(n). This is kind of like memoization/dynamic programming, as we only keep the values that we know we will need. Translating to Scheme:
```
(define (fiter-helper a b c count)
      (if (= count 0)
            c
            (fiter-helper (+ a (* 2 b) (* 3 c)) a b (- count 1))
      )
)

(define (fiter n)
      (fiter-helper 2 1 0 n)
)
```

## Exercise 1. 16.
```
Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses logarithmic number of steps.
```
Using the observation that 
```
b^n = b^(n/2)^2 = b^2^(n/2)
```
and suggestion to use an additional state variable a so that ab^n is constant:
```
(define (fast-expt-inner b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-inner (* b b) (/ n 2) a))
          (else (fast-expt-inner b (- n 1) (* a b)))
    )
)

(define (fast-expt-iter b n) (fast-expt-inner b n 1))
```
It is a nice suggestion to define an invariant quality that remains unchanged from state to state - it is a powerful way to think about the design of iterative algorithms.
