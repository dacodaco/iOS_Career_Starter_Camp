import XCTest
@testable import YourProject

class PracticeTests: XCTestCase {
    func test_is_ModelType_can_decode_JSONData() {
        let jokesAPI = JokesAPI()
        let data = jokesAPI.sampleData
    }
}
