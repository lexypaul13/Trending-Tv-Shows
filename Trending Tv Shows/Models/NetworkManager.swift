//
//  NetworkManager.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/7/21.
//

import UIKit

class NetworkManger {
    
     static let shared = NetworkManger()
     let baseURL = "https://api.themoviedb.org/3/trending/tv/week?api_key=352b794e6bc3be2fe8b0b6b3d7221ac1"
     let cache   = NSCache<NSString, UIImage>()

    private init (){}

    
    func getShows(page: Int, completed:@escaping(Result<[Shows],ErroMessage>)->Void){
        
        let endpoint = baseURL + "&language=en-US&page=\(page)"
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
                let apiResponse = try decoder.decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(apiResponse.shows))
                }
                
                
            } catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {  //downloads image
        let cacheKey = NSString(string: urlString) //creates cacheKey to store in image variable
        
        if let image = cache.object(forKey: cacheKey) {  //check if image is there
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
    
}


