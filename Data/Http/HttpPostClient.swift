import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?)
}
