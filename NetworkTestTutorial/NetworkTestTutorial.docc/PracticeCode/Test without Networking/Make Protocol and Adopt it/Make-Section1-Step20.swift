import XCTest
@testable import Practice

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
        let expectation = XCTestExpectation(description: "waitForNetworking")
        var valueCheck: JokeResponse?
        let session = URLSession.shared
        let jokesAPIProvider = JokesAPIProvider(session: session)

        jokesAPIProvider.fetchRandomJoke { result in
            switch result {
            case .failure:
                XCTFail()
                return
            case .success(let data):
                valueCheck = data
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(valueCheck?.type, "success")
    }
    
    func test_URLSession_without_Network_when_Success() {
        let expectation = XCTestExpectation(description: "waitForNetworking")
        var valueCheck: JokeResponse?
        let session = MockURLSession()
        let jokesAPIProvider = JokesAPIProvider(session: session)

        jokesAPIProvider.fetchRandomJoke { result in
            switch result {
            case .failure:
                XCTFail()
                return
            case .success(let data):
                valueCheck = data
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(valueCheck?.type, "success")
    }
    
    func test_URLSession_without_Network_when_Failure() {
        let expectation = XCTestExpectation(description: "waitForNetworking")
        var valueCheck: JokeResponse?
        let session = MockURLSession()
        let jokesAPIProvider = JokesAPIProvider(session: session)

        jokesAPIProvider.fetchRandomJoke { result in
            switch result {
            case .failure:
                XCTFail()
                return
            case .success(let data):
                valueCheck = data
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(valueCheck?.type, "success")
    }
}
