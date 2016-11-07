//: [Previous](@previous)
/*:
 # Interpreter
 
 *"In computer science, an interpreter is a computer program that directly executes, i.e. performs, instructions written in a programming or scripting language, without previously compiling them into a machine language program."* *-Wikipedia*
 
 
 ## Example:
 `Mu`'s interpreter will walk through its A.S.T and compute a value by applying an operator to the children nodes.  
 
 
 ![Alt text](simple-ast.png)
 
 */
enum InterpreterError: Error {
    case unknownOperator
}

struct Interpreter {
    static func eval(_ expression: ExpressionNode) throws -> Int {
        let firstEval = try eval(expression.first)
        let secEval = try eval(expression.second)
        
        if expression.op == "s" {
            return firstEval + secEval
        }
        
        throw InterpreterError.unknownOperator
    }    
    
    static func eval(_ prim: PrimaryExpressionNode) throws -> Int {
        switch prim {
        case .expression(let exp):
            return try eval(exp)
        case .number(let n):
            return Int(n)
        }
    }
    
}

let input = "(s (s 5 2) 4)"
let tokens = Lexer.tokenize(input)
var parser = Parser(tokens: tokens)

let ast = try! parser.parse()
try! Interpreter.eval(ast)


//: [Next](@next)
