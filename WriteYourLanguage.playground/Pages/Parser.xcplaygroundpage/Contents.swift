//: [Previous](@previous)
/*:
 # Parser
 
 *Parsing or syntactic analysis is the process of analysing a string of symbols, either in natural language or in computer languages, conforming to the rules of a formal grammar...* *-Wikipedia*
 
 ## Grammar:
 
 `expression: parensOpen operator primaryExpression primaryExpression parensClose`
 
 `primaryExpression: expression | number`
 
 `parensOpen: "("`
 
 `parensClose: ")"`
 
 `operator: "s"`
    
 `number: [0-9]`
 
 `Mu`'s grammar is a context-free grammar, that means it describes all possible strings in the language. 
 The parser will start from the top (root of the generated tree) and it will go until the lowest node. 
 
 **Tip: the code should be a direct representation of the grammar**
 ~~~
 func parseExpression() -> ExpressionNode {
     ...
     firstPrimaryExpression = parsePrimaryExpression()
     secondPrimaryExpression = parsePrimaryExpression()
     ...
 }
 
 func parseExpression() -> PrimaryExpressionNode {
     return parseExpression() || parseNumber()
 }
 ~~~
 
 ![Alt text](parser.png)
 
 */

indirect enum PrimaryExpressionNode {
    case number(Int)
    case expression(ExpressionNode)
}

struct ExpressionNode {
    var op: String
    var firstExpression: PrimaryExpressionNode
    var secondExpression: PrimaryExpressionNode
}

struct Parser {
    
    var index = 0
    let tokens: [Token]
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    mutating func popToken() -> Token {
        let token = tokens[index]
        index += 1
        
        return token
    }
    
    mutating func peekToken() -> Token {
        return tokens[index]
    }
    
    mutating func parse() throws -> ExpressionNode {
        return try parseExpression()
    }
    
    mutating func parseExpression() throws -> ExpressionNode {
        guard case .parensOpen = popToken() else {
            throw ParsingError.unexpectedToken
        }
        guard case let Token.op(_operator) = popToken() else {
            throw ParsingError.unexpectedToken
        }
        
        let firstExpression = try parsePrimaryExpression()
        let secondExpression = try parsePrimaryExpression()
        
        guard case .parensClose = popToken() else {
            throw ParsingError.unexpectedToken
        }
        
        return ExpressionNode(op: _operator, firstExpression: firstExpression, secondExpression: secondExpression)
    }
    
    mutating func parsePrimaryExpression() throws -> PrimaryExpressionNode {
        switch peekToken() {
        case .number:
            return try parseNumber()
        case .parensOpen:
            let expressionNode = try parseExpression()
            
            return PrimaryExpressionNode.expression(expressionNode)
        default:
            throw ParsingError.unexpectedToken
        }
    }
    
    mutating func parseNumber() throws -> PrimaryExpressionNode {
        guard case let Token.number(n) = popToken() else { throw ParsingError.unexpectedToken }
        
        return PrimaryExpressionNode.number(n)
    }
    
}

//MARK: Utils

extension ExpressionNode: CustomStringConvertible {
    public var description: String {
        return "\(op) -> [\(firstExpression), \(secondExpression)]"
    }
}
extension PrimaryExpressionNode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .number(let n): return n.description
        case .expression(let exp): return exp.description
        }
    }
}


let input = "(s 2 (s 3 5))"
let tokens = Lexer.tokenize(input)
var parser = Parser(tokens: tokens)
var ast = try! parser.parse()
//: [Next](@next)
