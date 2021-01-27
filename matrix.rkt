#lang racket

; matrix m1
(define m1
  '([1 2 3]
    [4 5 6]
    [7 8 9]))

; matrix m2
(define m2
  '([1  2  3 ]
    [4  5  6 ]
    [7  8  9 ]
    [10 11 12]))

; matrix m3
(define m3
  '([1  0  0]
    [0  1  0]
    [0  0  1]))

; matrix m4
(define m4
  '([1  2  3  4 ]
    [5  6  7  8 ]
    [9  10 11 12]
    [13 14 15 16]))

; matrix m5
(define m5
  '([1]
    [2]
    [3]
    [4]))

; return length of list
(define (length list)
  (if (null? list)
      0
      (+ 1 (length [cdr list]))))

; return dimension of matrix -> '(roxs cols)
(define (matDim matrix)
  (cons (length matrix) (cons (length [car matrix]) null)))

; return nth row of matrix (indexed from 0)
(define (matNthRow matrix n)
  (if (null? matrix)
      null
      (if (= 0 n)
          [car matrix]
          (matNthRow [cdr matrix] (- n 1)))))

; return nth element of list (indexed from 0)
(define (nthElement list n)
  (if (null? list)
      null
      (if (= 0 n)
          [car list]
          (nthElement [cdr list] (- n 1)))))

; append element to list
(define (append list element)
  (if (null? list)
      (cons element null)
      (cons [car list] (append [cdr list] element))))

; return nth column of matrix (indexed from 0)
(define (matNthCol matrix n)
  (map (lambda (row) (nthElement row n)) matrix))

; return value matrix[i, j] (ith row and jth col), indexed from 0)
(define (matGetFromPos matrix i j)
  (if (null? matrix)
      null
      (nthElement (matNthRow matrix i) j)))

; add two matrixex, matrixes hat to be same dimensions
(define (matAdd matrix1 matrix2)
  (matAddAux matrix1 matrix2 null))

; auxiliary function
(define (matAddAux matrix1 matrix2 accumulator)
  (map (lambda (row1 row2) (map (lambda (e1 e2) (+ e1 e2)) row1 row2)) matrix1 matrix2))

; add elements on same positions, lists has to be same length
(define (addLists list1 list2)
  (map (lambda (e1 e2) (+ e1 e2)) list1 list2))

; return diagonale of matrix like list
(define (matDiag matrix)
  (matDiagAux matrix 0 null))

;auxiliary function, n represent which element shoud be added to accumulator
(define (matDiagAux matrix n accumulator)
  (if (null? matrix)
      accumulator
      (let ([element (nthElement [car matrix] n)])
        (if (null? element)
            accumulator
            (matDiagAux [cdr matrix] (+ n 1) (append accumulator element))))))

; add to all element of matrix scalar x
(define (matSumScalar matrix x)
  (map (lambda (row) (map (lambda (element) (+ element x)) row)) matrix))

; add x to all elements from list
(define (addX list x)
  (map (lambda (e) (+ e x)) list))

; delete last element of list
(define (deleteLast list)
  (deleteLastAux list null))

; auxiliary function
(define (deleteLastAux list accumulator)
  (cond
    [(null? list)       accumulator]
    [(null? [cdr list]) accumulator]
    [#t                   (deleteLastAux [cdr list] (append accumulator [car list]))]))

; crom matrix = delete first and last row and first and last column
(define (matCrop matrix)
  (if (null? matrix)
      null
      (map (lambda (row) (deleteLast [cdr row])) (deleteLast [cdr matrix]))))

















