//: [Previous](@previous)
/*:
 # Conclusion
 
 ![Alt text](complete-flow.png)
 
 - Given an input
 */

let input = "(s (s 4 5) 4)"

/*:
  - Extract an array of tokens (Lexing);
 */

let tokens = Lexer.tokenize(input)

/*:
 - Parse the given tokens into a tree (Parsing);
 */

var parser = Parser(tokens: tokens)
let ast = try! parser.parse()

/*:
 - And walk through this tree, and compute the values contained inside a node (Interpreting);
 */
let result = try! Interpreter.eval(ast)


/*:

 ### Resources
 
 - https://ruslanspivak.com/lsbasi-part1/
 - https://www.amazon.com/Compilers-Principles-Techniques-Tools-2nd/dp/0321486811
 - http://llvm.org/docs/tutorial/
 */
