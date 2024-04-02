//
//  File.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import UIKit

public struct MovieDetailsBuilder {
    
    private init() { }
    
    public static func build(
        movieAdapter: MovieAdapter
    ) -> UIViewController {
        let view = MovieDetailsViewController.init(
            nibName: MovieDetailsViewController.Identifier,
            bundle: Bundle.module
        )
        view.movieAdapter = movieAdapter
        return view
    }
}
