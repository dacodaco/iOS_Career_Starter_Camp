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
                    "joke": "It is a test Joke",
                    "categories": []
                }
            }
            """.utf8
        )
    }
}

class JokesAPIProvider {
    let session: URLSession
    
    init(session: URLSession){
        self.session = session
    }
    
    func fetchRandomJoke(completion: @escaping (Result<JokeResponse, Error>) -> Void) {
        let request = URLRequest(url: JokesAPI.url)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(.failure(error))
                return
            }
            
            if let data = data,
               let jokeResponse = try? JSONDecoder().decode(JokeResponse.self, from: data) {
                completion(.success(jokeResponse))
                return
            }
            
            completion(.failure(error))
        }

        task.resume()
    }
}
