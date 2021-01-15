//
//  Shows.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import Foundation

struct Shows: Codable, Hashable {
    var originalName: String
    var backdrop_path: String
    
    enum CodingKeys:String, CodingKey {
        case originalName = "original_name"
        case backdrop_path = "backdrop_path"
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
