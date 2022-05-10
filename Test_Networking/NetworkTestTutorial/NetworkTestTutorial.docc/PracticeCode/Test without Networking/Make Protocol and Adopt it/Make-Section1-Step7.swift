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
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return mockURLSessionDataTask
    }
}
