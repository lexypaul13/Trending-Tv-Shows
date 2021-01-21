//
//  Shows.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import Foundation

struct Show: Codable, Hashable {
    let id: Int?
    let overview:String?
    let voteCount: Int?
    let name: String?
    let backdropPath: String?
    let voteAverage :Double?
    let firstAirDate :String?
}


struct ApiResponse:Codable, Hashable {
    let page:Int
    let shows:[Show]
    
    enum CodingKeys:String, CodingKey {
        case page = "page"
        case shows = "results"
    }
}


extension Show{
    var voteAverageStr: String{
        "\(voteAverage ?? 0.0)"
    }
    
    var unwrappedOverview:String {
        "\(overview ?? "Unavilable")"
    }
    
    var unwrappedVoteCount:String {
        "\(voteCount ?? 0)"
    }
    
    var unwrappedName:String {
        "\(name ?? "No Name")"
    }
    
    var unwrappedfirstAirDate:String {
        "\(firstAirDate ?? "Unavailable")"
    }
    
}
