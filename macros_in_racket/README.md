## Macros in Racket

This project was completed for the Programming Paradigms course at [Faculty of Information Technology, Czech Technical University](https://fit.cvut.cz/cs). The goal of the project was to create macros that simplify coding in Racket.

## Minimal requirements

- **let** - assigns new variables
- **cond** - like switch, translate to if-else-if-else...
- **foreach** - iterates over a list
- **assert** - throws an exception, when it's argument is not evaluated as _true_, and similar macros like: **assert-equal**, **assert-not-equal**, **assert-false**
- **loop** - used for loops where the iteration variable name, lower and upper bounds, and code to execute are specified. The iteration variable can be used in the code.

## Extra points

- **recursive foreach** - can iterates over a nested lists

## Usage

### How to run

- Download the IDE for Racket development [DrRacket](https://racket-lang.org/)

### Macros

#### my-let:

- `(my-let (list of bind pairs) (body))`
- bind-pair looks like `(variable_name value)`
- e.g. `(my-let ([a 5][b 6][c 100])( (+ a b) c))`

#### my-cond:

- `(my-cond (list of conditions and return values))`
- condition looks like `[(condition) ret_value]`
- e.g. `(my-cond [ (> 100 22) 1 ] [ (< 1 2) -1 ] [ (= 16 16) 0 ])`

#### my-foreach:

- `(my-foreach iteration_variable_name list body)`
- Allow also iterating over nested lists.
- e.g. `(my-foreach i '(1 2 3) (printf "ahoj ~s\n" (+ i i i)))`

#### my-assert-true:

- `(my-assert-true function)`
- The function will raise an exception if it does not return true.
- e.g. `(my-assert-true (is-in-list '(1 2 3 4) 4))`

#### my-assert-false:

- `(my-assert-false function)`
- The function will raise an exception if it does not return false.
- e.g. `(my-assert-false (is-in-list '(1 2 3 4) 4))`

#### my-assert-equal:

- `(my-assert-equal expected_value function)`
- The function will raise an exception if it does not return the `expected value`.
- e.g. `(my-assert-equal 4 [list-length '(1 2 3 4)])`

#### my-assert-not-equal:

- `(my-assert-not-equal not_expected_value function)`
- The function will raise an exception if it return the `expected value`.
- e.g. `(my-assert-not-equal 4 (list-length '(1 2 3 4)))`

#### my-loop:

- `(my-loop iteration_variable range_from range_to body)`
- `range_from` and `range_to` are included
- e.g. `(my-loop xyz 3 5 (printf "ahoj ~s\n" (* xyz xyz)))`

## What I Learned

Through this project, I learned about macros and their distinction from functions. I also gained knowledge on how to create and use macros. Additionally, I acquired an understanding of the functional programming paradigm, which I plan to utilize in future projects.