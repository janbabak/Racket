#lang racket

; range n return list '(n n-1 ... 3 2)
(define (range n)
  (if (= 2 n)
      (cons 2 null)
      (cons n (range (- n 1)))))

; auxiliary function - check if number is divisible by any number from range
(define (primeAux num range)
  (if (null? range)
      #t
      (if (= 0 (modulo num [car range]))
          #f
          (primeAux num [cdr range]))))

; return true if number is prime, otherwise return false
(define (prime? num)
  (if (>= 1 num)
      #f
      (if (= 2 num)
          #t
          (primeAux num (range (- num 1))))))

;auxiliary function, get range of numbers and empty accumulator and return list of numbers from range which are prime
(define (primeListAux range acc)
  (if (null? range)
      acc
      (if (prime? [car range])
          (primeListAux [cdr range] (cons [car range] acc))
          (primeListAux [cdr range] acc))))

; generate list of prime numbers in interval <1; n>
(define (primeList n)
  (primeListAux (range n) null))