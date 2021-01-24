//
//  NetworkManager.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/7/21.
//
import UIKit

class NetworkManger {
    
    enum EndPoint {
        case showList
        case showDetail
    }
    
    static let shared = NetworkManger()
    private let baseURL : String
    let languageParam : String
    private var  apiKeyPathCompononent :String
    let cache   = NSCache<NSString, UIImage>()
    
    
    private init (){
        self.baseURL = "https://api.themoviedb.org/3/"
        self.languageParam = "&language=en-US"
        self.apiKeyPathCompononent = "?api_key=352b794e6bc3be2fe8b0b6b3d7221ac1"
    }
    
    private var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func get<T:Decodable>(_ endPoints: EndPoint, showID: Int? = nil, page: Int? = nil, urlString: String, completed:@escaping(T?)->Void){
        
        guard let url = urlBuilder(endPoint: endPoints, showID: showID, page: page) else {
            print(ErroMessage.invalidURL.rawValue)
            //            completed(.failure(.invalidURL))
            completed(nil)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                //                completed(.failure(.unableToComplete))
                print(ErroMessage.unableToComplete.rawValue)
                completed(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode==200 else {
                //                completed(.failure(.invalidResponse))
                print(ErroMessage.invalidResponse.rawValue)
                return
            }
            
            guard let data = data else{
                //                completed(.failure(.invalidData))
                print(ErroMessage.invalidData.rawValue)
                return
            }
            do{
                // let decoder = JSONDecoder()
                let apiResponse = try self.jsonDecoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    //                    completed(.success(apiResponse))
                    completed(apiResponse)
                }
                
                
            } catch{
                //                completed(.failure(.invalidData))
                print(ErroMessage.invalidData.rawValue)
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {  //downloads image
        let cacheKey = NSString(string: urlString) //creates cacheKey to store in image variable
        
        let imagesBaseURLSTring = "https://image.tmdb.org/t/p/w500"
        guard let url = URL(string: imagesBaseURLSTring)?.appendingPathComponent(urlString)else {
            completed(nil)
            return
        }
        
        if let image = cache.object(forKey: cacheKey) {  //check if image is there
            completed(image)
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
    
    
    private func urlBuilder(endPoint: EndPoint, showID: Int?, page: Int? = nil) -> URL? {
        
        switch endPoint {
        
        case .showList:
            return URL(string: baseURL + "trending/tv/week" + apiKeyPathCompononent + "&page=\(page ?? 1)" + languageParam)
            
        case .showDetail:
            guard let id = showID else { return nil }
            return URL(string: baseURL + "tv/\(id)" + apiKeyPathCompononent + languageParam)
        }
        
        
    }
    
    
}


