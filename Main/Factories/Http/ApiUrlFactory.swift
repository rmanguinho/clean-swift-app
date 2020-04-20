import Foundation

func makeApiUrl(path: String) -> URL {
    return URL(string: "\(Environment.variable(.apiBaseUrl))/\(path)")!
}
