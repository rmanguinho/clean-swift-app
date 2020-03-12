import Foundation
import Data

class HttpClientSpy: HttpPostClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HttpError>) -> Void)?

    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }

    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }

    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
