
import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    override init() {}
    var resumeDidCall: () -> Void = {}
    
    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: URLSessionProtocol {
    var isRequestSuccess: Bool
    let sessionDataTask = MockURLSessionDataTask()
    
    init(isRequestSuccess: Bool){
        self.isRequestSuccess = isRequestSuccess
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let successResponse = HTTPURLResponse(url: JokesAPI.url,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        let failureResponse = HTTPURLResponse(url: JokesAPI.url,
                                              statusCode: 402,
                                              httpVersion: "2",
                                              headerFields: nil)
        if isRequestSuccess {
            sessionDataTask.resumeDidCall = { completionHandler(JokesAPI().sampleData, successResponse, nil) }
        } else {
            sessionDataTask.resumeDidCall = { completionHandler(nil, failureResponse, nil) }
        }
        
        return sessionDataTask
    }
}
