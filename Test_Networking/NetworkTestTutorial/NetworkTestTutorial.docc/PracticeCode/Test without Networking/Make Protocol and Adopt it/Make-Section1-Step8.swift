import Foundation
@testable import Practice

class MockURLSessionDataTask: URLSessionDataTask {
    var runWhenResumeDidCall: (() -> Void)!
    
    override func resume() {
        runWhenResumeDidCall()
    }
}

class MockURLSession: URLSessionProtocol {
    var mockURLSessionDataTask = MockURLSessionDataTask()
    
    let successResponse = HTTPURLResponse(url: JokesAPI.url,
                                          statusCode: 200,
                                          httpVersion: "2",
                                          headerFields: nil)
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return mockURLSessionDataTask
    }
}
