//
//  MovieDetailsViewController.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import UIKit
import ImageCache

class MovieDetailsViewController: UIViewController {
    
    // MARK: Identifier
    public static let Identifier = String(describing: MovieDetailsViewController.self)
    
    // MARK: Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDetailsLabel: UILabel!
    @IBOutlet weak var imageActivityIndecator: UIActivityIndicatorView!
    
    // MARK: Data
    public var movieAdapter: MovieAdapter? = nil
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadViewData()
    }
    
    private func loadViewData() {
        guard let movieAdapter else { return }
        self.movieNameLabel.text = movieAdapter.title
        self.movieDetailsLabel.text = movieAdapter.overview
        
        guard let imageURL = NSURL(string: movieAdapter.posterOriginal) else {
            return
        }
        ImageCache.shared.load(
            url: imageURL
        ) { [weak self] url, image in
            guard let self else { return }
            imageActivityIndecator.stopAnimating()
            backgroundImageView.image = image
            movieImageView.image = image
        }
    }
}
