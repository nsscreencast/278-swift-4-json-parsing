import Foundation

enum BeerStyle : String, Codable {
    case ipa
    case lager
    case kolsch
}

struct Brewery : Codable {
    let name: String
}

struct Beer : Codable {
    let name: String
    let abv: Float
    let brewery: Brewery
    let style: BeerStyle
    let createdAt: Date
    
    enum CodingKeys : String, CodingKey {
        case name
        case abv
        case brewery
        case style
        case createdAt = "created_at"
    }
}

let beer = Beer(name: "Lawnmower", abv: 4.9,
                brewery: Brewery(name: "Saint Arnold"),
                style: .kolsch,
                createdAt: Date())

let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
encoder.outputFormatting = .prettyPrinted
let data = try! encoder.encode(beer)

let json = String(data: data, encoding: .utf8)!
print(json)

let inputJSON = """
                {
                  "name" : "Lawnmower",
                  "abv" : 4.9,
                  "brewery" : { "name" : "Saint Arnold" },
                  "style": "kolsch",
                  "created_at": "2018-06-20T17:57:16Z"
                }
                """
let inputData = inputJSON.data(using: .utf8)!

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let beer2 = try! decoder.decode(Beer.self, from: inputData)

dump(beer2)
