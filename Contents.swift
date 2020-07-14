// ini untuk header

import UIKit

let request = URLRequest(url: URL(string: "https://api.rawg.io/api/games")!)

let task = URLSession.shared.dataTask(with: request) {data, response, error in
    guard let response = response as? HTTPURLResponse else {return}
    
    if let data = data {
        if response.statusCode == 200 {
            decodeJSON(data: data)
        } else {
            print("Error : \(data), Http status : \(response.statusCode)")
        }
    }
}

task.resume()

struct Games: Codable{
    
    let games: [Game]
    
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
        
    }
}

struct Game: Codable{
    let name: String
    let tanggalRilis: String
    let rating : Double
    let ratingTop: Int
    let gambar: URL
    let reviewsTextCount: Int
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case tanggalRilis = "released"
        case rating = "rating"
        case ratingTop = "rating_top"
        case gambar = "background_image"
        case reviewsTextCount = "reviews_text_count"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
      
        name =  try container.decode(String.self, forKey: .name)
        tanggalRilis = try container.decode(String.self, forKey: .tanggalRilis)
        rating = try container.decode(Double.self, forKey: .rating)
        ratingTop = try container.decode(Int.self, forKey: .ratingTop)
        gambar = try container.decode(URL.self, forKey: .gambar)
        reviewsTextCount = try container.decode(Int.self, forKey: .reviewsTextCount)
                
    }
}

private func decodeJSON(data: Data) {
    let decoder = JSONDecoder()
    
    
    let games = try! decoder.decode(Games.self, from: data)
    
    games.games.forEach { game in
        print("Judul : ", game.name)
        print("Tanggal Rilis : ", game.tanggalRilis)
        print("Rating : ", game.rating)
        print("Peringkat : ", game.ratingTop)
        print("Gambar : ", game.gambar)
        print("Reviews Text Count : ", game.reviewsTextCount)
       
        print("\n")
    }
}
    

// ini percobaan kedua
