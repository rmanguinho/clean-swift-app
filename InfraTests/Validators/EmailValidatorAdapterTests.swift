import XCTest
import Infra

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }

    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "rodrigo@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "rodrigo@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "rodrigo@hotmail.com"))
    }
}

extension EmailValidatorAdapterTests {
    func makeSut() -> EmailValidatorAdapter {
        return EmailValidatorAdapter()
    }
}
