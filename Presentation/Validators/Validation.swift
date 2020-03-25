import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}
