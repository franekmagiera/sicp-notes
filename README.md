# SICP notes
These are my notes for the [Structure and Implementation of Computer Programs](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html) text book.

## Applicative order vs normal order
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

## Conditional expressions
```
(cond (<p1> <e1>)
      (<p2> <e2>))

(cond (<p1> <e1>)
      (else <e2>))

(if <predicate> <consequent> <alternative>)
```

In an if expression, the consequent and alternative must be single expressions.

## Recursion and iteration
Recursive process is characterized by a chain of deferred operations. Carrying out this process requires the interpreter to keep track of the operations to be performed later on.
Recursive process grows and then shrinks.

Iterative process does not grow and shrink. Iterative process can be characterized by a fixed number of state variables and a fixed rule describing how the state variables should be updated as the process moves from state to state. Iterative process can be executed using constant space.

Recursive procedure definition refers to itself. A recursive procedure does not have to describe a recursive process - it can describe an iterative process.

Most implementations of common languages are designed in such a way that the interpretation of any recursive procedure consumes an amount of memory that grows with the number of procedure calls, even when the process described is iterative! Therefore, in those languages (e.g. C) iterative processes can only be described using loops.

Tail-recursive property holds when iterative process described by recursive procedure is executed in constant space. With tail-recursive implementation, iteration can be expressed using ordinary procedure call mechanism.

### Exercise 1. 11.
>A function f if defined by the rule that f(n) = n if n < 3 and f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.

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

### Exercise 1. 16.
>Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses logarithmic number of steps.

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

## Greatest common divisors (GCD)
The GCD of two integers *a* and *b* is the largest integer that divides both *a* and *b* with no remainder.

We can implement an efficient algorithm for computing *GCD(a,b)* based on the observation that, if *r* is the remainder of *a* divided by *b*, then the common divisors are exactly the same as the common divisors of *b* and *r*. Therefore, we can use the equation:
```
GCD(a, b) = GCD(b, r) ; where r := a mod b
```
Applying this reduction repeatedly will finally yield a pair where the second number is 0. The GCD of any number *a* and 0 is *a* itself.

So using the above observation we can implement the algorithm:
```
(define (gcd a b)
      (if (= b 0)
          a
          (gcd b (remainder a b))
      )
)
```
Using Lame's theorem it can be shown that the order of growth for the above algorithm is *O(log n)* where *n* is smaller of the two nubmers *a* and *b*.

So what is the intuiton for the observation that:
```
GCD(a, b) = GCD(b, r)
```
?

Hopefully, this image provides some help:
![gcd-intuition](img/gcd-intuition.jpeg)
Greatest common divisor *gcd* has to divide *b* evenly. So, we can express *b* as *gcd times x*; *gcd* also has to divide *a* evenly. We can express *a* as *gcd times x + gcd times y*; *gcd times y* is equal to *r* (*x* and *y* are arbitrary numbers). Hence, the problem comes down to finding the greatest common divisor of *b* and *r*.

It is easy to convince oneself, that repeating this procedure repeatedly can only make the *b* parameter smaller and it will eventually become 0.

### Exercise 1. 20.
>How many `remainder` operations are actually performed in the normal-order evaluation of `(gcd 206 40)`? In the applicative-order evaluation?

It is easy to go through the procedure using the applicative-order evaluation and determine that it requires just *4* `remainder` operations:
![gcd-applicative-order](img/ex-1-20-applicative.jpeg)

Using normal-order evaluation:
![gcd-normal-order](img/ex-1-20-normal.jpeg)
with every call, the second argument has to be evaluated as it is used in the `if` statement's predicate. 

*x1* requires *1* `remainder` operation.
*x2* requires *2* `remainder` operations - *1* for *x1* and *1* for itself.
*x3* requires *4* `remainder` operations - *1* for *x1*; *2* for *x2* and *1* for itself.
*x4* requires *7* `remainder` operations - *2* for *x2*; *4* for *x3* and *1* for itself.

Finally, *x4* evaluates to *0* and expression is reduced to *x3* which again requires *4* `remainder` operations. Summing all the required evaluations up we end up with *18* evaluations.

So, in this case applicative-order evaluation is much better.
