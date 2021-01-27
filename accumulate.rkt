#lang racket

; foo is binary function which is called on init value and first element of the list,
; result is used in foo and second element of the list and so on
; (foldl foo 0 '(1 2 3)) -> (foo (foo (foo 0 1) 2) 3)
(define (foldl foo init list)
  (if (null? list)
      init
      (foldl foo (foo init [car list]) [cdr list])))

; foo is binary function which is called on init value and last element of the list,
; result is used in foo and second last element of the list and so on
; (foldl foo 0 '(1 2 3)) -> (foo (foo (foo 0 3) 2) 1)
(define (foldr foo init lst)
  (if (null? lst)
      init
      (foo (foldr foo init (cdr lst)) (car lst))))

; not effective version of previous function
(define (foldr0 foo init list)
  (if (null? list)
      init
      (foldl foo (foo init (getLast list)) (popBack list))))

; pop last element (popBack '(1 2 3)) -> '(1 2)
(define (popBack list)
  (cond
    [(null? list)       null]            
    [(null? [cdr list]) null]                
    [#t                 (cons [car list] (popBack [cdr list]))]))

; return last element from list
(define (getLast list)
  (cond
    [(null? list)       null]
    [(null? [cdr list]) [car list]]
    [#t                 (getLast [cdr list])]))

; supports only one list, apply unary function foo on each element of the list
(define (myMap foo list)
  (if (null? list)
      null
      (cons (foo [car list]) (myMap foo [cdr list]))))

; (mapZip foo '(a1 a2 a3 ... an) '(b1 b2 ... bm)) -> '((foo a1 b1) (foo a2 b2) ... (foo an bn))
(define (mapZip foo list1 list2)
  (cond
    [(and (null? list1) (null? list2)) null]
    [(null? list1)                     list2]
    [(null? list2)                     list1]
    [#t                                (cons (foo [car list1] [car list2])
                                             (mapZip foo [cdr list1] [cdr list2]))]))

; (zip '(a1 a2 a3 ... an) '(b1 b2 ... bm)) -> '((a1 b1) (a2 b2) ... (ax bx))
(define (zipNaive list1 list2)
  (cond
    [(and (null? list1) (null? list2)) null]
    [(null? list1)                     (cons (cons [car list2] null) (zipNaive null [cdr list2]))]
    [(null? list2)                     (cons (cons [car list1] null) (zipNaive null [cdr list1]))]
    [#t                                (cons (cons [car list1] (cons [car list2] null)) (zipNaive [cdr list1] [cdr list2]))]))

; better version of previous function
(define (zip list1 list2)
  (mapZip (lambda (x1 x2) (cons x1 (cons x2 null))) list1 list2))

; average of list
(define (avg lst)          
  (let ([sumAndCnt
          (foldr
           (lambda (acc e) (list (+ e [car acc]) (+ 1 [cadr acc])))
           (list 0 0) ; (first element of init value is sum and second is count of elements
           lst)
        ])
    (/ [car sumAndCnt] [cadr sumAndCnt])))

; return middle element   
(define (middleElement list)
  (cond
    [(null? list)        null]
    [(null? [cdr list])  [car list]]
    [(null? [cddr list]) [car list]]
    [#t                  (middleElement (popBack [cdr list]))]))

; return all elements from list, which are greater than n
(define (filterGreater list n)
  (foldr (lambda (acc x) (if (> x n) (cons x acc) acc)) null list))

         





    
      