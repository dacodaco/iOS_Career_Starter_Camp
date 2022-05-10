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
