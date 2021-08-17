import Foundation

struct JokesAPI {
    static var url = URL(string: "https://api.icndb.com/jokes/random")!
    var sampleData: Data {
        Data(
            """
            {
                "type": "success",
                    "value": {
                    "id": 459,
                    "joke": "Chuck Norris can solve the Towers of Hanoi in one move.",
                    "categories": []
                }
            }
            """.utf8
        )
    }
}

enum APIError: Error {
    case unknownError
}

class JokesAPIProvider {
    let session: URLSessionProtocol
    init(session: URLSessionProtocol){
        self.session = session
    }
    
    func fetchRandomJoke(completion: @escaping(Result<Joke, APIError>) -> Void) {
        let request = URLRequest(url: JokesAPI.url)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(.unknownError))
                return
            }
            
            if let data = data,
               let jokeResponse = try? JSONDecoder().decode(JokeReponse.self, from: data) {
                completion(.success(jokeResponse.value))
                return
            }
            
            completion(.failure(.unknownError))
        }
        task.resume()
    }
}
