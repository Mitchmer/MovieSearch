//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Mitch Merrell on 8/16/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie? {
        didSet{
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let movie = movie else {
            titleLabel.text = ""
            ratingLabel.text = ""
            descriptionLabel.text = ""
            movieImageView.image = nil
            
            return
        }
        
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: " + String(movie.rating)
        descriptionLabel.text = movie.description
        
        MovieController.fetchImage(for: movie) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }

}
