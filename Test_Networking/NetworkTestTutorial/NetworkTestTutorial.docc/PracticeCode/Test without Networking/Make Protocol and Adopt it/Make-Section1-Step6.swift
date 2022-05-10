import Foundation
@testable import Practice

class MockURLSessionDataTask: URLSessionDataTask {
    
}

class MockURLSession: URLSessionProtocol {
    var mockURLSessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return mockURLSessionDataTask
    }
}
