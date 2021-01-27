#lang racket

; bst (binary search tree) is represented like list '(value, leftSubtree, rightSubTree)

; return value of bst tree
(define (bstGetVal tree)
  (if (null? tree)
      null
      [car tree]))

; return left subtree
(define (bstGetLeft tree)
  (if (null? tree)
      null
      [cadr tree]))

; return right subtree
(define (bstGetRight tree)
  (if (null? tree)
      null
      [caddr tree]))

; create bst from value, left subtree, right subtree
(define (bstCreate value leftSubTree rightSubTree)
  (list value leftSubTree rightSubTree))

; insert value into tree
(define (bstInsert value tree)
  (cond
    [(null? tree)                    (bstCreate value null null)] ; create new tree
    [(equal? (bstGetVal tree) value) tree]
    [(< value (bstGetVal tree))      (bstCreate (bstGetVal tree)
                                                (bstInsert value (bstGetLeft tree))
                                                (bstGetRight tree))]
    [#t                              (bstCreate (bstGetVal tree)
                                                (bstGetLeft tree)
                                                (bstInsert value (bstGetRight tree)))]))

; return true if tree contains value, otherwise return false
(define (bstFind value tree)
  (cond
    [(null? tree)                    #f]
    [(equal? (bstGetVal tree) value) #t]
    [(< value (bstGetVal tree))      (bstFind value (bstGetLeft tree))]
    [#t                              (bstFind value (bstGetRight tree))]))

; return list of values, which you get from in-order (left value right) traversal of tree
(define (bstInOrder tree)
  (if (null? tree)
      null
      (appendList (bstInOrder (bstGetLeft tree))
                  (cons (bstGetVal tree) (bstInOrder (bstGetRight tree))))))

; append list1 behind list2
(define (appendList lst1 lst2)
  (if (null? lst1)
      lst2
      (cons [car lst1] (appendList [cdr lst1] lst2))))

; return height of tree
(define (bstHeight tree)
  (cond
    [(null? tree)
      0] ; empty tree
    [(and (null? (bstGetLeft tree)) (null? (bstGetRight tree)))
      1] ; leave
    [#t (let ([leftHeight (bstHeight (bstGetLeft tree))]
              [rightHeight (bstHeight (bstGetRight tree))])
          (if (<= leftHeight rightHeight) ; max height of subtrees + 1 because of value
              (+ 1 rightHeight)
              (+ 1 leftHeight)))]))

; return max value of bst
(define (bstMax tree)
  (cond
    [(null? tree) null]
    [(null? (bstGetRight tree)) (bstGetVal tree)]
    [#t                   (bstMax (bstGetRight tree))]))
                 
; return min value of bst
(define (bstMin tree)
  (cond
    [(null? tree) null]
    [(null? (bstGetLeft tree)) (bstGetVal tree)]
    [#t                   (bstMin (bstGetLeft tree))]))

; create bst from list
(define (bstFromList lst)
  (foldr (lambda (acc n) (bstInsert n acc)) lst null))

; accumulate
(define (foldr foo lst init)
  (if (null? lst)
      init
      (foo (foldr foo [cdr lst] init) [car lst])))

; sort list makes bst from it and make in order traversal
(define (treeSort lst)
  (bstInOrder (bstFromList lst)))


















       