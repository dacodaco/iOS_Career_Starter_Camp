
import Foundation

struct JokeResponse {
    let type: String
    let value: Joke
}

struct Joke {
    let id: Int
    let joke: String
    let categories: [String]
}
