# Macros in Racket

This is semestral work from programming paradigms. I had to implement several macros, which make coding in Racket easier.

### minimal requirements:

- **let** - assigns new variables
- **cond** - like switch, translate like if-else-if-else...
- **foreach** - iterate over list
- **assert** - throw exception, when get argument, which is not evaluated as _true_, and it's derivates: **assert-equal**, **assert-not-equal**, **assert-false**
- **loop** - for loop, where is specified name of iteration variable, lower and upper bound and code to execute, which can use iteration variable

### extra points:

- **recursive foreach** - iterate over nested lists

### Usage:

##### How to run:

- download IDE for rocket called [DrRacket](https://racket-lang.org/)

##### my-let:

- (my-let (list of bind pairs) (body))
- bind-pair looks like (variable_name value)
- e.g. `(my-let ([a 5][b 6][c 100])( (+ a b) c))`

###### my-cond:

- (my-cond (list of conditions and return values))
- condition looks like ((condition) ret_value)
- e.g. `(my-cond [ (> 100 22) 1 ] [ (< 1 2) -1 ] [ (= 16 16) 0 ])`

##### my-foreach:

- (my-foreach iteration_variable_name list body)
- support iteration over nested lists
- e.g. `(my-foreach i '(1 2 3) (printf "ahoj ~s\n" (+ i i i)))`

##### my-assert-true:

- (my-assert-true function)
- raise exception if function does not return true
- e.g. `(my-assert-true (is-in-list '(1 2 3 4) 4))`

##### my-assert-false:

- (my-assert-false function)
- raise exception if function does not return false
- e.g. `(my-assert-false (is-in-list '(1 2 3 4) 4))`

##### my-assert-equal:

- (my-assert-equal expected_value function)
- raise exception if function does not return expected_value
- e.g. `(my-assert-equal 4 (list-length '(1 2 3 4)))`

##### my-assert-equal:

- (my-assert-not-equal not_expected_value function)
- raise exception if function does return not_expected_value
- e.g. `(my-assert-not-equal 4 (list-length '(1 2 3 4)))`

##### my-loop:

- (my-loop iteration_variable range_from range_to body)
- range_from and range_to are included
- e.g. `(my-loop xyz 3 5 (printf "ahoj ~s\n" (* xyz xyz)))`
