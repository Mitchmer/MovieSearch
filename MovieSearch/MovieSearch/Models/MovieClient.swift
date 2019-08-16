//
//  MovieClient.swift
//  MovieSearch
//
//  Created by Mitch Merrell on 8/16/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation

struct TopLevelMovieObject: Codable {
    let results: [MovieObject]
}

struct MovieObject: Codable {
    let title: String
    let rating: Double
    let description: String
    let imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case rating = "vote_average"
        case description = "overview"
        case imageURL = "poster_path"
    }
}
