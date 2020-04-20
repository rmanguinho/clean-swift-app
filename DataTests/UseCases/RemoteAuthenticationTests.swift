import XCTest
import Domain
import Data

class RemoteAuthenticationTests: XCTestCase {
    func test_auth_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authenticationModel: makeAuthenticationModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }

    func test_auth_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let authenticationModel = makeAuthenticationModel()
        sut.auth(authenticationModel: authenticationModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, authenticationModel.toData())
    }

    func test_auth_should_complete_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }

    func test_auth_should_complete_with_expired_session_error_if_client_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.expiredSession), when: {
            httpClientSpy.completeWithError(.unauthorized)
        })
    }

    func test_auth_should_complete_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completeWith: .success(account), when: {
            httpClientSpy.completeWithData(account.toData()!)
        })
    }

    func test_auth_should_complete_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithData(makeInvalidData())
        })
    }

    func test_auth_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAuthentication? = RemoteAuthentication(url: makeUrl(), httpClient: httpClientSpy)
        var result: Authentication.Result?
        sut?.auth(authenticationModel: makeAuthenticationModel()) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAuthenticationTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }

    func expect(_ sut: RemoteAuthentication, completeWith expectedResult: Authentication.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationModel: makeAuthenticationModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
