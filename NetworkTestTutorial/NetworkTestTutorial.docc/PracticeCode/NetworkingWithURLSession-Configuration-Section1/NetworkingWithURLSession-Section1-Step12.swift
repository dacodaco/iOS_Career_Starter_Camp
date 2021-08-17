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

class JokesAPIProvider {
    let session: URLSession
    
    init(session: URLSession){
        self.session = session
    }
    
    func fetchRandomJoke() {
        let request = URLRequest(url: JokesAPI.url)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("에러입니다.")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("잘못된 response가 전달되었습니다.")
                return
            }
            
            if let data = data,
               let jokeResponse = try? JSONDecoder().decode(JokeResponse.self, from: data) {
                print("서버로부터 받은 정보를 디코딩까지 완료했습니다.")
                return
            }
            
            print("디코딩이 불가능하거나, 데이터가 nil입니다.")
        }

        task.resume()
    }
}
