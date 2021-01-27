#lang racket

; return length of list not inccluding sublists
(define (length list)
  (if (null? list)
      0
      (+ 1 (length (cdr list)))))

; return true if x is an atom (x is not null and not pair, otherwise return false
(define (atom? x)
  (and (not (null? x)) (not (pair? x))))

; if x == 0 return 1 else return x
(define (plus-one-if-zero x)
    (if (= x 0)
        1
        x))

; return length of list including sublists
; e.g. (reclength '(1 2 3 (4 5))) -> 5
; e.g. (recLength '( () () () )) -> 3
(define (recLength list)
  (if (null? list)
      0
      (if (atom? (car list))
          (+ 1 (recLength (cdr list)))
          (+ (plus-one-if-zero (recLength (car list))) (recLength (cdr list))))))

; sum of list, which not include sublists
(define (sumList list)
  (if (null? list)
      0
      (+ (car list) (sumList (cdr list)))))

; return sum of list including sublists
; e.g. (reclength '(1 2 3 (4 5))) -> 15
(define (recSum list)
  (if (null? list)
      0
      (if (atom? (car list))
          (+ (car list) (recSum (cdr list)))
          (+ (recSum (car list)) (recLength (cdr list))))))

; minimum of list which not contain sublists
(define (listMin list)
  (if (null? list)
      null
      (let ([min (listMin (cdr list))])
        (if (null? min)
            (car list)
            (if (< (car list) min)
                (car list)
                min)))))

(define (listMinRec list)
  (if (null? list)
      null ; list is null -> return null
      (if (atom? (car list)) ; list is not null
          (let ([min (listMinRec (cdr list))]) ; car list is not list
            (if (null? min)
                (car list) ; list has only first element
                (if (< (car list) min) ; return min of first element of list and min of cdr list
                    (car list)
                    min)))
          (let ([min1 (listMinRec (car list))] ; first element is sublist
                [min2 (listMinRec (cdr list))]) ; get min of sublist and from rest of list an return the smaller one
            (if (null? min1)
                min2
                (if (null? min2)
                    min1
                    (if (< min1 min2)
                        min1
                        min2)))))))

; return nth element of list indexed from 0
(define (nth list n)
  (if (null? list)
      null
      (if (= 0 n)
          (car list)
          (nth (cdr list) (- n 1)))))

; return true if x is not element of list, otherwise return false
(define (notMember list x)
  (if (null? list)
      #t
      (if (= (car list) x)
          #f
          (notMember (cdr list) x)))) 

; return true if element is member of list, otherwise return false
(define (member list x)
  (if (null? list)
      #f
      (if (= (car list) x)
          #t
          (member (cdr list) x))))

; append x (push back) to list
(define (append list x)
  (if (null? list)
      (cons x null)
      (cons (car list) (append (cdr list) x))))

; prepend x (push front) to list
(define (prepend list x)
  (if (null? list)
      (cons x null)
      (cons x list)))
  

; return range '(0 2 3 ... n-1)
(define (myRange n)
  (myRangeAux (- n 1)))
(define (myRangeAux n)
  (if (= 0 n)
      '(0)
      (if (< n 0)
          null
          (append (myRangeAux (- n 1)) n))))

; append list2 behinf list1
(define (appendList list1 list2)
  (if (null? list2)
      list1
      (if (null? list1)
          list2
          (cons (car list1) (appendList (cdr list1) list2)))))
      
; insert element into list to position indexed from 0
(define (insert list element position)
  (if (null? list)
      (cons element null)
      (if (= 0 position)
          (cons element list)
          (cons (car list) (insert (cdr list) element (- position 1))))))


; make list, which contain element n times
(define (repeat element n)
  (if (= 0 n)
      null
      (if (= 1 n)
          (cons element null)
          (cons element (repeat element (- n 1))))))

; reverse list
(define (reverse list)
  (reverseAux list '()))
(define (reverseAux list accumulator)
  (if (null? list)
      accumulator
      (reverseAux (cdr list) (cons (car list) accumulator))))

; delete first occurrence of element from list
(define (deleteFirst list element)
  (if (null? list)
      '()
      (if (equal? element (car list))
          (cdr list)
          (cons (car list) (deleteFirst (cdr list) element)))))

; delete last occurrence of element from list
(define (deleteLast list element)
  (if (null? list)
      null
      (if (equal? (car list) element)
          (if (member (cdr list) element)
              (cons (car list) (deleteLast (cdr list) element))
              (cdr list))
          (cons (car list) (deleteLast (cdr list) element)))))

; delete all occurrences of element from list
(define (deleteAll list element)
  (if (null? list)
      null
      (if (equal? (car list) element)
          (deleteAll (cdr list) element)
          (cons (car list) (deleteAll (cdr list) element)))))

; delete all from list, which can contain sublists
(define (deleteAllRec list element)
  (if (null? list)
      null
      (if (atom? (car list))
          (if (equal? (car list) element)
              (deleteAllRec (cdr list) element)
              (cons (car list) (deleteAllRec (cdr list) element)))
        (cons (deleteAllRec (car list) element) (deleteAllRec (cdr list) element)))))

       
; insert element between each two elements of list
(define (insertBetweenAll list element)
  (if (null? list)
      null
      (if (not (null? (cdr list)))
          (cons (car list) (cons element (insertBetweenAll (cdr list) element)))
          (cons (car list) null))))

; duplicate all elements in list
(define (duplicate list element)
  (if (null? list)
      null
      (if (equal? (car list) element)
          (cons element (cons element (duplicate (cdr list) element)))
          (cons (car list) (duplicate (cdr list) element)))))

; flatten list which contain sublists
(define (flatten list)
  (if (null? list)
      null
      (if (atom? (car list))
          (cons (car list) (flatten (cdr list)))
          (appendList (flatten (car list)) (flatten (cdr list))))))

; second lowes number from list, which can contain sublists
(define (secondMin list)
  (listMinRec (deleteAllRec list [listMinRec list])))

; delete last element of list
(define (popBack list)
  (popBackAux list null))

; auxiliary function
(define (popBackAux list accumulator)
  (cond
    [(null? list)       accumulator]
    [(null? [cdr list]) accumulator]
    [#t                   (popBackAux [cdr list] (append accumulator [car list]))]))

; return last element from list
(define (getLast list)
  (cond
    [(null? list)       null]
    [(null? [cdr list]) [car list]]
    [#t                 (getLast [cdr list])]))

; rotate list by x postitions to right (rotateRight '(1 2 3 4 5) 2) -> '(4 5 1 2 3)
(define (rotateRight list x)
  (cond
    [(null? list) null]
    [(= 0 x)      list]
    [#t           (rotateRight (cons (getLast list) (popBack list)) (- x 1))]))

; rotate list by x postitions to left (rotateLeft '(1 2 3 4 5) 2) -> '(3 4 5 1 2)
(define (rotateLeft list x)
  (cond
    [(null? list) null]
    [(= 0 x)      list]
    [#t           (rotateLeft (append [cdr list] [car list]) (- x 1))]))

; delete first n elements from list
(define (deleteFirstN list n)
  (cond
    [(null? list) null]
    [(<= n 0)     list]
    [#t           (deleteFirstN [cdr list] (- n 1))]))

; return first n elements from list
(define (getFirstN list n)
  (getFirstNAux list n null))

; auxiliary function
(define (getFirstNAux list n accumulator)
  (cond
    [(null? list) accumulator]
    [(<= n 0)     accumulator]
    [#t           (getFirstNAux [cdr list] (- n 1) (append accumulator [car list]))])) 
                  

; return list from element of index1 to element of index2 (not included), indexing from 0
(define (slice list index1 index2)
  (getFirstN (deleteFirstN list index1) (+ 1 (- index2 index1))))




(define (jmeno a1 a2)
  (+ a1 a2))

(define (len lst)
  (if (null? lst)
      0
      (+ 1 (len [cdr lst]))))










 
                          



