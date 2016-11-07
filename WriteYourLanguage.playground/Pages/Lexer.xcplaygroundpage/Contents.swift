//: [Previous](@previous)
/*:
 
 # Lexer
 
 *"In computer science, lexical analysis is the process of converting a sequence of characters into a sequence of tokens (strings with an identified "meaning"). A program that performs lexical analysis may be called a lexer, tokenizer,[1] or scanner (though "scanner" is also used to refer to the first stage of a lexer). Such a lexer is generally combined with a parser, which together analyze the syntax of programming languages..."* *-Wikipedia*
 

 ## Example:
 ![Alt text](lexer.png)
 
 Because `Mu` is so small--only one character operator and numbers--you can simply iterate over the input and check each one character at the time.
 
*/

enum Token {
    case parensOpen
    case op(String)
    case number(Int)
    case parensClose
}

struct Lexer {
    
    static func tokenize(_ input: String) -> [Token] {
        return input.characters.flatMap {
            switch $0 {
                case "(": return Token.parensOpen
                case ")": return Token.parensClose
                case "s": return Token.op($0.description)
            default:
                if "0"..."9" ~= $0 {
                    return Token.number(Int($0.description)!)
                }
            }
            
            return nil
        }
    }
}

let input = "(s (s 4 5) 4)"
let tokens = Lexer.tokenize(input)

//: [Next](@next)
