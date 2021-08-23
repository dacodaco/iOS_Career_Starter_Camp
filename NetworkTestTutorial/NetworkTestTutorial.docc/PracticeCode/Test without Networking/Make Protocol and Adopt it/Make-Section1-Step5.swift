import Foundation
@testable import Practice

class MockURLSessionDataTask: URLSessionDataTask {
    
}

class MockURLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        <#code#>
    }
}
