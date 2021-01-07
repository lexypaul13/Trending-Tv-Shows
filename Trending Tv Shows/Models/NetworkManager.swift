//
//  NetworkManager.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/7/21.
//

import Foundation

class NetworkManger {
    static let shared = NetworkManger()
    private let baseURL = "https://api.themoviedb.org/3/trending/tv/week?api_key=352b794e6bc3be2fe8b0b6b3d7221ac1"
    
    private init (){}

    func getShows(for shows:String, page: Int, completed:@escaping(Result<[Shows],ErroMessage>)->Void){
        let endpoint = baseURL + "\(shows)/language=en-US&page=\(page)"
        guard let url = URL(string: endpoint) else{
            completed(.failure(.invalidTvName))
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode==200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let show = try decoder.decode([Shows].self, from: data)
                completed(.success(show))
            } catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
}
