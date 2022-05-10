import Foundation
@testable import YourProject

class MockURLSessionDataTask: URLSessionDataTask {
    var runWhenResumeDidCall: (() -> Void)!
    
    override func resume() {
        runWhenResumeDidCall()
    }
}

class MockURLSession: URLSessionProtocol {
    var mockURLSessionDataTask = MockURLSessionDataTask()
    var isRequestSuccess: Bool
    
    init(isRequestSuccess: Bool) {
        self.isRequestSuccess = isRequestSuccess
    }
    
    let successResponse = HTTPURLResponse(url: JokesAPI.url,
                                          statusCode: 200,
                                          httpVersion: "2",
                                          headerFields: nil)
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        mockURLSessionDataTask.runWhenResumeDidCall = { [self] in
            completionHandler(JokesAPI().sampleData, successResponse, nil)
        }
        
        return mockURLSessionDataTask
    }
}
