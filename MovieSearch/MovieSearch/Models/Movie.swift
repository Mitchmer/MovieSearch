//
//  Movie.swift
//  MovieSearch
//
//  Created by Mitch Merrell on 8/16/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation


struct Movie: Codable {

    let title: String
    let rating: Double
    let description: String
    let imageURL: String?
    
    init(jsonObject: MovieObject){
        self.title = jsonObject.title
        self.rating = jsonObject.rating
        self.description = jsonObject.description
        self.imageURL = jsonObject.imageURL
    }
}
