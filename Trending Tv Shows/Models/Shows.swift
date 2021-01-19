//
//  Shows.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import Foundation

struct Shows: Codable, Hashable {
  
    let overview:String
   let vote_count: String
   let name: String
   let backdrop_path: String
   let vote_average :String
   let first_air_date :String

    
    enum CodingKeys:String, CodingKey {
        case overview = "overview"
        case vote_count = "vote_count"
        case name = "name"
        case backdrop_path = "backdrop_path"
        case vote_average = "vote_average"
        case first_air_date = "first_air_date"

    }
}


struct ApiResponse:Codable, Hashable {
    let page:Int
    let shows:[Shows]
    
    enum CodingKeys:String, CodingKey {
        case page = "page"
        case shows = "results"
    }
}

