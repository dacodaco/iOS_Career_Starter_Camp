
import Foundation

let jokesAPIProvider = JokesAPIProvider(session: URLSession.shared)
jokesAPIProvider.fetchRandomJoke { result in
    switch result {
    case .failure: print("엄마나!! 실패했자나")
    case .success(let joke):
        print("서버에서 받아온 조크입니다.")
        print(joke.joke)
    }
}

sleep(3)
