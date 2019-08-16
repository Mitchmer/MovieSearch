//
//  MovieController.swift
//  MovieSearch
//
//  Created by Mitch Merrell on 8/16/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MovieController: Codable {
    
    static var shared = MovieController()
    
    static func fetchMovie(searchTerm: String, completion: @escaping ([Movie]) -> Void){
        
        let baseURL = URL(string: "https://api.themoviedb.org/3/search")
        guard let url = baseURL?.appendingPathComponent("movie") else { completion([]); return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let apiKey = "9499367d6658ca88e4c3c64e86dba2ee"
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
        let searchQueryItem = URLQueryItem(name: "query", value: searchTerm)
        let queryItems = [apiKeyQueryItem, searchQueryItem]
        urlComponents?.queryItems = queryItems
        
        guard let finalURL = urlComponents?.url else { completion([]); return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                completion([])
                print(error); return
            }
            
            guard let data = data else { completion([]); return }
            
            do {
                let decoder = JSONDecoder()
                let topLevelMovieObject = try decoder.decode(TopLevelMovieObject.self, from: data)
                var decodedMovies = [Movie]()
                
                for movieObject in topLevelMovieObject.results {
                    let newMovie = Movie(jsonObject: movieObject)
                    decodedMovies.append(newMovie)
                }
                completion(decodedMovies)
                
            } catch {
                print(error)
                print(error.localizedDescription)
                completion([])
                return
            }
        }.resume()
    }
    
    static func fetchImage(for movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        if let unwrappedURL = movie.imageURL {
            guard let url = baseURL?.appendingPathComponent(unwrappedURL) else { completion(nil); return }
            print(url)
            
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                    return
                }
                
                guard let data = data else { completion(nil); return }
                
                let image = UIImage(data: data)
                
                completion(image)
            }.resume()
        }

        
    }
    
}
