import Foundation

func fetchRandomJoke(completion: @escaping (Result<JokeResponse, APIError>) -> Void) {
    let request = URLRequest(url: JokesAPI.url)
    
    let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(.serverError))
            return
        }
        
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
                  completion(.failure(.responseError))
            return
        }
        
        if let data = data,
           let jokeResponse = try? JSONDecoder().decode(JokeResponse.self, from: data) {
            completion(.success(jokeResponse))
            return
        }
        
        completion(.failure(.dataError))
    }

    task.resume()
}
