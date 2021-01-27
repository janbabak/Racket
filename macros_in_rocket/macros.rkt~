#lang racket
(require compatibility/defmacro)

; +-----------------------+
; | LET S VICE PROMENNYMI |
; +-----------------------+

; example usage:
;   (my-let
;      ([a 5]
;       [b 6]
;       [c 100])
;      (* (+ a b) c)
;   )

; principle:
;   (my-let ([a 5] [b 6]) (+ a b))  expands like:  ( (lambda(a b) (+ a b)) 5 6 )

; implementation:
(define-macro (my-let bind-pairs body)
  `((lambda ,(map (lambda (x) (car x)) bind-pairs) ,body) ,@(map (lambda (x) (car (cdr x))) bind-pairs)))


; ---------------------------------------------------------------------------------------------------------


; +--------+
; |  COND  |
; +--------+

; example usage:
;   (my-cond
;     [ (> 1 2) 1 ]
;     [ (> 1 2) 2 ]
;     [ (= 1 1) 3 ]
;   )

; principle:
;   expands first condition from the list like if statement and recursively call itself to rest of the list
;   (my-cond
;     [ (> 1 2) 1 ]
;     [ (> 1 2) 2 ]
;     [ (= 1 1) 3 ]
;   )
;   expands like:
;   (if (null? '(([(> 1 2) 1] [(> 1 2) 2] [(= 1 1) 3])))
;     (void)
;     (if (> 1 2)
;       1
;       (if (null? '((((> 1 2) 2) ((= 1 1) 3))))
;         (void)
;         (if (> 1 2)
;           2
;           (if (null? '((((= 1 1) 3))))
;             (void)
;             (if (= 1 1)
;               3
;               #<void>))))))))

; implementation
(define-macro (my-cond . conditions)
   `(if (null? '(,conditions))
        (void)
        (if ,(car (car conditions))
            ,(cadr (car conditions))
            ,(if (null? (cdr conditions))
                 (void)
                 `(my-cond ,@(cdr conditions))))))


; ---------------------------------------------------------------------------------------------------------


; my-append
; append l2 behind l1
(define (my-append l1 l2)
  (if (null? l1)
      l2
      (cons (car l1) (my-append (cdr l1) l2))))

; atom
(define (atom? x)
  (and (not (null? x)) (not (pair? x))))

; my-flatten
; from (my-flatten '(1 2 3 (9) (1 2 2) (1 2 (2 4 (9))))) make '(1 2 3 9 1 2 2 1 2 2 4 9)
(define (my-flatten lst)
  (if (null? lst)
      lst
      (if (atom? (car lst))
          (cons (car lst) (my-flatten (cdr lst)))
          (my-append (my-flatten (car lst)) (my-flatten (cdr lst))))))

; example usage:
;   (my-while2 '(1 2 3) (lambda (i) (printf "ahoj ~s\n" i)))
(define (my-while2 lst foo)
  (if (null? lst)
      (void)
      (begin
        (foo (car lst))
        (my-while2 (cdr lst) foo))))

; +--------------+
; |   FOR EACH   | ... foreach - for elemnet in list do body
; +--------------+

; example usage:
;   (my-foreach i '(1 2 3) (printf "ahoj ~s\n" (+ i i i)))
;   (my-foreach i '(1 2 3 (4) (5 6) ((7 (8)))) (printf "ahoj ~s\n" (+ i i i)))

; principle:
;   use auxiliary function my-while2, which need get lambda function

; implementation:
(define-macro (my-foreach element list body)
  `(my-while2 (my-flatten ,list) (lambda(,element) ,body)))


; ---------------------------------------------------------------------------------------------------------


; +---------------+
; |  ASSERT TRUE  | ... if assert pass do nothing, else raise exception
; +---------------+

; example usage:
;   (my-assert-true (is-in-list '(1 2 3 4) 4))

; implementation:
(define-macro (my-assert-true foo)
  `(if ,foo
       (void)
       (raise-result-error 'assert-true' "#t" #f) ))


; ---------------------------------------------------------------------------------------------------------


; +----------------+
; |  ASSERT FALSE  | ... if assert pass do nothing, else raise exception
; +----------------+

; example usage:
;   (my-assert-false (is-in-list '(1 2 3 4) 7))

(define-macro (my-assert-false foo)
  `(if ,foo
       (raise-result-error 'assert-false' "#f" #t)
       (void)))


; ---------------------------------------------------------------------------------------------------------


; +----------------+
; |  ASSERT EQUAL  | ... if assert pass do nothing, else raise exception
; +----------------+

; example usage:
;   (my-assert-equal 4 (list-length '(1 2 3 4)))

; implementation:
(define-macro (my-assert-equal expected-result foo)
  (let ([resultTMP (gensym)])
    `(let ([,resultTMP ,foo])
      (if (equal? ,expected-result ,resultTMP)
         (void)
         (raise-result-error 'assert-equal' ,(format "~a" expected-result) ,resultTMP)))))


; ---------------------------------------------------------------------------------------------------------


; +--------------------+
; |  ASSERT NOT EQUAL  | ... if assert pass do nothing, else raise exception
; +--------------------+

; usage:
;   (my-assert-not-equal 5 (list-length '(1 2 3 4)))

; implementation:
(define-macro (my-assert-not-equal expected-result foo)
  (let ([resultTMP (gensym)])
     `(let ([,resultTMP ,foo]
           [expected ,expected-result])
       (if (equal? expected ,resultTMP)
           (raise-result-error 'assert-not-equal' ,(format "not ~a" expected-result) ,resultTMP)
           (void)))))


; ---------------------------------------------------------------------------------------------------------


; while i < upperBound; i++
; usage: (my-while 1 5 (lambda () (println "ahoj")))
(define (my-while i upperBound foo)
  (if (> i upperBound)
       (void)
       (begin
         (foo i)
         (my-while (+ i 1) upperBound foo))))

; +--------------+
; | LOOP FROM TO |  ... loop from 3 to 5 includes 3 and 5
; +--------------+

; example usage:
;   (my-loop xyz 3 5 (printf "ahoj ~s\n" (* xyz xyz)))

; principle:
;   use auxiliary function my whild

; implementation
(define-macro (my-loop iterVar from to body)
     `(my-while ,from ,to (lambda(,iterVar) ,body)))


; ---------------------------------------------------------------------------------------------------------


; +---------+
; |  TESTY  |
; +---------+

; return true if element is in list, otherwise return false - funtion I want to test
(define (is-in-list list element)
  (if (null? list)
      #f
      (if (= (car list) element)
          #t
          (is-in-list (cdr list) element))))

; return lenght of list - for assert check
(define (list-length list)
  (list-length-aux list 0))
; auxiliary function for list-length
(define (list-length-aux list accumulator)
  (if (null? list)
      accumulator
      (list-length-aux (cdr list) (+ accumulator 1))))


; should pass
;(my-assert-true (is-in-list '(1 2 3 4) 4))

; shouldn't pass
;(my-assert-true (is-in-list '(1 2 3 5) 4))

; should pass
;(my-assert-false (is-in-list '(1 2 3 5) 4))

; shouldn't pass
;(my-assert-false (is-in-list '(1 2 3 4) 4))

; should pass
;(my-assert-equal 4 (list-length '(1 2 3 4)))

; shouldn't pass
;(my-assert-equal 5 (list-length '(1 2 3 4)))

; should pass
;(my-assert-not-equal 5 (list-length '(1 2 3 4)))

; shouldn't pass
;(my-assert-not-equal 4 (list-length '(1 2 3 4)))

; should pass
;(my-assert-equal 1100
; (my-let
;      ([a 5]
;       [b 6]
;       [c 100])
;      (* (+ a b) c)
;   )
;)

; should pass
;(my-assert-equal 2
; (my-cond
;     [ (> 1 2) 1 ]
;     [ (< 1 2) 2 ]
;     [ (= 1 1) 3 ]
;   )
;)

; should pass
;(my-assert-equal 3
 ;(my-cond
  ;   [ (> 1 2) 1 ]
   ;  [ (= 1 2) 2 ]
    ; [ (= 1 1) 3 ]
;   )
;)

; should print rovno
;(my-cond
;     [ (> 1 2) (println "vetsi") ]
;     [ (< 1 0) (println "mensi") ]
;     [ (= 1 1) (println "rovno") ]
;)
;(printf "\n")

; should print
; ahoj 3
; ahoj 6
; ahoj 9
;(my-foreach i '(1 2 3) (printf "ahoj ~s\n" (+ i i i)))
;(printf "\n")

; should print
; 1^2 = 1
; 2^2 = 4
; 3^2 = 9
;(my-foreach brokolice '(1 2 3) (printf "~s^2 = ~s\n" brokolice (* brokolice brokolice)))
;(printf "\n")

; should print
; 3^2 = 9
; 4^2 = 16
; 5^2 = 25
;(my-loop xyz 3 5 (printf "~s^2 = ~s\n" xyz (* xyz xyz)))

(my-loop xyz 3 5 (printf "ahoj ~s\n" (* xyz xyz)))
