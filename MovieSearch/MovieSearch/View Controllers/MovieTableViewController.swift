//
//  MovieTableViewController.swift
//  MovieSearch
//
//  Created by Mitch Merrell on 8/16/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        let movie = movies[indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        
        MovieController.fetchMovie(searchTerm: searchTerm) { (movies) in
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}


