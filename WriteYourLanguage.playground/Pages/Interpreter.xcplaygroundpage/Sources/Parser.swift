public indirect enum PrimaryExpressionNode {
    case number(Int)
    case expression(ExpressionNode)
}

public struct ExpressionNode {
    public var op: String
    public var first: PrimaryExpressionNode
    public var second: PrimaryExpressionNode
}

public enum ParsingError: Error {
    case unexpectedToken
}
public struct Parser {
    
    var index = 0
    let tokens: [Token]
    
    public init(tokens: [Token]) {
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
    
    
    mutating func parsePrimaryExpression() throws -> PrimaryExpressionNode {
        switch peekToken() {
        case .number(let n):
            _ = popToken() // Removing number
            return PrimaryExpressionNode.number(n)
        case .parensOpen:
            let expressionNode = try parseExpression()
            
            return PrimaryExpressionNode.expression(expressionNode)
        default:
            throw ParsingError.unexpectedToken
        }
    }
    
    mutating func parseExpression() throws -> ExpressionNode {
        guard case .parensOpen = popToken() else {
            throw ParsingError.unexpectedToken
        }
        guard case let .op(_operator) = popToken() else {
            throw ParsingError.unexpectedToken
        }
        
        let firstExpression = try parsePrimaryExpression()
        let secondExpression = try parsePrimaryExpression()
        
        guard case .parensClose = popToken() else {
            throw ParsingError.unexpectedToken
        }
        
        return ExpressionNode(op: _operator, first: firstExpression, second: secondExpression)
    }
    
    public mutating func parse() throws -> ExpressionNode {
        return try parseExpression()
    }
}
