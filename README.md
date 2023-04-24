# Functional programming in Racket

## Description

This repository includes programs created for the Programming Paradigms course at the [Faculty of Information Technology, Czech Technical University](https://fit.cvut.cz/cs). The programs are written in Racket, a general-purpose programming language that supports multiple paradigms and is based on the Scheme dialect of Lisp.

## 🤓 Functional Programming

Functional programming is a programming paradigm that treats computation as the evaluation of mathematical functions and avoids changing state or mutable data. It emphasizes the use of pure functions, higher-order functions, and recursion, leading to code that's easier to reason about, test, and debug.

Key concepts of functional programming:

* **Pure functions:** Functions that always produce the same output for the same input and have no side effects.
* **Immutability:** Data is not changed once it's created, leading to fewer bugs and easier-to-understand code.
* **Higher-order functions:** Functions that take other functions as arguments or return them as results.
* **Recursion:** Solving problems by breaking them down into smaller, self-similar problems, often replacing loops with function calls.
* **Referential transparency:** An expression can be replaced with its value without changing the behavior of the program.

Functional programming languages include Haskell, Lisp, Racket, Scala, and Erlang, but many mainstream languages like JavaScript, Python, and Ruby also support functional programming concepts.

## 🗃️ Content
The repository includes the following files:
- **macros_in_racket** - a course project that contains useful macros in Racket (let, cond, foreach, assert). More information can be found in the [readme](/macros_in_racket/README.md).
- **accumulate.rkt** - this file uses fold left and fold right functions for list accumulation. It also contains other list operations such as zip, map, and filter.
- **binarySearchTrees.rkt** - this file contains a binary search tree structure and its operations (insert, find, create from list, max, min, sort, height).
- **isPrime.rkt** - this file contains a function that determines whether a number is prime or not.
- **lists.rkt** - this file contains functions that involve lists (length, min, max, prepend, append, get $n$-th element, delete first, insert between, flatten, rotate, ...).
- **matrix.rkt** - this file contains matrix operations.

## 👨‍🎓 Takeaways

Throughout this course, I gained knowledge about programming paradigms beyond the imperative approach, including logical and functional. It came to my attention that certain tasks can be accomplished more efficiently with alternative methods. Additionally, I enhanced my understanding of recursion and acquired knowledge of recursive algorithms like merge sort and operations involving binary trees.
