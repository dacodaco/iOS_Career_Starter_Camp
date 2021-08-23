import XCTest
@testable import YourProject

class PracticeTests: XCTestCase {
    func test_is_ModelType_can_decode_JSONData() {
        let jokesAPI = JokesAPI()
        let data = jokesAPI.sampleData
        let decoder = JSONDecoder()
        
        guard let parsedData = try? decoder.decode(JokeResponse.self, from: data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(parsedData.type, "success")
    }
    
    func test_URLSession_with_Network() {
        let session = URLSession.shared
        let jokesAPIProvider = JokesAPIProvider(session: session)

        jokesAPIProvider.fetchRandomJoke { result in
            switch result {
            case .failure:
                XCTFail()
                return
            case .success(let data):
                XCTAssertEqual(data.type, "success")
            }
        }
    }
}
