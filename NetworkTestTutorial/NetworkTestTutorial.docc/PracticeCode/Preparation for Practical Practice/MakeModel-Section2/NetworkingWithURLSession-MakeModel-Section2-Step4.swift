import XCTest
class PracticeTests: XCTestCase {
    func test_is_ModelType_can_decode_JSONData() {
        let jokesAPI = JokesAPI()
        let data = jokesAPI.sampleData
        let decoder = JSONDecoder()
        
        guard let parsedData = try? decoder.decode(JokeResponse.self, from: data) else {
            XCTFail()
            return
        }
    }
}
