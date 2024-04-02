//
//  MoviesRepositoryProtocol.swift
//  
//
//  Created by Al-attar on 01/04/2024.
//

import Foundation
import Combine

public protocol MoviesRepositoryProtocol {
    
    /// Retrieves a list of movies from a remote data source.
    ///
    /// `GET discover/movie`
    ///
    /// - Parameters:
    ///   - page: The page number to retrieve from the remote data source.
    ///   - sortType: The sorting type to apply to the movie list.
    /// - Returns: A Combine `AnyPublisher` that emits a `MoviesListEntity` or an error.
    func getMovies(
        page: Int
    ) -> AnyPublisher<MoviesListEntity, Error>
    
    /// Retrieves a list of movies from a remote data source.
    ///
    /// `GET movie/movie_id`
    ///
    /// - Parameters:
    ///   - movieId: The unique identifier of the movie to retrieve details for.
    ///
    /// - Returns: A Combine `AnyPublisher` that emits a `MovieEntity` or an error.
    func getMovieDetails(
        movieId: Int
    ) -> AnyPublisher<MovieEntity, Error>
}
