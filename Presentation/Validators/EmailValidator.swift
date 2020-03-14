import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}
