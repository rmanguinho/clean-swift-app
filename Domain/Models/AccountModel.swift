import Foundation

public struct AccountModel: Model {
    public var accessToken: String

    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
