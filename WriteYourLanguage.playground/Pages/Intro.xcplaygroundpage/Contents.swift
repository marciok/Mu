/*:
 # Writing Your Own Programming Language
 
 You don't need a CS degree to write a programing language, you just need to understand 3 basic steps.
 
 ## The Language: **Mu(μ)**
 Mu is a minimal language, that is consisted by a postfix operator, a binary operation and one digit numbers.
 
 ### Examples:
 `(s 2 4)` or `(s (s 4 5) 4)` or `(s (s 4 5) (s 3 2))`...
 
 ## The Steps:
 * Lexer
 * Parser
 * Interpreter
 
 ![Alt text](flow.png)
*/

let input = "(s (s 6 6) 6)" // Should return 18

//: [Lexer ->](@next)
